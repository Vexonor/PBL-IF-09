<!-- Tambah -->
<div id="tambah-modal"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="w-full max-h-full overflow-hidden flex flex-col bg-white border shadow-sm rounded-xl pointer-events-auto">
            <div class="flex justify-between items-center py-3 px-4 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Tambah Admin
                </h3>
                <button type="button"
                    class="size-8 inline-flex justify-center items-center gap-x-2 rounded-full border border-transparent bg-gray-100 text-gray-800 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#tambah-modal">
                    <span class="sr-only">Close</span>
                    <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round">
                        <path d="M18 6 6 18"></path>
                        <path d="m6 6 12 12"></path>
                    </svg>
                </button>
            </div>
            <div class="p-4 overflow-y-auto">
                <div class="space-y-4">
                    <form action="{{ route('admin.store') }}" method="post" enctype="multipart/form-data">
                        @csrf
                        <!-- Nama Lengkap -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Nama Lengkap
                                :</label>
                            <input type="text" id="input-label" name="Nama"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Lengkap" required>
                            @error('Nama')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Tanggal Lahir -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Tanggal
                                Lahir
                                :</label>
                            <input type="date" id="input-label" name="Tanggal_Lahir"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Lengkap" required>
                            @error('Tanggal_Lahir')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Jenis Kelamin -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jenis
                                Kelamin :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Jenis Kelamin",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600  \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Jenis_Kelamin" required>
                                <option value="">Pilih</option>
                                <option value="Laki-laki">Laki-laki</option>
                                <option value="Perempuan">Perempuan</option>
                            </select>
                            @error('Jenis_Kelamin')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Alamat -->
                        <div class="w-full mb-5">
                            <label for="textarea-label"
                                class="block text-sm 2xl:text-base font-medium mb-2">Alamat</label>
                            <textarea id="textarea-label" name="Alamat"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                rows="3" placeholder="Alamat" required></textarea>
                            @error('Alamat')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- No. Telepon -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">No. Telepon
                                :</label>
                            <input type="text" id="input-label" name="No_Telp"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan No. Telepon" required>
                            @error('No_Telp')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Email -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Email
                                :</label>
                            <input type="email" id="input-label" name="email"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Email" required>
                            @error('email')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Password -->
                        <div class="w-full mb-5">
                            <label class="block text-sm 2xl:text-base mb-2">Password</label>
                            <div class="relative">
                                <input id="oldPass" type="password" name="password"
                                    class="py-3 ps-4 pe-10 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                    placeholder="Enter password" value="password123" readonly>
                                <button type="button" data-hs-toggle-password='{
        "target": "#oldPass"
      }' class="absolute inset-y-0 end-0 flex items-center z-20 px-3 cursor-pointer text-gray-400 rounded-e-md focus:outline-none focus:text-blue-600 dark:text-neutral-600 dark:focus:text-blue-500">
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
                            </div>
                            @error('password')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Role Admin -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Role Admin
                                :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Role Admin",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600  \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Role_Admin" required>
                                <option value="">Pilih</option>
                                <option value="Master">Master Admin</option>
                                <option value="Admin">Admin</option>
                            </select>
                            @error('Role_Admin')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                </div>
            </div>
            <div class="flex justify-end items-center gap-x-2 py-3 px-4 border-t">
                <button type="button"
                    class="py-2 px-3 inline-flex items-center gap-x-2 text-sm 2xl:text-base font-medium rounded-lg border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 focus:outline-none focus:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none"
                    data-hs-overlay="#tambah-modal">
                    Tutup
                </button>
                <button type="submit"
                    class="py-2 px-3 inline-flex items-center gap-x-2 text-sm 2xl:text-base font-medium rounded-lg border border-transparent bg-Genoa text-white  focus:outline-none  disabled:opacity-50 disabled:pointer-events-none">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#ffffff" viewBox="0 0 256 256">
                        <path
                            d="M208,32H83.31A15.86,15.86,0,0,0,72,36.69L36.69,72A15.86,15.86,0,0,0,32,83.31V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32ZM88,48h80V80H88ZM208,208H48V83.31l24-24V80A16,16,0,0,0,88,96h80a16,16,0,0,0,16-16V48h24Zm-80-96a40,40,0,1,0,40,40A40,40,0,0,0,128,112Zm0,64a24,24,0,1,1,24-24A24,24,0,0,1,128,176Z">
                        </path>
                    </svg>
                    Simpan
                </button>
            </div>
            </form>
        </div>
    </div>
</div>

