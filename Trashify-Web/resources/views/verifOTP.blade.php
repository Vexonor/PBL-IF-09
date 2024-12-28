<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $title }}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap"
        rel="stylesheet">
    @vite('resources/css/app.css')
    @vite('resources/js/app.js')
</head>

<body class="font-poppins bg-Genoa">
    <!-- Message -->
    <div class="flex justify-center items-center">
        @include('alert/success')
        @include('alert/error')
    </div>
    <div class="flex justify-center items-center w-screen h-screen">
        <div
            class="w-6/12 bg-white border shadow-sm rounded-xl dark:bg-neutral-900 dark:border-neutral-700 dark:shadow-neutral-700/70">
            <div class="p-4 md:p-5">
                <p class="text-center font-semibold mt-2 text-gray-500 dark:text-neutral-400">
                    Harap mengisi form dibawah terlebih dahulu sebelum mengakses halaman dashboard
                </p>
                <form action="{{ route('otp.validate', $user->ID_User) }}" class="my-10" method="post"
                    enctype="multipart/form-data">
                    @csrf
                    <!-- Kode OTP -->
                    <div class="w-full mb-5">
                        <label for="input-label" class="block text-sm font-medium mb-2 dark:text-white">Kode OTP
                            :</label>
                        <input type="text" id="input-label" name="Kode_Otp"
                            class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-900 dark:border-neutral-700 dark:text-neutral-400 dark:placeholder-neutral-500 dark:focus:ring-neutral-600"
                            placeholder="Masukkan Kode" required autocomplete="off">

                        @error('Kode_Otp')
                        <p class="text-sm text-red-600 mt-2">{{ $message }}</p>
                        @enderror

                        @if (session('Kode_Otp'))
                        <p class="text-sm text-red-600 mt-2">{{ session('Kode_Otp') }}</p>
                        @endif
                    </div>

                    <button type="submit"
                        class="w-full mt-10 py-3 px-4 inline-flex justify-center items-center gap-x-2 text-sm font-medium rounded-lg border border-transparent bg-Genoa text-white disabled:opacity-50 disabled:pointer-events-none">
                        Verifikasi
                    </button>
                </form>

                <button class="mx-auto" id="resend-otp-btn" style="display: none;" type="button"
                    onclick="document.getElementById('resend-otp-form').submit();">Kirim Ulang Kode OTP</button>
                <p class="text-center" id="countdown-timer"></p>

                <!-- Formulir untuk mengirim ulang OTP -->
                <form id="resend-otp-form" action="{{ route('otp.resend') }}" method="POST" style="display: none;">
                    @csrf
                    <input type="hidden" name="ID_User" value="{{ $user->ID_User }}">
                </form>

            </div>
        </div>
    </div>


    <script>
        const fetchExpiredAt = async () => {
            try {
                const response = await fetch('http://localhost:8000/api/otp');
                if (!response.ok) throw new Error('Gagal mengambil data OTP');

                const data = await response.json();
                const expiredAt = data.data[0].expired_at;

                return new Date(expiredAt).getTime();
            } catch (error) {
                console.error(error);
                return null;
            }
        };

        const startCountdown = (expiredTime) => {
            const countdownTimer = setInterval(() => {
                const now = new Date().getTime();
                const distance = expiredTime - now;
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);
                const timerElement = document.getElementById('countdown-timer');

                if (distance > 0) {
                    timerElement.textContent = `${minutes} menit ${seconds} detik`;
                } else {
                    timerElement.textContent = '';
                    clearInterval(countdownTimer);
                    document.getElementById('resend-otp-btn').style.display = 'block'; // Tampilkan tombol
                }
            }, 1000);
        };

        const initCountdown = async () => {
            const expiredTime = await fetchExpiredAt();
            if (!expiredTime) {
                document.getElementById('countdown-timer').textContent =
                    'Kode OTP tidak valid atau telah kedaluwarsa.';
                return;
            }
            startCountdown(expiredTime);
        };

        initCountdown();

        const resendOtpUrl = "{{ route('otp.resend') }}";
        const sendOtpAgain = async () => {
            try {
                const userId = '{{ $user->ID_User }}';
                const form = new FormData();
                form.append('ID_User', userId);

                const response = await fetch(resendOtpUrl, {
                    method: 'POST',
                    body: form
                });

                if (!response.ok) throw new Error('Gagal mengirim OTP');

                const data = await response.json();
                const expiredAt = new Date(data.expired_at).getTime();

                startCountdown(expiredAt);
            } catch (error) {
                console.error(error);
            }
        };

        document.getElementById('resend-otp-btn').addEventListener('click', sendOtpAgain);
    </script>
</body>

</html>