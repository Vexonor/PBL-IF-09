<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\PetugasResource;
use App\Models\PetugasModel;
use Illuminate\Http\Request;

class PetugasController extends Controller
{
    public function index()
    {
        $petugas = PetugasModel::with('UserTable')->latest()->get();

        return new PetugasResource(true, 'Data Petugas Kebersihan', $petugas);
    }
}