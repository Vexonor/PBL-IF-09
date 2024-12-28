<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\TPSResource;
use App\Models\TPSModel;
use Illuminate\Http\Request;

class TPSController extends Controller
{
    public function index()
    {
        $tps = TPSModel::latest()->get();

        return new TPSResource(true, 'Data Lokasi TPS', $tps);
    }
}