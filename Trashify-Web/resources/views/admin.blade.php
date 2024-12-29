@extends('layouts/main')

@section('main')
<!-- Section Button -->
<div class="grid grid-cols-2 mb-5">
    <div class="col-span-1">
        <button type="button"
            class="py-3 px-4 w-max justify-center inline-flex items-center gap-x-2 text-xs xl:text-sm 2xl:text-base font-medium rounded-lg border border-transparent bg-Genoa text-white focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
            aria-haspopup="dialog" aria-expanded="false" aria-controls="hs-large-modal" data-hs-overlay="#tambah-modal">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
                <path
                    d="M224,128a8,8,0,0,1-8,8H136v80a8,8,0,0,1-16,0V136H40a8,8,0,0,1,0-16h80V40a8,8,0,0,1,16,0v80h80A8,8,0,0,1,224,128Z">
                </path>
            </svg>
            Tambah Admin
        </button>
    </div>
    <div class="col-span-1 flex gap-4 justify-end">
        <form class="flex justify-end w-full gap-4" id="filterForm">
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
            <!-- Peran Admin -->
            <div class="w-52">
                <select data-hs-select='{
            "placeholder": "<span class=\"inline-flex 2xl:text-base items-center\"><svg class=\"shrink-0 size-3.5 me-2\" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polygon points=\"22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3\"/></svg> Peran Admin</span>",
            "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
            "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
            "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
            "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100",
            "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
            "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
            }' class="hidden" name="status" id="statusFilter" onchange="submitForm()">
                    <option value="">Choose</option>
                    <option value="Master" {{ request('status') == 'Master' ? 'selected' : '' }}>Master</option>
                    <option value="Admin" {{ request('status') == 'Admin' ? 'selected' : '' }}>Admin</option>
                </select>
            </div>
        </form>
    </div>
</div>

<div class="flex flex-col">
    <div class="-m-1.5 xl:overflow-x-auto">
        <div class="p-1.5 min-w-full inline-block align-middle">
            <div class="border overflow-hidden">
                <table id="contentTable" class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-Genoa text-white">
                        <tr>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                No.</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Nama Admin</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Role Admin</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                No. Telepon</th>
                            <th scope="col"
                                class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm border-r-2 font-medium uppercase">
                                Email</th>
                            <th scope="col" class="p-3 xl:px-6 xl:py-3 text-xs 2xl:text-sm font-medium uppercase">
                                Aksi</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 text-center">
                        @if ($dataUser->isEmpty())
                        <tr>
                            <td colspan="6"
                                class="px-6 py-4 text-sm 2xl:text-base font-medium border-r-2 text-gray-800 whitespace-nowrap">
                                Data Admin Tidak Tersedia</td>
                        </tr>
                        @else
                        @foreach ($dataUser as $key => $User)
                        <tr class="hover:bg-gray-100">
                            <td
                                class="px-6 py-4 whitespace-nowrap text-xs xl:text-sm 2xl:text-base border-r-2 font-medium text-gray-800">
                                {{ $key + 1 }}.
                            </td>
                            <td
                                class="px-6 py-4 whitespace-nowrap text-xs xl:text-sm 2xl:text-base border-r-2 text-gray-800">
                                <p class="truncate w-28 2xl:w-max 2xl:mx-auto">
                                    {{ $User->UserTable->Nama }}
                                </p>
                            </td>
                            <td
                                class="px-6 py-4 whitespace-nowrap text-xs xl:text-sm 2xl:text-base border-r-2 text-gray-800">
                                {{ $User->Role_Admin }}
                            </td>
                            <td
                                class="px-6 py-4 whitespace-nowrap text-xs xl:text-sm 2xl:text-base border-r-2 text-gray-800">
                                {{ $User->UserTable->No_Telp ? $User->UserTable->No_Telp : '-' }}
                            </td>
                            <td
                                class="px-6 py-4 whitespace-nowrap text-xs xl:text-sm 2xl:text-base border-r-2 text-gray-800">
                                <p class="truncate w-32 2xl:w-40 2xl:mx-auto">
                                    {{ $User->UserTable->email }}
                                </p>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-center text-sm 2xl:text-base font-medium">
                                <button type="button"
                                    class="py-3 px-4 inline-flex items-center text-sm font-medium rounded-full gap-x-2 hover:bg-slate-200 border border-transparent text-white focus:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                    aria-haspopup="dialog" aria-expanded="false" aria-controls="hs-large-modal"
                                    data-hs-overlay="#edit-modal{{ $User->ID_User }}">
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
                                    data-hs-overlay="#hapus-modal{{ $User->ID_User }}">
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
                                    data-hs-overlay="#detail-modal{{ $User->ID_User }}">
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
        </div>
    </div>
</div>

@include('components/adminModal')

<div class="my-5">
    {{ $dataUser->links() }}
</div>

@endsection