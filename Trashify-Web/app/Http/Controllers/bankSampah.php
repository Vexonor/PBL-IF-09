<?php

namespace App\Http\Controllers;

use App\Http\Requests\BankSampahRequest;
use Illuminate\Http\Request;
use App\Models\BankSampahModel;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class bankSampah extends Controller
{
    public function bankSampah(Request $request)
    {
        $search = request('search');
        $dataCount = $request->input('data_count', 10);
        $status = $request->input('status');
        $query = $dataBankSampah = BankSampahModel::bankSampah($search)->latest();
        $wilayahOptions = BankSampahModel::getWilayahOptions();

        if ($status) {
            $query->where('Status_Operasional', $status);
        }

        $dataBankSampah = $query->paginate($dataCount);

        return view('/bankSampah', [
            "title" => "Bank Sampah",
            "dataBankSampah" => $dataBankSampah,
            "wilayahOptions" => $wilayahOptions,
            "data_count" => $dataCount,
            "status" => $status
        ]);
    }

    public function storeBankSampah(BankSampahRequest $request)
    {
        try {
            DB::beginTransaction();

            $bankSampah = BankSampahModel::create([
                'Nama_Bank_Sampah' => $request->Nama_Bank_Sampah,
                'Jenis_Sampah' => $request->Jenis_Sampah,
                'Harga_Sampah' => $request->Harga_Sampah,
                'Nama_Pemilik' => $request->Nama_Pemilik,
                'No_Telp' => $request->No_Telp,
                'Wilayah_BankSampah' => $request->Wilayah_BankSampah,
                'Titik_Koordinat' => $request->Titik_Koordinat,
                'Jam_Buka' => $request->Jam_Buka,
                'Jam_Tutup' => $request->Jam_Tutup,
                'Status_Operasional' => $request->Status_Operasional,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Bank Sampah Berhasil Ditambahkan');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error menambahkan bank sampah: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Bank Sampah Gagal Ditambahkan');
        }
    }

    public function updateBankSampah(BankSampahRequest $request, $ID_BankSampah)
    {
        DB::beginTransaction();
        try {
            $bankSampah = BankSampahModel::findOrFail($ID_BankSampah);

            $bankSampah->update([
                'Nama_Bank_Sampah' => $request->Nama_Bank_Sampah,
                'Jenis_Sampah' => $request->Jenis_Sampah,
                'Harga_Sampah' => $request->Harga_Sampah,
                'Nama_Pemilik' => $request->Nama_Pemilik,
                'No_Telp' => $request->No_Telp,
                'Wilayah_BankSampah' => $request->Wilayah_BankSampah,
                'Titik_Koordinat' => $request->Titik_Koordinat,
                'Jam_Buka' => $request->Jam_Buka,
                'Jam_Tutup' => $request->Jam_Tutup,
                'Status_Operasional' => $request->Status_Operasional,
            ]);

            DB::commit();

            return redirect()->back()->with('success', 'Data Bank Sampah Berhasil Diperbarui');
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Error memperbarui bank sampah: ' . $e->getMessage());

            return redirect()->back()->with('error', 'Data Bank Sampah Gagal Diperbarui');
        }
    }

    public function destroyBankSampah($ID_BankSampah)
    {
        $bankSampah = BankSampahModel::findOrFail($ID_BankSampah);

        $status = $bankSampah->delete($bankSampah);
        if ($status) {
            return redirect()->back()->with('success', 'Data Bank Sampah Berhasil Dihapus!');
        } else {
            return redirect()->back()->with('error', 'Data Bank Sampah Gagal Dihapus!');
        }
    }
}
