<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class InformasiSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');
        $petugas = DB::table('Petugas_Kebersihan')->pluck('ID_Petugas');

        for ($i = 0; $i < 400; $i++) {
            $id_petugas = $faker->randomElement($petugas);

            DB::table('Informasi_Pengangkutan')->insert([
                'ID_Petugas' => $id_petugas,
                'Wilayah_Pengangkutan' => $faker->randomElement([
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
                ]),
                'Titik_Koordinat' => $faker->latitude . ', ' . $faker->longitude,
                'Tanggal_Pengangkutan' => $faker->dateTimeBetween('first day of January 2020', 'last day of December 2024')->format('Y-m-d'),
                'Jam_Pengangkutan' => $faker->time('H:i:s'),
                'Status_Pengangkutan' => $faker->randomElement(['Selesai', 'Belum Selesai', 'Tertunda']),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
