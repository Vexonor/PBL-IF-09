@extends('layouts/main')

@section('main')
<!-- Filter -->
<div class="grid grid-cols-1 mb-5">
    <form class="flex justify-end w-full gap-4" id="filterForm">
        <!-- Data Count -->
        <div class="max-w-xs">
            <select
                class="py-3 px-4 pe-9 max-w-xs block border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                name="data_count" onchange="submitForm()">
                <option value="10" {{ request('data_count') == '10' ? 'selected' : '' }}>10</option>
                <option value="20" {{ request('data_count') == '20' ? 'selected' : '' }}>20</option>
                <option value="30" {{ request('data_count') == '30' ? 'selected' : '' }}>30</option>
            </select>
        </div>
        <!-- Kategori Pengaduan -->
        <div class="w-max">
            <select data-hs-select='{
            "placeholder": "<span class=\"inline-flex items-center\"><svg class=\"shrink-0 size-3.5 me-2\" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polygon points=\"22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3\"/></svg> Kategori Pengaduan</span>",
            "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
            "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm focus:outline-none focus:ring-2 focus:ring-blue-500",
            "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
            "optionClasses": "py-2 px-4 w-full text-sm text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100",
            "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 dark:text-blue-500 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
            "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
            }' class="hidden" name="kategori" id="statusFilter" onchange="submitForm()">
                <option value="">Choose</option>
                <option value="Pengangkutan Sampah" {{ request('jenis') == 'Pengangkutan Sampah' ? 'selected' : '' }}>
                    Pengangkutan Sampah</option>
                <option value="Tempat Sampah Liar" {{ request('jenis') == 'Tempat Sampah Liar' ? 'selected' : '' }}>
                    Tempat Sampah Liar</option>
                <option value="Kondisi TPS" {{ request('jenis') == 'Kondisi TPS' ? 'selected' : '' }}>Kondisi TPS
                </option>
                <option value="Lainnya" {{ request('jenis') == 'Lainnya' ? 'selected' : '' }}>Lainnya</option>
            </select>
        </div>
        <!-- Status Pengaduan -->
        <div class="w-52">
            <select data-hs-select='{
            "placeholder": "<span class=\"inline-flex items-center\"><svg class=\"shrink-0 size-3.5 me-2\" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polygon points=\"22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3\"/></svg> Status Pengaduan</span>",
            "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
            "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm focus:outline-none focus:ring-2 focus:ring-blue-500",
            "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
            "optionClasses": "py-2 px-4 w-full text-sm text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100",
            "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
            "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 dark:text-neutral-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
            }' class="hidden" name="status" id="kategoriFilter" onchange="submitForm()">
                <option value="">Choose</option>
                <option value="Selesai" {{ request('status') == 'Selesai' ? 'selected' : '' }}>Selesai</option>
                <option value="Sedang Diproses" {{ request('status') == 'Sedang Diproses' ? 'selected' : '' }}>Sedang
                    Diproses</option>
                <option value="Belum Selesai" {{ request('status') == 'Belum Selesai' ? 'selected' : '' }}>Belum Selesai
                </option>
            </select>
        </div>
    </form>
</div>

