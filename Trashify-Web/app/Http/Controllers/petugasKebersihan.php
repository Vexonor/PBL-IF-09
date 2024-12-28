<?php

namespace App\Http\Controllers;

use App\Http\Requests\PetugasRequest;
use App\Models\PetugasModel;
use App\Models\User;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\Rule;

class petugasKebersihan extends Controller
{
    public function petugasKebersihan(Request $request)
    {
        $search = request('search');
        $dataCount = $request->input('data_count', 10);
        $wilayah = $request->input('wilayah');
        $status = $request->input('status');
        $query = $dataUser = PetugasModel::with('UserTable')->petugas($search)->latest();
        $wilayahOptions = PetugasModel::getWilayahOptions();

        if ($wilayah) {
            $query->where('Wilayah_Bertugas', $wilayah);
        }

        if ($status) {
            $query->where('Status_Keaktifan', $status);
        }

        $dataUser = $query->paginate($dataCount);

        return view('/petugasKebersihan', [
            "title" => "Petugas Kebersihan",
            "wilayahOptions" => $wilayahOptions,
            "dataUser" => $dataUser,
            "data_count" => $dataCount,
            "wilayah" => $wilayah,
            "status" => $status
        ]);
    }

    public function storePetugas(PetugasRequest $request)
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

            $petugas = PetugasModel::create([
                'ID_User' => $user->ID_User,
                'Wilayah_Bertugas' => $request->Wilayah_Bertugas,
                'Tanggal_Bergabung' => $request->Tanggal_Bergabung,
                'Status_Keaktifan' => $request->Status_Keaktifan,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Petugas Berhasil Ditambahkan');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error menambahkan petugas: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Petugas Gagal Ditambahkan');
        }
    }

    public function updatePetugas(PetugasRequest $request, $ID_User)
    {
        DB::beginTransaction();
        try {
            $user = User::with('PetugasTable')->findOrFail($ID_User);

            $user->update([
                'Nama' => $request->Nama,
                'Tanggal_Lahir' => $request->Tanggal_Lahir,
                'Jenis_Kelamin' => $request->Jenis_Kelamin,
                'Alamat' => $request->Alamat,
                'No_Telp' => $request->No_Telp,
                'email' => $request->email,
            ]);

            $user->PetugasTable->update([
                'Wilayah_Bertugas' => $request->Wilayah_Bertugas,
                'Tanggal_Bergabung' => $request->Tanggal_Bergabung,
                'Status_Keaktifan' => $request->Status_Keaktifan,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Data Petugas Berhasil Diperbarui');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error memperbarui petugas: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Data Petugas Gagal Diperbarui');
        }
    }


    public function destroyPetugas($ID_User)
    {

        $user = User::findOrFail($ID_User);

        if ($user->Foto_Profil) {
            Storage::disk('public')->delete($user->Foto_Profil);
        }

        $status = $user->delete();
        if ($status) {
            return redirect()->back()->with('success', 'Data Petugas Berhasil Dihapus');
        } else {
            return redirect()->back()->with('error', 'Data Petugas Gagal Dihapus');
        }
    }
}
