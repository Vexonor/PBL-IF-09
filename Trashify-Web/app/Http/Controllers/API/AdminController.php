<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\AdminResource;
use App\Models\AdminModel;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function index()
    {
        $admin = AdminModel::with('UserTable')->latest()->get();

        return new AdminResource(true, 'Data Admin', $admin);
    }
}