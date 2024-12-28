<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use App\Models\KontenModel;
use App\Models\User;
use Illuminate\Http\Request;

class KontenEdukasiMobileController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $kontenEdukasi = KontenModel::all();
        return response()->json($kontenEdukasi);
    }

    /**
     * Display a listing of the resource.
     */
    public function indexGalery(string $userId)
    {
        $kontenEdukasi = KontenModel::where('ID_User', $userId)->get();

        if (!$kontenEdukasi) {
            return response()->json(['message' => 'Konten Edukasi tidak ditemukan atau belum diunggah!'], 404);
        }

        return response()->json($kontenEdukasi, 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        if ($request->input('Jenis_Edukasi') === 'Artikel') {
            // Validasi tanpa Link_URL
            $validateKontenEdukasi = $request->validate([
                'ID_User' => 'required|string',
                'Judul_Edukasi' => 'required|string|max:100',
                'Deskripsi_Edukasi' => 'required|string|max:255',
                'Jenis_Edukasi' => 'required|string',
            ]);
            } else {
            // Validasi dengan Link_URL
            $validateKontenEdukasi = $request->validate([
                'ID_User' => 'required|string',
                'Judul_Edukasi' => 'required|string|max:100',
                'Link_URL' => 'required|string',
                'Deskripsi_Edukasi' => 'required|string|max:255',
                'Jenis_Edukasi' => 'required|string',
            ]);
        }

        $store = KontenModel::create($validateKontenEdukasi);

        if ($store) {
            return response()->json(['message' => 'Berhasil menambah Konten Edukasi'], 201);
        } else {
            return response()->json(['message' => 'Gagal menambah Konten Edukasi!'], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $edukasi)
    {
        $kontenEdukasi = KontenModel::where('ID_Edukasi', $edukasi)
        ->where('Status_Edukasi', 'Telah Diunggah')
        ->first();

        if (!$kontenEdukasi) {
            return response()->json(['message' => 'Konten Edukasi tidak ditemukan atau belum diunggah!'], 404);
        }

        $user = User::find($kontenEdukasi->ID_User);

        return response()->json([
            'konten' => $kontenEdukasi,
            'nama' => $user ? $user->Nama : 'User tidak ditemukan'
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function showDetail(string $edukasi)
    {
        $kontenEdukasi = KontenModel::find($edukasi);

        if (!$kontenEdukasi) {
            return response()->json(['message' => 'Konten Edukasi tidak ditemukan atau belum diunggah!'], 404);
        }

        return response()->json($kontenEdukasi, 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $kontenEdukasi)
    {
        $kontenEdukasi = KontenModel::findOrFail($kontenEdukasi);

        if (!$kontenEdukasi) { 
            return response()->json(['message' => 'Konten Edukasi tidak ditemukan!'], 404);
        }

        if ($request->input('Jenis_Edukasi') === 'Artikel') {
            // Validasi tanpa Link_URL
            $validateKontenEdukasi = $request->validate([
                'Judul_Edukasi' => 'required|string|max:100',
                'Deskripsi_Edukasi' => 'required|string|max:255',
            ]);
        } else {
            // Validasi dengan Link_URL
            $validateKontenEdukasi = $request->validate([
                'Judul_Edukasi' => 'required|string|max:100',
                'Link_URL' => 'required|string',
                'Deskripsi_Edukasi' => 'required|string|max:255',
            ]);
        }

        $update = $kontenEdukasi->update($validateKontenEdukasi);

        if ($update) {
            return response()->json(['message' => 'Berhasil memperbarui Konten Edukasi', 'data' => $kontenEdukasi], 200);
        } else {
            return response()->json(['message' => 'Gagal memperbarui Konten Edukasi!', 'data' => $kontenEdukasi], 403);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $kontenEdukasi)
    {
        $kontenEdukasi = KontenModel::find($kontenEdukasi);

        if (!$kontenEdukasi) {
            return response()->json(['message' => 'Konten Edukasi tidak ditemukan!'], 404);
        }

        $delete = $kontenEdukasi->delete();

        if ($delete) {
            return response()->json(['message' => 'Berhasil menghapus Konten Edukasi'], 201);
        } else {
            return response()->json(['message' => 'Gagal menghapus Konten Edukasi!'], 403);
        }
    }
}
