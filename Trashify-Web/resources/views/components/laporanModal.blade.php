@foreach ($dataPengaduan as $key => $Pengaduan)
<!-- Edit Laporan -->
<div id="edit-modal{{ $Pengaduan->ID_Pengaduan }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="flex flex-col w-full max-h-full overflow-hidden bg-white border shadow-sm pointer-events-auto rounded-xl">
            <div class="flex items-center justify-between px-4 py-3 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Edit Status Pengaduan
                </h3>
                <button type="button"
                    class="inline-flex items-center justify-center text-gray-800 bg-gray-100 border border-transparent rounded-full size-8 gap-x-2 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#edit-modal{{ $Pengaduan->ID_Pengaduan }}">
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
                    <form action="{{ route('laporan.update', ['ID_Pengaduan' => $Pengaduan -> ID_Pengaduan]) }}"
                        method="post" enctype="multipart/form-data">
                        @csrf
                        @method('PATCH')
                        <!-- Kode Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Kode Pengaduan
                                :</label>
                            <input type="text" id="input-label" name="Kode_Pengaduan"
                                class="block w-full px-4 py-3 text-sm 2xl:text-base border-gray-200 rounded-lg pointer-events-none focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Kode Laporan" value="{{ $Pengaduan->Kode_Pengaduan }}" readonly>
                        </div>
                        <!-- Kategori Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Kategori
                                Pengaduan :</label>
                            <div class="grid grid-cols-2 gap-4">
                                <div class="flex">
                                    <input type="radio" name="Kategori_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-1" value="Pengangkutan Sampah"
                                        {{ $Pengaduan->Kategori_Pengaduan === 'Pengangkutan Sampah' ? 'checked' : 'disabled' }}>
                                    <label for="hs-radio-group-1"
                                        class="text-sm 2xl:text-base text-gray-500 ms-2">Pengumpulan
                                        Sampah</label>
                                </div>
                                <div class="flex">
                                    <input type="radio" name="Kategori_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-2" value="Kondisi TPS"
                                        {{ $Pengaduan->Kategori_Pengaduan === 'Kondisi TPS' ? 'checked' : 'disabled' }}>
                                    <label for="hs-radio-group-2"
                                        class="text-sm 2xl:text-base text-gray-500 ms-2">Kondisi
                                        TPS</label>
                                </div>
                                <div class="flex">
                                    <input type="radio" name="Kategori_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-3" value="Tempat Sampah Liar"
                                        {{ $Pengaduan->Kategori_Pengaduan === 'Tempat Sampah Liar' ? 'checked' : 'disabled' }}>
                                    <label for="hs-radio-group-3"
                                        class="text-sm 2xl:text-base text-gray-500 ms-2">Tempat
                                        Sampah
                                        Liar</label>
                                </div>
                                <div class="flex">
                                    <input type="radio" name="Kategori_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-3" value="Lainnya"
                                        {{ $Pengaduan->Kategori_Pengaduan === 'Lainnya' ? 'checked' : 'disabled' }}>
                                    <label for="hs-radio-group-3"
                                        class="text-sm 2xl:text-base text-gray-500 ms-2">Lainnya</label>
                                </div>
                            </div>
                        </div>
                        <!-- Deskripsi Laporan -->
                        <div class="w-full mb-5">
                            <label for="textarea-label" class="block mb-2 text-sm 2xl:text-base font-medium">Deskripsi
                                Pengaduan</label>
                            <textarea id="textarea-label" name="Deskripsi_Pengaduan"
                                class="block w-full px-4 py-3 text-sm 2xl:text-base border-gray-200 rounded-lg pointer-events-none focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                rows="3" placeholder="Deskripsi Laporan"
                                readonly>{{ $Pengaduan->Deskripsi_Pengaduan }}</textarea>
                        </div>
                        <!-- Titik Koordinat -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Titik
                                Koordinat :</label>
                            <input type="text" id="input-label" name="Titik_Koordinat"
                                class="block w-full px-4 py-3 text-sm 2xl:text-base border-gray-200 rounded-lg pointer-events-none focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Titik Koordinat" value="{{ $Pengaduan->Titik_Koordinat }}"
                                readonly>
                        </div>
                        <div class="w-full mb-5">
                            @php
                            list($latitude, $longitude) = explode(',', $Pengaduan->Titik_Koordinat);
                            @endphp
                            <iframe
                                src="https://www.google.com/maps?q={{ $latitude }},{{ $longitude }}&hl=en&z=17&output=embed"
                                class="w-full h-[25rem] 2xl:h-[35rem] rounded-sm" style="border:0;" allowfullscreen=""
                                loading="lazy">
                            </iframe>
                        </div>
                        <!-- Gambar Pendukung -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Gambar
                                Pendukung :</label>
                            <div class="grid grid-cols-3 gap-4">
                                @foreach ($Pengaduan->FotoTable as $foto)
                                @if ($foto->ID_Pengaduan === $Pengaduan->ID_Pengaduan)
                                <div class="col-span-1">
                                    <img src="{{ asset('storage/' . $foto->Foto) }}" class="size-full" alt="">
                                </div>
                                @endif
                                @endforeach
                            </div>

                        </div>
                        <!-- Dokumen Pendukung -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Dokumen
                                Pendukung :</label>
                            @if($Pengaduan->Gambar_Pengaduan)
                            <a href="{{ Storage::url($Pengaduan->Gambar_Pengaduan) }}" target="_blank"
                                class="w-max p-2 border-2 border-Genoa rounded-lg flex items-center gap-4">
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#000000"
                                    viewBox="0 0 256 256">
                                    <path
                                        d="M224,152a8,8,0,0,1-8,8H192v16h16a8,8,0,0,1,0,16H192v16a8,8,0,0,1-16,0V152a8,8,0,0,1,8-8h32A8,8,0,0,1,224,152ZM92,172a28,28,0,0,1-28,28H56v8a8,8,0,0,1-16,0V152a8,8,0,0,1,8-8H64A28,28,0,0,1,92,172Zm-16,0a12,12,0,0,0-12-12H56v24h8A12,12,0,0,0,76,172Zm88,8a36,36,0,0,1-36,36H112a8,8,0,0,1-8-8V152a8,8,0,0,1,8-8h16A36,36,0,0,1,164,180Zm-16,0a20,20,0,0,0-20-20h-8v40h8A20,20,0,0,0,148,180ZM40,112V40A16,16,0,0,1,56,24h96a8,8,0,0,1,5.66,2.34l56,56A8,8,0,0,1,216,88v24a8,8,0,0,1-16,0V96H152a8,8,0,0,1-8-8V40H56v72a8,8,0,0,1-16,0ZM160,80h28.69L160,51.31Z">
                                    </path>
                                </svg>
                                <p class="w-40 truncate">
                                    {{ $Pengaduan->Gambar_Pengaduan }}
                                </p>
                            </a>
                            @else
                            <p class="text-gray-500">Tidak Ada File Yang Diunggah.</p>
                            @endif
                        </div>
                        <!-- Status Laporan -->
                        <div class="w-full">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Status
                                Pengaduan :</label>
                            <div class="flex gap-x-6">
                                <div class="flex items-center">
                                    <input type="radio" name="Status_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-1" value="Selesai"
                                        {{ $Pengaduan->Status_Pengaduan === 'Selesai' ? 'checked' : '' }}>
                                    <span
                                        class="inline-flex mx-5 border-2 border-Genoa items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-base font-medium bg-Aquamarine text-Genoa">
                                        <span
                                            class="size-1.5 inline-block rounded-full bg-Genoa  dark:bg-blue-500"></span>
                                        Selesai
                                    </span>
                                </div>

                                <div class="flex items-center">
                                    <input type="radio" name="Status_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-2" value="Sedang Diproses"
                                        {{ $Pengaduan->Status_Pengaduan === 'Sedang Diproses' ? 'checked' : '' }}>
                                    <span
                                        class="inline-flex mx-5 border-2 border-Orange-Peel items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-base font-medium bg-yellow-100 text-Orange-Peel">
                                        <span class="size-1.5 inline-block rounded-full bg-Orange-Peel"></span>
                                        Sedang Diproses
                                    </span>
                                </div>

                                <div class="flex items-center">
                                    <input type="radio" name="Status_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-3" value="Belum Selesai"
                                        {{ $Pengaduan->Status_Pengaduan === 'Belum Selesai' ? 'checked' : '' }}>
                                    <span
                                        class="inline-flex mx-5 border-2 border-Medium-Carmine items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-base font-medium bg-red-100 text-Medium-Carmine">
                                        <span class="size-1.5 inline-block rounded-full bg-Medium-Carmine"></span>
                                        Belum Selesai
                                    </span>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
            <div class="flex items-center justify-end px-4 py-3 border-t gap-x-2">
                <button type="button"
                    class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-800 bg-white border border-gray-200 rounded-lg shadow-sm gap-x-2 hover:bg-gray-50 focus:outline-none focus:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none"
                    data-hs-overlay="#edit-modal{{ $Pengaduan->ID_Pengaduan }}">
                    Tutup
                </button>
                <button type="submit"
                    class="inline-flex items-center px-3 py-2 text-sm font-medium text-white border border-transparent rounded-lg gap-x-2 bg-Genoa focus:outline-none disabled:opacity-50 disabled:pointer-events-none">
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

