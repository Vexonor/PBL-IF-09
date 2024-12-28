<?php

namespace App\Http\Controllers;

use App\Http\Requests\PenanggungJawabRequest;
use App\Models\FotoModel;
use App\Models\LaporanModel;
use App\Models\PenanggungJawabModel;
use Illuminate\Support\Facades\Storage;
use App\Models\PetugasModel;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class laporan extends Controller
{
    public function laporan(Request $request)
    {
        $search = request('search');
        $dataCount = $request->input('data_count', 10);
        $kategori = $request->input('kategori');
        $status = $request->input('status');
        $queryPengaduan = $dataPengaduan = LaporanModel::with('UserTable', 'FotoTable')->pengaduan($search)->latest();
        $dataPetugas = PetugasModel::with('UserTable')->get();
        $queryPenanggungJawab = $dataPenanggungJawab = PenanggungJawabModel::with('PengaduanTable', 'PetugasTable')->penanggungJawab($search)->latest();
        $user = User::where('role', 'Warga')->get();

        if ($kategori) {
            $queryPengaduan->where('Kategori_Pengaduan', $kategori);
            $queryPenanggungJawab->where('Kategori_Pengaduan', $kategori);
        }

        if ($status) {
            $queryPengaduan->where('Status_Pengaduan', $status);
            $queryPenanggungJawab->where('Status_Pengaduan', $status);
        }

        $dataPengaduan = $queryPengaduan->paginate($dataCount);
        $dataPenanggungJawab = $queryPenanggungJawab->paginate($dataCount);

        $pegaduan = LaporanModel::get();

        return view('/laporan', [
            "title" => "Pengaduan",
            "dataPengaduan" => $dataPengaduan,
            "pegaduan" => $pegaduan,
            "dataPetugas" => $dataPetugas,
            "dataPenanggungJawab" => $dataPenanggungJawab,
            "user" => $user,
            "data_count" => $dataCount,
            "kategori" => $kategori,
            "status" => $status
        ]);
    }

    public function getKategori($kodeLaporan)
    {
        $pengaduan = LaporanModel::where('Kode_Pengaduan', $kodeLaporan)->first();

        return response()->json([
            'Kategori_Pengaduan' => $pengaduan ? $pengaduan->Kategori_Pengaduan : null,
            'Status_Pengaduan' => $pengaduan ? $pengaduan->Status_Pengaduan : null,
        ]);
    }

    public function storeLaporan(Request $request)
    {
        $validatedData = $request->validate([
            'ID_User' => 'required',
            'Kategori_Pengaduan' => 'required',
            'Deskripsi_Pengaduan' => 'required',
            'Titik_Koordinat' => 'required',
            'Gambar_Pengaduan' => 'required|file',
        ]);

        $laporanData = [
            'ID_User' => $validatedData['ID_User'],
            'Kategori_Pengaduan' => $validatedData['Kategori_Pengaduan'],
            'Deskripsi_Pengaduan' => $validatedData['Deskripsi_Pengaduan'],
            'Titik_Koordinat' => $validatedData['Titik_Koordinat'],
        ];

        if ($request->hasFile('Gambar_Pengaduan')) {
            $dokumenPath = $request->file('Gambar_Pengaduan')->store('dokumen_pengaduan', 'public');
            $laporanData['Gambar_Pengaduan'] = $dokumenPath;
        }

        $laporan = LaporanModel::create($laporanData);

        if ($laporan) {
            if ($request->hasFile('Foto')) {
                $fotoPath = $request->file('Foto')->store('foto_pengaduan', 'public');
                $fotoData = [
                    'Foto' => $fotoPath,
                    'ID_Pengaduan' => $laporan->ID_Pengaduan,
                ];
                FotoModel::create($fotoData);
            }

            return redirect()->back()->with('success', 'Berhasil Membuat Pengaduan');
        }

        return redirect()->back()->with('error', 'Gagal Membuat Pengaduan');
    }

    public function updateLaporan(Request $request, $ID_Pengaduan)
    {
        $laporan = LaporanModel::findOrFail($ID_Pengaduan);

        $validateLaporan = $request->validate([
            'Status_Pengaduan' => 'required'
        ]);

        $status = $laporan->update($validateLaporan);
        if ($status) {
            return redirect()->back()->with('success', 'Status Pengaduan Berhasil Diperbarui!');
        } else {
            return redirect()->back()->with('error', 'Status Pengaduan Gagal Diperbarui!');
        }
    }

    public function destroyLaporan($ID_Pengaduan)
    {
        $laporan = LaporanModel::findOrFail($ID_Pengaduan);

        $status = $laporan->delete($laporan);
        if ($status) {
            return redirect()->back()->with('success', 'Data Pengaduan Berhasil Dihapus!');
        } else {
            return redirect()->back()->with('error', 'Data Pengaduan Gagal Dihapus!');
        }
    }

    public function storePenanggungJawab(PenanggungJawabRequest $request)
    {
        try {
            DB::beginTransaction();

            $penanggungJawab = PenanggungJawabModel::create([
                'Kode_Pengaduan' => $request->Kode_Pengaduan,
                'ID_Petugas' => $request->ID_Petugas,
                'Kategori_Pengaduan' => $request->Kategori_Pengaduan,
                'Status_Pengaduan' => $request->Status_Pengaduan,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Penanggung Jawab Berhasil Ditambahkan');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error menambahkan penanggung jawab: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Penanggung Jawab Gagal Ditambahkan');
        }
    }

    public function updatePenanggungJawab(Request $request, $ID_PJ)
    {
        DB::beginTransaction();
        try {
            $penanggungJawab = PenanggungJawabModel::findOrFail($ID_PJ);

            $penanggungJawab->update([
                'Kode_Pengaduan' => $request->Kode_Pengaduan,
                'ID_Petugas' => $request->ID_Petugas,
                'Kategori_Pengaduan' => $request->Kategori_Pengaduan,
                'Status_Pengaduan' => $request->Status_Pengaduan,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Data Penanggung Jawab Berhasil Diperbarui');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error memperbarui penanggung jawab: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Data Penanggung Jawab Gagal Diperbarui');
        }
    }

    public function destroyPenanggungJawab($ID_PJ)
    {
        $penanggungJawab = PenanggungJawabModel::findOrFail($ID_PJ);

        $status = $penanggungJawab->delete($penanggungJawab);
        if ($status) {
            return redirect()->back()->with('success', 'Data Penanggung Jawab Berhasil Dihapus!');
        } else {
            return redirect()->back()->with('error', 'Data Penanggung Jawab Gagal Dihapus!');
        }
    }
}