<?php

namespace App\Http\Controllers\Mobile;

use App\Mail\SendEmail;
use App\Models\OTPModel;
use App\Http\Controllers\Controller;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Date;
use Illuminate\Support\Facades\Mail;
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
                'email' => 'required|string|email|max:255|unique:User',
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

            if ($user && $warga) {
                $kodeOTP = OTPModel::create([
                    'ID_User' => $user->ID_User,
                    'Kode_Otp' => rand(100000, 999999),
                    'expired_at' => Date::now()->addMinutes(2)
                ]);
                event(new Registered($user));
                $message = [
                    'subject' => 'Trashify - Verification',
                    'title' => 'Kode Verifikasi Anda',
                    'code' => $kodeOTP->Kode_Otp,
                ];

                Mail::to($user->email)->send(new SendEmail($message));
                return response()->json([
                    'message' => 'Berhasil mendaftarkan Akun',
                    'ID_User' => $user->ID_User,
                ], 201);
            } else {
                return response()->json(['message' => 'Gagal mendaftarkan Akun!'], 500);
            }
        } catch (\Illuminate\Validation\ValidationException $e) {
            if ($e->validator->errors()->has('email')) {
                $existingUser  = User::where('email', $request->email)->first();
                if ($existingUser  && !$existingUser->email_verified_at) {
                    return response()->json([
                        'message' => 'Email sudah terdaftar, namun belum diverifikasi.',
                        'ID_User' => $existingUser->ID_User 
                    ], 410);
                }
                return response()->json(['message' => 'Email sudah terdaftar!'], 409);
            }
            return response()->json(['message' => 'Validasi gagal!'], 422);
        }
    }

    /**
     * Display the specified resource.
     */
    public function showVerifikasi(string $id)
    {
        $verifikasi = User::find($id);

        if (!$verifikasi) {
            return response()->json(['message' => 'User tidak ditemukan!'], 404);
        }

        return response()->json($verifikasi, 200);
    }

    public function verifikasiOtp(Request $request)
    {
        $request->validate([
            'Kode_Otp' => 'required|string|max:6',
        ]);

        $otp = OTPModel::where('Kode_Otp', $request->Kode_Otp)->first();

        if (!$otp || strtotime($otp->expired_at) < time()) {
            return response()->json([
                'Kode_Otp' => 'Kode OTP tidak ditemukan atau sudah kedaluwarsa.',
            ], 403);
        }

        $otp->UserTable->email_verified_at = now();
        $otp->UserTable->save();

        return response()->json(['message' => 'Berhasil Verifikasi! Silakan masuk.'], 200);
    }

    public function kirimUlangOTP(Request $request)
    {
        $user = User::find($request->ID_User);

        if (!$user) {
            return response()->json(['message' => 'User tidak ditemukan'], 404);
        }

        $otp = rand(100000, 999999);
        $expiredAt = now()->addMinutes(2);

        $kodeOTP = OTPModel::updateOrCreate(
            ['ID_User' => $user->ID_User],
            [
                'Kode_Otp' => $otp,
                'expired_at' => $expiredAt
            ]
        );

        if ($user) {
            $message = [
                'subject' => 'Trashify - Verification',
                'title' => 'Kode Verifikasi Anda',
                'code' => $kodeOTP->Kode_Otp,
            ];

            Mail::to($user->email)->send(new SendEmail($message));

            return response()->json(['message' => 'Berhasil Mengirim ulang OTP'], 200);
        } else {
            return response()->json(['message' => 'Gagal Mengirim ulang OTP'], 401);
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

        if (!$user->email_verified_at) {
            return response()->json([
                'message' => 'Email sudah terdaftar, namun belum diverifikasi', 
                'ID_User' => $user->ID_User,
            ], 403);
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

        $user = User::find($request->ID_User);
        if (!$user) {
            return response()->json(['message' => 'Terjadi Kesalahan, Pengguna tidak ditemukan!'], 404);
        }

        if ($request->hasFile('Foto_Profil')) {
            $file = $request->file('Foto_Profil');
            $filename = time() . '_' . $file->getClientOriginalName();
            $filePath = $file->storeAs('uploads/foto_profil', $filename, 'public');
            
            $validateDataDiri['Foto_Profil'] = $filePath;
        }else {
            $validateDataDiri['Foto_Profil'] = '';
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
                'email' => 'required|string|email|max:255|unique:User,email,' . $user->ID_User . ',ID_User',
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
                $file = $request->file('Foto_Profil');
                $filename = time() . '_' . $file->getClientOriginalName();
                $filePath = $file->storeAs('uploads/foto_profil', $filename, 'public');
            
                $validateDataDiri['Foto_Profil'] = $filePath;
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
}