<!-- Hapus Laporan -->
<div id="hapus-modal{{ $Pengaduan->ID_Pengaduan }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-vertically-centered-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-lg sm:w-full m-3 sm:mx-auto min-h-[calc(100%-3.5rem)] flex items-center">
        <div class="flex flex-col w-full bg-white border shadow-sm pointer-events-auto rounded-xl">
            <div class="flex items-center justify-between px-4 py-3 border-b">
                <h3 id="hs-vertically-centered-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Hapus Pengaduan
                </h3>
                <button type="button"
                    class="inline-flex items-center justify-center text-gray-800 bg-gray-100 border border-transparent rounded-full size-8 gap-x-2 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#hapus-modal{{ $Pengaduan->ID_Pengaduan }}">
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
                <p class="text-center 2xl:text-lg text-gray-800">
                    Apakah anda yakin ingin menghapus data ini?
                </p>

                <ul class="flex items-center justify-center gap-4 my-10">
                    <li><button type="button" data-hs-overlay="#hapus-modal{{ $Pengaduan->ID_Pengaduan }}"
                            class="btn-cancel inline-flex items-center justify-center w-32 px-4 py-3 text-sm font-medium text-white border border-transparent rounded-full gap-x-2 bg-Medium-Carmine focus:outline-none disabled:opacity-50 disabled:pointer-events-none">
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
                        <form action="{{ route('laporan.destroy', ['ID_Pengaduan' => $Pengaduan -> ID_Pengaduan]) }}"
                            method="post">
                            @csrf
                            @method('DELETE')
                            <button type="submit"
                                class="inline-flex items-center justify-center w-32 px-4 py-3 text-sm font-medium text-white border border-transparent rounded-full gap-x-2 bg-Genoa focus:outline-none disabled:opacity-50 disabled:pointer-events-none">
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