@foreach ($dataUser as $User)
<!-- Edit -->
<div id="edit-modal{{ $User->ID_User }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="w-full max-h-full overflow-hidden flex flex-col bg-white border shadow-sm rounded-xl pointer-events-auto">
            <div class="flex justify-between items-center py-3 px-4 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Edit Admin
                </h3>
                <button type="button"
                    class="size-8 inline-flex justify-center items-center gap-x-2 rounded-full border border-transparent bg-gray-100 text-gray-800 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#edit-modal{{ $User->ID_User }}">
                    <span class="sr-only">Close</span>
                    <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round">
                        <path d="M18 6 6 18"></path>
                        <path d="m6 6 12 12"></path>
                    </svg>
                </button>
            </div>
            <div class="p-4 overflow-y-auto">
                <div class="space-y-4">
                    <form action="{{ route('admin.update', ['ID_User' => $User -> ID_User]) }}" method="post">
                        @csrf
                        @method('PATCH')
                        <!-- Nama Lengkap -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Nama Lengkap
                                :</label>
                            <input type="text" id="input-label" name="Nama"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Lengkap" value="{{ $User->UserTable->Nama }}" required>
                            @error('Nama')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Tanggal Lahir -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Tanggal
                                Lahir
                                :</label>
                            <input type="date" id="input-label" name="Tanggal_Lahir"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Lengkap" value="{{ $User->UserTable->Tanggal_Lahir }}"
                                required>
                            @error('Tanggal_Lahir')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Jenis Kelamin -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jenis
                                Kelamin :</label>
                            <select name="Jenis_Kelamin"
                                class="py-3 px-4 pe-9 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                required>
                                <option value="" disabled>Pilih Jenis Kelamin</option>
                                <option value="Laki-laki"
                                    {{ $User->UserTable->Jenis_Kelamin == 'Laki-laki' ? 'selected' : '' }}>Laki-laki
                                </option>
                                <option value="Perempuan"
                                    {{ $User->UserTable->Jenis_Kelamin == 'Perempuan' ? 'selected' : '' }}>
                                    Perempuan</option>
                            </select>
                            @error('Jenis_Kelamin')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Alamat -->
                        <div class="w-full mb-5">
                            <label for="textarea-label"
                                class="block text-sm 2xl:text-base font-medium mb-2">Alamat</label>
                            <textarea id="textarea-label"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                rows="3" placeholder="Alamat" name="Alamat"
                                required>{{ $User->UserTable->Alamat }}</textarea>
                            @error('Alamat')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- No. Telepon -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">No. Telepon
                                :</label>
                            <input type="text" id="input-label" name="No_Telp"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan No. Telepon" value="{{ $User->UserTable->No_Telp }}" required>
                            @error('No_Telp')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Email -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Email
                                :</label>
                            <input type="email" id="input-label" name="email"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Email" value="{{ $User->UserTable->email }}" required>
                            @error('email')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Role Admin -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Role Admin
                                :</label>
                            <select name="Role_Admin"
                                class="py-3 px-4 pe-9 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                required>
                                <option selected="" disabled>Pilih Role Admin</option>
                                <option value="Master" {{ $User->Role_Admin == 'Master' ? 'selected' : '' }}>Master
                                    Admin</option>
                                <option value="Admin" {{ $User->Role_Admin == 'Admin' ? 'selected' : '' }}>
                                    Admin</option>
                            </select>
                            @error('Role_Admin')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                </div>
            </div>
            <div class="flex justify-end items-center gap-x-2 py-3 px-4 border-t">
                <button type="button"
                    class="py-2 px-3 inline-flex items-center gap-x-2 text-sm 2xl:text-base font-medium rounded-lg border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 focus:outline-none focus:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none"
                    data-hs-overlay="#edit-modal{{ $User->ID_User }}">
                    Tutup
                </button>
                <button type="submit"
                    class="py-2 px-3 inline-flex items-center gap-x-2 text-sm 2xl:text-base font-medium rounded-lg border border-transparent bg-Genoa text-white  focus:outline-none  disabled:opacity-50 disabled:pointer-events-none">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#ffffff" viewBox="0 0 256 256">
                        <path
                            d="M208,32H83.31A15.86,15.86,0,0,0,72,36.69L36.69,72A15.86,15.86,0,0,0,32,83.31V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32ZM88,48h80V80H88ZM208,208H48V83.31l24-24V80A16,16,0,0,0,88,96h80a16,16,0,0,0,16-16V48h24Zm-80-96a40,40,0,1,0,40,40A40,40,0,0,0,128,112Zm0,64a24,24,0,1,1,24-24A24,24,0,0,1,128,176Z">
                        </path>
                    </svg>
                    Simpan
                </button>
            </div>
            </form>
        </div>
    </div>
</div>

