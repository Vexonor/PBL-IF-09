<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $title }}</title>
    <link rel="icon" type="image/x-icon" href="{{ asset('img/Trashify-Icon.png') }}">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap"
        rel="stylesheet">
    @vite('resources/css/app.css')
    @vite('resources/css/loader.css')
    @vite('resources/js/app.js')
    @vite('resources/js/loader.js')
</head>

<body class="font-poppins bg-Genoa">
    <!-- Loader -->
    <div class="loader-wrapper fixed top-0 left-0 bg-Genoa flex justify-center items-center w-full h-full z-[9999]">
        <div class="loader">
            @include('components/loaders')
        </div>
    </div>
    <!-- Message -->
    <div class="flex justify-center items-center">
        @include('alert/roleError')
    </div>
    <div class="flex justify-center items-center w-screen h-screen">
        <div class="w-5/12 flex flex-col bg-white border shadow-sm rounded-xl">
            <div class="p-4 md:p-5">
                <p class="text-center 2xl:text-lg font-semibold mt-2 text-gray-500">
                    Harap mengisi form dibawah terlebih dahulu sebelum mengakses halaman dashboard
                </p>
                @error('email')
                <p class="text-base 2xl:text-lg font-semibold text-center text-red-600 mt-2"
                    id="hs-validation-name-error-helper">
                    {{ $message }}
                </p>
                @enderror
                @error('password')
                <p class="text-base 2xl:text-lg font-semibold text-center text-red-600 mt-2"
                    id="hs-validation-name-error-helper">
                    {{ $message }}
                </p>
                @enderror
                <form action="{{ route('login.process') }}" class="my-10" method="post" enctype="multipart/form-data">
                    @csrf
                    <!-- Email -->
                    <div class="w-full mb-5">
                        <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Email
                            :</label>
                        <input type="email" id="input-label" name="email"
                            class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                            placeholder="Masukkan Email" required>
                    </div>
                    <!-- Password -->
                    <div class="w-full mb-5">
                        <label class="block text-sm 2xl:text-base mb-2">Password :</label>
                        <div class="relative">
                            <input id="oldPass" type="password" name="password"
                                class="py-3 ps-4 pe-10 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Enter password" required>
                            <button type="button" data-hs-toggle-password='{
                                        "target": "#oldPass"
                                    }'
                                class="absolute inset-y-0 end-0 flex items-center z-20 px-3 cursor-pointer text-gray-400 rounded-e-md focus:outline-none focus:text-blue-600">
                                <svg class="shrink-0 size-3.5" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <path class="hs-password-active:hidden" d="M9.88 9.88a3 3 0 1 0 4.24 4.24">
                                    </path>
                                    <path class="hs-password-active:hidden"
                                        d="M10.73 5.08A10.43 10.43 0 0 1 12 5c7 0 10 7 10 7a13.16 13.16 0 0 1-1.67 2.68">
                                    </path>
                                    <path class="hs-password-active:hidden"
                                        d="M6.61 6.61A13.526 13.526 0 0 0 2 12s3 7 10 7a9.74 9.74 0 0 0 5.39-1.61">
                                    </path>
                                    <line class="hs-password-active:hidden" x1="2" x2="22" y1="2" y2="22"></line>
                                    <path class="hidden hs-password-active:block"
                                        d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"></path>
                                    <circle class="hidden hs-password-active:block" cx="12" cy="12" r="3"></circle>
                                </svg>
                            </button>
                        </div>
                    </div>
                    <button type="submit"
                        class="w-full mt-10 py-3 px-4 inline-flex justify-center items-center gap-x-2 text-sm 2xl:text-base font-medium rounded-lg border border-transparent bg-Genoa text-white disabled:opacity-50 disabled:pointer-events-none">
                        Masuk
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>

</html>