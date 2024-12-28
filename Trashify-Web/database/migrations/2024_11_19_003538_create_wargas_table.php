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
        Schema::create('warga', function (Blueprint $table) {
            $table->id('ID_Warga');
            $table->foreignId('ID_User')->constrained('User', 'ID_User')->onDelete('cascade');
            $table->timestamps();
        });
        $this->call(\Database\Seeders\WargaSeeder::class);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('wargas');
    }

    protected function call($class)
    {
        (new $class)->run();
    }
};
