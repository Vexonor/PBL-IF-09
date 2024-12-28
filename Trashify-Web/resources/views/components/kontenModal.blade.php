@foreach ($dataKonten as $Konten)
<!-- Edit Konten -->
<div id="edit-modal{{ $Konten->ID_Edukasi }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-vertically-centered-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-lg sm:w-full m-3 sm:mx-auto min-h-[calc(100%-3.5rem)] flex items-center">
        <div class="flex flex-col w-full bg-white border shadow-sm pointer-events-auto rounded-xl">
            <div class="flex items-center justify-between px-4 py-3 border-b">
                <h3 id="hs-vertically-centered-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Unggah Konten
                </h3>
                <button type="button"
                    class="inline-flex items-center justify-center text-gray-800 bg-gray-100 border border-transparent rounded-full size-8 gap-x-2 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#edit-modal{{ $Konten->ID_Edukasi }}">
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
                    Apakah anda yakin ingin mengunggah konten ini?
                </p>
                <ul class="flex items-center justify-center gap-4 my-10">
                    <li><button type="button" data-hs-overlay="#edit-modal{{ $Konten->ID_Edukasi }}"
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
                        <form action="{{ route('konten.upload', ['ID_Edukasi' => $Konten -> ID_Edukasi]) }}"
                            method="post">
                            @csrf
                            @method('PUT')
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