<!-- Detail Laporan -->
<div id="detail-modal{{ $Pengaduan->ID_Pengaduan }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="flex flex-col w-full max-h-full overflow-hidden bg-white border shadow-sm pointer-events-auto rounded-xl">
            <div class="flex items-center justify-between px-4 py-3 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="font-bold text-gray-800">
                    Detail Pengaduan
                </h3>
                <button type="button"
                    class="inline-flex items-center justify-center text-gray-800 bg-gray-100 border border-transparent rounded-full size-8 gap-x-2 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#detail-modal{{ $Pengaduan->ID_Pengaduan }}">
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
                        <!-- Kode Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Kode Pengaduan
                                :</label>
                            <input type="text" id="input-label" name="Kode_Pengaduan"
                                class="block w-full px-4 py-3 text-sm 2xl:text-base border-gray-200 rounded-lg pointer-events-none focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Kode Laporan" value="{{ $Pengaduan->Kode_Pengaduan }}" readonly>
                        </div>
                        <!-- Kategori Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Kategori
                                Pengaduan :</label>
                            <div class="grid grid-cols-2 gap-4">
                                <div class="flex">
                                    <input type="radio" name="Kategori_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-1" value="Pengangkutan Sampah"
                                        {{ $Pengaduan->Kategori_Pengaduan === 'Pengangkutan Sampah' ? 'checked' : 'disabled' }}>
                                    <label for="hs-radio-group-1"
                                        class="text-sm 2xl:text-base text-gray-500 ms-2 dark:text-neutral-400">Pengumpulan
                                        Sampah</label>
                                </div>
                                <div class="flex">
                                    <input type="radio" name="Kategori_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-2" value="Kondisi TPS"
                                        {{ $Pengaduan->Kategori_Pengaduan === 'Kondisi TPS' ? 'checked' : 'disabled' }}>
                                    <label for="hs-radio-group-2"
                                        class="text-sm 2xl:text-base text-gray-500 ms-2 dark:text-neutral-400">Kondisi
                                        TPS</label>
                                </div>
                                <div class="flex">
                                    <input type="radio" name="Kategori_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-3" value="Tempat Sampah Liar"
                                        {{ $Pengaduan->Kategori_Pengaduan === 'Tempat Sampah Liar' ? 'checked' : 'disabled' }}>
                                    <label for="hs-radio-group-3"
                                        class="text-sm 2xl:text-base text-gray-500 ms-2 dark:text-neutral-400">Tempat
                                        Sampah
                                        Liar</label>
                                </div>
                                <div class="flex">
                                    <input type="radio" name="Kategori_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-3" value="Lainnya"
                                        {{ $Pengaduan->Kategori_Pengaduan === 'Lainnya' ? 'checked' : 'disabled' }}>
                                    <label for="hs-radio-group-3"
                                        class="text-sm 2xl:text-base text-gray-500 ms-2 dark:text-neutral-400">Lainnya</label>
                                </div>
                            </div>
                        </div>
                        <!-- Deskripsi Laporan -->
                        <div class="w-full mb-5">
                            <label for="textarea-label" class="block mb-2 text-sm 2xl:text-base font-medium">Deskripsi
                                Pengaduan</label>
                            <textarea id="textarea-label" name="Deskripsi_Pengaduan"
                                class="block w-full px-4 py-3 text-sm 2xl:text-base border-gray-200 rounded-lg pointer-events-none focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                rows="3" placeholder="Deskripsi Laporan"
                                readonly>{{ $Pengaduan->Deskripsi_Pengaduan }}</textarea>
                        </div>
                        <!-- Titik Koordinat -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Titik
                                Koordinat :</label>
                            <input type="text" id="input-label" name="Titik_Koordinat"
                                class="block w-full px-4 py-3 text-sm 2xl:text-base border-gray-200 rounded-lg pointer-events-none focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Titik Koordinat" value="{{ $Pengaduan->Titik_Koordinat }}"
                                readonly>
                        </div>
                        <div class="w-full mb-5">
                            @php
                            if (filter_var($Pengaduan->Titik_Koordinat, FILTER_VALIDATE_URL)) {
                            if (preg_match('/@([0-9.-]+),([0-9.-]+)/', $Pengaduan->Titik_Koordinat, $matches)) {
                            $latitude = $matches[1];
                            $longitude = $matches[2];
                            } else {
                            $latitude = 0;
                            $longitude = 0;
                            }
                            } else {
                            $coordinates = explode(',', $Pengaduan->Titik_Koordinat);
                            $latitude = isset($coordinates[0]) ? trim($coordinates[0]) : 0;
                            $longitude = isset($coordinates[1]) ? trim($coordinates[1]) : 0;
                            }
                            @endphp
                            <iframe
                                src="https://www.google.com/maps?q={{ $latitude }},{{ $longitude }}&hl=en&z=17&output=embed"
                                class="w-full h-[25rem] rounded-sm" style="border:0;" allowfullscreen="" loading="lazy">
                            </iframe>
                        </div>
                        <!-- Gambar Pendukung -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Gambar
                                Pendukung :</label>
                            <div class="grid grid-cols-3 gap-4">
                                @foreach ($Pengaduan->FotoTable as $foto)
                                @if ($foto->ID_Pengaduan === $Pengaduan->ID_Pengaduan)
                                <div class="col-span-1">
                                    <img src="{{ asset('storage/' . $foto->Foto) }}" class="size-full" alt="">
                                </div>
                                @endif
                                @endforeach
                            </div>

                        </div>
                        <!-- Dokumen Pendukung -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Dokumen
                                Pendukung :</label>
                            @if($Pengaduan->Gambar_Pengaduan)
                            <a href="{{ Storage::url($Pengaduan->Gambar_Pengaduan) }}" target="_blank"
                                class="w-max p-2 border-2 border-Genoa rounded-lg flex items-center gap-4">
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#000000"
                                    viewBox="0 0 256 256">
                                    <path
                                        d="M224,152a8,8,0,0,1-8,8H192v16h16a8,8,0,0,1,0,16H192v16a8,8,0,0,1-16,0V152a8,8,0,0,1,8-8h32A8,8,0,0,1,224,152ZM92,172a28,28,0,0,1-28,28H56v8a8,8,0,0,1-16,0V152a8,8,0,0,1,8-8H64A28,28,0,0,1,92,172Zm-16,0a12,12,0,0,0-12-12H56v24h8A12,12,0,0,0,76,172Zm88,8a36,36,0,0,1-36,36H112a8,8,0,0,1-8-8V152a8,8,0,0,1,8-8h16A36,36,0,0,1,164,180Zm-16,0a20,20,0,0,0-20-20h-8v40h8A20,20,0,0,0,148,180ZM40,112V40A16,16,0,0,1,56,24h96a8,8,0,0,1,5.66,2.34l56,56A8,8,0,0,1,216,88v24a8,8,0,0,1-16,0V96H152a8,8,0,0,1-8-8V40H56v72a8,8,0,0,1-16,0ZM160,80h28.69L160,51.31Z">
                                    </path>
                                </svg>
                                <p class="w-40 truncate">
                                    {{ $Pengaduan->Gambar_Pengaduan }}
                                </p>
                            </a>
                            @else
                            <p class="text-gray-500">Tidak ada file yang diunggah.</p>
                            @endif
                        </div>
                        <!-- Status Laporan -->
                        <div class="w-full">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Status
                                Pengaduan :</label>
                            <div class="flex gap-x-6">
                                <div class="flex items-center">
                                    <input type="radio" name="Status_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-1" value="Selesai"
                                        {{ $Pengaduan->Status_Pengaduan === 'Selesai' ? 'checked' : 'disabled' }}>
                                    <span
                                        class="inline-flex mx-5 border-2 border-Genoa items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-base font-medium bg-Aquamarine text-Genoa">
                                        <span class="size-1.5 inline-block rounded-full bg-Genoa"></span>
                                        Selesai
                                    </span>
                                </div>

                                <div class="flex items-center">
                                    <input type="radio" name="Status_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-2" value="Sedang Diproses"
                                        {{ $Pengaduan->Status_Pengaduan === 'Sedang Diproses' ? 'checked' : 'disabled' }}>
                                    <span
                                        class="inline-flex mx-5 border-2 border-Orange-Peel items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-base font-medium bg-yellow-100 text-Orange-Peel">
                                        <span class="size-1.5 inline-block rounded-full bg-Orange-Peel"></span>
                                        Sedang Diproses
                                    </span>
                                </div>

                                <div class="flex items-center">
                                    <input type="radio" name="Status_Pengaduan"
                                        class="shrink-0 mt-0.5 border-gray-400 rounded-full text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        id="hs-radio-group-3" value="Belum Selesai"
                                        {{ $Pengaduan->Status_Pengaduan === 'Belum Selesai' ? 'checked' : 'disabled' }}>
                                    <span
                                        class="inline-flex mx-5 border-2 border-Medium-Carmine items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs 2xl:text-base font-medium bg-red-100 text-Medium-Carmine">
                                        <span class="size-1.5 inline-block rounded-full bg-Medium-Carmine"></span>
                                        Belum Selesai
                                    </span>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endforeach

