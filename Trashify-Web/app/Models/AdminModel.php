<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;


class AdminModel extends Model
{
    use HasFactory;
    protected $table = "Admin";
    protected $primaryKey = "ID_Admin";
    protected $fillable = [
        "ID_User",
        "Role_Admin",
    ];

    public function UserTable()
    {
        return $this->belongsTo(User::class, 'ID_User', 'ID_User');
    }

    public function scopeAdmin(Builder $query, $search): void
    {
        $query->whereHas('UserTable', function ($adminQuery) use ($search) {
            $adminQuery->where('Nama', 'LIKE', '%' . $search . '%')
                ->orWhere('email', 'LIKE', '%' . $search . '%');
        });
    }
}
