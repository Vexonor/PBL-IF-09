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
        Schema::create('Komentar', function (Blueprint $table) {
            $table->id('ID_Komentar');
            $table->foreignId('ID_Edukasi')->constrained('Konten_Edukasi', 'ID_Edukasi')->onDelete('cascade');
            $table->unsignedBigInteger('ID_User')->nullable();
            $table->foreign('ID_User')->references('ID_User')->on('User')->onDelete('set null');
            $table->longText('Isi_Komentar');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Komentar');
    }
};