<!-- Tambah Penanggung Jawab -->
<div id="tambah-modal"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="w-full max-h-full overflow-hidden flex flex-col bg-white border shadow-sm rounded-xl pointer-events-auto">
            <div class="flex justify-between items-center py-3 px-4 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="2xl:text-lg font-bold text-gray-800">
                    Tambah Penanggung Jawab
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
                    <form action="{{ route('penanggungJawab.store') }}" method="post">
                        @csrf
                        <!-- Petugas -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Petugas
                                Yang Bertanggung Jawab :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-slate-400 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" id="id_petugas_input"
                                        name="ID_Petugas" data-hs-combo-box-input="" required>
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
                                @foreach ($dataPetugas as $User)
                                @if ($User->Status_Keaktifan == 'Aktif')
                                <div class="absolute z-50 w-full max-h-72 p-1 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300"
                                    style="display: none;" data-hs-combo-box-output="{{ $User->UserTable->Nama }}">
                                    <div class="cursor-pointer py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100"
                                        tabindex="0" data-hs-combo-box-output-item="{{ $User->UserTable->Nama }}">
                                        <div class="flex justify-between items-center w-full">
                                            <span data-hs-combo-box-search-text="{{ $User->ID_Petugas }}"
                                                data-hs-combo-box-value="{{ $User->ID_Petugas }}">{{ $User->UserTable->Nama }}</span>
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
                        <!-- Kode Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Kode Pengaduan
                                :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-slate-400 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" name="Kode_Pengaduan"
                                        data-hs-combo-box-input="" id="kode_laporan_input" value="" required>
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
                                @foreach ($pegaduan as $Pengaduan)
                                @if ($Pengaduan->Status_Pengaduan !== "Selesai")
                                <div class="absolute z-50 w-full max-h-72 p-1 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300"
                                    style="display: none;" data-hs-combo-box-output="{{ $Pengaduan->Kode_Pengaduan }}">
                                    <div class="cursor-pointer py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100"
                                        tabindex="0" data-hs-combo-box-output-item="{{ $Pengaduan->Kode_Pengaduan }}">
                                        <div class="flex justify-between items-center w-full">
                                            <span data-hs-combo-box-search-text="{{ $Pengaduan->Kode_Pengaduan }}"
                                                data-hs-combo-box-value="{{ $Pengaduan->Kode_Pengaduan }}">{{ $Pengaduan->Kode_Pengaduan }}</span>
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
                            @error('Kode_Pengaduan')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Kategori Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Kategori
                                Pengaduan
                                :</label>
                            <input type="text" id="kategori_laporan_input"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Kategori Laporan" name="Kategori_Pengaduan" value="" readonly>
                            @error('Kategori_Pengaduan')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Status Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Status
                                Laporan :</label>
                            <input type="text" id="status_laporan_input"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Status Laporan" name="Status_Pengaduan" value="">
                            @error('Status_Pengaduan')
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

