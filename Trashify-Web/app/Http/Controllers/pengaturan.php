<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class pengaturan extends Controller
{
    public function pengaturan()
    {
        return view('/pengaturan', [
            "title" => "Pengaturan"
        ]);
    }

    public function updateProfile(Request $request, $ID_User)
    {
        $user = User::findOrFail($ID_User);
        $validateUser = $request->validate(
            [
                'Nama' => 'required',
                'Jenis_Kelamin' => 'required',
                'Alamat' => 'required',
                'No_Telp' => 'required',
                'Nik' => 'required',
                'email' => 'required',
            ]
        );

        if ($request->hasFile('Foto_Profil')) {
            if ($user->Foto_Profil && Storage::exists('public/' . $user->Foto_Profil)) {
                Storage::delete('public/' . $user->Foto_Profil);
            }

            $path = $request->file('Foto_Profil')->store('foto_profil', 'public');
            $validateUser['Foto_Profil'] = $path;
        }


        $user->update($validateUser);

        return redirect()->back()->with('success', 'Profil Berhasil Diperbarui!');
    }

    public function changePassword(Request $request, $ID_User)
    {
        $user = User::findOrFail($ID_User);
        $request->validate([
            'password' => [
                'required',
                'min:6',
                'regex:/[a-z]/',
                'regex:/[A-Z]/',
                'regex:/[0-9]/',
                'regex:/[!@#$%^&*]/'
            ],
        ]);

        $status = $user->update([
            'password' => Hash::make($request->password),
        ]);

        if ($status) {
            return redirect()->back()->with('success', 'Password Berhasil Diperbarui!');
        } else {
            return redirect()->back()->with('error', 'Password Gagal Diperbarui!');
        }
    }
}
