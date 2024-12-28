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
        Schema::create('Petugas_Kebersihan', function (Blueprint $table) {
            $table->id();
            $table->string('ID_Petugas')->unique();
            $table->foreignId('ID_User')->constrained('User', 'ID_User')->onDelete('cascade');
            $table->enum('Wilayah_Bertugas', [
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
            $table->date('Tanggal_Bergabung');
            $table->enum('Status_Keaktifan', ['Aktif', 'Izin', 'Cuti']);
            $table->timestamps();
        });
        $this->call(\Database\Seeders\PetugasSeeder::class);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Petugas_Kebersihan');
    }

    protected function call($class)
    {
        (new $class)->run();
    }
};
