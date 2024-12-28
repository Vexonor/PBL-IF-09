<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\BankSampahResource;
use App\Models\BankSampahModel;
use Illuminate\Http\Request;

class BankSampahController extends Controller
{
    public function index()
    {
        $bankSampah = BankSampahModel::latest()->get();

        return new BankSampahResource(true, 'Data Bank Sampah', $bankSampah);
    }
}