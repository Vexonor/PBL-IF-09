<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class PetugasModel extends Model
{
    use HasFactory;

    protected $table = "Petugas_Kebersihan";
    protected $primaryKey = "id";
    protected $fillable = [
        "ID_User",
        "ID_Petugas",
        "Wilayah_Bertugas",
        "Tanggal_Bergabung",
        "Status_Keaktifan"
    ];
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $latestId = static::max('id');
            $nextId = $latestId + 1;
            $model->ID_Petugas = 'PTGS-' . str_pad($nextId, 3, '0', STR_PAD_LEFT);
        });
    }


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

    public function UserTable()
    {
        return $this->belongsTo(User::class, 'ID_User', 'ID_User');
    }

    public function InformasiTable()
    {
        return $this->hasMany(InformasiModel::class, 'ID_Petugas');
    }

    public function PengangkutanTable()
    {
        return $this->hasMany(PengangkutanModel::class, 'ID_Petugas', 'ID_Petugas');
    }

    public function PenanggungJawabTable()
    {
        return $this->hasMany(PenanggungJawabModel::class, 'ID_Petugas');
    }

    public function scopePetugas(Builder $query, $search): void
    {
        $query->whereHas('UserTable', function ($adminQuery) use ($search) {
            $adminQuery->where('Nama', 'LIKE', '%' . $search . '%');
        });
    }
}