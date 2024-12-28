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
        Schema::create('bank_sampah', function (Blueprint $table) {
            $table->id('ID_BankSampah');
            $table->string('Nama_Bank_Sampah');
            $table->enum('Jenis_Sampah', ['Plastik', 'Kaca', 'Kertas', 'Logam', 'Organik', 'Elektronik']);
            $table->char('Harga_Sampah');
            $table->string('Nama_Pemilik');
            $table->char('No_Telp');
            $table->enum('Wilayah_BankSampah', [
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
            $table->time('Jam_Buka');
            $table->time('Jam_Tutup');
            $table->enum('Status_Operasional', ['Buka', 'Tutup']);
            $table->timestamps();
        });
        $this->call(\Database\Seeders\BankSampahSeeder::class);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bank_sampah');
    }
    protected function call($class)
    {
        (new $class)->run();
    }
};
