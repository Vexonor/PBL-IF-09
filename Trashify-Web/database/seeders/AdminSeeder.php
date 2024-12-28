<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;


class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');

        $admins = DB::table('User')->where('role', 'Admin')->pluck('ID_User');

        foreach ($admins as $index) {
            DB::table('Admin')->insert([
                'ID_User' => $index,
                'Role_Admin' => $faker->randomElement(['Master', 'Admin']),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
