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
        Schema::create('Lokasi_TPS', function (Blueprint $table) {
            $table->id('ID_TPS');
            $table->string('Kode_TPS')->unique();
            $table->enum('Wilayah_TPS', [
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
            $table->enum('Status_TPS', ['Kosong', 'Penuh']);
            $table->timestamps();
        });
        $this->call(\Database\Seeders\TPSSeeder::class);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Lokasi_TPS');
    }

    protected function call($class)
    {
        (new $class)->run();
    }
};
