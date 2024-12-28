<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class InformasiModel extends Model
{
    use HasFactory;

    protected $table = "Informasi_Pengangkutan";
    protected $primaryKey = "ID_Informasi";
    protected $fillable = [
        "ID_Petugas",
        "Wilayah_Pengangkutan",
        "Titik_Koordinat",
        "Tanggal_Pengangkutan",
        "Jam_Pengangkutan",
        "Status_Pengangkutan",
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

    public function PetugasTable()
    {
        return $this->belongsTo(PetugasModel::class, 'ID_Petugas', 'ID_Petugas');
    }

    public function scopeInformasi(Builder $query, $search): void
    {
        if ($search) {
            $query->whereHas('PetugasTable.UserTable', function ($userQuery) use ($search) {
                $userQuery->where('Nama', 'LIKE', '%' . $search . '%')
                    ->orWhere('Tanggal_Pengangkutan', 'LIKE', '%' . $search . '%');
            });
        }
    }
}
