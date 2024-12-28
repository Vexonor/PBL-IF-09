<?php

namespace App\Http\Controllers;

use App\Http\Requests\AdminRequest;
use App\Models\User;
use App\Models\AdminModel;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class admin extends Controller
{
    public function admin(Request $request)
    {
        $search = request('search');
        $dataCount = $request->input('data_count', 10);
        $status = $request->input('status');
        $query = $dataUser = AdminModel::with('UserTable')->admin($search)->latest();

        if ($status) {
            $query->where('Role_Admin', $status);
        }

        $dataUser = $query->paginate($dataCount);

        return view('/admin', [
            "title" => "Admin",
            "dataUser" => $dataUser,
            "data_count" => $dataCount,
            "status" => $status
        ]);
    }

    public function storeAdmin(AdminRequest $request)
    {
        try {
            DB::beginTransaction();

            $user = User::create([
                'Nama' => $request->Nama,
                'Tanggal_Lahir' => $request->Tanggal_Lahir,
                'Jenis_Kelamin' => $request->Jenis_Kelamin,
                'Alamat' => $request->Alamat,
                'No_Telp' => $request->No_Telp,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'role' => 'Admin',
            ]);

            $admin = AdminModel::create([
                'ID_User' => $user->ID_User,
                'Role_Admin' => $request->Role_Admin,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Admin Berhasil Ditambahkan');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error menambahkan admin: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Admin Gagal Ditambahkan');
        }
    }

    public function updateAdmin(AdminRequest $request, $ID_User)
    {
        DB::beginTransaction();
        try {
            $user = User::with('AdminTable')->findOrFail($ID_User);

            $user->update([
                'Nama' => $request->Nama,
                'Tanggal_Lahir' => $request->Tanggal_Lahir,
                'Jenis_Kelamin' => $request->Jenis_Kelamin,
                'Alamat' => $request->Alamat,
                'No_Telp' => $request->No_Telp,
                'email' => $request->email,
            ]);

            $user->AdminTable->update([
                'Role_Admin' => $request->Role_Admin,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Data Admin Berhasil Diperbarui');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error memperbarui admin: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Data Admin Gagal Diperbarui');
        }
    }


    public function destroyAdmin($ID_User)
    {

        $user = User::findOrFail($ID_User);

        if ($user->Foto_Profil) {
            Storage::disk('public')->delete($user->Foto_Profil);
        }

        $status = $user->delete();
        if ($status) {
            return redirect()->back()->with('success', 'Data Admin Berhasil Dihapus');
        } else {
            return redirect()->back()->with('error', 'Data Admin Gagal Dihapus');
        }
    }
}
