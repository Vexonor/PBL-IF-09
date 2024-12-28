<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use App\Models\InformasiModel;
use App\Models\PetugasModel;
use App\Models\user;
use Illuminate\Http\Request;

class InformasiPengangkutanMobileController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $informasiPengangkutan = InformasiModel::all();
        return response()->json($informasiPengangkutan);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show($idPetugas)
    {
        $informasiPetugasPengangkutan = PetugasModel::where('ID_Petugas', $idPetugas)->first();

        if (!$informasiPetugasPengangkutan) {
            return response()->json(['message' => 'Petugas tidak ditemukan!'], 404);
        }

        $wilayahBertugas = $informasiPetugasPengangkutan->Wilayah_Bertugas;

        $idUser = $informasiPetugasPengangkutan->ID_User;
        
        // Mencari user berdasarkan ID_User
        $user = User::find($idUser);
        
        // Mengambil nama user
        $namaPetugas  = $user?->Nama;
        $noTelp = $user?->No_Telp;

        if ($user) {
            return response()->json([
                'Wilayah_Bertugas' => $wilayahBertugas,
                'Nama' => $namaPetugas,
                'No_Telp' => $noTelp,
            ], 200);
        } else {
            return response()->json(['message' => 'Gagal memuat Petugas!'], 403);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, InformasiModel $informasiModel)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(InformasiModel $informasiModel)
    {
        //
    }
}
