<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class RouteServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public const HOME = '/dashboard';

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        //
    }
}