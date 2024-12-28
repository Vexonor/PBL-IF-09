<?php

use App\Http\Controllers\admin;
use App\Http\Controllers\Mobile\AutentikasiMobileController;
use App\Http\Controllers\Mobile\BankSampahMobileController;
use App\Http\Controllers\Mobile\BerandaMobileController;
use App\Http\Controllers\Mobile\InformasiPengangkutanMobileController;
use App\Http\Controllers\Mobile\KomentarMobileController;
use App\Http\Controllers\Mobile\KontenEdukasiMobileController;
use App\Http\Controllers\Mobile\LokasiTpsMobileController;
use App\Http\Controllers\Mobile\PengaduanMobileController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Admin
Route::apiResource('/informasiPengangkutan', App\Http\Controllers\API\InformasiController::class);
Route::apiResource('/otp', App\Http\Controllers\API\OTPController::class);

//Mobile
Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

//Auth
Route::post('/masuk', [AutentikasiMobileController::class, 'masuk']);
Route::post('/daftar', [AutentikasiMobileController::class, 'daftar']);
Route::post('/pembuka', [AutentikasiMobileController::class, 'store']);

Route::middleware('auth:sanctum')->group(function () {

    // Pengaduan
    Route::get('/pengaduan', [PengaduanMobileController::class, 'index']);
    Route::get('/pengaduan/{id}', [PengaduanMobileController::class, 'show']);
    Route::post('/pengaduan', [PengaduanMobileController::class, 'store']);
    Route::post('/pengaduan/{id}', [PengaduanMobileController::class, 'update']);
    Route::delete('/pengaduan/{id}', [PengaduanMobileController::class, 'destroy']);

    // Informasi pengangkutan
    Route::get('/informasi_pengangkutan', [InformasiPengangkutanMobileController::class, 'index']);
    Route::get('/informasi_pengangkutan/{idPetugas}', [InformasiPengangkutanMobileController::class, 'show']);

    // Edukasi
    Route::get('/konten_edukasi', [KontenEdukasiMobileController::class, 'index']);
    Route::get('/konten_edukasi/{kontenEdukasi}', [KontenEdukasiMobileController::class, 'show']);
    Route::get('/konten_edukasi/user/{user}', [KontenEdukasiMobileController::class, 'indexGalery']);
    Route::get('/konten_edukasi/detail/{kontenEdukasi}', [KontenEdukasiMobileController::class, 'showDetail']);
    Route::post('/konten_edukasi', [KontenEdukasiMobileController::class, 'store']);
    Route::post('/konten_edukasi/{kontenEdukasi}', [KontenEdukasiMobileController::class, 'update']);
    Route::delete('/konten_edukasi/{kontenEdukasi}', [KontenEdukasiMobileController::class, 'destroy']);

    // Komentar
    Route::get('/komentar', [KomentarMobileController::class, 'index']);
    Route::get('/komentar/{kontenEdukasi}', [KomentarMobileController::class, 'show']);
    Route::post('/komentar', [KomentarMobileController::class, 'store']);
    Route::delete('/komentar/{komentar}', [KomentarMobileController::class, 'destroy']);

    // Lokasi TPS
    Route::get('/lokasi_tps/{kecamatan}', [LokasiTpsMobileController::class, 'show']);

    // Bank Sampah
    Route::get('/bank_sampah/{jenisSampah}', [BankSampahMobileController::class, 'show']);

    // Pengaturan
    Route::post('/ubah_profil/{user}', [AutentikasiMobileController::class, 'updateProfil']);
    Route::post('/ubah_kata_sandi/{user}', [AutentikasiMobileController::class, 'updateKataSandi']);
});
