<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class TPSModel extends Model
{
    use HasFactory;

    protected $table = "Lokasi_TPS";
    protected $primaryKey = "ID_TPS";
    protected $fillable = [
        "Kode_TPS",
        "Wilayah_TPS",
        "Titik_Koordinat",
        "Status_TPS",
    ];

    public static function getWilayahOptions()
    {
        return [
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
            'Batu Aji',
        ];
    }

    public function PengangkutanTable()
    {
        return $this->hasMany(PengangkutanModel::class, 'Kode_TPS');
    }

    public function scopeLokasiTPS(Builder $query, $search): void
    {
        $query->where('Kode_TPS', 'LIKE', '%' . $search . '%');
    }
}
