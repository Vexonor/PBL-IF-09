@if (session()->has('unmatch'))
<div id="toast"
    class="fixed top-10 w-7/12 bg-red-50 border-s-4 border-red-500 p-4 transition-all duration-500 rounded-md"
    role="alert" tabindex="-1" aria-labelledby="hs-bordered-red-style-label">
    <div class="flex">
        <div class="shrink-0">
            <!-- Icon -->
            <span
                class="inline-flex justify-center items-center size-8 rounded-full border-4 border-red-100 bg-red-200 text-red-800 dark:border-red-900 dark:bg-red-800 dark:text-red-400">
                <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                    viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                    stroke-linejoin="round">
                    <path d="M18 6 6 18"></path>
                    <path d="m6 6 12 12"></path>
                </svg>
            </span>
            <!-- End Icon -->
        </div>
        <div class="ms-3">
            <h3 id="hs-bordered-red-style-label" class="text-gray-800 font-semibold dark:text-white">
                Gagal!
            </h3>
            <p class="text-sm text-gray-700 dark:text-neutral-400">
                {{ session('unmatch')}}
            </p>
        </div>
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
            }, 10000);
        }
    });
</script>
@endif