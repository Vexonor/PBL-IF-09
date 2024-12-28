<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Warga;

class AutentikasiMobileController extends Controller
{
    public function daftar(Request $request)
    {
        try {
            // Validasi input
            $validateUser  = $request->validate([
                'Nama' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:user',
                'password' => 'required|string|min:8',
            ]);
            
            // Menambahkan role dan meng-hash password
            $validateUser ['role'] = 'Warga';
            $validateUser ['password'] = Hash::make($validateUser ['password']);

            // Membuat pengguna baru
            $user = User::create($validateUser);

            // Membuat entri Warga
            $warga = Warga::create([
                'ID_User' => $user->ID_User,
            ]);

            // Membuat token untuk pengguna
            $token = $user->createToken('token')->plainTextToken;

            if ($user && $warga) {
                return response()->json([
                    'message' => 'Berhasil mendaftarkan Akun',
                    'token' => $token,
                ], 201);
            } else {
                return response()->json(['message' => 'Gagal mendaftarkan Akun!'], 500);
            }
        } catch (\Illuminate\Validation\ValidationException $e) {
            if ($e->validator->errors()->has('email')) {
                return response()->json(['message' => 'Email sudah digunakan!'], 409);
            }
            return response()->json(['message' => 'Validasi gagal!'], 422);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Terjadi kesalahan, silakan coba lagi!'], 500);
        }
    }
    
    public function masuk(Request $request)
    {
        $validateUser  = $request->validate([
            'email' => 'required|string|email|max:255',
            'password' => 'required|string',
        ]);

        $user = User::where('email', $validateUser ['email'])->first();

        if (!$user) {
            return response()->json(['message' => 'Email belum terdaftar'], 404);
        }

        $token = $user->createToken('token')->plainTextToken;

        if (Auth::attempt($validateUser)) { 
            $user = Auth::user();
            if ($user->role === 'Warga') {
                return response()->json([
                    'message' => 'Berhasil Masuk',
                    'ID_User' => $user->ID_User,
                    'Nama' => $user->Nama,
                    'Email' => $user->email,
                    'No_Telp' => $user->No_Telp,
                    'Alamat' => $user->Alamat,
                    'Jenis_Kelamin' => $user->Jenis_Kelamin,
                    'Nik' => $user->Nik,
                    'Tanggal_Lahir' => $user->Tanggal_Lahir,
                    'Foto_Profil' => $user->Foto_Profil,
                    'token' => $token,
                ], 200);
            }
        } else {
            return response()->json(['message' => 'Kata Sandi salah'], 401);
        }
    }

