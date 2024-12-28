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
                    Tambah Bank Sampah
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
                    <form action="{{ route('bankSampah.store') }}" method="post" enctype="multipart/form-data">
                        @csrf
                        <!-- Nama Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Nama Bank
                                Sampah :</label>
                            <input type="text" id="input-label" name="Nama_Bank_Sampah"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Bank Sampah" required>
                            @error('Nama_Bank_Sampah')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Jenis Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jenis
                                Bank Sampah :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Jenis Sampah",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Jenis_Sampah" required>
                                <option value="">Pilih Jenis Sampah</option>
                                <option value="Plastik">Plastik</option>
                                <option value="Kaca">Kaca</option>
                                <option value="Kertas">Kertas</option>
                                <option value="Logam">Logam</option>
                                <option value="Organik">Organik</option>
                                <option value="Elektronik">Elektronik</option>
                            </select>
                            @error('Jenis_Sampah')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Harga Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Harga Sampah
                                per Kg :</label>
                            <div class="py-2 px-3 border border-gray-200 rounded-lg" data-hs-input-number="">
                                <div class="w-full flex justify-between items-center gap-x-5">
                                    <div class="grow">
                                        <input
                                            class="price-input w-full p-0 bg-transparent border-0 text-gray-800 focus:ring-0 [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
                                            style="-moz-appearance: textfield;" type="text"
                                            aria-roledescription="Number field" name="Harga_Sampah" value="0">
                                    </div>
                                    <div class="flex justify-end items-center gap-x-1.5">
                                        <button class="decrement-button  border border-gray-200 p-1 rounded-md"
                                            type="button" aria-label="Decrease">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="size-5" fill="currentColor"
                                                viewBox="0 0 256 256">
                                                <path
                                                    d="M224,128a8,8,0,0,1-8,8H40a8,8,0,0,1,0-16H216A8,8,0,0,1,224,128Z">
                                                </path>
                                            </svg>
                                        </button>
                                        <button class="increment-button border border-gray-200 p-1 rounded-md"
                                            type="button" aria-label="Increase">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="size-5" fill="currentColor"
                                                viewBox="0 0 256 256">
                                                <path
                                                    d="M224,128a8,8,0,0,1-8,8H136v80a8,8,0,0,1-16,0V136H40a8,8,0,0,1,0-16h80V40a8,8,0,0,1,16,0v80h80A8,8,0,0,1,224,128Z">
                                                </path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            @error('Harga_Sampah')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Nama Pemilik Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Nama Pemilik
                                Bank
                                Sampah :</label>
                            <input type="text" id="input-label" name="Nama_Pemilik"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Pemilik Bank Sampah" required>
                            @error('Nama_Pemilik')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- No. Telepon -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">No. Telepon
                                Pemilik :</label>
                            <input type="text" id="input-label" name="No_Telp"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan No. Telepon Pemilik" required>
                            @error('No_Telp')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Jam Operasional -->
                        <ul class="flex justify-between gap-2">
                            <!-- Jam Buka -->
                            <li class="w-full">
                                <div class="w-full mb-5">
                                    <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jam
                                        Buka :</label>
                                    <input type="time" id="input-label" name="Jam_Buka"
                                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        placeholder="Masukkan No. Telepon Pemilik" required>
                                    @error('Jam_Buka')
                                    <p class="text-sm 2xl:text-base text-red-600 mt-2"
                                        id="hs-validation-name-error-helper">
                                        {{ $message }}
                                    </p>
                                    @enderror
                                </div>
                            </li>
                            <!-- Jam Tutup -->
                            <li class="w-full">
                                <div class="w-full mb-5">
                                    <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jam
                                        Tutup :</label>
                                    <input type="time" id="input-label" name="Jam_Tutup"
                                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        placeholder="Masukkan No. Telepon Pemilik" required>
                                    @error('Jam_Tutup')
                                    <p class="text-sm 2xl:text-base text-red-600 mt-2"
                                        id="hs-validation-name-error-helper">
                                        {{ $message }}
                                    </p>
                                    @enderror
                                </div>
                            </li>
                        </ul>
                        <!-- Wilayah Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Wilayah
                                Bank Sampah
                                :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" name="Wilayah_BankSampah"
                                        data-hs-combo-box-input="" value="" required>
                                    <div class="absolute top-1/2 end-3 -translate-y-1/2" aria-expanded="false"
                                        data-hs-combo-box-toggle="">
                                        <svg class="shrink-0 size-3.5 text-gray-500" xmlns="http://www.w3.org/2000/svg"
                                            width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="m7 15 5 5 5-5"></path>
                                            <path d="m7 9 5-5 5 5"></path>
                                        </svg>
                                    </div>
                                </div>
                                @foreach ($wilayahOptions as $wilayah)
                                <div class="absolute z-50 w-full max-h-72 p-1 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300"
                                    style="display: none;" data-hs-combo-box-output="{{ $wilayah }}">
                                    <div class="cursor-pointer py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100"
                                        tabindex="0" data-hs-combo-box-output-item="">
                                        <div class="flex justify-between items-center w-full">
                                            <span data-hs-combo-box-search-text="{{ $wilayah }}"
                                                data-hs-combo-box-value="">{{ $wilayah }}</span>
                                            <span class="hidden hs-combo-box-selected:block">
                                                <svg class="shrink-0 size-3.5 text-blue-600"
                                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M20 6 9 17l-5-5"></path>
                                                </svg>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                @endforeach
                            </div>
                            @error('Wilayah_BankSampah')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Lokasi -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Lokasi
                                :</label>
                            <input type="text" id="input-label" name="Titik_Koordinat"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Titik Koordinat" required>
                            @error('Titik_Koordinat')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Status Operasional -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Status
                                Operasional :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Status",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Status_Operasional" required>
                                <option value="">Pilih Status</option>
                                <option value="Buka">Buka</option>
                                <option value="Tutup">Tutup</option>
                            </select>
                            @error('Status_Operasional')
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
                </form>
            </div>
        </div>
    </div>
