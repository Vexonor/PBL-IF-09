<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class KontenEdukasiSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');

        for ($i = 0; $i < 20; $i++) {
            DB::table('Konten_Edukasi')->insert([
                'ID_User' => $faker->randomElement(DB::table('User')->where('role', 'Warga')->pluck('ID_User')->toArray()),
                'Judul_Edukasi' => $faker->sentence(6),
                'Link_URL' => $faker->url(),
                'Deskripsi_Edukasi' => $faker->paragraph(),
                'Jenis_Edukasi' => $faker->randomElement(['Video', 'Artikel']),
                'Status_Edukasi' => $faker->randomElement(['Draf', 'Telah Diunggah']),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}