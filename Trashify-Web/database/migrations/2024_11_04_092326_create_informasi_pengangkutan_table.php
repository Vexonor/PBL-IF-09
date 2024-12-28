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
        Schema::create('Informasi_Pengangkutan', function (Blueprint $table) {
            $table->id('ID_Informasi');
            $table->char('ID_Petugas');
            $table->foreign('ID_Petugas')->references('ID_Petugas')->on('Petugas_Kebersihan')->onDelete('cascade');
            $table->enum('Wilayah_Pengangkutan', [
                'Batu Ampar',
                'Bengkong',
                'Bulang',
                'Galang',
                'Lubuk Baja',
                'Nongsa',
                'Sagulung',
                'Sei Beduk',
                'Sekupang',
                'Batam Kota',
                'Belakang Padang',
                'Batu Aji'
            ]);
            $table->string('Titik_Koordinat');
            $table->date('Tanggal_Pengangkutan');
            $table->time('Jam_Pengangkutan');
            $table->enum('Status_Pengangkutan', ['Selesai', 'Belum Selesai', 'Tertunda']);
            $table->timestamps();
        });
        $this->call(\Database\Seeders\InformasiSeeder::class);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Informasi_Pengangkutan');
    }

    protected function call($class)
    {
        (new $class)->run();
    }
};