</div>

@foreach ($dataBankSampah as $BankSampah)
<!-- Edit -->
<div id="edit-modal{{ $BankSampah -> ID_BankSampah }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="w-full max-h-full overflow-hidden flex flex-col bg-white border shadow-sm rounded-xl pointer-events-auto">
            <div class="flex justify-between items-center py-3 px-4 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Edit Bank Sampah
                </h3>
                <button type="button"
                    class="size-8 inline-flex justify-center items-center gap-x-2 rounded-full border border-transparent bg-gray-100 text-gray-800 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#edit-modal{{ $BankSampah -> ID_BankSampah }}">
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
                    <form action="{{ route('bankSampah.update', ['ID_BankSampah' => $BankSampah -> ID_BankSampah]) }}"
                        method="post">
                        @csrf
                        @method('PATCH')
                        <!-- Nama Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Nama Bank
                                Sampah :</label>
                            <input type="text" id="input-label" name="Nama_Bank_Sampah"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Bank Sampah" value="{{ $BankSampah->Nama_Bank_Sampah }}"
                                required>
                            @error('Nama_Bank_Sampah')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Jenis Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jenis
                                Bank Sampah :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Jenis Sampah",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Jenis_Sampah" required>
                                <option value="">Pilih Jenis Sampah</option>
                                <option value="Plastik" {{ $BankSampah->Jenis_Sampah == 'Plastik' ? 'selected' : '' }}>
                                    Plastik</option>
                                <option value="Kaca" {{ $BankSampah->Jenis_Sampah == 'Kaca' ? 'selected' : '' }}>Kaca
                                </option>
                                <option value="Kertas" {{ $BankSampah->Jenis_Sampah == 'Kertas' ? 'selected' : '' }}>
                                    Kertas</option>
                                <option value="Logam" {{ $BankSampah->Jenis_Sampah == 'Logam' ? 'selected' : '' }}>Logam
                                </option>
                                <option value="Organik" {{ $BankSampah->Jenis_Sampah == 'Organik' ? 'selected' : '' }}>
                                    Organik</option>
                                <option value="Elektronik"
                                    {{ $BankSampah->Jenis_Sampah == 'Elektronik' ? 'selected' : '' }}>Elektronik
                                </option>
                            </select>
                            @error('Jenis_Sampah')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Harga Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Harga Sampah
                                per Kg :</label>
                            <div class="py-2 px-3 border border-gray-200 rounded-lg" data-hs-input-number="">
                                <div class="w-full flex justify-between items-center gap-x-5">
                                    <div class="grow">
                                        <input
                                            class="price-input w-full p-0 bg-transparent border-0 text-gray-800 focus:ring-0 [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
                                            style="-moz-appearance: textfield;" type="text" id="price-input"
                                            aria-roledescription="Number field" name="Harga_Sampah"
                                            value="{{ $BankSampah->Harga_Sampah }}">
                                    </div>
                                    <div class="flex justify-end items-center gap-x-1.5">
                                        <button class="decrement-button border border-gray-200 p-1 rounded-md"
                                            type="button" id="decrement-button" aria-label="Decrease">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="size-5" fill="currentColor"
                                                viewBox="0 0 256 256">
                                                <path
                                                    d="M224,128a8,8,0,0,1-8,8H40a8,8,0,0,1,0-16H216A8,8,0,0,1,224,128Z">
                                                </path>
                                            </svg>
                                        </button>
                                        <button class="increment-button border border-gray-200 p-1 rounded-md"
                                            type="button" id="increment-button" aria-label="Increase">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="size-5" fill="currentColor"
                                                viewBox="0 0 256 256">
                                                <path
                                                    d="M224,128a8,8,0,0,1-8,8H136v80a8,8,0,0,1-16,0V136H40a8,8,0,0,1,0-16h80V40a8,8,0,0,1,16,0v80h80A8,8,0,0,1,224,128Z">
                                                </path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            @error('Harga_Sampah')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Nama Pemilik Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Nama Pemilik
                                Bank
                                Sampah :</label>
                            <input type="text" id="input-label" name="Nama_Pemilik"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Pemilik Bank Sampah" value="{{ $BankSampah->Nama_Pemilik }}"
                                required>
                            @error('Nama_Pemilik')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- No. Telepon -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">No. Telepon
                                Pemilik :</label>
                            <input type="text" id="input-label" name="No_Telp"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan No. Telepon Pemilik" value="{{ $BankSampah->No_Telp }}" required>
                            @error('No_Telp')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Jam Operasional -->
                        <ul class="flex justify-between gap-2">
                            <!-- Jam Buka -->
                            <li class="w-full">
                                <div class="w-full mb-5">
                                    <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jam
                                        Buka :</label>
                                    <input type="time" id="input-label" name="Jam_Buka"
                                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        placeholder="Masukkan No. Telepon Pemilik" value="{{ $BankSampah->Jam_Buka }}"
                                        required>
                                    @error('Jam_Buka')
                                    <p class="text-sm 2xl:text-base text-red-600 mt-2"
                                        id="hs-validation-name-error-helper">
                                        {{ $message }}
                                    </p>
                                    @enderror
                                </div>
                            </li>
                            <!-- Jam Tutup -->
                            <li class="w-full">
                                <div class="w-full mb-5">
                                    <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jam
                                        Tutup :</label>
                                    <input type="time" id="input-label" name="Jam_Tutup"
                                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        placeholder="Masukkan No. Telepon Pemilik" value="{{ $BankSampah->Jam_Tutup }}"
                                        required>
                                    @error('Jam_Tutup')
                                    <p class="text-sm 2xl:text-base text-red-600 mt-2"
                                        id="hs-validation-name-error-helper">
                                        {{ $message }}
                                    </p>
                                    @enderror
                                </div>
                            </li>
                        </ul>
                        <!-- Wilayah Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Wilayah
                                Bank Sampah
                                :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" name="Wilayah_BankSampah"
                                        data-hs-combo-box-input="" value="{{ $BankSampah->Wilayah_BankSampah }}"
                                        required>
                                    <div class="absolute top-1/2 end-3 -translate-y-1/2" aria-expanded="false"
                                        data-hs-combo-box-toggle="">
                                        <svg class="shrink-0 size-3.5 text-gray-500 dark:text-neutral-500"
                                            xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <path d="m7 15 5 5 5-5"></path>
                                            <path d="m7 9 5-5 5 5"></path>
                                        </svg>
                                    </div>
                                </div>
                                @foreach ($wilayahOptions as $wilayah)
                                <div class="absolute z-50 w-full max-h-72 p-1 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300"
                                    style="display: none;" data-hs-combo-box-output="{{ $wilayah }}">
                                    <div class="cursor-pointer py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100"
                                        tabindex="0" data-hs-combo-box-output-item="">
                                        <div class="flex justify-between items-center w-full">
                                            <span data-hs-combo-box-search-text="{{ $wilayah }}"
                                                data-hs-combo-box-value="">{{ $wilayah }}</span>
                                            <span class="hidden hs-combo-box-selected:block">
                                                <svg class="shrink-0 size-3.5 text-blue-600"
                                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M20 6 9 17l-5-5"></path>
                                                </svg>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                @endforeach
                            </div>
                            @error('Wilayah_BankSampah')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Lokasi -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Lokasi
                                :</label>
                            <input type="text" id="input-label" name="Titik_Koordinat"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Titik Koordinat" value="{{ $BankSampah->Titik_Koordinat }}"
                                required>
                            @error('Titik_Koordinat')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Status Operasional -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Status
                                Operasional :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Status",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Status_Operasional" required>
                                <option value="">Pilih Status</option>
                                <option value="Buka" {{ $BankSampah->Status_Operasional == 'Buka' ? 'selected' : '' }}>
                                    Buka
                                </option>
                                <option value="Tutup"
                                    {{ $BankSampah->Status_Operasional == 'Tutup' ? 'selected' : '' }}>Tutup
                                </option>
                            </select>
                            @error('Status_Operasional')
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
                    data-hs-overlay="#edit-modal{{ $BankSampah -> ID_BankSampah }}">
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
<div id="hapus-modal{{ $BankSampah -> ID_BankSampah }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-vertically-centered-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-lg sm:w-full m-3 sm:mx-auto min-h-[calc(100%-3.5rem)] flex items-center">
        <div class="w-full flex flex-col bg-white border shadow-sm rounded-xl pointer-events-auto">
            <div class="flex justify-between items-center py-3 px-4 border-b">
                <h3 id="hs-vertically-centered-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Hapus Informasi Pengangkutan
                </h3>
                <button type="button"
                    class="size-8 inline-flex justify-center items-center gap-x-2 rounded-full border border-transparent bg-gray-100 text-gray-800 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#hapus-modal{{ $BankSampah -> ID_BankSampah }}">
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
                    <li><button type="button" data-hs-overlay="#hapus-modal{{ $BankSampah -> ID_BankSampah }}"
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
                        <form
                            action="{{ route('bankSampah.destroy', ['ID_BankSampah' => $BankSampah -> ID_BankSampah]) }}"
                            method="post">
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
<div id="detail-modal{{ $BankSampah -> ID_BankSampah }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="w-full max-h-full overflow-hidden flex flex-col bg-white border shadow-sm rounded-xl pointer-events-auto">
            <div class="flex justify-between items-center py-3 px-4 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Detail Bank Sampah
                </h3>
                <button type="button"
                    class="size-8 inline-flex justify-center items-center gap-x-2 rounded-full border border-transparent bg-gray-100 text-gray-800 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#detail-modal{{ $BankSampah -> ID_BankSampah }}">
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
                        <!-- Nama Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Nama Bank
                                Sampah :</label>
                            <input type="text" id="input-label" name="Nama_Bank_Sampah"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Bank Sampah" value="{{ $BankSampah->Nama_Bank_Sampah }}"
                                readonly>
                        </div>
                        <!-- Jenis Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jenis
                                Bank Sampah :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Jenis Sampah",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Jenis_Sampah">
                                <option value="">Pilih Jenis Sampah</option>
                                <option value="Plastik" {{ $BankSampah->Jenis_Sampah == 'Plastik' ? 'selected' : '' }}>
                                    Plastik</option>
                                <option value="Kaca" {{ $BankSampah->Jenis_Sampah == 'Kaca' ? 'selected' : '' }}>Kaca
                                </option>
                                <option value="Kertas" {{ $BankSampah->Jenis_Sampah == 'Kertas' ? 'selected' : '' }}>
                                    Kertas</option>
                                <option value="Logam" {{ $BankSampah->Jenis_Sampah == 'Logam' ? 'selected' : '' }}>Logam
                                </option>
                                <option value="Organik" {{ $BankSampah->Jenis_Sampah == 'Organik' ? 'selected' : '' }}>
                                    Organik</option>
                                <option value="Elektronik"
                                    {{ $BankSampah->Jenis_Sampah == 'Elektronik' ? 'selected' : '' }}>Elektronik
                                </option>
                            </select>
                        </div>
                        <!-- Harga Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Harga Sampah
                                per Kg :</label>
                            <div class="py-2 px-3 border border-gray-200 rounded-lg" data-hs-input-number="">
                                <div class="w-full flex justify-between items-center gap-x-5">
                                    <div class="grow">
                                        <input
                                            class="price-input w-full p-0 bg-transparent border-0 text-gray-800 focus:ring-0 [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
                                            style="-moz-appearance: textfield;" type="text" id="price-input"
                                            aria-roledescription="Number field" name="Harga_Sampah"
                                            value="{{ $BankSampah->Harga_Sampah }}" readonly>
                                    </div>
                                    <div class="flex justify-end items-center gap-x-1.5">
                                        <button class="decrement-button border border-gray-200 p-1 rounded-md"
                                            type="button" id="decrement-button" aria-label="Decrease" disabled>
                                            <svg xmlns="http://www.w3.org/2000/svg" class="size-5" fill="currentColor"
                                                viewBox="0 0 256 256">
                                                <path
                                                    d="M224,128a8,8,0,0,1-8,8H40a8,8,0,0,1,0-16H216A8,8,0,0,1,224,128Z">
                                                </path>
                                            </svg>
                                        </button>
                                        <button class="increment-button border border-gray-200 p-1 rounded-md"
                                            type="button" id="increment-button" aria-label="Increase" disabled>
                                            <svg xmlns="http://www.w3.org/2000/svg" class="size-5" fill="currentColor"
                                                viewBox="0 0 256 256">
                                                <path
                                                    d="M224,128a8,8,0,0,1-8,8H136v80a8,8,0,0,1-16,0V136H40a8,8,0,0,1,0-16h80V40a8,8,0,0,1,16,0v80h80A8,8,0,0,1,224,128Z">
                                                </path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Nama Pemilik Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Nama Pemilik
                                Bank
                                Sampah :</label>
                            <input type="text" id="input-label" name="Nama_Pemilik"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Nama Pemilik Bank Sampah" value="{{ $BankSampah->Nama_Pemilik }}"
                                readonly>
                        </div>
                        <!-- No. Telepon -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">No. Telepon
                                Pemilik :</label>
                            <input type="text" id="input-label" name="No_Telp"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan No. Telepon Pemilik" value="{{ $BankSampah->No_Telp }}" readonly>
                        </div>
                        <!-- Jam Operasional -->
                        <ul class="flex justify-between gap-2">
                            <!-- Jam Buka -->
                            <li class="w-full">
                                <div class="w-full mb-5">
                                    <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jam
                                        Buka :</label>
                                    <input type="time" id="input-label" name="Jam_Buka"
                                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        placeholder="Masukkan No. Telepon Pemilik" value="{{ $BankSampah->Jam_Buka }}"
                                        readonly>
                                </div>
                            </li>
                            <!-- Jam Tutup -->
                            <li class="w-full">
                                <div class="w-full mb-5">
                                    <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jam
                                        Tutup :</label>
                                    <input type="time" id="input-label" name="Jam_Tutup"
                                        class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        placeholder="Masukkan No. Telepon Pemilik" value="{{ $BankSampah->Jam_Tutup }}"
                                        readonly>
                                </div>
                            </li>
                        </ul>
                        <!-- Wilayah Bank Sampah -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Wilayah
                                Bank Sampah
                                :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" name="Wilayah_BankSampah"
                                        data-hs-combo-box-input="" value="{{ $BankSampah->Wilayah_BankSampah }}"
                                        readonly>
                                    <div class="absolute top-1/2 end-3 -translate-y-1/2 pointer-events-none"
                                        aria-expanded="false" data-hs-combo-box-toggle="">
                                        <svg class="shrink-0 size-3.5 text-gray-500" xmlns="http://www.w3.org/2000/svg"
                                            width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="m7 15 5 5 5-5"></path>
                                            <path d="m7 9 5-5 5 5"></path>
                                        </svg>
                                    </div>
                                </div>
                                @foreach ($wilayahOptions as $wilayah)
                                <div class="absolute z-50 w-full max-h-72 p-1 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300"
                                    style="display: none;" data-hs-combo-box-output="{{ $wilayah }}">
                                    <div class="cursor-pointer py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100"
                                        tabindex="0" data-hs-combo-box-output-item="">
                                        <div class="flex justify-between items-center w-full">
                                            <span data-hs-combo-box-search-text="{{ $wilayah }}"
                                                data-hs-combo-box-value="">{{ $wilayah }}</span>
                                            <span class="hidden hs-combo-box-selected:block">
                                                <svg class="shrink-0 size-3.5 text-blue-600"
                                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M20 6 9 17l-5-5"></path>
                                                </svg>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                @endforeach
                            </div>
                        </div>
                        <!-- Lokasi -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Lokasi
                                :</label>

                            @php
                            if (filter_var($BankSampah->Titik_Koordinat, FILTER_VALIDATE_URL)) {
                            if (preg_match('/@([0-9.-]+),([0-9.-]+)/', $BankSampah->Titik_Koordinat, $matches)) {
                            $latitude = $matches[1];
                            $longitude = $matches[2];
                            } else {
                            $latitude = 0;
                            $longitude = 0;
                            }
                            } else {
                            $coordinates = explode(',', $BankSampah->Titik_Koordinat);
                            $latitude = isset($coordinates[0]) ? trim($coordinates[0]) : 0;
                            $longitude = isset($coordinates[1]) ? trim($coordinates[1]) : 0;
                            }
                            @endphp

                            <iframe
                                src="https://www.google.com/maps?q={{ $latitude }},{{ $longitude }}&hl=en&z=17&output=embed"
                                class="w-full h-[25rem] rounded-sm" style="border:0;" allowfullscreen="" loading="lazy">
                            </iframe>
                        </div>
                        <!-- Status Operasional -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Status
                                Operasional :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Status",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Status_Operasional" required>
                                <option value="">Pilih Status</option>
                                <option value="Buka" {{ $BankSampah->Status_Operasional == 'Buka' ? 'selected' : '' }}>
                                    Buka
                                </option>
                                <option value="Tutup"
                                    {{ $BankSampah->Status_Operasional == 'Tutup' ? 'selected' : '' }}>Tutup
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