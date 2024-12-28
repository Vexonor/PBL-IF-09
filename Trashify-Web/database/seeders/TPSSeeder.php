<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class TPSSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');

        foreach (range(1, 20) as $index) {
            DB::table('Lokasi_TPS')->insert([
                'Kode_TPS' => 'TPS-' . str_pad($index, 3, '0', STR_PAD_LEFT), // Kode unik TPS dalam format TPS-001, TPS-002, dst.
                'Wilayah_TPS' => $faker->randomElement([
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
                'Status_TPS' => $faker->randomElement(['Kosong', 'Penuh']),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
