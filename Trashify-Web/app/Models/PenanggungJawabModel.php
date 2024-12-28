<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class PenanggungJawabModel extends Model
{
    protected $table = "Penanggung_Jawab";
    protected $primaryKey = "ID_PJ";
    protected $fillable = [
        "Kode_Pengaduan",
        "ID_Petugas",
        "Kategori_Pengaduan",
        "Status_Pengaduan",
    ];
    public function PengaduanTable()
    {
        return $this->belongsTo(LaporanModel::class, 'Kode_Pengaduan');
    }
    public function PetugasTable()
    {
        return $this->belongsTo(PetugasModel::class, 'ID_Petugas', 'ID_Petugas');
    }

    public function scopePenanggungJawab(Builder $query, $search): void
    {
        $query->whereHas('PetugasTable.UserTable', function ($userQuery) use ($search) {
            $userQuery->where('Nama', 'LIKE', '%' . $search . '%')
                ->orWhere('Kode_Pengaduan', 'LIKE', '%' . $search . '%');
        });
    }
}
