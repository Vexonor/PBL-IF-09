@extends('layouts/main')

@section('main')
<!-- Section Button -->
<div class="grid grid-cols-2 mb-5">
    <div class="col-span-1">
        <div class="max-w-xs">
            <!-- Button Tambah -->
            <button type="button"
                class="py-3 px-4 w-max justify-center inline-flex items-center white-space: nowrap; gap-x-2 text-xs xl:text-sm 2xl:text-base font-medium rounded-lg border border-transparent bg-Genoa text-white focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                aria-haspopup="dialog" aria-expanded="false" aria-controls="hs-large-modal"
                data-hs-overlay="#tambah-modal">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                    viewBox="0 0 256 256">
                    <path
                        d="M224,128a8,8,0,0,1-8,8H136v80a8,8,0,0,1-16,0V136H40a8,8,0,0,1,0-16h80V40a8,8,0,0,1,16,0v80h80A8,8,0,0,1,224,128Z">
                    </path>
                </svg>
                Tambah Informasi Pengangkutan
            </button>
        </div>
    </div>
    <form class="flex justify-end w-full gap-2 xl:gap-4" id="filterForm">
        <!-- Data Count -->
        <div class="max-w-xs">
            <select
                class="py-3 px-4 pe-9 max-w-xs block border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                name="data_count" onchange="submitForm()">
                <option value="10" {{ request('data_count') == '10' ? 'selected' : '' }}>10</option>
                <option value="20" {{ request('data_count') == '20' ? 'selected' : '' }}>20</option>
                <option value="30" {{ request('data_count') == '30' ? 'selected' : '' }}>30</option>
            </select>
        </div>
        <!-- Wilayah Bertugas -->
        <div class="w-max">
            <select data-hs-select='{
            "placeholder": "<span class=\"inline-flex items-center\"><svg class=\"shrink-0 size-3.5 me-2\" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polygon points=\"22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3\"/></svg> Wilayah Pengangkutan</span>",
            "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
            "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
            "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
            "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100",
            "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
            "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
            }' class="hidden" name="wilayah" id="kategoriFilter" onchange="submitForm()">
                <option value="">Choose</option>
                @foreach ($wilayahOptions as $wilayah)
                <option value="{{ $wilayah }}" {{ request('wilayah') == $wilayah ? 'selected' : '' }}>
                    {{ $wilayah }}
                </option>
                @endforeach
            </select>
        </div>
        <!-- Status Pengangkutan -->
        <div class="w-60 2xl:w-max">
            <select data-hs-select='{
                    "placeholder": "<span class=\"inline-flex items-center\"><svg class=\"shrink-0 size-3.5 me-2\" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polygon points=\"22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3\"/></svg> Status Pengangkutan</span>",
                    "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                    "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                    "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                    "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100",
                    "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                    "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                    }' class="hidden" name="status" id="statusFilter" onchange="submitForm()">
                <option value="">Choose</option>
                <option value="Selesai" {{ request('status') == 'Selesai' ? 'selected' : '' }}>Selesai
                </option>
                <option value="Tertunda" {{ request('status') == 'Tertunda' ? 'selected' : '' }}>Tertunda
                </option>
                <option value="Belum Selesai" {{ request('status') == 'Belum Selesai' ? 'selected' : '' }}>
                    Belum Selesai
                </option>
            </select>
        </div>
    </form>
</div>

