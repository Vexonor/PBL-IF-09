<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use App\Models\FotoModel;
use App\Models\LaporanModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class PengaduanMobileController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $pengaduan = LaporanModel::all();
        return response()->json($pengaduan);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validatePengaduan = $request->validate([
            'ID_User' => 'required|string',
            'Kategori_Pengaduan' => 'required|string|max:255',
            'Deskripsi_Pengaduan' => 'required|string',
            'Titik_Koordinat' => 'required|string',
            'Gambar_Pengaduan.*' => 'required|image|mimes:jpeg,png,jpg,gif|max:10240',
        ]);
        $validatePengaduan ['Status_Pengaduan'] = 'Belum Selesai';

        $store = LaporanModel::create([
            'ID_User' => $validatePengaduan['ID_User'], // User ID
            'Kategori_Pengaduan' => $validatePengaduan['Kategori_Pengaduan'], // Category
            'Deskripsi_Pengaduan' => $validatePengaduan['Deskripsi_Pengaduan'], // Description
            'Titik_Koordinat' => $validatePengaduan['Titik_Koordinat'], // Coordinates
            'Status_Pengaduan' => $validatePengaduan['Status_Pengaduan'], // Status
        ]);

        if ($store) {
            if ($request->hasFile('Gambar_Pengaduan')) {
                foreach ($request->file('Gambar_Pengaduan') as $file) {
                    $filename = time() . '_' . $file->getClientOriginalName();
                    $filePath = $file->storeAs('uploads/pengaduan', $filename, 'public');

                    DB::table('Foto_Pengaduan')->insert([
                        'ID_Pengaduan' => $store->ID_Pengaduan,
                        'Foto' => $filePath,
                    ]);
                }
            }
        }


        if ($store) {
            return response()->json(['message' => 'Berhasil menambah Pengaduan'], 201);
        } else {
            return response()->json(['message' => 'Gagal menambah Pengaduan!'], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $pengaduan = LaporanModel::find($id);

        if (!$pengaduan) {
            return response()->json(['message' => 'Pengaduan tidak ditemukan!'], 404);
        }

        $foto = FotoModel::where('ID_Pengaduan', $pengaduan->ID_Pengaduan)->pluck('Foto');

        $response = [
        'ID_Pengaduan' => $pengaduan->ID_Pengaduan,
        'ID_User' => $pengaduan->ID_User,
        'Kategori_Pengaduan' => $pengaduan->Kategori_Pengaduan,
        'Deskripsi_Pengaduan' => $pengaduan->Deskripsi_Pengaduan,
        'Titik_Koordinat' => $pengaduan->Titik_Koordinat,
        'Status_Pengaduan' => $pengaduan->Status_Pengaduan,
        'created_at' => $pengaduan->created_at,
        'updated_at' => $pengaduan->updated_at,
        'Gambar_Pengaduan' => $foto, // Add the images to the response
    ];

        return response()->json($response, 200);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $pengaduan = LaporanModel::findOrFail($id);

        if (!$pengaduan) { 
            return response()->json(['message' => 'Pengaduan tidak ditemukan!'], 404);
        }

        $validatePengaduan = $request->validate([
            'Kategori_Pengaduan' => 'required|string|max:255',
            'Deskripsi_Pengaduan' => 'required|string',
            'Titik_Koordinat' => 'required|string',
            'Gambar_Pengaduan.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:10240',
        ]);

        $pengaduan->Kategori_Pengaduan = $validatePengaduan['Kategori_Pengaduan'];
        $pengaduan->Deskripsi_Pengaduan = $validatePengaduan['Deskripsi_Pengaduan'];
        $pengaduan->Titik_Koordinat = $validatePengaduan['Titik_Koordinat'];
        $pengaduan->save();

        if ($request->hasFile('Gambar_Pengaduan')) {
            // Hapus gambar lama jika ada
            DB::table('Foto_Pengaduan')->where('ID_Pengaduan', $pengaduan->ID_Pengaduan)->delete();

            // Proses penyimpanan gambar baru
            foreach ($request->file('Gambar_Pengaduan') as $file) {
                $filename = time() . '_' . $file->getClientOriginalName();
                $filePath = $file->storeAs('uploads/pengaduan', $filename, 'public');

                DB::table('Foto_Pengaduan')->insert([
                    'ID_Pengaduan' => $pengaduan->ID_Pengaduan,
                    'Foto' => $filePath,
                ]);
            }
        }
        return response()->json(['message' => 'Berhasil memperbarui Pengaduan', 'data' => $pengaduan], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
{
    $pengaduan = LaporanModel::find($id);

    if (!$pengaduan) {
        return response()->json(['message' => 'Pengaduan tidak ditemukan!'], 404);
    }

    // Ambil semua gambar terkait pengaduan
    $fotoPengaduan = DB::table('Foto_Pengaduan')->where('ID_Pengaduan', $pengaduan->ID_Pengaduan)->get();

    // Hapus gambar dari penyimpanan
    foreach ($fotoPengaduan as $foto) {
        $filePath = storage_path('app/public/' . $foto->Foto);
        if (file_exists($filePath)) {
            unlink($filePath);
        } else {
            Log::warning('File tidak ditemukan: ' . $filePath);
        }
    }

    // Hapus data pengaduan
    $delete = $pengaduan->delete();

    if ($delete) {
        return response()->json(['message' => 'Berhasil menghapus Pengaduan'], 201);
    } else {
        return response()->json(['message' => 'Gagal menghapus Pengaduan!'], 403);
    }
}
}