<!-- Laporan -->
<div class="flex flex-col">
    <div class="xl:-m-1.5 xl:overflow-x-auto">
        <div class="p-1.5 min-w-full inline-block align-middle">
            <div class="overflow-hidden border">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-Genoa text-white">
                        <tr>
                            <th scope="col"
                                class="p-3 xl:px-6 py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                No.</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Kode Pengaduan</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Nama Pelapor</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Kategori Pengaduan</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Status Pengaduan</th>
                            <th scope="col" class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm font-medium uppercase">
                                Aksi</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 text-center">
                        @if ($dataPengaduan->isEmpty())
                        <tr>
                            <td colspan="6"
                                class="px-6 py-4 text-sm 2xl:text-base font-medium border-r-2 text-gray-800 whitespace-nowrap">
                                Data Pengaduan Tidak Tersedia</td>
                        </tr>
                        @else
                        @foreach ($dataPengaduan as $key => $Pengaduan)
                        <tr class="hover:bg-gray-100">
                            <td
                                class="px-3 py-4 whitespace-nowrap text-xs xl:text-sm 2xl:text-base border-r-2 font-medium text-gray-800">
                                {{ $key + 1 }}.
                            </td>
                            <td
                                class="px-3 py-4 text-xs xl:text-sm 2xl:text-base border-r-2 text-gray-800 whitespace-nowrap">
                                {{ $Pengaduan->Kode_Pengaduan }}
                            </td>
                            <td
                                class="px-6 py-4 text-xs xl:text-sm 2xl:text-base border-r-2 text-gray-800 whitespace-nowrap">
                                <p class="truncate w-20 xl:w-28 2xl:w-max 2xl:mx-auto">
                                    {{ $Pengaduan->UserTable->Nama }}
                                </p>
                            </td>
                            <td class="px-3 py-4 text-xs xl: 2xl:text-base border-r-2 text-gray-800 whitespace-nowrap">
                                {{ $Pengaduan->Kategori_Pengaduan }}
                            </td>
                            <td class="px-1 py-4 text-xs xl: 2xl:text-base border-r-2 text-gray-800 whitespace-nowrap">
                                @if ($Pengaduan->Status_Pengaduan === 'Selesai')
                                <span
                                    class="inline-flex border-2 border-Genoa items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs font-medium bg-Aquamarine text-Genoa">
                                    <span class="size-1.5 inline-block rounded-full bg-Genoa"></span>
                                    Selesai
                                </span>
                                @elseif ($Pengaduan->Status_Pengaduan === 'Sedang Diproses')
                                <span
                                    class="inline-flex mx-5 border-2 border-Orange-Peel items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs font-medium bg-yellow-100 text-Orange-Peel">
                                    <span class="size-1.5 inline-block rounded-full bg-Orange-Peel"></span>
                                    Sedang Diproses
                                </span>
                                @elseif($Pengaduan->Status_Pengaduan === 'Belum Selesai')
                                <span
                                    class="inline-flex mx-5 border-2 border-Medium-Carmine items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs font-medium bg-red-100 text-Medium-Carmine">
                                    <span class="size-1.5 inline-block rounded-full bg-Medium-Carmine"></span>
                                    Belum Selesai
                                </span>
                                @endif
                            </td>
                            <td class="px-3 py-4 text-sm font-medium text-center whitespace-nowrap">
                                <button type="button"
                                    class="inline-flex items-center px-4 py-3 text-sm 2xl:text-base font-medium text-white border border-transparent rounded-full gap-x-2 hover:bg-slate-200 focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                    aria-haspopup="dialog" aria-expanded="false" aria-controls="hs-large-modal"
                                    data-hs-overlay="#edit-modal{{ $Pengaduan->ID_Pengaduan }}">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="size-4 xl:size-5 2xl:size-6"
                                        fill="#000000" viewBox="0 0 256 256">
                                        <path
                                            d="M227.32,73.37,182.63,28.69a16,16,0,0,0-22.63,0L36.69,152A15.86,15.86,0,0,0,32,163.31V208a16,16,0,0,0,16,16H216a8,8,0,0,0,0-16H115.32l112-112A16,16,0,0,0,227.32,73.37ZM92.69,208H48V163.31l88-88L180.69,120ZM192,108.69,147.32,64l24-24L216,84.69Z">
                                        </path>
                                    </svg>
                                </button>
                                <button type="button"
                                    class="inline-flex items-center px-4 py-3 text-sm 2xl:text-base font-medium text-white border border-transparent rounded-full gap-x-2 hover:bg-slate-200 focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                    aria-haspopup="dialog" aria-expanded="false"
                                    aria-controls="hs-vertically-centered-scrollable-modal"
                                    data-hs-overlay="#hapus-modal{{ $Pengaduan->ID_Pengaduan }}">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="size-4 xl:size-5 2xl:size-6"
                                        fill="#000000" viewBox="0 0 256 256">
                                        <path
                                            d="M216,48H40a8,8,0,0,0,0,16h8V208a16,16,0,0,0,16,16H192a16,16,0,0,0,16-16V64h8a8,8,0,0,0,0-16ZM192,208H64V64H192ZM80,24a8,8,0,0,1,8-8h80a8,8,0,0,1,0,16H88A8,8,0,0,1,80,24Z">
                                        </path>
                                    </svg>
                                </button>
                                <button type="button"
                                    class="inline-flex items-center px-4 py-3 text-sm 2xl:text-base font-medium text-white border border-transparent rounded-full gap-x-2 hover:bg-slate-200 focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                    aria-haspopup="dialog" aria-expanded="false"
                                    aria-controls="hs-vertically-centered-scrollable-modal"
                                    data-hs-overlay="#detail-modal{{ $Pengaduan->ID_Pengaduan }}">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="size-4 xl:size-5 2xl:size-6"
                                        fill="#000000" viewBox="0 0 256 256">
                                        <path
                                            d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm12-88a12,12,0,1,1-12-12A12,12,0,0,1,140,128Zm44,0a12,12,0,1,1-12-12A12,12,0,0,1,184,128Zm-88,0a12,12,0,1,1-12-12A12,12,0,0,1,96,128Z">
                                        </path>
                                    </svg>
                                </button>
                            </td>
                        </tr>
                        @endforeach
                        @endif
                    </tbody>
                </table>
            </div>
            <div class="my-5">
                {{ $dataPengaduan->links() }}
            </div>
        </div>
    </div>
