<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\PengangkutanResource;
use App\Models\PengangkutanModel;
use Illuminate\Http\Request;

class PengangkutanController extends Controller
{
    public function index()
    {
        $pengangkutan = PengangkutanModel::latest()->get();

        return new PengangkutanResource(true, 'Data Pengangkutan TPS', $pengangkutan);
    }
}