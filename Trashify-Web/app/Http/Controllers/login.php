<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class login extends Controller
{
    public function login()
    {
        return view('/login', [
            "title" => "Login"
        ]);
    }

    public function loginProcess(Request $request)
    {
        $credentials = [
            'email' => $request->email,
            'password' => $request->password
        ];

        if (Auth::attempt($credentials)) {
            $request->session()->regenerate();

            $user = Auth::user();

            if ($user->role === 'Admin') {
                return redirect()->route('dashboard.page')->with('success', 'Berhasil Login');
            } elseif ($user->role !== 'Admin') {
                return redirect()->back()->with('unmatch', 'Anda Bukan Admin');
            } else {
                return redirect()->route('login')->with('error', 'Gagal Login');
            }
        }
        return back()->with('gagal', 'Email atau password yang dimasukkan salah!.')->withErrors([
            'email' => 'Email atau password salah.',
        ])->withInput($request->only('email'));
    }

    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();

        $request->session()->regenerateToken();
        return redirect()->route('login')->with('success', 'Logout Berhasil');
    }
}
