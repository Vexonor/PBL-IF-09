<?php

namespace App\Http\Controllers;

use App\Http\Requests\LokasiTPSRequest;
use App\Http\Requests\PengangkutanRequest;
use App\Models\PengangkutanModel;
use App\Models\TPSModel;
use App\Models\PetugasModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\Rule;

class lokasiTPS extends Controller
{
    public function lokasiTPS(Request $request)
    {
        $search = request('search');
        $dataCount = $request->input('data_count', 10);
        $wilayah = $request->input('wilayah');
        $status = $request->input('status');
        $statusPengangkutan = $request->input('statusPengangkutan');
        $queryTPS = $dataTPS = TPSModel::lokasiTPS($search)->latest();
        $queryPengangkutan = $dataPengangkutan = PengangkutanModel::pengangkutanTPS($search)->latest();
        $dataUser = PetugasModel::with('UserTable')->get();
        $wilayahOptions = TPSModel::getWilayahOptions();

        if ($wilayah) {
            $queryTPS->where('Wilayah_TPS', $wilayah);
        }

        if ($status) {
            $queryTPS->where('Status_TPS', $status);
        }

        if ($statusPengangkutan) {
            $queryPengangkutan->where('Status_Pengangkutan', $statusPengangkutan);
        }

        $dataTPS = $queryTPS->paginate($dataCount);
        $dataPengangkutan = $queryPengangkutan->paginate($dataCount);

        $tps = TPSModel::get();

        return view('/lokasiTPS', [
            "title" => "Lokasi TPS",
            "dataTPS" => $dataTPS,
            "tps" => $tps,
            "dataPengangkutan" => $dataPengangkutan,
            "wilayahOptions" => $wilayahOptions,
            "dataUser" => $dataUser,
            "data_count" => $dataCount,
            "wilayah" => $wilayah,
            "status" => $status,
            "statusPengangkutan" => $statusPengangkutan
        ]);
    }

    public function storeTPS(LokasiTPSRequest $request)
    {
        try {
            DB::beginTransaction();

            $lokasiTPS = TPSModel::create([
                'Kode_TPS' => $request->Kode_TPS,
                'Wilayah_TPS' => $request->Wilayah_TPS,
                'Titik_Koordinat' => $request->Titik_Koordinat,
                'Status_TPS' => $request->Status_TPS,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Lokasi TPS Berhasil Ditambahkan');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error menambahkan lokasi tps: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Lokasi TPS Gagal Ditambahkan');
        }
    }

    public function updateTPS(LokasiTPSRequest $request, $ID_TPS)
    {
        DB::beginTransaction();
        try {
            $lokasiTPS = TPSModel::findOrFail($ID_TPS);

            $request->validate([
                'Kode_TPS' => [
                    'required',
                    'string',
                    'max:255',
                    Rule::unique('Lokasi_TPS', 'Kode_TPS')->ignore($ID_TPS, 'ID_TPS'),
                ],
            ]);

            $lokasiTPS->update([
                'Kode_TPS' => $request->Kode_TPS,
                'Wilayah_TPS' => $request->Wilayah_TPS,
                'Titik_Koordinat' => $request->Titik_Koordinat,
                'Status_TPS' => $request->Status_TPS,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Data Lokasi TPS Berhasil Diperbarui');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error memperbarui lokasi tps: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Data Lokasi TPS Gagal Diperbarui');
        }
    }

    public function destroyTPS($ID_TPS)
    {
        $tps = TPSModel::findOrFail($ID_TPS);

        $status = $tps->delete($tps);
        if ($status) {
            return redirect()->back()->with('success', 'Data Lokasi TPS Berhasil Dihapus!');
        } else {
            return redirect()->back()->with('error', 'Data Lokasi TPS Gagal Dihapus!');
        }
    }

    // Jadwal Pengangkutan

    public function storePengangkutan(PengangkutanRequest $request)
    {
        try {
            DB::beginTransaction();

            $pengangkutan = PengangkutanModel::create([
                'Kode_TPS' => $request->Kode_TPS,
                'ID_Petugas' => $request->ID_Petugas,
                'Tanggal_Pengangkutan' => $request->Tanggal_Pengangkutan,
                'Jam_Pengangkutan' => $request->Jam_Pengangkutan,
                'Status_Pengangkutan' => $request->Status_Pengangkutan,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Pengangkutan TPS Berhasil Ditambahkan');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error menambahkan pengangkutan tps: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Pengangkutan TPS Gagal Ditambahkan');
        }
    }

    public function updatePengangkutan(PengangkutanRequest $request, $ID_Pengangkutan)
    {
        DB::beginTransaction();
        try {
            $pengangkutan = PengangkutanModel::findOrFail($ID_Pengangkutan);

            $pengangkutan->update([
                'Kode_TPS' => $request->Kode_TPS,
                'ID_Petugas' => $request->ID_Petugas,
                'Tanggal_Pengangkutan' => $request->Tanggal_Pengangkutan,
                'Jam_Pengangkutan' => $request->Jam_Pengangkutan,
                'Status_Pengangkutan' => $request->Status_Pengangkutan,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Data Pengangkutan TPS Berhasil Diperbarui');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error memperbarui pengangkutan tps: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Data Pengangkutan TPS Gagal Diperbarui');
        }
    }

    public function destroyPengangkutan($ID_Pengangkutan)
    {
        $pengangkutan = PengangkutanModel::findOrFail($ID_Pengangkutan);

        $status = $pengangkutan->delete($pengangkutan);
        if ($status) {
            return redirect()->back()->with('success', 'Data Jadwal Pengangkutan TPS Berhasil Dihapus!');
        } else {
            return redirect()->back()->with('error', 'Data Jadwal Pengangkutan TPS Gagal Dihapus!');
        }
    }
}