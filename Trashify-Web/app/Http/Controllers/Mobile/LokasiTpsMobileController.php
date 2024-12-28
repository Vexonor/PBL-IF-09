<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use App\Models\TPSModel;
use Illuminate\Http\Request;

class LokasiTpsMobileController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
    public function show($kecamatan)
    {
        $lokasiTps = TPSModel::where('Wilayah_TPS', $kecamatan)->get();

        if (!$lokasiTps) {
            return response()->json(['message' => 'Lokasi TPS tidak ditemukan!'], 404);
        }

        return response()->json($lokasiTps, 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, TPSModel $tPSModel)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(TPSModel $tPSModel)
    {
        //
    }
}
