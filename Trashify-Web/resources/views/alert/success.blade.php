@if (session()->has('success'))
<div id="toast"
    class="z-[100] fixed top-10 w-7/12 bg-green-50 border-s-4 border-green-500 p-4 transition-all duration-500 rounded-md"
    role="alert" tabindex="-1" aria-labelledby="hs-bordered-red-style-label">
    <div class="flex">
        <div class="shrink-0">
            <!-- Icon -->
            <span
                class="inline-flex justify-center items-center size-8 rounded-full border-4 border-green-100 bg-green-200 text-green-800">
                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                    viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                    stroke-linejoin="round">
                    <path d="M12 22c5.523 0 10-4.477 10-10S17.523 2 12 2 2 6.477 2 12s4.477 10 10 10z"></path>
                    <path d="m9 12 2 2 4-4"></path>
                </svg>
            </span>
            <!-- End Icon -->
        </div>
        <div class="ms-3">
            <h3 id="hs-bordered-green-style-label" class="text-gray-800 font-semibold">
                Berhasil!
            </h3>
            <p class="text-sm text-gray-700">
                {{ session('success')}}
            </p>
        </div>
    </div>
</div>


<script>
    document.addEventListener('DOMContentLoaded', function() {
        var toastElement = document.getElementById('toast');

        if (toastElement) {
            toastElement.classList.remove('opacity-0', 'translate-y-0');
            toastElement.classList.add('opacity-100', 'translate-y-10');

            setTimeout(function() {
                toastElement.classList.remove('opacity-100', 'translate-y-10');
                toastElement.classList.add('opacity-0', 'translate-y-0');

                setTimeout(function() {
                    toastElement.remove();
                }, 5000);
            }, 5000);
        }
    });
</script>

@endif