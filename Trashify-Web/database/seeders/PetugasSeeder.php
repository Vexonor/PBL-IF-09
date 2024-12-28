<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Faker\Factory as Faker;

class PetugasSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');

        $petugas = DB::table('User')->where('role', 'Petugas')->pluck('ID_User');

        foreach ($petugas as $index => $id_user) {
            DB::table('Petugas_Kebersihan')->insert([
                'ID_Petugas' => 'PTGS-' . str_pad($index + 1, 2, '0', STR_PAD_LEFT), // ID unik, format PTGS-01, PTGS-02, dst.
                'ID_User' => $id_user,
                'Wilayah_Bertugas' => $faker->randomElement([
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
                'Tanggal_Bergabung' => $faker->date('Y-m-d', '2024-01-01'), // Tanggal bergabung acak sebelum 2024
                'Status_Keaktifan' => $faker->randomElement(['Aktif', 'Izin', 'Cuti']),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
