<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use App\Models\BankSampahModel;
use Illuminate\Http\Request;

class BankSampahMobileController extends Controller
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
    public function show($jenisSampah)
    {
        $bankSampah = BankSampahModel::where('Jenis_Sampah', $jenisSampah)->get();

        if (!$bankSampah) {
            return response()->json(['message' => 'Bank Sampah tidak ditemukan!'], 404);
        }

        return response()->json($bankSampah, 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, BankSampahModel $bankSampahModel)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BankSampahModel $bankSampahModel)
    {
        //
    }
}
