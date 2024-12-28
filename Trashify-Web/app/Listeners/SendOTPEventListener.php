<?php

namespace App\Listeners;

use App\Notifications\SendOTPNotification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class SendOTPEventListener
{
    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
    public function handle(object $event): void
    {
        if ($event->user->OTP) {
            $event->user->notify(new SendOTPNotification($event->user->OTP->Kode_Otp));
        }
    }
}
