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
        Schema::create('Pengaduan', function (Blueprint $table) {
            $table->id('ID_Pengaduan');
            $table->string('Kode_Pengaduan')->unique();
            $table->foreignId('ID_User')->constrained('User', 'ID_User')->onDelete('cascade');
            $table->enum('Kategori_Pengaduan', ['Pengangkutan Sampah', 'Tempat Sampah Liar', 'Kondisi TPS', 'Lainnya']);
            $table->longText('Deskripsi_Pengaduan');
            $table->string('Titik_Koordinat');
            $table->string('Gambar_Pengaduan')->nullable();
            $table->enum('Status_Pengaduan', ['Selesai', 'Sedang Diproses', 'Belum Selesai'])->default('Belum Selesai');
            $table->timestamps();
        });

        Schema::create('Foto_Pengaduan', function (Blueprint $table) {
            $table->id('ID_Foto');
            $table->foreignId('ID_Pengaduan')->constrained('Pengaduan', 'ID_Pengaduan')->onDelete('cascade');
            $table->string('Foto');
            $table->timestamps();
        });
        $this->call(\Database\Seeders\LaporanSeeder::class);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Pengaduan');
        Schema::dropIfExists('Foto_Pengaduan');
    }
    protected function call($class)
    {
        (new $class)->run();
    }
};