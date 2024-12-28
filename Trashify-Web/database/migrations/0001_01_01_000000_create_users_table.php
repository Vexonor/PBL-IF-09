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
        Schema::create('User', function (Blueprint $table) {
            $table->id('ID_User');
            $table->string('Nama');
            $table->bigInteger('Nik')->nullable();
            $table->date('Tanggal_Lahir')->nullable();
            $table->enum('Jenis_Kelamin', ['Laki-laki', 'Perempuan'])->nullable();
            $table->longText('Alamat')->nullable();
            $table->char('No_Telp')->nullable();
            $table->string('Foto_Profil')->nullable();
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->enum('role', ['Admin', 'Petugas', 'Warga']);
            $table->rememberToken();
            $table->timestamps();
        });
        $this->call(\Database\Seeders\UserSeeder::class);

        Schema::create('password_reset_tokens', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
        });

        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->foreignId('user_id')->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->longText('payload');
            $table->integer('last_activity')->index();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('User');
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('sessions');
    }

    protected function call($class)
    {
        (new $class)->run();
    }
};