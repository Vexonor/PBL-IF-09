<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class PenanggungJawabSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');

        $laporanList = DB::table('Pengaduan')->pluck('Kode_Pengaduan');
        $petugasList = DB::table('Petugas_Kebersihan')->where('Status_Keaktifan', 'Aktif')->pluck('ID_Petugas');

        for ($i = 0; $i < 20; $i++) {
            DB::table('Penanggung_Jawab')->insert([
                'Kode_Pengaduan' => $faker->randomElement($laporanList),
                'ID_Petugas' => $faker->randomElement($petugasList),
                'Kategori_Pengaduan' => $faker->randomElement(['Pengangkutan Sampah', 'Tempat Sampah Liar', 'Kondisi TPS', 'Lainnya']),
                'Status_Pengaduan' => $faker->randomElement(['Selesai', 'Sedang Diproses', 'Belum Selesai']),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}