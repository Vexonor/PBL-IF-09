<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use App\Models\Komentar;
use Illuminate\Http\Request;
use illuminate\support\Facades\Log;

class KomentarMobileController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $komentar = Komentar::all();
        return response()->json($komentar);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validateKomentar = $request->validate([
            'ID_Edukasi' => 'required|string',
            'ID_User' => 'required|string',
            'Isi_Komentar' => 'required|string|max:255',
        ]);

        $store = Komentar::create($validateKomentar);

        if ($store) {
            return response()->json(['message' => 'Berhasil menambah Komentar'], 201);
        } else {
            return response()->json(['message' => 'Gagal menambah Komentar!'], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $idEdukasi)
    {
        $komentar = Komentar::where('ID_Edukasi', $idEdukasi)->get();

        if (!$komentar) {
            return response()->json(['message' => 'Komentar tidak ditemukan!'], 404);
        }

        return response()->json($komentar, 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Komentar $komentar)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $idKomentar)
    {
        $komentar = Komentar::find($idKomentar);

        if (!$komentar) {
            return response()->json(['message' => 'Komentar tidak ditemukan!'], 404);
        }

        $delete = $komentar->delete();

        if ($delete) {
            return response()->json(['message' => 'Berhasil menghapus Komentar'], 201);
        } else {
            return response()->json(['message' => 'Gagal menghapus Komentar!'], 403);
        }
    }
}
