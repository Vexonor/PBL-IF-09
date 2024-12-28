<div class="sidebar min-h-full xl:h-lvh md:w-72 xl:w-80 2xl:w-[21.875rem] overflow-hidden">
    <ul class="sticky top-5">
        <li class="logo pointer-events-none flex justify-center items-center mt-3">
            <a href="#">
                <div class="icon">
                    <img class="size-16" src="{{ asset('img/garbage-truck 4.svg') }}" alt="">
                </div>
                <div class="text md:text-xl xl:text-2xl font-bold">Trashify</div>
            </a>
        </li>
        <div class="Menulist">
            <li class="{{ $title == 'Dashboard' ? 'active' : '' }}">
                <a href="/dashboard">
                    <div class="icon">
                        <svg class="{{ $title == 'Dashboard' ? 'text-black' : 'text-white' }}"
                            xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 256 256">
                            <path
                                d="M232,208a8,8,0,0,1-8,8H32a8,8,0,0,1-8-8V48a8,8,0,0,1,16,0v94.37L90.73,98a8,8,0,0,1,10.07-.38l58.81,44.11L218.73,90a8,8,0,1,1,10.54,12l-64,56a8,8,0,0,1-10.07.38L96.39,114.29,40,163.63V200H224A8,8,0,0,1,232,208Z"
                                fill="currentColor">
                            </path>
                        </svg>
                    </div>
                    <div
                        class="text md:text-sm xl:text-md 2xl:text-lg font-medium {{ $title == 'Dashboard' ? 'text-black' : 'text-white' }}">
                        Dashboard</div>
                </a>
            </li>

            <li class="{{ $title == 'Pengaduan' ? 'active' : '' }}">
                <a href="/laporan">
                    <div class="icon">
                        <svg class="{{ $title == 'Pengaduan' ? 'text-black' : 'text-white' }}"
                            xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 256 256">
                            <path
                                d="M168,152a8,8,0,0,1-8,8H96a8,8,0,0,1,0-16h64A8,8,0,0,1,168,152Zm-8-40H96a8,8,0,0,0,0,16h64a8,8,0,0,0,0-16Zm56-64V216a16,16,0,0,1-16,16H56a16,16,0,0,1-16-16V48A16,16,0,0,1,56,32H92.26a47.92,47.92,0,0,1,71.48,0H200A16,16,0,0,1,216,48ZM96,64h64a32,32,0,0,0-64,0ZM200,48H173.25A47.93,47.93,0,0,1,176,64v8a8,8,0,0,1-8,8H88a8,8,0,0,1-8-8V64a47.93,47.93,0,0,1,2.75-16H56V216H200Z"
                                fill="currentColor">
                            </path>
                        </svg>
                    </div>
                    <div
                        class="text md:text-sm xl:text-md 2xl:text-lg font-medium {{ $title == 'Pengaduan' ? 'text-black' : 'text-white' }}">
                        Pengaduan
                    </div>
                </a>
            </li>

            <li class="{{ $title == 'Informasi Pengangkutan' ? 'active' : '' }}">
                <a href="/informasiPengangkutan">
                    <div class="icon">
                        <svg class="{{ $title == 'Informasi Pengangkutan' ? 'text-black' : 'text-white' }}"
                            xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 256 256">
                            <path
                                d="M168,152a8,8,0,0,1-8,8H96a8,8,0,0,1,0-16h64A8,8,0,0,1,168,152Zm-8-40H96a8,8,0,0,0,0,16h64a8,8,0,0,0,0-16Zm56-64V216a16,16,0,0,1-16,16H56a16,16,0,0,1-16-16V48A16,16,0,0,1,56,32H92.26a47.92,47.92,0,0,1,71.48,0H200A16,16,0,0,1,216,48ZM96,64h64a32,32,0,0,0-64,0ZM200,48H173.25A47.93,47.93,0,0,1,176,64v8a8,8,0,0,1-8,8H88a8,8,0,0,1-8-8V64a47.93,47.93,0,0,1,2.75-16H56V216H200Z"
                                fill="currentColor">
                            </path>
                        </svg>
                    </div>
                    <div
                        class="text md:text-sm xl:text-md 2xl:text-lg font-medium {{ $title == 'Informasi Pengangkutan' ? 'text-black' : 'text-white' }}">
                        Informasi Pengangkutan</div>
                </a>
            </li>

            <li class="{{ $title == 'Konten Edukasi' ? 'active' : '' }}">
                <a href="/kontenEdukasi">
                    <div class="icon">
                        <svg class="{{ $title == 'Konten Edukasi' ? 'text-black' : 'text-white'}}"
                            xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                            viewBox="0 0 256 256">
                            <path
                                d="M164.44,105.34l-48-32A8,8,0,0,0,104,80v64a8,8,0,0,0,12.44,6.66l48-32a8,8,0,0,0,0-13.32ZM120,129.05V95l25.58,17ZM216,40H40A16,16,0,0,0,24,56V168a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V56A16,16,0,0,0,216,40Zm0,128H40V56H216V168Zm16,40a8,8,0,0,1-8,8H32a8,8,0,0,1,0-16H224A8,8,0,0,1,232,208Z">
                            </path>
                        </svg>
                    </div>
                    <div
                        class="text md:text-sm xl:text-md 2xl:text-lg font-medium {{ $title == 'Konten Edukasi' ? 'text-black' : 'text-white' }}">
                        Konten Edukasi
                    </div>
                </a>
            </li>

            <li class="{{ $title == 'Lokasi TPS' ? 'active' : '' }}">
                <a href="/lokasiTPS">
                    <div class="icon">
                        <svg class="{{ $title == 'Lokasi TPS' ? 'text-black' : 'text-white' }}"
                            xmlns=" http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 256 256">
                            <path
                                d="M112,80a16,16,0,1,1,16,16A16,16,0,0,1,112,80ZM64,80a64,64,0,0,1,128,0c0,59.95-57.58,93.54-60,94.95a8,8,0,0,1-7.94,0C121.58,173.54,64,140,64,80Zm16,0c0,42.2,35.84,70.21,48,78.5,12.15-8.28,48-36.3,48-78.5a48,48,0,0,0-96,0Zm122.77,67.63a8,8,0,0,0-5.54,15C213.74,168.74,224,176.92,224,184c0,13.36-36.52,32-96,32s-96-18.64-96-32c0-7.08,10.26-15.26,26.77-21.36a8,8,0,0,0-5.54-15C29.22,156.49,16,169.41,16,184c0,31.18,57.71,48,112,48s112-16.82,112-48C240,169.41,226.78,156.49,202.77,147.63Z"
                                fill="currentColor">
                            </path>
                        </svg>
                    </div>
                    <div
                        class="text md:text-sm xl:text-md 2xl:text-lg font-medium {{ $title == 'Lokasi TPS' ? 'text-black' : 'text-white' }}">
                        Lokasi
                        TPS</div>
                </a>
            </li>

            <li class="{{ $title == 'Bank Sampah' ? 'active' : '' }}">
                <a href="/bankSampah">
                    <div class="icon">
                        <svg class="{{ $title == 'Bank Sampah' ? 'text-black' : 'text-white' }}"
                            xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                            viewBox="0 0 256 256">
                            <path
                                d="M24,104H48v64H32a8,8,0,0,0,0,16H224a8,8,0,0,0,0-16H208V104h24a8,8,0,0,0,4.19-14.81l-104-64a8,8,0,0,0-8.38,0l-104,64A8,8,0,0,0,24,104Zm40,0H96v64H64Zm80,0v64H112V104Zm48,64H160V104h32ZM128,41.39,203.74,88H52.26ZM248,208a8,8,0,0,1-8,8H16a8,8,0,0,1,0-16H240A8,8,0,0,1,248,208Z">
                            </path>
                        </svg>
                    </div>
                    <div
                        class="text md:text-sm xl:text-md 2xl:text-lg font-medium {{ $title == 'Bank Sampah' ? 'text-black' : 'text-white' }}">
                        Bank
                        Sampah
                    </div>
                </a>
            </li>

            @if (auth()->check() && optional(auth()->user()->AdminTable)->Role_Admin === 'Master')
            <li class="{{ $title == 'Admin' ? 'active' : '' }}">
                <a href="/admin">
                    <div class="icon">
                        <svg class="{{ $title == 'Admin' ? 'text-black' : 'text-white' }}"
                            xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 256 256">
                            <path
                                d="M144,157.68a68,68,0,1,0-71.9,0c-20.65,6.76-39.23,19.39-54.17,37.17a8,8,0,1,0,12.24,10.3C50.25,181.19,77.91,168,108,168s57.75,13.19,77.87,37.15a8,8,0,0,0,12.26-10.3C183.18,177.07,164.6,164.44,144,157.68ZM56,100a52,52,0,1,1,52,52A52.06,52.06,0,0,1,56,100Zm196.25,43.07-4.66-2.69a23.6,23.6,0,0,0,0-8.76l4.66-2.69a8,8,0,1,0-8-13.86l-4.67,2.7a23.92,23.92,0,0,0-7.58-4.39V108a8,8,0,0,0-16,0v5.38a23.92,23.92,0,0,0-7.58,4.39l-4.67-2.7a8,8,0,1,0-8,13.86l4.66,2.69a23.6,23.6,0,0,0,0,8.76l-4.66,2.69a8,8,0,0,0,8,13.86l4.67-2.7a23.92,23.92,0,0,0,7.58,4.39V164a8,8,0,0,0,16,0v-5.38a23.92,23.92,0,0,0,7.58-4.39l4.67,2.7a7.92,7.92,0,0,0,4,1.07,8,8,0,0,0,4-14.93ZM216,136a8,8,0,1,1,8,8A8,8,0,0,1,216,136Z"
                                fill="currentColor">
                            </path>
                        </svg>
                    </div>
                    <div
                        class="text md:text-sm xl:text-md 2xl:text-lg font-medium {{ $title == 'Admin' ? 'text-black' : 'text-white' }}">
                        Admin
                    </div>
                </a>
            </li>
            @endif

            <li class="{{ $title == 'Petugas Kebersihan' ? 'active' : '' }}">
                <a href="/petugasKebersihan">
                    <div class="icon">
                        <svg class="{{ $title == 'Petugas Kebersihan' ? 'text-black' : 'text-white' }}"
                            xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 256 256">
                            <path
                                d="M117.25,157.92a60,60,0,1,0-66.5,0A95.83,95.83,0,0,0,3.53,195.63a8,8,0,1,0,13.4,8.74,80,80,0,0,1,134.14,0,8,8,0,0,0,13.4-8.74A95.83,95.83,0,0,0,117.25,157.92ZM40,108a44,44,0,1,1,44,44A44.05,44.05,0,0,1,40,108Zm210.14,98.7a8,8,0,0,1-11.07-2.33A79.83,79.83,0,0,0,172,168a8,8,0,0,1,0-16,44,44,0,1,0-16.34-84.87,8,8,0,1,1-5.94-14.85,60,60,0,0,1,55.53,105.64,95.83,95.83,0,0,1,47.22,37.71A8,8,0,0,1,250.14,206.7Z"
                                fill="currentColor">
                            </path>
                        </svg>
                    </div>
                    <div
                        class="text md:text-sm xl:text-md 2xl:text-lg font-medium {{ $title == 'Petugas Kebersihan' ? 'text-black' : 'text-white' }}">
                        Petugas
                        Kebersihan</div>
                </a>
            </li>
        </div>
    </ul>
</div>