    public function store(Request $request)
    {
        try {
            $validateDataDiri = $request->validate([
                'ID_User' => 'required|string',
                'Foto_Profil' => 'required|image|mimes:jpeg,png,jpg,gif|max:10240',
                'No_Telp' => 'required|string',
                'Alamat' => 'required|string',
                'Jenis_Kelamin' => 'required|string',
                'Tanggal_Lahir' => 'required|string',
                'Nik' => 'required|string',
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            // Mengembalikan error validasi
            return response()->json(['message' => 'Validation Error', 'errors' => $e->validator->errors()], 422);
        }

        $user = User::find($request->ID_User);
        if (!$user) {
            return response()->json(['message' => 'Terjadi Kesalahan, Pengguna tidak ditemukan!'], 404);
        }

        if ($request->hasFile('Foto_Profil')) {
            $file = $request->file('Foto_Profil');
            $filename = time() . '_' . $file->getClientOriginalName();
            $filePath = $file->storeAs('uploads/foto_profil', $filename, 'public');
            
            $validateDataDiri['Foto_Profil'] = $filePath;
        }

        $token = $user->createToken('token')->plainTextToken;

        // Simpan file gambar
        $update = $user->update($validateDataDiri);

        if ($update) {
            return response()->json(['message' => 'Data diri berhasil diperbarui, Selamat Datang', 'token' => $token, 'Foto_Profil' => $validateDataDiri['Foto_Profil']], 201);
        } else {
            return response()->json(['message' => 'Data diri gagal diperbarui!'], 500);
        }
    }

    public function updateProfil(Request $request, string $userId)
    {
        $user = User::find($userId);
        if (!$user) {
            return response()->json(['message' => 'Terjadi Kesalahan, Pengguna tidak ditemukan!'], 404);
        }

        try {
            $validateDataDiri = $request->validate([
                'Nama' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:user,email,' . $user->ID_User . ',ID_User',
                'Foto_Profil' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:10240',
                'No_Telp' => 'required|string',
                'Alamat' => 'required|string',
                'Jenis_Kelamin' => 'required|string',
                'Tanggal_Lahir' => 'required|string',
                'Nik' => 'required|string',
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            // Mengembalikan error validasi
            return response()->json(['message' => 'Validation Error', 'errors' => $e->validator->errors()], 422);
        }

        if ($request->hasFile('Foto_Profil')) {
            $filePath = storage_path('app/public/' . $user->Foto_Profil);
            if (file_exists($filePath)) {
                unlink($filePath);
                $file = $request->file('Foto_Profil');
                $filename = time() . '_' . $file->getClientOriginalName();
                $filePath = $file->storeAs('uploads/foto_profil', $filename, 'public');
            
                $validateDataDiri['Foto_Profil'] = $filePath;
            } else {
                $validateDataDiri['Foto_Profil'] = $user->Foto_Profil;
            }
        } else {
            $validateDataDiri['Foto_Profil'] = $user->Foto_Profil;
        }

        $token = $user->createToken('token')->plainTextToken;

        // Simpan file gambar
        $update = $user->update($validateDataDiri);

        if ($update) {
            return response()->json(['message' => 'Data diri berhasil diperbarui', 'token' => $token, 'Foto_Profil' => $validateDataDiri['Foto_Profil']], 201);
        } else {
            return response()->json(['message' => 'Data diri gagal diperbarui!'], 500);
        }
    }

    public function updateKataSandi(Request $request, string $userId)
    {
        $user = User::find($userId);
        if (!$user) {
            return response()->json(['message' => 'Terjadi Kesalahan, Pengguna tidak ditemukan!'], 404);
        }

        $request->validate([
            'Kata_Sandi_Lama' => 'required|string',
            'Kata_Sandi_Baru' => 'required|string|min:8',
        ]);

        if (!Hash::check($request->Kata_Sandi_Lama, $user->password)) {
            return response()->json(['message' => 'Kata Sandi Lama tidak cocok!'], 403);
        }

        // Enkripsi kata sandi baru
        $user->password = Hash::make($request->Kata_Sandi_Baru);
        $update = $user->save();

        if ($update) {
            return response()->json(['message' => 'Kata Sandi berhasil diperbarui'], 201);
        } else {
            return response()->json(['message' => 'Kata Sandi gagal diperbarui!'], 500);
        }
    }

    // public function sendVerificationEmail(Request $request)
    // {
    //     $user = User::where('email', $request->email)->first();
        
    //     if ($user) {
    //         $verificationCode = rand(100000, 999999); // Generate a random verification code
    //         $user->verification_code = $verificationCode;
    //         $user->save();

    //         // Send email with verification code
    //         Mail::to($user->email)->send(new \App\Mail\VerificationMail($verificationCode));

    //         return response()->json(['message' => 'Verification code sent to your email.'], 200);
    //     }

    //     return response()->json(['message' => 'User  not found.'], 404);
    // }

    // public function verify(Request $request)
    // {
    //     $request->validate([
    //         'email' => 'required|email',
    //         'verification_code' => 'required|integer',
    //     ]);

    //     $user = User::where('email', $request->email)->first();

    //     if ($user && $user->verification_code == $request->verification_code) {
    //         $user->is_verified = true; // Set user as verified
    //         $user->verification_code = null; // Clear the verification code
    //         $user->save();

    //         return response()->json(['message' => 'Email verified successfully.'], 200);
    //     }

    //     return response()->json(['message' => 'Invalid verification code.'], 400);
    // }
}
