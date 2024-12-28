<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class BankSampahSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');

        for ($i = 0; $i < 20; $i++) {
            DB::table('bank_sampah')->insert([
                'Nama_Bank_Sampah' => $faker->company,
                'Jenis_Sampah' => $faker->randomElement(['Plastik', 'Kaca', 'Kertas', 'Logam', 'Organik', 'Elektronik']),
                'Harga_Sampah' => 'Rp ' . number_format($faker->numberBetween(1000, 30000), 0, ',', '.'),
                'Nama_Pemilik' => $faker->name,
                'No_Telp' => $faker->phoneNumber,
                'Wilayah_BankSampah' => $faker->randomElement([
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
                'Jam_Buka' => $faker->time('H:i', '08:00'),
                'Jam_Tutup' => $faker->time('H:i', '17:00'),
                'Status_Operasional' => $faker->randomElement(['Buka', 'Tutup']),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
