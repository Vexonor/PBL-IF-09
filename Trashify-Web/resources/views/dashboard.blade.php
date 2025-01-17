@extends('layouts/main')

@section('main')
<!-- Card Grid -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 lg:items-center mx-6 my-5 p-10">

    <!-- Card 1 -->
    <div class="w-full flex flex-col p-7 bg-white md:rounded-2xl shadow-md border border-gray-200">
        <h4 class="text-gray-500 text-sm xl:text-base mb-1">Jumlah Pengaduan</h4>
        <div class="flex justify-between items-center gap-x-2 mb-2">
            <p data-hs-toggle-count='{
            "target": "#toggle-count",
            "min": 0,
            "max": 150
        }' class="text-gray-800 font-semibold text-3xl">
                {{ $totalLaporan }}
            </p>

            <div class="icon">
                <svg width="40" height="40" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path
                        d="M21 19C21 19.2652 20.8946 19.5196 20.7071 19.7071C20.5196 19.8946 20.2652 20 20 20H12C11.7348 20 11.4804 19.8946 11.2929 19.7071C11.1054 19.5196 11 19.2652 11 19C11 18.7348 11.1054 18.4804 11.2929 18.2929C11.4804 18.1054 11.7348 18 12 18H20C20.2652 18 20.5196 18.1054 20.7071 18.2929C20.8946 18.4804 21 18.7348 21 19ZM20 14H12C11.7348 14 11.4804 14.1054 11.2929 14.2929C11.1054 14.4804 11 14.7348 11 15C11 15.2652 11.1054 15.5196 11.2929 15.7071C11.4804 15.8946 11.7348 16 12 16H20C20.2652 16 20.5196 15.8946 20.7071 15.7071C20.8946 15.5196 21 15.2652 21 15C21 14.7348 20.8946 14.4804 20.7071 14.2929C20.5196 14.1054 20.2652 14 20 14ZM27 6V27C27 27.5304 26.7893 28.0391 26.4142 28.4142C26.0391 28.7893 25.5304 29 25 29H7C6.46957 29 5.96086 28.7893 5.58579 28.4142C5.21071 28.0391 5 27.5304 5 27V6C5 5.46957 5.21071 4.96086 5.58579 4.58579C5.96086 4.21072 6.46957 4 7 4H11.5325C12.0944 3.37091 12.7828 2.86757 13.5527 2.52295C14.3225 2.17833 15.1565 2.00018 16 2.00018C16.8435 2.00018 17.6775 2.17833 18.4473 2.52295C19.2172 2.86757 19.9056 3.37091 20.4675 4H25C25.5304 4 26.0391 4.21072 26.4142 4.58579C26.7893 4.96086 27 5.46957 27 6ZM12 8H20C20 6.93914 19.5786 5.92172 18.8284 5.17157C18.0783 4.42143 17.0609 4 16 4C14.9391 4 13.9217 4.42143 13.1716 5.17157C12.4214 5.92172 12 6.93914 12 8ZM25 6H21.6562C21.8837 6.64227 22 7.31864 22 8V9C22 9.26522 21.8946 9.51957 21.7071 9.70711C21.5196 9.89464 21.2652 10 21 10H11C10.7348 10 10.4804 9.89464 10.2929 9.70711C10.1054 9.51957 10 9.26522 10 9V8C10 7.31864 10.1163 6.64227 10.3438 6H7V27H25V6Z"
                        fill="#343330" />
                </svg>
                <path d="M3 21h18M3 3h18l-3 18H6L3 3z"></path>
                </svg>
            </div>
        </div>

        <div class="flex items-center">
            <a href="/laporan" class="text-Genoa underline hover:text-green-900 text-sm ml-auto">
                Lihat Laporan
            </a>
        </div>
    </div>

    <!-- Card 2 -->
    <div class="w-full flex flex-col p-7 bg-white md:rounded-2xl shadow-md border border-gray-200">
        <h4 class="text-gray-500 text-sm xl:text-base mb-1">informasi Pengangkutan</h4>
        <div class="flex justify-between items-center gap-x-2 mb-2">
            <p data-hs-toggle-count='{
            "target": "#toggle-count",
            "min": 0,
            "max": 150
        }' class="text-gray-800 font-semibold text-3xl">
                {{ $totalInformasi }}
            </p>

            <div class="icon">
                <svg width="40" height="40" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path
                        d="M28 12.1V12C27.998 10.1441 27.2599 8.36477 25.9476 7.05245C24.6352 5.74012 22.8559 5.00199 21 5H20C19.4696 5 18.9609 5.21071 18.5858 5.58579C18.2107 5.96086 18 6.46957 18 7V22H16V9C16 8.73478 15.8946 8.48043 15.7071 8.29289C15.5196 8.10536 15.2652 8 15 8H2C1.46957 8 0.960859 8.21071 0.585786 8.58579C0.210714 8.96086 0 9.46957 0 10L0 23C0.000913299 23.8121 0.248994 24.6047 0.71126 25.2724C1.17353 25.9401 1.82808 26.4513 2.58789 26.738C3.3477 27.0246 4.17678 27.0733 4.9649 26.8774C5.75302 26.6815 6.46285 26.2503 7 25.6413C7.48014 26.1867 8.0998 26.591 8.79242 26.8109C9.48504 27.0307 10.2245 27.0577 10.9313 26.889C11.6381 26.7202 12.2856 26.3621 12.8042 25.8532C13.3228 25.3442 13.693 24.7035 13.875 24H24.125C24.3668 24.9445 24.9453 25.7681 25.7516 26.3162C26.558 26.8642 27.5367 27.0988 28.5039 26.976C29.4711 26.8532 30.3601 26.3814 31.0039 25.6492C31.6477 24.917 32.0019 23.9749 32 23V17C31.9986 15.8478 31.6 14.7313 30.8713 13.8387C30.1427 12.9461 29.1286 12.3321 28 12.1ZM20 7H21C22.3261 7 23.5979 7.52678 24.5355 8.46447C25.4732 9.40215 26 10.6739 26 12V13C26 13.2652 26.1054 13.5196 26.2929 13.7071C26.4804 13.8946 26.7348 14 27 14C27.7956 14 28.5587 14.3161 29.1213 14.8787C29.6839 15.4413 30 16.2044 30 17V19.5387C29.3929 19.1851 28.7026 18.9991 28 19C27.1132 19.0008 26.2517 19.2958 25.5505 19.8387C24.8493 20.3815 24.3479 21.1417 24.125 22H20V7ZM14 10V22H13.875C13.693 21.2965 13.3228 20.6558 12.8042 20.1468C12.2856 19.6379 11.6381 19.2798 10.9313 19.111C10.2245 18.9423 9.48504 18.9693 8.79242 19.1891C8.0998 19.409 7.48014 19.8133 7 20.3587C6.39074 19.6638 5.559 19.2021 4.64698 19.0525C3.73497 18.9029 2.79932 19.0748 2 19.5387V10H14ZM4 25C3.60444 25 3.21776 24.8827 2.88886 24.6629C2.55996 24.4432 2.30362 24.1308 2.15224 23.7654C2.00087 23.3999 1.96126 22.9978 2.03843 22.6098C2.1156 22.2219 2.30608 21.8655 2.58579 21.5858C2.86549 21.3061 3.22186 21.1156 3.60982 21.0384C3.99778 20.9613 4.39991 21.0009 4.76537 21.1522C5.13082 21.3036 5.44318 21.56 5.66294 21.8889C5.8827 22.2178 6 22.6044 6 23C6 23.5304 5.78929 24.0391 5.41421 24.4142C5.03914 24.7893 4.53043 25 4 25ZM10 25C9.60444 25 9.21776 24.8827 8.88886 24.6629C8.55996 24.4432 8.30362 24.1308 8.15224 23.7654C8.00087 23.3999 7.96126 22.9978 8.03843 22.6098C8.1156 22.2219 8.30608 21.8655 8.58579 21.5858C8.86549 21.3061 9.22186 21.1156 9.60982 21.0384C9.99778 20.9613 10.3999 21.0009 10.7654 21.1522C11.1308 21.3036 11.4432 21.56 11.6629 21.8889C11.8827 22.2178 12 22.6044 12 23C12 23.5304 11.7893 24.0391 11.4142 24.4142C11.0391 24.7893 10.5304 25 10 25ZM28 25C27.6044 25 27.2178 24.8827 26.8889 24.6629C26.56 24.4432 26.3036 24.1308 26.1522 23.7654C26.0009 23.3999 25.9613 22.9978 26.0384 22.6098C26.1156 22.2219 26.3061 21.8655 26.5858 21.5858C26.8655 21.3061 27.2219 21.1156 27.6098 21.0384C27.9978 20.9613 28.3999 21.0009 28.7654 21.1522C29.1308 21.3036 29.4432 21.56 29.6629 21.8889C29.8827 22.2178 30 22.6044 30 23C30 23.5304 29.7893 24.0391 29.4142 24.4142C29.0391 24.7893 28.5304 25 28 25Z"
                        fill="#343330" />
                </svg>
            </div>
        </div>

        <div class="flex items-center">
            <a href="/informasiPengangkutan" class="text-Genoa underline hover:text-green-900 text-sm ml-auto">
                Lihat Informasi
            </a>
        </div>
    </div>

    <!-- Card 3 -->
    <div class="w-full flex flex-col p-7 bg-white md:rounded-2xl shadow-md border border-gray-200">
        <h4 class="text-gray-500 text-sm xl:text-base mb-1">Lokasi TPS</h4>
        <div class="flex justify-between items-center gap-x-2 mb-2">
            <p data-hs-toggle-count='{
            "target": "#toggle-count",
            "min": 0,
            "max": 150
        }' class="text-gray-800 font-semibold text-3xl">
                {{ $totalTPS }}
            </p>

            <div class="icon">
                <svg width="40" height="40" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path
                        d="M14 10C14 9.60444 14.1173 9.21776 14.3371 8.88886C14.5568 8.55996 14.8692 8.30362 15.2346 8.15224C15.6001 8.00087 16.0022 7.96126 16.3902 8.03843C16.7781 8.1156 17.1345 8.30608 17.4142 8.58579C17.6939 8.86549 17.8844 9.22186 17.9616 9.60982C18.0387 9.99778 17.9991 10.3999 17.8478 10.7654C17.6964 11.1308 17.44 11.4432 17.1111 11.6629C16.7822 11.8827 16.3956 12 16 12C15.4696 12 14.9609 11.7893 14.5858 11.4142C14.2107 11.0391 14 10.5304 14 10ZM8 10C8 7.87827 8.84285 5.84344 10.3431 4.34315C11.8434 2.84285 13.8783 2 16 2C18.1217 2 20.1566 2.84285 21.6569 4.34315C23.1571 5.84344 24 7.87827 24 10C24 17.4937 16.8025 21.6925 16.5 21.8687C16.3489 21.9551 16.1778 22.0006 16.0037 22.0006C15.8297 22.0006 15.6586 21.9551 15.5075 21.8687C15.1975 21.6925 8 17.5 8 10ZM10 10C10 15.275 14.48 18.7763 16 19.8125C17.5188 18.7775 22 15.275 22 10C22 8.4087 21.3679 6.88258 20.2426 5.75736C19.1174 4.63214 17.5913 4 16 4C14.4087 4 12.8826 4.63214 11.7574 5.75736C10.6321 6.88258 10 8.4087 10 10ZM25.3463 18.4538C25.1001 18.3724 24.832 18.3899 24.5985 18.5024C24.365 18.6149 24.1843 18.8137 24.0945 19.0568C24.0047 19.3 24.0128 19.5685 24.1171 19.8058C24.2215 20.0431 24.4139 20.2306 24.6537 20.3288C26.7175 21.0925 28 22.115 28 23C28 24.67 23.435 27 16 27C8.565 27 4 24.67 4 23C4 22.115 5.2825 21.0925 7.34625 20.33C7.58614 20.2318 7.77853 20.0443 7.88286 19.807C7.98719 19.5697 7.99531 19.3012 7.90551 19.0581C7.8157 18.8149 7.63499 18.6161 7.40147 18.5036C7.16795 18.3911 6.89987 18.3737 6.65375 18.455C3.6525 19.5613 2 21.1763 2 23C2 26.8975 9.21375 29 16 29C22.7863 29 30 26.8975 30 23C30 21.1763 28.3475 19.5613 25.3463 18.4538Z"
                        fill="#343330" />
                </svg>
            </div>
        </div>

        <div class="flex items-center">
            <a href="/lokasiTPS" class="text-Genoa underline hover:text-green-900 text-sm ml-auto">
                Lihat Lokasi
            </a>
        </div>
    </div>

    <!-- Card 4 -->
    <div class="w-full flex flex-col p-7 bg-white md:rounded-2xl shadow-md border border-gray-200">
        <h4 class="text-gray-500 text-sm xl:text-base mb-1">Lokasi Bank Sampah
            <div class="flex justify-between items-center gap-x-2 mb-2">
                <p data-hs-toggle-count='{
            "target": "#toggle-count",
            "min": 0,
            "max": 150
        }' class="text-gray-800 font-semibold text-3xl">
                    22
                </p>

                <div class="icon">
                    <svg width="40" height="40" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M3 13H6V21H4C3.73478 21 3.48043 21.1053 3.29289 21.2929C3.10536 21.4804 3 21.7348 3 22C3 22.2652 3.10536 22.5196 3.29289 22.7071C3.48043 22.8946 3.73478 23 4 23H28C28.2652 23 28.5196 22.8946 28.7071 22.7071C28.8946 22.5196 29 22.2652 29 22C29 21.7348 28.8946 21.4804 28.7071 21.2929C28.5196 21.1053 28.2652 21 28 21H26V13H29C29.2176 12.9998 29.4292 12.9286 29.6026 12.7973C29.7761 12.6659 29.902 12.4816 29.9612 12.2722C30.0205 12.0629 30.0098 11.8399 29.9308 11.6371C29.8519 11.4344 29.709 11.2629 29.5238 11.1487L16.5238 3.14874C16.3662 3.05189 16.1849 3.00061 16 3.00061C15.8151 3.00061 15.6338 3.05189 15.4762 3.14874L2.47625 11.1487C2.29103 11.2629 2.14811 11.4344 2.06916 11.6371C1.99021 11.8399 1.97955 12.0629 2.03878 12.2722C2.09801 12.4816 2.22391 12.6659 2.39738 12.7973C2.57085 12.9286 2.78242 12.9998 3 13ZM8 13H12V21H8V13ZM18 13V21H14V13H18ZM24 21H20V13H24V21ZM16 5.17374L25.4675 11H6.5325L16 5.17374ZM31 26C31 26.2652 30.8946 26.5196 30.7071 26.7071C30.5196 26.8946 30.2652 27 30 27H2C1.73478 27 1.48043 26.8946 1.29289 26.7071C1.10536 26.5196 1 26.2652 1 26C1 25.7348 1.10536 25.4804 1.29289 25.2929C1.48043 25.1053 1.73478 25 2 25H30C30.2652 25 30.5196 25.1053 30.7071 25.2929C30.8946 25.4804 31 25.7348 31 26Z"
                            fill="#343330" />
                    </svg>
                </div>
            </div>

            <div class="flex items-center">
                <a href="/bankSampah" class="text-Genoa underline hover:text-green-900 text-sm ml-auto">
                    Lihat Lokasi
                </a>
            </div>
    </div>

    <!-- Card 5 -->
    <div class="w-full flex flex-col p-7 bg-white md:rounded-2xl shadow-md border justify-center border-gray-200">
        <h4 class="text-gray-500 text-sm xl:text-base mb-1">
            Admin
            <div class="flex justify-between items-center gap-x-2 mb-2">
                <p data-hs-toggle-count='{
            "target": "#toggle-count",
            "min": 0,
            "max": 150
        }' class="text-gray-800 font-semibold text-3xl">
                    {{ $totalAdmin }}
                </p>

                <div class="icon">
                    <svg width="40" height="40" viewBox="0 0 33 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M17.9999 19.7101C19.5675 18.7337 20.7745 17.2734 21.4382 15.55C22.1019 13.8265 22.1863 11.9338 21.6786 10.1582C21.1708 8.38254 20.0986 6.82057 18.624 5.70859C17.1495 4.59661 15.3529 3.99512 13.5061 3.99512C11.6593 3.99512 9.86274 4.59661 8.38822 5.70859C6.91369 6.82057 5.84144 8.38254 5.33369 10.1582C4.82594 11.9338 4.91031 13.8265 5.57405 15.55C6.23778 17.2734 7.44476 18.7337 9.01238 19.7101C6.43113 20.5551 4.10863 22.1339 2.24113 24.3564C2.15363 24.4564 2.08695 24.5729 2.045 24.6991C2.00305 24.8252 1.98667 24.9584 1.99681 25.0909C2.00695 25.2235 2.04341 25.3527 2.10406 25.4709C2.16471 25.5892 2.24833 25.6942 2.35003 25.7798C2.45173 25.8654 2.56948 25.9298 2.69638 25.9694C2.82328 26.0089 2.95679 26.0228 3.08911 26.0101C3.22143 25.9975 3.34989 25.9585 3.467 25.8957C3.5841 25.8328 3.68749 25.7472 3.77113 25.6439C6.28113 22.6489 9.73863 21.0001 13.4999 21.0001C17.2611 21.0001 20.7186 22.6489 23.2336 25.6439C23.4044 25.8471 23.6488 25.9742 23.9133 25.9971C24.1777 26.0201 24.4404 25.9371 24.6436 25.7664C24.8469 25.5956 24.9739 25.3512 24.9969 25.0867C25.0199 24.8223 24.9369 24.5596 24.7661 24.3564C22.8974 22.1339 20.5749 20.5551 17.9999 19.7101ZM6.99988 12.5001C6.99988 11.2145 7.3811 9.95783 8.09533 8.88891C8.80956 7.81999 9.82472 6.98687 11.0124 6.4949C12.2002 6.00293 13.5071 5.87421 14.768 6.12501C16.0288 6.37582 17.187 6.99488 18.0961 7.90392C19.0051 8.81296 19.6242 9.97115 19.875 11.232C20.1258 12.4929 19.9971 13.7998 19.5051 14.9876C19.0131 16.1753 18.18 17.1904 17.1111 17.9047C16.0422 18.6189 14.7855 19.0001 13.4999 19.0001C11.7766 18.9981 10.1244 18.3127 8.90588 17.0941C7.68732 15.8756 7.00186 14.2234 6.99988 12.5001ZM31.5311 17.8839L30.9486 17.5476C31.017 17.1858 31.017 16.8144 30.9486 16.4526L31.5311 16.1164C31.6449 16.0507 31.7446 15.9633 31.8246 15.8591C31.9045 15.7549 31.9632 15.636 31.9972 15.5091C32.0312 15.3822 32.0399 15.2499 32.0228 15.1197C32.0057 14.9895 31.963 14.8639 31.8974 14.7501C31.8317 14.6364 31.7443 14.5366 31.6401 14.4567C31.5359 14.3767 31.417 14.318 31.2901 14.284C31.1632 14.25 31.0309 14.2413 30.9007 14.2585C30.7705 14.2756 30.6449 14.3182 30.5311 14.3839L29.9474 14.7214C29.668 14.4817 29.3468 14.2957 28.9999 14.1726V13.5001C28.9999 13.2349 28.8945 12.9805 28.707 12.793C28.5195 12.6055 28.2651 12.5001 27.9999 12.5001C27.7347 12.5001 27.4803 12.6055 27.2928 12.793C27.1052 12.9805 26.9999 13.2349 26.9999 13.5001V14.1726C26.653 14.2957 26.3317 14.4817 26.0524 14.7214L25.4686 14.3839C25.3549 14.3182 25.2293 14.2756 25.0991 14.2585C24.9688 14.2413 24.8365 14.25 24.7097 14.284C24.5828 14.318 24.4639 14.3767 24.3597 14.4567C24.2555 14.5366 24.168 14.6364 24.1024 14.7501C24.0367 14.8639 23.9941 14.9895 23.977 15.1197C23.9598 15.2499 23.9685 15.3822 24.0025 15.5091C24.0366 15.636 24.0952 15.7549 24.1752 15.8591C24.2552 15.9633 24.3549 16.0507 24.4686 16.1164L25.0511 16.4526C24.9828 16.8144 24.9828 17.1858 25.0511 17.5476L24.4686 17.8839C24.3549 17.9495 24.2552 18.037 24.1752 18.1411C24.0952 18.2453 24.0366 18.3643 24.0025 18.4911C23.9685 18.618 23.9598 18.7503 23.977 18.8806C23.9941 19.0108 24.0367 19.1364 24.1024 19.2501C24.168 19.3639 24.2555 19.4636 24.3597 19.5436C24.4639 19.6235 24.5828 19.6822 24.7097 19.7162C24.8365 19.7502 24.9688 19.7589 25.0991 19.7418C25.2293 19.7246 25.3549 19.682 25.4686 19.6164L26.0524 19.2789C26.3317 19.5185 26.653 19.7046 26.9999 19.8276V20.5001C26.9999 20.7653 27.1052 21.0197 27.2928 21.2072C27.4803 21.3948 27.7347 21.5001 27.9999 21.5001C28.2651 21.5001 28.5195 21.3948 28.707 21.2072C28.8945 21.0197 28.9999 20.7653 28.9999 20.5001V19.8276C29.3468 19.7046 29.668 19.5185 29.9474 19.2789L30.5311 19.6164C30.683 19.7045 30.8556 19.7507 31.0311 19.7501C31.2513 19.7502 31.4654 19.6776 31.6401 19.5436C31.8149 19.4096 31.9405 19.2216 31.9975 19.0089C32.0544 18.7962 32.0396 18.5706 31.9553 18.3672C31.871 18.1638 31.7219 17.9939 31.5311 17.8839ZM26.9999 17.0001C26.9999 16.8023 27.0585 16.609 27.1684 16.4445C27.2783 16.2801 27.4345 16.1519 27.6172 16.0762C27.7999 16.0005 28.001 15.9807 28.195 16.0193C28.389 16.0579 28.5671 16.1532 28.707 16.293C28.8468 16.4329 28.9421 16.611 28.9807 16.805C29.0193 16.999 28.9994 17.2001 28.9238 17.3828C28.8481 17.5655 28.7199 17.7217 28.5555 17.8316C28.391 17.9415 28.1977 18.0001 27.9999 18.0001C27.7347 18.0001 27.4803 17.8948 27.2928 17.7072C27.1052 17.5197 26.9999 17.2653 26.9999 17.0001Z"
                            fill="#343330" />
                    </svg>
                </div>
            </div>

            <div class="flex items-center">
                <a href="/admin"
                    class="text-Genoa underline hover:text-green-900 text-sm ml-auto  {{ auth()->check() && optional(auth()->user()->AdminTable)->Role_Admin !== 'Master' ? 'opacity-50 pointer-events-none' : 'opacity-100 pointer-events-auto' }} ">
                    Lihat Akun
                </a>
            </div>
    </div>

    <!-- Card 6 -->
    <div class="w-full flex flex-col p-7 bg-white md:rounded-2xl shadow-md border border-gray-200">
        <h4 class="text-gray-500 text-sm xl:text-base mb-1">Petugas Kebersihan
            <div class="flex justify-between items-center gap-x-2 mb-2">
                <p data-hs-toggle-count='{
            "target": "#toggle-count",
            "min": 0,
            "max": 150
        }' class="text-gray-800 font-semibold text-3xl">
                    {{ $totalPetugas }}
                </p>

                <div class="icon">
                    <svg width="40" height="40" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M14.6563 19.7401C15.9966 18.8479 17.0141 17.548 17.5584 16.0327C18.1028 14.5174 18.145 12.8671 17.6789 11.326C17.2129 9.78483 16.2632 8.43458 14.9703 7.4749C13.6775 6.51522 12.1102 5.99707 10.5001 5.99707C8.88997 5.99707 7.32261 6.51522 6.02978 7.4749C4.73694 8.43458 3.78726 9.78483 3.32118 11.326C2.85509 12.8671 2.89734 14.5174 3.44168 16.0327C3.98603 17.548 5.00356 18.8479 6.34381 19.7401C3.91943 20.6337 1.84894 22.2872 0.441312 24.4539C0.367332 24.5638 0.315945 24.6874 0.290139 24.8174C0.264332 24.9474 0.264621 25.0812 0.290989 25.2111C0.317356 25.3409 0.369276 25.4643 0.44373 25.5739C0.518185 25.6835 0.613688 25.7773 0.72469 25.8497C0.835692 25.9221 0.959977 25.9717 1.09032 25.9956C1.22067 26.0196 1.35447 26.0174 1.48396 25.9892C1.61344 25.9609 1.73603 25.9073 1.84458 25.8312C1.95314 25.7552 2.04551 25.6584 2.11631 25.5464C3.0243 24.1498 4.26676 23.0023 5.73086 22.2078C7.19496 21.4134 8.83432 20.9973 10.5001 20.9973C12.1658 20.9973 13.8052 21.4134 15.2693 22.2078C16.7334 23.0023 17.9758 24.1498 18.8838 25.5464C19.0305 25.7644 19.257 25.9159 19.5145 25.9681C19.772 26.0204 20.0397 25.9692 20.2598 25.8257C20.4799 25.6822 20.6346 25.4578 20.6906 25.2011C20.7465 24.9444 20.6992 24.676 20.5588 24.4539C19.1512 22.2872 17.0807 20.6337 14.6563 19.7401ZM5.00006 13.5001C5.00006 12.4123 5.32263 11.3489 5.92698 10.4445C6.53133 9.54001 7.39031 8.83506 8.3953 8.41878C9.4003 8.00249 10.5062 7.89358 11.5731 8.10579C12.64 8.31801 13.62 8.84184 14.3891 9.61103C15.1583 10.3802 15.6822 11.3602 15.8944 12.4271C16.1066 13.494 15.9977 14.5999 15.5814 15.6049C15.1651 16.6099 14.4602 17.4688 13.5557 18.0732C12.6512 18.6775 11.5879 19.0001 10.5001 19.0001C9.04188 18.9985 7.64389 18.4185 6.6128 17.3874C5.58171 16.3563 5.00172 14.9583 5.00006 13.5001ZM31.2676 25.8376C31.0454 25.9825 30.7749 26.0331 30.5154 25.9785C30.2559 25.9239 30.0287 25.7685 29.8838 25.5464C28.9769 24.149 27.7346 23.0009 26.2702 22.2068C24.8058 21.4127 23.1659 20.9979 21.5001 21.0001C21.2348 21.0001 20.9805 20.8948 20.793 20.7072C20.6054 20.5197 20.5001 20.2653 20.5001 20.0001C20.5001 19.7349 20.6054 19.4805 20.793 19.293C20.9805 19.1055 21.2348 19.0001 21.5001 19.0001C22.31 18.9993 23.1098 18.8197 23.8423 18.474C24.5748 18.1283 25.2219 17.6251 25.7373 17.0003C26.2528 16.3756 26.6239 15.6447 26.8242 14.8598C27.0244 14.075 27.0488 13.2557 26.8957 12.4603C26.7426 11.6649 26.4157 10.9132 25.9383 10.2589C25.461 9.60449 24.845 9.06362 24.1344 8.6749C23.4239 8.28619 22.6362 8.05921 21.8277 8.0102C21.0192 7.96118 20.2099 8.09134 19.4576 8.39136C19.3349 8.44439 19.2028 8.47229 19.0692 8.47342C18.9356 8.47455 18.8031 8.44889 18.6795 8.39794C18.556 8.34699 18.4439 8.2718 18.3499 8.1768C18.2559 8.0818 18.1819 7.96893 18.1323 7.84485C18.0827 7.72077 18.0584 7.588 18.0609 7.45439C18.0635 7.32077 18.0928 7.18903 18.1471 7.06693C18.2015 6.94483 18.2797 6.83486 18.3772 6.74352C18.4748 6.65218 18.5897 6.58131 18.7151 6.53511C20.4369 5.84843 22.352 5.82372 24.091 6.46575C25.83 7.10778 27.2696 8.37106 28.1321 10.0119C28.9946 11.6527 29.2189 13.5548 28.7617 15.3513C28.3045 17.1477 27.1982 18.7112 25.6563 19.7401C28.0807 20.6337 30.1512 22.2872 31.5588 24.4539C31.7037 24.676 31.7543 24.9466 31.6997 25.2061C31.6451 25.4655 31.4897 25.6927 31.2676 25.8376Z"
                            fill="#343330" />
                    </svg>
                </div>
            </div>

            <div class="flex items-center">
                <a href="/petugasKebersihan" class="text-Genoa underline hover:text-green-900 text-sm ml-auto">
                    Lihat Akun
                </a>
            </div>
    </div>