@foreach ($dataPenanggungJawab as $key => $PJ)
<!-- Edit Penanggung Jawab -->
<div id="edit-modalPJ{{ $PJ->ID_PJ }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="flex flex-col w-full max-h-full overflow-hidden bg-white border shadow-sm pointer-events-auto rounded-xl">
            <div class="flex items-center justify-between px-4 py-3 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="2xl:text-lg font-bold text-gray-800">
                    Edit Status Penanggung Jawab
                </h3>
                <button type="button"
                    class="inline-flex items-center justify-center text-gray-800 bg-gray-100 border border-transparent rounded-full size-8 gap-x-2 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#edit-modalPJ{{ $PJ->ID_PJ }}">
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
                    <form action="{{ route('penanggungJawab.update', ['ID_PJ' => $PJ -> ID_PJ]) }}" method="post">
                        @csrf
                        @method('PATCH')
                        <!-- Petugas -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Petugas
                                Yang Bertanggung Jawab :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-slate-400 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" id="id_petugas_input"
                                        name="ID_Petugas" data-hs-combo-box-input="" value="{{ $PJ->ID_Petugas }}"
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
                                @foreach ($dataPetugas as $User)
                                @if ($User->Status_Keaktifan == 'Aktif')
                                <div class="absolute z-50 w-full max-h-72 p-1 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300"
                                    style="display: none;" data-hs-combo-box-output="{{ $User->UserTable->Nama }}">
                                    <div class="cursor-pointer py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100"
                                        tabindex="0" data-hs-combo-box-output-item="{{ $User->UserTable->Nama }}">
                                        <div class="flex justify-between items-center w-full">
                                            <span data-hs-combo-box-search-text="{{ $User->ID_Petugas }}"
                                                data-hs-combo-box-value="{{ $User->ID_Petugas }}">{{ $User->UserTable->Nama }}</span>
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
                        <!-- Kode Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Kode Pengaduan
                                :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-slate-400 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" name="Kode_Pengaduan"
                                        data-hs-combo-box-input="" id="kode_laporan_input"
                                        value="{{ $PJ->Kode_Pengaduan }}" required>
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
                                @foreach ($dataPengaduan as $Pengaduan)
                                @if ($Pengaduan->Status_Pengaduan !== 'Selesai')
                                <div class="absolute z-50 w-full max-h-72 p-1 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300"
                                    style="display: none;" data-hs-combo-box-output="{{ $Pengaduan->Kode_Pengaduan }}">
                                    <div class="cursor-pointer py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100"
                                        tabindex="0" data-hs-combo-box-output-item="{{ $Pengaduan->Kode_Pengaduan }}">
                                        <div class="flex justify-between items-center w-full">
                                            <span data-hs-combo-box-search-text="{{ $Pengaduan->Kode_Pengaduan }}"
                                                data-hs-combo-box-value="{{ $Pengaduan->Kode_Pengaduan }}">{{ $Pengaduan->Kode_Pengaduan }}</span>
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
                            @error('Kode_Pengaduan')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Kategori Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Kategori
                                Pengaduan
                                :</label>
                            <input type="text" id="kategori_laporan_input"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Kategori Laporan" name="Kategori_Pengaduan"
                                value="{{ $PJ->Kategori_Pengaduan }}" readonly>
                            @error('Kategori_Pengaduan')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                        <!-- Status Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Status
                                Laporan
                                :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Status Pengaduan",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Status_Pengaduan" required>
                                <option value="">Pilih</option>
                                <option value="Selesai" {{ $PJ->Status_Pengaduan == 'Selesai' ? 'selected' : '' }}>
                                    Selesai
                                </option>
                                <option value="Sedang Diproses"
                                    {{ $PJ->Status_Pengaduan == 'Sedang Diproses' ? 'selected' : '' }}>
                                    Sedang Diproses</option>
                                <option value="Belum Selesai"
                                    {{ $PJ->Status_Pengaduan == 'Belum Selesai' ? 'selected' : '' }}>
                                    Belum Selesai</option>
                            </select>
                            @error('Status_Pengaduan')
                            <p class="text-sm 2xl:text-base text-red-600 mt-2" id="hs-validation-name-error-helper">
                                {{ $message }}
                            </p>
                            @enderror
                        </div>
                </div>
            </div>
            <div class="flex items-center justify-end px-4 py-3 border-t gap-x-2">
                <button type="button"
                    class="inline-flex items-center px-3 py-2 text-sm 2xl:text-base font-medium text-gray-800 bg-white border border-gray-200 rounded-lg shadow-sm gap-x-2 hover:bg-gray-50 focus:outline-none focus:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none"
                    data-hs-overlay="#edit-modalPJ{{ $PJ->ID_PJ }}">
                    Tutup
                </button>
                <button type="submit"
                    class="inline-flex items-center px-3 py-2 text-sm 2xl:text-base font-medium text-white border border-transparent rounded-lg gap-x-2 bg-Genoa focus:outline-none disabled:opacity-50 disabled:pointer-events-none">
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

