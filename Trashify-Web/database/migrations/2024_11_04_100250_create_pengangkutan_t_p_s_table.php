<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('Pengangkutan_TPS', function (Blueprint $table) {
            $table->id('ID_Pengangkutan');
            $table->char('Kode_TPS');
            $table->foreign('Kode_TPS')->references('Kode_TPS')->on('Lokasi_TPS')->onDelete('cascade');
            $table->char('ID_Petugas');
            $table->foreign('ID_Petugas')->references('ID_Petugas')->on('Petugas_Kebersihan')->onDelete('cascade');
            $table->date('Tanggal_Pengangkutan');
            $table->time('Jam_Pengangkutan');
            $table->enum('Status_Pengangkutan', ['Selesai', 'Belum Selesai', 'Tertunda']);
            $table->timestamps();
        });
        $this->call(\Database\Seeders\PengangkutanSeeder::class);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Pengangkutan_TPS');
    }

    protected function call($class)
    {
        (new $class)->run();
    }
};
