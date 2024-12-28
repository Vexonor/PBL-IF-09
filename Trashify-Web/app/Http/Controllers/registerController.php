<?php

namespace App\Http\Controllers;

use App\Mail\SendEmail;
use App\Models\OTPModel;
use App\Models\User;
use App\Providers\RouteServiceProvider;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Date;
use Illuminate\Support\Facades\Mail;

class registerController extends Controller
{
    public function registerPage()
    {
        return view('/register', [
            "title" => "Register"
        ]);
    }

    public function OTPPage($ID_User)
    {
        $user = User::findOrFail($ID_User);
        $otp = OTPModel::where('expired_at', '>', now())->first();

        if (!$user) {
            return redirect()->route('register.page')->withErrors('User Tidak Ditemukan');
        }

        return view('/verifOTP', [
            "title" => "Kode OTP",
            "user" => $user,
            "otp" => $otp
        ]);
    }

    public function ValidateOTP(Request $request, $ID_User)
    {
        $otp = OTPModel::where('Kode_Otp', $request->Kode_Otp)->first();

        if (!$otp || strtotime($otp->expired_at) < time()) {
            $expiredTime = $otp ? date('Y-m-d H:i:s', strtotime($otp->expired_at)) : null;

            return redirect()->back()->with([
                'Kode_Otp' => 'Kode OTP tidak ditemukan atau sudah kedaluwarsa.',
                'expired_at' => $expiredTime,
            ]);
        }

        $otp->UserTable->email_verified_at = now();
        $otp->UserTable->save();
        Auth::login($otp->UserTable);

        return redirect(RouteServiceProvider::HOME);
    }


    public function resendOTP(Request $request)
    {
        $user = User::find($request->ID_User);

        if (!$user) {
            return redirect()->back()->with('error', 'User tidak ditemukan');
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
                'code' => $kodeOTP->Kode_Otp
            ];

            Mail::to($user->email)->send(new SendEmail($message));

            return redirect()->back()->with('success', 'Berhasil Mengirim Ulang Kode OTP');
        } else {
            return redirect()->back()->with('error', 'Gagal Mengirim Ulang Kode OTP');
        }
    }

    public function storeUser(Request $request)
    {
        $validateUser = $request->validate([
            'Nama' => 'required|string',
            'Tanggal_Lahir' => 'required',
            'email' => 'required|email',
            'password' =>
            [
                'required',
                'min:6',
                'regex:/[a-z]/',
                'regex:/[A-Z]/',
                'regex:/[0-9]/',
                'regex:/[!@#$%^&*]/'
            ],
        ]);
        $validateUser['role'] = 'Warga';
        $validateUser['password'] = bcrypt($validateUser['password']);

        $user = User::create($validateUser);
        $kodeOTP = OTPModel::create([
            'ID_User' => $user->ID_User,
            'Kode_Otp' => rand(100000, 999999),
            'expired_at' => Date::now()->addMinutes(2)
        ]);
        event(new Registered($user));

        if ($user) {
            $message = [
                'subject' => 'Trashify - Verification',
                'title' => 'Kode Verifikasi Anda',
                'code' => $kodeOTP->Kode_Otp
            ];

            Mail::to($user->email)->send(new SendEmail($message));

            return redirect()->route('otp.page', ['ID_User' => $user->ID_User])->with('success', 'Berhasil Mendaftar');
        } else {
            return redirect()->back()->with('error', 'Gagal Mendaftar');
        }
    }
}