<!-- Detail Penanggung Jawab -->
<div id="detail-modalPJ{{ $PJ->ID_PJ }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="flex flex-col w-full max-h-full overflow-hidden bg-white border shadow-sm pointer-events-auto rounded-xl">
            <div class="flex items-center justify-between px-4 py-3 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="2xl:text-lg font-bold text-gray-800">
                    Detail Penanggung Jawab
                </h3>
                <button type="button"
                    class="inline-flex items-center justify-center text-gray-800 bg-gray-100 border border-transparent rounded-full size-8 gap-x-2 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#detail-modalPJ{{ $PJ->ID_PJ }}">
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
                        <!-- Petugas -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Petugas
                                Yang Bertanggung Jawab :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-slate-400 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" id="id_petugas_input"
                                        name="ID_Petugas" data-hs-combo-box-input="" value="{{ $PJ->ID_Petugas }}"
                                        required>
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
                                @foreach ($dataPetugas as $User)
                                @if ($User->Status_Keaktifan == 'Aktif')
                                <div class="absolute z-50 w-full max-h-72 p-1 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto pointer-events-none [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300"
                                    style="display: none;" data-hs-combo-box-output="{{ $User->UserTable->Nama }}">
                                    <div class="cursor-pointer py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100"
                                        tabindex="0" data-hs-combo-box-output-item="{{ $User->UserTable->Nama }}">
                                        <div class="flex justify-between items-center w-full">
                                            <span data-hs-combo-box-search-text="{{ $User->ID_Petugas }}"
                                                data-hs-combo-box-value="{{ $User->ID_Petugas }}">{{ $User->UserTable->Nama }}</span>
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
                        </div>
                        <!-- Kode Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Kode Pengaduan
                                :</label>
                            <div class="relative" data-hs-combo-box="">
                                <div class="relative">
                                    <input
                                        class="py-3 ps-4 pe-9 block w-full border-2 border-slate-400 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 pointer-events-none"
                                        type="text" role="combobox" aria-expanded="false" name="Kode_Pengaduan"
                                        data-hs-combo-box-input="" id="kode_laporan_input"
                                        value="{{ $PJ->Kode_Pengaduan }}" required>
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
                                @foreach ($dataPengaduan as $Pengaduan)
                                @if ($Pengaduan->Status_Pengaduan !== 'Selesai')
                                <div class="absolute z-50 w-full max-h-72 p-1 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto pointer-events-none [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300"
                                    style="display: none;" data-hs-combo-box-output="{{ $Pengaduan->Kode_Pengaduan }}">
                                    <div class="cursor-pointer py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100"
                                        tabindex="0" data-hs-combo-box-output-item="{{ $Pengaduan->Kode_Pengaduan }}">
                                        <div class="flex justify-between items-center w-full">
                                            <span data-hs-combo-box-search-text="{{ $Pengaduan->Kode_Pengaduan }}"
                                                data-hs-combo-box-value="{{ $Pengaduan->Kode_Pengaduan }}">{{ $Pengaduan->Kode_Pengaduan }}</span>
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
                        </div>
                        <!-- Kategori Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Kategori
                                Pengaduan
                                :</label>
                            <input type="text" id="kategori_laporan_input"
                                class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm 2xl:text-base focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Kategori Laporan" name="Kategori_Pengaduan"
                                value="{{ $PJ->Kategori_Pengaduan }}" readonly>
                        </div>
                        <!-- Status Laporan -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block text-sm 2xl:text-base font-medium mb-2">Status
                                Laporan
                                :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Status Pengaduan",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Status_Pengaduan" required>
                                <option value="">Pilih</option>
                                <option value="Selesai" {{ $PJ->Status_Pengaduan == 'Selesai' ? 'selected' : '' }}>
                                    Selesai
                                </option>
                                <option value="Sedang Diproses"
                                    {{ $PJ->Status_Pengaduan == 'Sedang Diproses' ? 'selected' : '' }}>
                                    Sedang Diproses</option>
                                <option value="Belum Selesai"
                                    {{ $PJ->Status_Pengaduan == 'Belum Selesai' ? 'selected' : '' }}>
                                    Belum Selesai</option>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Hapus Laporan -->
