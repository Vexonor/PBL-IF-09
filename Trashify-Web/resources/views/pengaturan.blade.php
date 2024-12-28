@extends('layouts/main')

@section('main')
<div class="grid grid-cols-3 gap-5">
    <div class="col-span-1 bg-slate-100 flex flex-col items-center h-screen rounded-md">
        <span class="inline-block size-24 mt-10 bg-gray-100 rounded-full overflow-hidden">
            <img class="size-full object-center bg-white rounded-full"
                src="{{ Auth::User()->Foto_Profil ? asset('storage/' . Auth::User()->Foto_Profil) : asset('/img/user.svg') }}"
                alt="Avatar">
        </span>
        <p class="font-bold text-center text-lg mt-5">{{ Auth::User()->Nama }}</p>

        <ul class="w-full flex flex-col items-center gap-3 mt-10">
            <li class="w-full flex justify-center items-center">
                <a href="#informasiPersonal"
                    class="py-3 px-4 w-11/12 inline-flex justify-center items-center gap-x-2 text-sm font-medium rounded-full border border-transparent bg-Genoa text-white disabled:opacity-50 disabled:pointer-events-none">
                    Informasi Personal
                </a>
            </li>
            <li class="w-full flex justify-center items-center">
                <a href="#ubahProfile"
                    class="py-3 px-4 w-11/12 inline-flex justify-center items-center gap-x-2 text-sm font-medium rounded-full border border-transparent bg-Genoa text-white disabled:opacity-50 disabled:pointer-events-none">
                    Ubah Profile
                </a>
            </li>
            <li class="w-full flex justify-center items-center">
                <a href="#ubahPassword"
                    class="py-3 px-4 w-11/12 inline-flex justify-center items-center gap-x-2 text-sm font-medium rounded-full border border-transparent bg-Genoa text-white disabled:opacity-50 disabled:pointer-events-none">
                    Ubah Password
                </a>
            </li>
        </ul>
    </div>

    <div class="col-span-2 bg-slate-100 rounded-md h-screen overflow-hidden">
        <!-- Section Informasi Personal -->
        <section id="informasiPersonal" class="h-screen py-1.5 xl:py-5">
            <h2 class="mx-5 my-5 text-lg font-bold">Informasi Personal</h2>
            <div class="grid grid-cols-1 p-5 xl:p-10 gap-4">
                <!-- Email -->
                <div class="w-full">
                    <label for="input-label" class="block text-sm font-medium mb-2">Email</label>
                    <input type="text" id="input-label"
                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                        placeholder="you@site.com" value="{{ Auth::User()->email }}" readonly>
                </div>
                <!-- No. Telepon -->
                <div class="w-full">
                    <label for="input-label" class="block text-sm font-medium mb-2">No. Telepon</label>
                    <input type="text" id="input-label"
                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                        placeholder="0812345678" value="{{ Auth::User()->No_Telp }}" readonly>
                </div>
                <!-- Alamat -->
                <div class="w-full">
                    <label for="textarea-label" class="block text-sm font-medium mb-2">Alamat</label>
                    <textarea id="textarea-label"
                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                        rows="3" placeholder="Alamat" readonly>{{ Auth::User()->Alamat }}</textarea>
                </div>
                <!-- Jenis Kelamin -->
                <div class="w-full">
                    <label for="input-label" class="block text-sm font-medium mb-2">Jenis
                        Kelamin</label>
                    <input type="text" id="input-label"
                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                        placeholder="Jenis Kelamin" value="{{ Auth::User()->Jenis_Kelamin }}" readonly>
                </div>
                <!-- NIK -->
                <div class="w-full">
                    <label for="input-label" class="block text-sm font-medium mb-2">NIK</label>
                    <input type="text" id="input-label"
                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                        placeholder="NIK" value="{{ Auth::User()->Nik }}" readonly>
                </div>
            </div>
        </section>

        <!-- Section Ubah Profile -->
        <section id="ubahProfile"
            class="h-screen py-5 overflow-auto  [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-track]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-thumb]:bg-gray-300">
            <h2 class="mx-5 mt-5 text-lg font-bold">Ubah Profile</h2>
            <div class="grid grid-cols-1 p-10 gap-4">
                <form action="{{ route('pengaturan.update', ['ID_User' => Auth::User()->ID_User]) }}" method="post"
                    enctype="multipart/form-data">
                    @csrf
                    @method('PATCH')
                    <!-- Nama -->
                    <div class="w-full">
                        <label for="input-label" class="block text-sm font-medium mb-2">Nama</label>
                        <input type="text" id="input-label"
                            class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                            placeholder="Nama" name="Nama" value="{{ Auth::User()->Nama }}" required>
                    </div>
                    <!-- Photo Profile -->
                    <div class="w-full">
                        <label for="input-label" class="block text-sm font-medium mb-2">Foto
                            Profile</label>
                        <input type="file" name="Foto_Profil" id="file-input"
                            class="block w-full border border-gray-200 shadow-sm rounded-lg text-sm focus:z-10 focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none file:bg-gray-50 file:border-0 file:me-4 file:py-3 file:px-4">
                    </div>
                    <!-- Email -->
                    <div class="w-full">
                        <label for="input-label" class="block text-sm font-medium mb-2">Email</label>
                        <input type="text" id="input-label"
                            class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                            placeholder="you@site.com" name="email" value="{{ Auth::User()->email }}" required>
                    </div>
                    <!-- No. Telepon -->
                    <div class="w-full">
                        <label for="input-label" class="block text-sm font-medium mb-2">No.
                            Telepon</label>
                        <input type="text" id="input-label"
                            class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                            placeholder="0812345678" name="No_Telp" value="{{ Auth::User()->No_Telp }}" required>
                    </div>
                    <!-- Alamat -->
                    <div class="w-full">
                        <label for="textarea-label" class="block text-sm font-medium mb-2">Alamat</label>
                        <textarea id="textarea-label"
                            class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                            rows="3" placeholder="Alamat" name="Alamat" required>{{ Auth::User()->Alamat }}</textarea>
                    </div>
                    <!-- Jenis Kelamin -->
                    <label for="hs-select-label" class="block text-sm font-medium mb-2">Jenis
                        Kelamin</label>
                    <select id="hs-select-label" name="Jenis_Kelamin"
                        class="py-3 px-4 pe-9 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none">
                        <option disabled="">Pilih Jenis Kelamin</option>
                        <option value="Laki-laki"
                            {{ Auth::User()->Jenis_Kelamin == 'Laki-laki' ? 'selected' : '' }}>Laki -
                            Laki</option>
                        <option value="Perempuan" {{ Auth::User()->Jenis_Kelamin == 'Perempuan' ? 'selected' : '' }}>
                            Perempuan
                        </option>
                    </select>
                    <!-- NIK -->
                    <div class="w-full">
                        <label for="input-label" class="block text-sm font-medium mb-2">NIK</label>
                        <input type="text" id="input-label"
                            class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                            placeholder="NIK" name="Nik" value="{{ Auth::User()->Nik }}" required>
                    </div>
                    <!-- Button Simpan -->
                    <button type="submit"
                        class="py-3 px-4 w-full mt-10 inline-flex justify-center items-center gap-x-2 text-sm font-medium rounded-lg border border-transparent bg-Genoa text-white disabled:opacity-50 disabled:pointer-events-none">
                        Simpan Perubahan
                    </button>
                </form>
            </div>
        </section>

        <!-- Section Ubah Password -->
        <section id="ubahPassword" class="h-screen py-5">
            <h2 class="mx-5 mt-5 text-lg font-bold">Ubah Password</h2>
            <p class="mx-5 text-xs">Untuk memperbarui kata sandi anda tolong masukkan kata sandi anda sebelumnya</p>
            <div class="grid grid-cols-1 p-10 gap-4">
                <form action="{{ route('change.password', ['ID_User' => Auth::User()->ID_User]) }}" method="post">
                    @csrf
                    @method('PUT')
                    <!-- Kata Sandi Baru -->
                    <div class="w-full">
                        <label class="block text-sm mb-2">Password Baru</label>
                        <div class="flex">
                            <div class="relative flex-1">
                                <input type="password" id="new-pass"
                                    class="py-3 px-4 block w-full border-gray-200 rounded-md text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                    placeholder="Enter password" name="newPass">
                                <button type="button" data-hs-toggle-password='{
                                    "target": "#new-pass"
                                    }'
                                    class="absolute inset-y-0 end-0 flex items-center z-20 px-3 cursor-pointer text-gray-400 rounded-e-md focus:outline-none focus:text-blue-600">
                                    <svg class="shrink-0 size-3.5" width="24" height="24" viewBox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
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
                                <div id="hs-strong-password-popover-new-pass"
                                    class="hidden absolute z-50 w-full bg-white shadow-md rounded-lg p-4">
                                    <div id="hs-strong-password-in-popover" data-hs-strong-password='{
                                    "target": "#new-pass",
                                    "hints": "#hs-strong-password-popover-new-pass",
                                    "stripClasses": "hs-strong-password:opacity-100 hs-strong-password-accepted:bg-teal-500 h-2 flex-auto rounded-full bg-Genoa opacity-50 mx-1",
                                    "mode": "popover"
                                }' class="flex mt-2 -mx-1">
                                    </div>

                                    <h4 class="mt-3 text-sm font-semibold text-gray-800">
                                        Password Harus Memiliki :
                                    </h4>

                                    <ul class="space-y-1 text-sm text-gray-500">
                                        <li data-hs-strong-password-hints-rule-text="min-length"
                                            class="hs-strong-password-active:text-teal-500 flex items-center gap-x-2">
                                            <span class="hidden" data-check="">
                                                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                                    width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <polyline points="20 6 9 17 4 12"></polyline>
                                                </svg>
                                            </span>
                                            <span data-uncheck="">
                                                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                                    width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <path d="M18 6 6 18"></path>
                                                    <path d="m6 6 12 12"></path>
                                                </svg>
                                            </span>
                                            Jumlah Password Minimal 6 Karakter.
                                        </li>
                                        <li data-hs-strong-password-hints-rule-text="lowercase"
                                            class="hs-strong-password-active:text-teal-500 flex items-center gap-x-2">
                                            <span class="hidden" data-check="">
                                                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                                    width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <polyline points="20 6 9 17 4 12"></polyline>
                                                </svg>
                                            </span>
                                            <span data-uncheck="">
                                                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                                    width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <path d="M18 6 6 18"></path>
                                                    <path d="m6 6 12 12"></path>
                                                </svg>
                                            </span>
                                            Harus Memiliki Huruf Kecil.
                                        </li>
                                        <li data-hs-strong-password-hints-rule-text="uppercase"
                                            class="hs-strong-password-active:text-teal-500 flex items-center gap-x-2">
                                            <span class="hidden" data-check="">
                                                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                                    width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <polyline points="20 6 9 17 4 12"></polyline>
                                                </svg>
                                            </span>
                                            <span data-uncheck="">
                                                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                                    width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <path d="M18 6 6 18"></path>
                                                    <path d="m6 6 12 12"></path>
                                                </svg>
                                            </span>
                                            Harus Memiliki Huruf Besar.
                                        </li>
                                        <li data-hs-strong-password-hints-rule-text="numbers"
                                            class="hs-strong-password-active:text-teal-500 flex items-center gap-x-2">
                                            <span class="hidden" data-check="">
                                                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                                    width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <polyline points="20 6 9 17 4 12"></polyline>
                                                </svg>
                                            </span>
                                            <span data-uncheck="">
                                                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                                    width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <path d="M18 6 6 18"></path>
                                                    <path d="m6 6 12 12"></path>
                                                </svg>
                                            </span>
                                            Harus Memilii Angka.
                                        </li>
                                        <li data-hs-strong-password-hints-rule-text="special-characters"
                                            class="hs-strong-password-active:text-teal-500 flex items-center gap-x-2">
                                            <span class="hidden" data-check="">
                                                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                                    width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <polyline points="20 6 9 17 4 12"></polyline>
                                                </svg>
                                            </span>
                                            <span data-uncheck="">
                                                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                                    width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <path d="M18 6 6 18"></path>
                                                    <path d="m6 6 12 12"></path>
                                                </svg>
                                            </span>
                                            Harus Memiliki Karakter Khusus.
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Konfirmasi Kata Sandi Baru -->
                    <div class="w-full my-5">
                        <label class="block text-sm mb-2">Konfirmasi Password</label>
                        <div class="relative">
                            <input id="confirmPass" type="password" name="password"
                                class="py-3 ps-4 pe-10 block w-full border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Enter password" value="" required>
                            <button type="button" data-hs-toggle-password='{
                            "target": "#confirmPass"
                            }'
                                class="absolute inset-y-0 end-0 flex items-center z-20 px-3 cursor-pointer text-gray-400 rounded-e-md focus:outline-none focus:text-blue-600">
                                <svg class="shrink-0 size-3.5" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <path class="hs-password-active:hidden" d="M9.88 9.88a3 3 0 1 0 4.24 4.24"></path>
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

                    <!-- Peringatan jika password tidak cocok -->
                    <small id="error-message" class="text-base text-red-500 hidden">
                        Password Baru dan Konfirmasi Password Tidak Cocok.
                    </small>

                    <!-- Button Simpan -->
                    <div class="w-full my-5">
                        <button type="submit" id="submit-pass"
                            class="w-full py-3  px-4 inline-flex justify-center items-center gap-x-2 text-sm font-medium rounded-lg border border-transparent bg-Genoa text-white disabled:opacity-50 disabled:pointer-events-none">
                            Simpan Perubahan
                        </button>
                    </div>
                </form>
            </div>
    </div>
    </section>
</div>
</div>


@endsection