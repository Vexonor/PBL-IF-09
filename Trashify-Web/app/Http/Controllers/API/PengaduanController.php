<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\PengaduanResource;
use App\Models\LaporanModel;
use Illuminate\Http\Request;

class PengaduanController extends Controller
{
    public function index()
    {
        $pengaduan = LaporanModel::latest()->get();

        return new PengaduanResource(true, 'Data Pengaduan Warga', $pengaduan);
    }
}