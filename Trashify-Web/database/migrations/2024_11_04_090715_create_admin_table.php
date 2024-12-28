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
        Schema::create('Admin', function (Blueprint $table) {
            $table->id('ID_Admin');
            $table->foreignId('ID_User')->constrained('User', 'ID_User')->onDelete('cascade');
            $table->enum('Role_Admin', ['Master', 'Admin']);
            $table->timestamps();
        });
        $this->call(\Database\Seeders\AdminSeeder::class);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Admin');
    }

    protected function call($class)
    {
        (new $class)->run();
    }
};