<!-- Hapus -->
<div id="hapus-modal{{ $User->ID_User }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-vertically-centered-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-lg sm:w-full m-3 sm:mx-auto min-h-[calc(100%-3.5rem)] flex items-center">
        <div class="w-full flex flex-col bg-white border shadow-sm rounded-xl pointer-events-auto">
            <div class="flex justify-between items-center py-3 px-4 border-b">
                <h3 id="hs-vertically-centered-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Hapus Admin
                </h3>
                <button type="button"
                    class="size-8 inline-flex justify-center items-center gap-x-2 rounded-full border border-transparent bg-gray-100 text-gray-800 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#hapus-modal{{ $User->ID_User }}">
                    <span class="sr-only">Close</span>
                    <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round">
                        <path d="M18 6 6 18"></path>
                        <path d="m6 6 12 12"></path>
                    </svg>
                </button>
            </div>
            <div class="p-4 overflow-y-auto">
                <p class="text-gray-800 2xl:text-lg text-center">
                    Apakah anda yakin ingin menghapus data ini?
                </p>

                <ul class="flex justify-center items-center gap-4 my-10">
                    <li><button type="button" data-hs-overlay="#hapus-modal{{ $User->ID_User }}"
                            class="btn-cancel w-32 py-3 px-4 justify-center inline-flex items-center gap-x-2 text-sm font-medium rounded-full border border-transparent bg-Medium-Carmine text-white focus:outline-none disabled:opacity-50 disabled:pointer-events-none">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                viewBox="0 0 256 256">
                                <path
                                    d="M205.66,194.34a8,8,0,0,1-11.32,11.32L128,139.31,61.66,205.66a8,8,0,0,1-11.32-11.32L116.69,128,50.34,61.66A8,8,0,0,1,61.66,50.34L128,116.69l66.34-66.35a8,8,0,0,1,11.32,11.32L139.31,128Z">
                                </path>
                            </svg>
                            Tidak
                        </button>
                    </li>
                    <li>
                        <form action="{{ route('admin.destroy', ['ID_User' => $User -> ID_User]) }}" method="post">
                            @csrf
                            @method('DELETE')
                            <button type="submit"
                                class="w-32 justify-center py-3 px-4 inline-flex items-center gap-x-2 text-sm font-medium rounded-full border border-transparent bg-Genoa text-white focus:outline-none disabled:opacity-50 disabled:pointer-events-none">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                    viewBox="0 0 256 256">
                                    <path
                                        d="M229.66,77.66l-128,128a8,8,0,0,1-11.32,0l-56-56a8,8,0,0,1,11.32-11.32L96,188.69,218.34,66.34a8,8,0,0,1,11.32,11.32Z">
                                    </path>
                                </svg>
                                Ya
                            </button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Detail -->
<div id="detail-modal{{ $User->ID_User }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="w-full max-h-full overflow-hidden flex flex-col bg-white border shadow-sm rounded-xl pointer-events-auto">
            <div class="flex justify-between items-center py-3 px-4 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Detail Admin
                </h3>
                <button type="button"
                    class="size-8 inline-flex justify-center items-center gap-x-2 rounded-full border border-transparent bg-gray-100 text-gray-800 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#detail-modal{{ $User->ID_User }}">
                    <span class="sr-only">Close</span>
                    <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round">
                        <path d="M18 6 6 18"></path>
                        <path d="m6 6 12 12"></path>
                    </svg>
                </button>
            </div>
            <div class="p-4 overflow-y-auto">
                <div class="space-y-4">
                    <form action="">
                        <!-- Nama Lengkap -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Nama Lengkap
                                :</label>
                            <input type="text" id="input-label"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Lengkap" value="{{ $User->UserTable->Nama }}" readonly>
                        </div>
                        <!-- Tanggal Lahir -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Tanggal
                                Lahir
                                :</label>
                            <input type="date" id="input-label"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Lengkap" value="{{ $User->UserTable->Tanggal_Lahir }}"
                                readonly>
                        </div>
                        <!-- Jenis Kelamin -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jenis
                                Kelamin :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Jenis Kelamin",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" readonly>
                                <option value="" disabled>Pilih</option>
                                <option value="">Pilih</option>
                                <option value="Laki-laki"
                                    {{ $User->UserTable->Jenis_Kelamin == 'Laki-laki' ? 'selected' : '' }}>Laki-laki
                                </option>
                                <option value="Perempuan"
                                    {{ $User->UserTable->Jenis_Kelamin == 'Perempuan' ? 'selected' : '' }}>
                                    Perempuan</option>
                            </select>
                        </div>
                        <!-- Alamat -->
                        <div class="w-full mb-5">
                            <label for="textarea-label"
                                class="block text-sm 2xl:text-base font-medium mb-2">Alamat</label>
                            <textarea id="textarea-label"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                rows="3" placeholder="Alamat" readonly>{{ $User->UserTable->Alamat }}</textarea>
                        </div>
                        <!-- No. Telepon -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">No. Telepon
                                :</label>
                            <input type="text" id="input-label"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan No. Telepon" value="{{ $User->UserTable->No_Telp }}" readonly>
                        </div>
                        <!-- Email -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Email
                                :</label>
                            <input type="email" id="input-label"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Email" value="{{ $User->UserTable->email }}" readonly>
                        </div>
                        <!-- Role Admin -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Role Admin
                                :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Role Admin",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" readonly>
                                <option value="" disabled>Pilih</option>
                                <option
                                    value="{{ $User->Role_Admin === 'Master' ||$User->Role_Admin === 'Admin' ? 'selected' : '' }}">
                                    {{ $User->Role_Admin === 'Master' ||$User->Role_Admin === 'Admin' ? $User->Role_Admin : '' }}
                                </option>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endforeach