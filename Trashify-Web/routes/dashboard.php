<?php
// routes/web.php

use Illuminate\Support\Facades\Route;

// Admin route group
Route::prefix('admin')->group(function () {

    // Dashboard route
    Route::get('/dashboard', function () {
        return view('admin.dashboard'); // Will load resources/views/admin/dashboard.blade.php
    })->name('admin.dashboard');

    // Laporan route
    Route::get('/laporan', function () {
        return view('admin.laporan'); // Will load resources/views/admin/laporan.blade.php
    })->name('admin.laporan');

    // Informasi Pengangkutan route
    Route::get('/informasi-pengangkutan', function () {
        return view('admin.informasi_pengangkutan'); // Will load resources/views/admin/informasi_pengangkutan.blade.php
    })->name('admin.informasi_pengangkutan');

    // Lokasi TPS route
    Route::get('/lokasi-tps', function () {
        return view('admin.lokasi_tps'); // Will load resources/views/admin/lokasi_tps.blade.php
    })->name('admin.lokasi_tps');

    // Lokasi Bank Sampah route
    Route::get('/lokasi-bank-sampah', function () {
        return view('admin.lokasi_bank_sampah'); // Will load resources/views/admin/lokasi_bank_sampah.blade.php
    })->name('admin.lokasi_bank_sampah');

    // Admin settings route
    Route::get('/admin-settings', function () {
        return view('admin.admin_settings'); // Will load resources/views/admin/admin_settings.blade.php
    })->name('admin.admin_settings');

    // Petugas Kebersihan route
    Route::get('/petugas-kebersihan', function () {
        return view('admin.petugas_kebersihan'); // Will load resources/views/admin/petugas_kebersihan.blade.php
    })->name('admin.petugas_kebersihan');

});
