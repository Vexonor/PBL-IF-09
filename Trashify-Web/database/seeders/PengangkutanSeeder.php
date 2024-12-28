<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class PengangkutanSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');

        $tpsList = DB::table('Lokasi_TPS')->pluck('Kode_TPS');

        $petugasList = DB::table('Petugas_Kebersihan')->pluck('ID_Petugas');

        foreach ($tpsList as $kode_tps) {
            $id_petugas = $faker->randomElement($petugasList);

            DB::table('Pengangkutan_TPS')->insert([
                'Kode_TPS' => $kode_tps,
                'ID_Petugas' => $id_petugas,
                'Tanggal_Pengangkutan' => $faker->dateTimeBetween('-1 month', 'now')->format('Y-m-d'),
                'Jam_Pengangkutan' => $faker->time('H:i:s'),
                'Status_Pengangkutan' => $faker->randomElement(['Selesai', 'Belum Selesai', 'Tertunda']),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
