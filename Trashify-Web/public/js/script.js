
document.querySelectorAll('[data-hs-combo-box-output-item]').forEach(item => {
    item.addEventListener('click', function() {

        const selectedText = this.querySelector(
            '[data-hs-combo-box-search-text]').getAttribute(
            'data-hs-combo-box-search-text');

        const kodeInput = document.getElementById('kode_laporan_input');
        kodeInput.value = selectedText;

        fetch(`/laporan/get-kategori/${selectedText}`)
    .then(response => {
        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
        return response.json();
    })
    .then(data => {
        console.log('Response Data:', data);

        const kategoriInput = document.getElementById('kategori_laporan_input');
        const statusInput = document.getElementById('status_laporan_input');

        if (data.Kategori_Pengaduan) {
            kategoriInput.value = data.Kategori_Pengaduan;
            kategoriInput.disabled = false;
        } else {
            kategoriInput.value = 'Tidak Ada Kategori';
            kategoriInput.disabled = true;
        }

        if (data.Status_Pengaduan) {
            statusInput.value = data.Status_Pengaduan;
            statusInput.disabled = false;
        } else {
            statusInput.value = 'Tidak Ada Status';
            statusInput.disabled = true;
        }
    })
    .catch(error => console.error('Error:', error));

    });
});

// Strong Password
const validatePassword = () => {
const newPassword = document.getElementById('new-pass').value;
const confirmPassword = document.getElementById('confirmPass').value;
const submitPass = document.getElementById('submit-pass');
const errorMessage = document.getElementById('error-message');

    if (newPassword !== confirmPassword) {
        errorMessage.classList.remove('hidden');
        submitPass.setAttribute('disabled', ''); 
    } else {
        errorMessage.classList.add('hidden');
        submitPass.removeAttribute('disabled');
    }
};

document.getElementById('confirmPass').addEventListener('input', validatePassword);
document.getElementById('new-pass').addEventListener('input', validatePassword);

// Filter Data
function submitForm() {
    document.getElementById('filterForm').submit();
}

