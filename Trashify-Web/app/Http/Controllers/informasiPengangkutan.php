<?php

namespace App\Http\Controllers;

use App\Http\Requests\InformasiRequest;
use App\Models\InformasiModel;
use App\Models\PetugasModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class informasiPengangkutan extends Controller
{
    public function informasiPengangkutan(Request $request)
    {
        $search = request('search');
        $dataCount = $request->input('data_count', 10);
        $status = $request->input('status');
        $wilayah = $request->input('wilayah');
        $query = $dataInformasi = InformasiModel::with('PetugasTable.UserTable')->informasi($search)->latest();
        $wilayahOptions = InformasiModel::getWilayahOptions();
        $dataUser = PetugasModel::with('UserTable')->get();

        if ($wilayah) {
            $query->where('Wilayah_Pengangkutan', $wilayah);
        }

        if ($status) {
            $query->where('Status_Pengangkutan', $status);
        }

        $dataInformasi = $query->paginate($dataCount);

        return view('/informasiPengangkutan', [
            "title" => "Informasi Pengangkutan",
            "dataInformasi" => $dataInformasi,
            "wilayahOptions" => $wilayahOptions,
            "dataUser" => $dataUser,
            "data_count" => $dataCount,
            "status" => $status
        ]);
    }


    public function storeInformasi(InformasiRequest $request)
    {
        try {
            DB::beginTransaction();

            $informasi = InformasiModel::create([
                'ID_Petugas' => $request->ID_Petugas,
                'Wilayah_Pengangkutan' => $request->Wilayah_Pengangkutan,
                'Titik_Koordinat' => $request->Titik_Koordinat,
                'Tanggal_Pengangkutan' => $request->Tanggal_Pengangkutan,
                'Jam_Pengangkutan' => $request->Jam_Pengangkutan,
                'Status_Pengangkutan' => $request->Status_Pengangkutan,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Informasi Pengangkutan Berhasil Ditambahkan');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error menambahkan informasi pengangkutan: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Informasi Pengangkutan Gagal Ditambahkan');
        }
    }

    public function updateInformasi(InformasiRequest $request, $ID_Informasi)
    {
        DB::beginTransaction();
        try {
            $informasi = InformasiModel::findOrFail($ID_Informasi);

            $informasi->update([
                'ID_Petugas' => $request->ID_Petugas,
                'Wilayah_Pengangkutan' => $request->Wilayah_Pengangkutan,
                'Titik_Koordinat' => $request->Titik_Koordinat,
                'Tanggal_Pengangkutan' => $request->Tanggal_Pengangkutan,
                'Jam_Pengangkutan' => $request->Jam_Pengangkutan,
                'Status_Pengangkutan' => $request->Status_Pengangkutan,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Data Informasi Pengangkutan Berhasil Diperbarui');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error memperbarui informasi pengangkutan: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Data Informasi Pengangkutan Gagal Diperbarui');
        }
    }

    public function destroyInformasi($ID_Informasi)
    {
        $informasi = InformasiModel::findOrFail($ID_Informasi);

        $status = $informasi->delete($informasi);
        if ($status) {
            return redirect()->back()->with('success', 'Data Informasi Pengangkutan Berhasil Dihapus!');
        } else {
            return redirect()->back()->with('error', 'Data Informasi Pengangkutan Gagal Dihapus!');
        }
    }
}