<div id="hapus-modalPJ{{ $PJ->ID_PJ }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-vertically-centered-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-lg sm:w-full m-3 sm:mx-auto min-h-[calc(100%-3.5rem)] flex items-center">
        <div class="flex flex-col w-full bg-white border shadow-sm pointer-events-auto rounded-xl">
            <div class="flex items-center justify-between px-4 py-3 border-b">
                <h3 id="hs-vertically-centered-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Hapus Penanggung Jawab
                </h3>
                <button type="button"
                    class="inline-flex items-center justify-center text-gray-800 bg-gray-100 border border-transparent rounded-full size-8 gap-x-2 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#hapus-modalPJ{{ $PJ->ID_PJ }}">
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
                <p class="text-center 2xl:text-lg text-gray-800">
                    Apakah anda yakin ingin menghapus data ini?
                </p>

                <ul class="flex items-center justify-center gap-4 my-10">
                    <li><button type="button" data-hs-overlay="#hapus-modalPJ{{ $PJ->ID_PJ }}"
                            class="btn-cancel inline-flex items-center justify-center w-32 px-4 py-3 text-sm font-medium text-white border border-transparent rounded-full gap-x-2 bg-Medium-Carmine focus:outline-none disabled:opacity-50 disabled:pointer-events-none">
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
                        <form action="{{ route('penanggungJawab.destroy', ['ID_PJ' => $PJ -> ID_PJ]) }}" method="post">
                            @csrf
                            @method('DELETE')
                            <button type="submit"
                                class="inline-flex items-center justify-center w-32 px-4 py-3 text-sm font-medium text-white border border-transparent rounded-full gap-x-2 bg-Genoa focus:outline-none disabled:opacity-50 disabled:pointer-events-none">
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
@endforeach