</div>

<div
    class="mt-12 py-3 flex items-center text-lg 2xl:text-xl font-bold text-gray-800 before:flex-1 before:border-t before:border-gray-200 before:me-6 after:flex-1 after:border-t after:border-gray-200 after:ms-6">
    Penanggung Jawab Pengaduan</div>

<!-- Penanggung Jawab -->
<button type="button"
    class="inline-flex items-center justify-center px-4 py-3 my-10 text-sm 2xl:text-base font-medium text-white border border-transparent rounded-lg w-max gap-x-2 bg-Genoa focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
    aria-haspopup="dialog" aria-expanded="false" aria-controls="hs-large-modal" data-hs-overlay="#tambah-modal">
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path
            d="M224,128a8,8,0,0,1-8,8H136v80a8,8,0,0,1-16,0V136H40a8,8,0,0,1,0-16h80V40a8,8,0,0,1,16,0v80h80A8,8,0,0,1,224,128Z">
        </path>
    </svg>
    Tambah Penanggung Jawab Pengaduan
</button>

<div class="flex flex-col">
    <div class="-m-1.5 xl:overflow-x-auto">
        <div class="p-1.5 min-w-full inline-block align-middle">
            <div class="overflow-hidden border">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-Genoa text-white">
                        <tr>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                No.</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Kode Pengaduan</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Nama Petugas</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Kategori Pengaduan</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Status Pengerjaan</th>
                            <th scope="col" class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm font-medium uppercase">
                                Aksi</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 text-center">
                        @if ($dataPengaduan->isEmpty())
                        <tr>
                            <td colspan="6"
                                class="px-6 py-4 text-sm 2xl:text-base font-medium border-r-2 text-gray-800 whitespace-nowrap">
                                Data Penanggung Jawab Tidak Tersedia</td>
                        </tr>
                        @else
                        @foreach ($dataPenanggungJawab as $key => $PJ)
                        <tr class="hover:bg-gray-100">
                            <td
                                class="px-6 py-4 text-xs xl:text-sm 2xl:text-base border-r-2 font-medium text-gray-800 whitespace-nowrap">
                                {{ $key + 1 }}.
                            </td>
                            <td
                                class="px-3 py-4 text-xs xl:text-sm 2xl:text-base border-r-2 text-gray-800 whitespace-nowrap">
                                {{ $PJ->Kode_Pengaduan }}
                            </td>
                            <td
                                class="px-6 py-4 text-xs xl:text-sm 2xl:text-base border-r-2 text-gray-800 whitespace-nowrap">
                                <p class="truncate w-20 xl:w-28 2xl:w-max 2xl:mx-auto">
                                    {{ $PJ->PetugasTable->UserTable->Nama }}
                                </p>
                            </td>
                            <td
                                class="px-6 py-4 text-xs xl:text-sm 2xl:text-base border-r-2 text-gray-800 whitespace-nowrap">
                                {{ $PJ->Kategori_Pengaduan }}
                            </td>
                            <td
                                class="px-1 py-4 text-xs xl:text-sm 2xl:text-base border-r-2 text-gray-800 whitespace-nowrap">
                                @if ($PJ->Status_Pengaduan === 'Selesai')
                                <span
                                    class="inline-flex border-2 border-Genoa items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-sm font-medium bg-Aquamarine text-Genoa">
                                    <span class="size-1.5 inline-block rounded-full bg-Genoa"></span>
                                    Selesai
                                </span>
                                @elseif ($PJ->Status_Pengaduan === 'Sedang Diproses')
                                <span
                                    class="inline-flex mx-5 border-2 border-Orange-Peel items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-sm font-medium bg-yellow-100 text-Orange-Peel">
                                    <span class="size-1.5 inline-block rounded-full bg-Orange-Peel"></span>
                                    Sedang Diproses
                                </span>
                                @elseif($PJ->Status_Pengaduan === 'Belum Selesai')
                                <span
                                    class="inline-flex mx-5 border-2 border-Medium-Carmine items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-sm font-medium bg-red-100 text-Medium-Carmine">
                                    <span class="size-1.5 inline-block rounded-full bg-Medium-Carmine"></span>
                                    Belum Selesai
                                </span>
                                @endif
                            </td>
                            <td class="px-3 py-4 text-sm font-medium text-center whitespace-nowrap">
                                <button type="button"
                                    class="inline-flex items-center px-4 py-3 text-sm font-medium text-white border border-transparent rounded-full gap-x-2 hover:bg-slate-200 focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                    aria-haspopup="dialog" aria-expanded="false" aria-controls="hs-large-modal"
                                    data-hs-overlay="#edit-modalPJ{{ $PJ->ID_PJ }}">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="size-4 xl:size-5 2xl:size-6"
                                        fill="#000000" viewBox="0 0 256 256">
                                        <path
                                            d="M227.32,73.37,182.63,28.69a16,16,0,0,0-22.63,0L36.69,152A15.86,15.86,0,0,0,32,163.31V208a16,16,0,0,0,16,16H216a8,8,0,0,0,0-16H115.32l112-112A16,16,0,0,0,227.32,73.37ZM92.69,208H48V163.31l88-88L180.69,120ZM192,108.69,147.32,64l24-24L216,84.69Z">
                                        </path>
                                    </svg>
                                </button>
                                <button type="button"
                                    class="inline-flex items-center px-4 py-3 text-sm font-medium text-white border border-transparent rounded-full gap-x-2 hover:bg-slate-200 focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                    aria-haspopup="dialog" aria-expanded="false"
                                    aria-controls="hs-vertically-centered-scrollable-modal"
                                    data-hs-overlay="#hapus-modalPJ{{ $PJ->ID_PJ }}">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="size-4 xl:size-5 2xl:size-6"
                                        fill="#000000" viewBox="0 0 256 256">
                                        <path
                                            d="M216,48H40a8,8,0,0,0,0,16h8V208a16,16,0,0,0,16,16H192a16,16,0,0,0,16-16V64h8a8,8,0,0,0,0-16ZM192,208H64V64H192ZM80,24a8,8,0,0,1,8-8h80a8,8,0,0,1,0,16H88A8,8,0,0,1,80,24Z">
                                        </path>
                                    </svg>
                                </button>
                                <button type="button"
                                    class="inline-flex items-center px-4 py-3 text-sm font-medium text-white border border-transparent rounded-full gap-x-2 hover:bg-slate-200 focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                    aria-haspopup="dialog" aria-expanded="false"
                                    aria-controls="hs-vertically-centered-scrollable-modal"
                                    data-hs-overlay="#detail-modalPJ{{ $PJ->ID_PJ }}">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="size-4 xl:size-5 2xl:size-6"
                                        fill="#000000" viewBox="0 0 256 256">
                                        <path
                                            d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm12-88a12,12,0,1,1-12-12A12,12,0,0,1,140,128Zm44,0a12,12,0,1,1-12-12A12,12,0,0,1,184,128Zm-88,0a12,12,0,1,1-12-12A12,12,0,0,1,96,128Z">
                                        </path>
                                    </svg>
                                </button>
                            </td>
                        </tr>
                        @endforeach
                        @endif
                    </tbody>
                </table>
            </div>
            <div class="my-5">
                {{ $dataPenanggungJawab->links() }}
            </div>
        </div>
    </div>
</div>

@include('components/laporanModal')

@endsection