<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class PengangkutanModel extends Model
{
    use HasFactory;

    protected $table = "Pengangkutan_TPS";
    protected $primaryKey = "ID_Pengangkutan";
    protected $fillable = [
        "Kode_TPS",
        "ID_Petugas",
        "Tanggal_Pengangkutan",
        "Jam_Pengangkutan",
        "Status_Pengangkutan"
    ];

    public function TPSTable()
    {
        return $this->belongsTo(TPSModel::class, 'Kode_TPS');
    }

    public function PetugasTable()
    {
        return $this->belongsTo(PetugasModel::class, 'ID_Petugas', 'ID_Petugas');
    }

    public function scopePengangkutanTPS(Builder $query, $search): void
    {
        if ($search) {
            $query->whereHas('PetugasTable.UserTable', function ($userQuery) use ($search) {
                $userQuery->where('Nama', 'LIKE', '%' . $search . '%')
                    ->orWhere('Kode_TPS', 'LIKE', '%' . $search . '%')
                    ->orWhere('ID_Petugas', 'LIKE', '%' . $search . '%');
            });
        }
    }
}