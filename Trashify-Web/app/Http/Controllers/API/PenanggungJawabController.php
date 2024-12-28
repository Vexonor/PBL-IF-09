<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\PenanggungJawabResource;
use App\Models\PenanggungJawabModel;
use Illuminate\Http\Request;

class PenanggungJawabController extends Controller
{
    public function index()
    {
        $penanggungJawab = PenanggungJawabModel::latest()->get();

        return new PenanggungJawabResource(true, 'Data Penanggung Jawab Laporan', $penanggungJawab);
    }
}