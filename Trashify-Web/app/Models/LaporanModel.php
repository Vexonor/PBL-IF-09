<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class LaporanModel extends Model
{
    protected $table = "Pengaduan";
    protected $primaryKey = "ID_Pengaduan";
    protected $fillable = [
        "Kode_Pengaduan",
        "ID_User",
        "Kategori_Pengaduan",
        "Deskripsi_Pengaduan",
        "Titik_Koordinat",
        "Foto",
        "Gambar_Pengaduan",
        "Status_Pengaduan"
    ];
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $latestId = static::max('ID_Pengaduan');
            $nextId = $latestId + 1;
            $model->Kode_Pengaduan = 'PGD-' . str_pad($nextId, 3, '0', STR_PAD_LEFT);
        });
    }
    public function UserTable()
    {
        return $this->belongsTo(User::class, 'ID_User');
    }
    public function FotoTable()
    {
        return $this->hasMany(FotoModel::class, 'ID_Pengaduan');
    }
    public function PenanggungJawabTable()
    {
        return $this->belongsTo(PenanggungJawabModel::class, 'Kode_Pengaduan');
    }

    public function scopePengaduan(Builder $query, $search): void
    {
        $query->whereHas('UserTable', function ($adminQuery) use ($search) {
            $adminQuery->where('Nama', 'LIKE', '%' . $search . '%')
                ->orWhere('Kode_Pengaduan', 'LIKE', '%' . $search . '%');
        });
    }
}
