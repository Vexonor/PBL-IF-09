<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\OTPResource;
use App\Http\Resources\WargaResource;
use App\Models\OTPModel;
use App\Models\User;
use Illuminate\Http\Request;

class OTPController extends Controller
{
    public function index()
    {
        $kodeOTP = OTPModel::with('UserTable')->latest()->get();

        return new OTPResource(true, 'Data User', $kodeOTP);
    }

    public function getOtp()
    {
        $otp = OTPModel::where('expired_at', '>', now())->first();

        if ($otp) {
            return response()->json(['expired_at' => $otp->expired_at]);
        } else {
            return response()->json(['error' => 'Kode OTP telah kedaluwarsa'], 404);
        }
    }
}
