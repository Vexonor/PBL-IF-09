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
        Schema::create('User_Otp', function (Blueprint $table) {
            $table->id();
            $table->foreignId('ID_User')->constrained('User', 'ID_User')->onDelete('cascade');
            $table->integer('Kode_Otp');
            $table->dateTime('expired_at');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('User_Otp');
    }
};