</div>

<div
    class="mt-12 py-3 flex items-center text-lg font-bold text-gray-800 before:flex-1 before:border-t before:border-gray-200 before:me-6 after:flex-1 after:border-t after:border-gray-200 after:ms-6">
    Data Pengangkutan Sampah
</div>

<div class="grid grid-cols-2 p-10">
    <div class="col-span-2 flex gap-4">
        <!-- Select Wilayah -->
        <div class="w-80">
            <select data-hs-select='{
            "placeholder": "<span class=\"inline-flex items-center\"><svg class=\"shrink-0 size-3.5 me-2\" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polygon points=\"22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3\"/></svg> Wilayah Pengangkutan</span>",
            "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
            "toggleClasses": "hs-select-disabled:pointer-events-none hs-select-disabled:opacity-50 relative py-3 ps-4 pe-9 flex gap-x-2 text-nowrap w-full cursor-pointer bg-white border border-gray-200 rounded-lg text-start text-sm focus:outline-none focus:ring-2 focus:ring-blue-500",
            "dropdownClasses": "mt-2 z-50 w-full max-h-72 p-1 space-y-0.5 bg-white border border-gray-200 rounded-lg overflow-hidden overflow-y-auto [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300",
            "optionClasses": "py-2 px-4 w-full text-sm text-gray-800 cursor-pointer hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100",
            "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"hidden hs-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 dark:text-blue-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"/></svg></span></div>",
            "extraMarkup": "<div class=\"absolute top-1/2 end-3 -translate-y-1/2\"><svg class=\"shrink-0 size-3.5 text-gray-500 dark:text-neutral-500 \" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"m7 15 5 5 5-5\"/><path d=\"m7 9 5-5 5 5\"/></svg></div>"
            }' class="hidden" name="wilayah" id="wilayahFilter">
                <option value="">Choose</option>
                @foreach ($wilayahOptions as $wilayah)
                <option value="{{ $wilayah }}" {{ old('wilayah') == $wilayah ? 'selected' : '' }}>
                    {{ $wilayah }}
                </option>
                @endforeach
            </select>
        </div>
        <!-- Select Tahun -->
        <div class="w-80">
            <select id="tahunFilter"
                class="py-3 px-4 pe-9 block w-full border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none">
            </select>
        </div>
    </div>

    <!-- Chart -->
    <div class="col-span-2">
        <canvas id="chart"></canvas>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.7/dist/chart.umd.min.js"></script>
    <script>
        function fetchDataWithAJAX() {
            const wilayahFilter = document.querySelector('#wilayahFilter').value;
            const tahunFilter = document.querySelector('#tahunFilter').value || new Date().getFullYear();

            let url = 'http://127.0.0.1:8000/api/informasiPengangkutan';
            const params = new URLSearchParams();
            if (wilayahFilter) {
                params.append('wilayah', wilayahFilter);
            }
            if (tahunFilter) {
                params.append('tahun', tahunFilter);
            }
            if (params.toString()) {
                url += `?${params.toString()}`;
            }

            const xhr = new XMLHttpRequest();
            xhr.open('GET', url, true);

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    const data = JSON.parse(xhr.responseText);
                    updateTahunFilter(data.data);
                    processData(data.data, tahunFilter);
                }
            };

            xhr.send();
        }

        function updateTahunFilter(rawData) {
            const tahunSet = new Set();
            rawData.forEach(item => {
                const year = new Date(item.Tanggal_Pengangkutan).getFullYear();
                tahunSet.add(year);
            });

            const tahunArray = Array.from(tahunSet).sort();
            const tahunFilterElement = document.querySelector('#tahunFilter');
            tahunFilterElement.innerHTML = '<option selected disabled>Pilih Tahun</option>';

            tahunArray.forEach(year => {
                const option = document.createElement('option');
                option.value = year;
                option.textContent = year;
                tahunFilterElement.appendChild(option);
            });

            const tahunFilter = document.querySelector('#tahunFilter').value;
            const currentYear = new Date().getFullYear();

            tahunFilterElement.value = tahunFilter || currentYear;
        }

        function processData(rawData, tahunFilter) {
            const terangkutData = [];
            const tidakTerangkutData = [];
            const tertundaData = [];
            const months = [];

            const monthMap = {
                'Jan': 0,
                'Feb': 1,
                'Mar': 2,
                'Apr': 3,
                'May': 4,
                'Jun': 5,
                'Jul': 6,
                'Aug': 7,
                'Sep': 8,
                'Oct': 9,
                'Nov': 10,
                'Dec': 11
            };

            const currentYear = new Date().getFullYear();
            const filteredData = rawData.filter(item => {
                const date = new Date(item.Tanggal_Pengangkutan);
                const year = date.getFullYear();
                const matchesWilayah = document.querySelector('#wilayahFilter').value ? item
                    .Wilayah_Pengangkutan === document.querySelector('#wilayahFilter').value : true;
                const matchesTahun = tahunFilter ? year === parseInt(tahunFilter) : year === currentYear;

                return matchesWilayah && matchesTahun;
            });

            filteredData.forEach(item => {
                const date = new Date(item.Tanggal_Pengangkutan);
                const month = date.toLocaleString('default', {
                    month: 'short'
                });
                const year = date.getFullYear();
                const monthYear = `${month} ${year}`;

                const index = months.indexOf(monthYear);
                if (index === -1) {
                    months.push(monthYear);
                    terangkutData.push(item.Status_Pengangkutan === 'Selesai' ? 1 : 0);
                    tidakTerangkutData.push(item.Status_Pengangkutan === 'Belum Selesai' ? 1 : 0);
                    tertundaData.push(item.Status_Pengangkutan === 'Tertunda' ? 1 : 0);
                } else {
                    if (item.Status_Pengangkutan === 'Selesai') {
                        terangkutData[index]++;
                    } else if (item.Status_Pengangkutan === 'Belum Selesai') {
                        tidakTerangkutData[index]++;
                    } else if (item.Status_Pengangkutan === 'Tertunda') {
                        tertundaData[index]++;
                    }
                }
            });

            months.sort((a, b) => {
                const [monthA, yearA] = a.split(' ');
                const [monthB, yearB] = b.split(' ');
                return yearA - yearB || monthMap[monthA] - monthMap[monthB];
            });

            displayChart(terangkutData, tidakTerangkutData, tertundaData, months);
        }

        function displayChart(terangkutData, tidakTerangkutData, tertundaData, months) {
            const chartElement = document.querySelector('#chart');
            if (!chartElement) {
                console.error("Element chart not found!");
                return;
            }

            if (chartElement.chartInstance) {
                chartElement.chartInstance.destroy();
            }

            const ctx = chartElement.getContext('2d');
            chartElement.chartInstance = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: months,
                    datasets: [{
                            label: 'Terangkut',
                            data: terangkutData,
                            borderColor: '#368666',
                            backgroundColor: 'rgba(54, 134, 102, 0.5)',
                            fill: true,
                            tension: 0.4,
                        },
                        {
                            label: 'Tidak Terangkut',
                            data: tidakTerangkutData,
                            borderColor: '#B5333D',
                            backgroundColor: 'rgba(181, 51, 61, 0.5)',
                            fill: true,
                            tension: 0.4,
                        },
                        {
                            label: 'Tertunda',
                            data: tertundaData,
                            borderColor: '#F6A800',
                            backgroundColor: 'rgba(246, 168, 0, 0.5)',
                            fill: true,
                            tension: 0.4,
                        },
                    ],
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        tooltip: {
                            mode: 'index',
                            intersect: false,
                        },
                    },
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Bulan',
                            },
                        },
                        y: {
                            title: {
                                display: true,
                                text: 'Jumlah Pengangkutan',
                            },
                            beginAtZero: true,
                        },
                    },
                },
            });
        }

        document.querySelector('#wilayahFilter').addEventListener('change', fetchDataWithAJAX);
        document.querySelector('#tahunFilter').addEventListener('change', fetchDataWithAJAX);

        window.onload = function() {
            fetchDataWithAJAX();
        };
    </script>
</div>


@endsection