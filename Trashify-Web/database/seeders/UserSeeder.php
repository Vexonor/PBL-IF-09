<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Carbon\Carbon;
use Illuminate\Support\Str;
use Faker\Factory as Faker;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');

        foreach (range(1, 50) as $index) {
            DB::table('User')->insert([
                'Nama' => $faker->name,
                'Nik' => $faker->unique()->randomNumber(9, true),
                'Tanggal_Lahir' => $faker->date('Y-m-d', '2000-12-31'),
                'Jenis_Kelamin' => $faker->randomElement(['Laki-laki', 'Perempuan']),
                'Alamat' => $faker->address,
                'No_Telp' => $faker->phoneNumber,
                'Foto_Profil' => null,
                'email' => $faker->unique()->safeEmail,
                'email_verified_at' => now(),
                'password' => Hash::make('Password123'),
                'role' => $faker->randomElement(['Admin', 'Petugas', 'Warga']),
                'remember_token' => Str::random(10),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}