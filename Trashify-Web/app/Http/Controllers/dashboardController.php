<?php

namespace App\Http\Controllers;

use App\Models\AdminModel;
use App\Models\InformasiModel;
use App\Models\LaporanModel;
use App\Models\PetugasModel;
use App\Models\TPSModel;
use Illuminate\Http\Request;

class dashboardController extends Controller
{
    public function dashboard()
    {
        $totalLaporan = LaporanModel::count();
        $totalInformasi = InformasiModel::count();
        $totalTPS = TPSModel::count();
        $totalAdmin = AdminModel::count();
        $totalPetugas = PetugasModel::count();
        $wilayahOptions = InformasiModel::getWilayahOptions();
        return view('/dashboard', [
            "title" => "Dashboard",
            "totalLaporan" => $totalLaporan,
            "totalInformasi" => $totalInformasi,
            "totalTPS" => $totalTPS,
            "totalAdmin" => $totalAdmin,
            "totalPetugas" => $totalPetugas,
            "wilayahOptions" => $wilayahOptions
        ]);
    }
}