<!-- Table -->
<div class="flex flex-col">
    <div class="xl:-m-1.5 xl:overflow-x-auto">
        <div class="p-1.5 min-w-full inline-block align-middle">
            <div class="border overflow-hidden">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-Genoa text-white">
                        <tr>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase bg-Genoa">
                                No.</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase bg-Genoa">
                                Nama Petugas</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase bg-Genoa">
                                Tanggal Pengangkutan</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase bg-Genoa">
                                Wilayah Pengangkutan</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase bg-Genoa">
                                Status Pengangkutan</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm font-medium uppercase bg-Genoa">
                                Aksi</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 text-center">
                        @if ($dataInformasi->isEmpty())
                        <tr>
                            <td colspan="6"
                                class="px-6 py-4 text-sm 2xl:text-base font-medium border-r-2 text-gray-800 whitespace-nowrap">
                                Data Informasi Pengangkutan Tidak Tersedia</td>
                        </tr>
                        @else
                        @foreach ($dataInformasi as $key => $Informasi)
                        <tr class="hover:bg-gray-100">
                            <td
                                class="px-3 py-4 whitespace-nowrap text-xs xl:text-sm 2xl:text-base border-r-2 font-medium">
                                {{ $key + 1 }}.
                            </td>
                            <td class="px-3 py-4 whitespace-nowrap text-xs xl:text-sm 2xl:text-base border-r-2">

                                <p class="truncate w-28 2xl:w-max 2xl:mx-auto">
                                    {{ $Informasi->PetugasTable->UserTable->Nama }}
                                </p>

                            </td>
                            <td class="px-3 py-4 whitespace-nowrap text-xs xl:text-sm 2xl:text-base border-r-2">
                                {{ $Informasi->Tanggal_Pengangkutan }}
                            </td>
                            <td class="px-3 py-4 whitespace-nowrap text-xs xl:text-sm 2xl:text-base border-r-2">
                                {{ $Informasi->Wilayah_Pengangkutan }}
                            </td>
                            <td class="px-3 py-4 text-xs xl:text-sm 2xl:text-base border-r-2 whitespace-nowrap">
                                @if ($Informasi->Status_Pengangkutan === 'Selesai')
                                <span
                                    class="inline-flex border-2 border-Genoa items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-sm font-medium bg-Aquamarine text-Genoa">
                                    <span class="size-1.5 inline-block rounded-full bg-Genoa"></span>
                                    Selesai
                                </span>
                                @elseif ($Informasi->Status_Pengangkutan === 'Tertunda')
                                <span
                                    class="inline-flex mx-5 border-2 border-Orange-Peel items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-sm font-medium bg-yellow-100 text-Orange-Peel">
                                    <span class="size-1.5 inline-block rounded-full bg-Orange-Peel"></span>
                                    Tertunda
                                </span>
                                @elseif($Informasi->Status_Pengangkutan === 'Belum Selesai')
                                <span
                                    class="inline-flex mx-5 border-2 border-Medium-Carmine items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-sm font-medium bg-red-100 text-Medium-Carmine">
                                    <span class="size-1.5 inline-block rounded-full bg-Medium-Carmine"></span>
                                    Belum Selesai
                                </span>
                                @endif
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-center text-sm font-medium">
                                <button type="button"
                                    class="py-3 px-4 inline-flex items-center text-sm font-medium rounded-full gap-x-2 hover:bg-slate-200 border border-transparent text-white focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                    aria-haspopup="dialog" aria-expanded="false" aria-controls="hs-large-modal"
                                    data-hs-overlay="#edit-modal{{ $Informasi->ID_Informasi }}">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="size-4 xl:size-5 2xl:size-6"
                                        fill="#000000" viewBox="0 0 256 256">
                                        <path
                                            d="M227.32,73.37,182.63,28.69a16,16,0,0,0-22.63,0L36.69,152A15.86,15.86,0,0,0,32,163.31V208a16,16,0,0,0,16,16H216a8,8,0,0,0,0-16H115.32l112-112A16,16,0,0,0,227.32,73.37ZM92.69,208H48V163.31l88-88L180.69,120ZM192,108.69,147.32,64l24-24L216,84.69Z">
                                        </path>
                                    </svg>
                                </button>
                                <button type="button"
                                    class="py-3 px-4 inline-flex items-center text-sm font-medium rounded-full gap-x-2 hover:bg-slate-200 border border-transparent text-white focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                    aria-haspopup="dialog" aria-expanded="false"
                                    aria-controls="hs-vertically-centered-scrollable-modal"
                                    data-hs-overlay="#hapus-modal{{ $Informasi->ID_Informasi }}">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="size-4 xl:size-5 2xl:size-6"
                                        fill="#000000" viewBox="0 0 256 256">
                                        <path
                                            d="M216,48H40a8,8,0,0,0,0,16h8V208a16,16,0,0,0,16,16H192a16,16,0,0,0,16-16V64h8a8,8,0,0,0,0-16ZM192,208H64V64H192ZM80,24a8,8,0,0,1,8-8h80a8,8,0,0,1,0,16H88A8,8,0,0,1,80,24Z">
                                        </path>
                                    </svg>
                                </button>
                                <button type="button"
                                    class="py-3 px-4 inline-flex items-center text-sm font-medium rounded-full gap-x-2 hover:bg-slate-200 border border-transparent text-white focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                    aria-haspopup="dialog" aria-expanded="false"
                                    aria-controls="hs-vertically-centered-scrollable-modal"
                                    data-hs-overlay="#detail-modal{{ $Informasi->ID_Informasi }}">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="size-4 xl:size-5 2xl:size-6"
                                        fill="#000000" viewBox="0 0 256 256">
                                        <path
                                            d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm12-88a12,12,0,1,1-12-12A12,12,0,0,1,140,128Zm44,0a12,12,0,1,1-12-12A12,12,0,0,1,184,128Zm-88,0a12,12,0,1,1-12-12A12,12,0,0,1,96,128Z">
                                        </path>
                                    </svg>
                                </button>
                            </td>
                        </tr>
                        @include('components/informasiModal')
                        @endforeach
                        @endif
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


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
                    Tambah Informasi Pengangkutan
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
                    <form action="{{ route('informasi.store') }}" method="post">
                        @csrf
                        <!-- Wilayah -->
                        <div class="w-full mb-5">
                            <label for="wilayah-combo" class="block text-sm 2xl:text-base font-medium mb-2">Wilayah
                                Pengangkutan :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-slate-400 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" name="Wilayah_Pengangkutan"
                                        data-hs-combo-box-input="" required>
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
                            @error('Wilayah_Pengangkutan')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Titik Koordinat -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Titik
                                Koordinat :</label>
                            <input type="text" id="input-label" name="Titik_Koordinat"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Titik Koordinat" required>
                            @error('Titik_Koordinat')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Tanggal Pengangkutan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Tanggal
                                Pengangkutan :</label>
                            <input type="date" id="input-label" name="Tanggal_Pengangkutan"
                                class="py-3 px-4 block w-full border-2 border-slate-400 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="you@site.com">
                            @error('Tanggal_Pengangkutan')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>

                        <!-- Jam Pengangkutan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Jam
                                Pengangkutan :</label>
                            <input type="time" id="input-label" name="Jam_Pengangkutan"
                                class="py-3 px-4 block w-full border-2 border-slate-400 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="you@site.com">
                            @error('Jam_Pengangkutan')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>

                        <!-- Petugas -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Petugas
                                Yang Bertanggung Jawab :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-slate-400 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" name="ID_Petugas"
                                        data-hs-combo-box-input="" required>
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
                                @foreach ($dataUser as $User)
                                @if ($User->Status_Keaktifan == 'Aktif')
                                <div class="absolute z-50 w-full max-h-72 p-1 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300"
                                    style="display: none;" data-hs-combo-box-output="{{ $User->UserTable->Nama }}">
                                    <div class="cursor-pointer py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100"
                                        tabindex="0" data-hs-combo-box-output-item="">
                                        <div class="flex justify-between items-center w-full">
                                            <span data-hs-combo-box-search-text="{{ $User->ID_Petugas }}"
                                                data-hs-combo-box-value="">{{ $User->UserTable->Nama }}</span>
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
                                @endif
                                @endforeach
                            </div>
                            @error('ID_Petugas')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>

                        <!-- Status Pengangkutan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Status
                                Pengangkutan :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Pengangkutan",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Status_Pengangkutan" required>
                                <option value="">Pilih</option>
                                <option>Selesai</option>
                                <option>Tertunda</option>
                                <option>Belum Selesai</option>
                            </select>
                            @error('Status_Pengangkutan')
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

<div class="my-5">
    {{ $dataInformasi->links() }}
</div>

@endsection