<!-- Hapus Laporan -->
<div id="hapus-modal{{ $Konten->ID_Edukasi }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-vertically-centered-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-lg sm:w-full m-3 sm:mx-auto min-h-[calc(100%-3.5rem)] flex items-center">
        <div class="flex flex-col w-full bg-white border shadow-sm pointer-events-auto rounded-xl">
            <div class="flex items-center justify-between px-4 py-3 border-b">
                <h3 id="hs-vertically-centered-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Hapus Konten Edukasi
                </h3>
                <button type="button"
                    class="inline-flex items-center justify-center text-gray-800 bg-gray-100 border border-transparent rounded-full size-8 gap-x-2 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#hapus-modal{{ $Konten->ID_Edukasi }}">
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
                    <li><button type="button" data-hs-overlay="#hapus-modal{{ $Konten->ID_Edukasi }}"
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
                        <form action="{{ route('konten.destroy', ['ID_Edukasi' => $Konten -> ID_Edukasi]) }}"
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
<div id="detail-modal{{ $Konten->ID_Edukasi }}"
    class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto pointer-events-none"
    role="dialog" tabindex="-1" aria-labelledby="hs-large-modal-label">
    <div
        class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-4xl 2xl:max-w-7xl sm:w-full m-3 sm:mx-auto h-[calc(100%-3.5rem)] min-h-[calc(100%-3.5rem)] flex items-center">
        <div
            class="flex flex-col w-full max-h-full overflow-hidden bg-white border shadow-sm pointer-events-auto rounded-xl">
            <div class="flex items-center justify-between px-4 py-3 border-b">
                <h3 id="hs-vertically-centered-scrollable-modal-label" class="font-bold 2xl:text-lg text-gray-800">
                    Detail Konten Edukasi
                </h3>
                <button type="button"
                    class="inline-flex items-center justify-center text-gray-800 bg-gray-100 border border-transparent rounded-full size-8 gap-x-2 hover:bg-gray-200 focus:outline-none focus:bg-gray-200 disabled:opacity-50 disabled:pointer-events-none"
                    aria-label="Close" data-hs-overlay="#detail-modal{{ $Konten->ID_Edukasi }}">
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
                        <!-- Nama Penerbit -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Nama
                                Penerbit
                                :</label>
                            <input type="text" id="input-label"
                                class="block w-full px-4 py-3 text-sm 2xl:text-base border-gray-200 rounded-lg focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Judul Konten" name="Judul_Edukasi"
                                value="{{ $Konten->UserTable->Nama }}" readonly>
                        </div>
                        <!-- Judul Konten -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Judul Konten
                                :</label>
                            <input type="text" id="input-label"
                                class="block w-full px-4 py-3 text-sm 2xl:text-base border-gray-200 rounded-lg focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Judul Konten" name="Judul_Edukasi"
                                value="{{ $Konten->Judul_Edukasi }}" readonly>
                        </div>
                        <!-- Link Konten -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Link URL
                                Konten
                                :</label>
                            <input type="url" id="input-label"
                                class="block w-full px-4 py-3 text-sm 2xl:text-base border-gray-200 rounded-lg focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                placeholder="Masukkan Judul Konten" name="Link_URL" value="{{ $Konten->Link_URL }}"
                                readonly>
                        </div>
                        <!-- Konten -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">
                                Konten :</label>
                            @if ($Konten->Jenis_Edukasi === 'Video')
                            <iframe class="w-full h-80 2xl:h-96"
                                src="https://www.youtube.com/embed/{{ $Konten->Link_URL }}" frameborder="0"></iframe>
                            @elseif ($Konten->Jenis_Edukasi === 'Artikel')
                            <a href="{{ $Konten->Link_URL }}" target="_blank"
                                class="w-max p-2 border-2 border-Genoa rounded-lg flex items-center gap-2">
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#000000"
                                    viewBox="0 0 256 256">
                                    <path
                                        d="M240,88.23a54.43,54.43,0,0,1-16,37L189.25,160a54.27,54.27,0,0,1-38.63,16h-.05A54.63,54.63,0,0,1,96,119.84a8,8,0,0,1,16,.45A38.62,38.62,0,0,0,150.58,160h0a38.39,38.39,0,0,0,27.31-11.31l34.75-34.75a38.63,38.63,0,0,0-54.63-54.63l-11,11A8,8,0,0,1,135.7,59l11-11A54.65,54.65,0,0,1,224,48,54.86,54.86,0,0,1,240,88.23ZM109,185.66l-11,11A38.41,38.41,0,0,1,70.6,208h0a38.63,38.63,0,0,1-27.29-65.94L78,107.31A38.63,38.63,0,0,1,144,135.71a8,8,0,0,0,16,.45A54.86,54.86,0,0,0,144,96a54.65,54.65,0,0,0-77.27,0L32,130.75A54.62,54.62,0,0,0,70.56,224h0a54.28,54.28,0,0,0,38.64-16l11-11A8,8,0,0,0,109,185.66Z">
                                    </path>
                                </svg>
                                <span>Kunjungi</span>
                            </a>
                            @endif
                        </div>
                        <!-- Deskripsi Konten -->
                        <div class="w-full mb-5">
                            <label for="textarea-label" class="block mb-2 text-sm 2xl:text-base font-medium">Deskripsi
                                Konten :</label>
                            <textarea id="textarea-label"
                                class="block w-full px-4 py-3 text-sm 2xl:text-base border-gray-200 rounded-lg focus-within:outline-none disabled:opacity-50 disabled:pointer-events-none"
                                rows="3" placeholder="Deskripsi Konten" name="Deskripsi_Edukasi"
                                readonly>{{ $Konten->Deskripsi_Edukasi }}</textarea>
                        </div>
                        <!-- Tipe Konten -->
                        <div class="w-full mb-5">
                            <label for="input-label" class="block mb-2 text-sm 2xl:text-base font-medium">Tipe Konten
                                :</label>
                            <select data-hs-select='{
                                "placeholder": "Pilih Tipe Konten",
                                "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                                "toggleClasses": "pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm 2xl:text-base focus:outline-none focus:ring-2 focus:ring-blue-500",
                                "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
                                "optionClasses": "py-2 px-4 w-full text-sm 2xl:text-base text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 pointer-events-none hs-select-disabled:opacity-50",
                                "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 \" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
                                "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
                                }' class="hidden" name="Jenis_Edukasi" required>
                                <option value="">Pilih Jenis Konten</option>
                                <option value="Video" {{ $Konten->Jenis_Edukasi == 'Video' ? 'selected' : '' }}>
                                    Video</option>
                                <option value="Artikel" {{ $Konten->Jenis_Edukasi == 'Artikel' ? 'selected' : '' }}>
                                    Artikel</option>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endforeach