<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\KontenEdukasiResource;
use App\Models\KontenModel;
use Illuminate\Http\Request;

class KontenEdukasiController extends Controller
{
    public function index()
    {
        $kontenEdukasi = KontenModel::latest()->get();

        return new KontenEdukasiResource(true, 'Data Konten Edukasi', $kontenEdukasi);
    }
}