<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class WargaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $wargas = DB::table('User')->where('role', 'Warga')->pluck('ID_User');

        foreach ($wargas as $index) {
            DB::table('Warga')->insert([
                'ID_User' => $index,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
