<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\InformasiResource;
use App\Models\InformasiModel;
use Illuminate\Http\Request;

class InformasiController extends Controller
{
    public function index()
    {
        $admin = InformasiModel::latest()->get();

        return new InformasiResource(true, 'Data Informasi Pengangkutan', $admin);
    }
}