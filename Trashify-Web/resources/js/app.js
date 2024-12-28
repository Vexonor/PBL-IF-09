import './bootstrap';
import 'preline';
import ApexCharts from 'apexcharts';

// Grafik Informasi Pengangkutan
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
    'Jan': 0, 'Feb': 1, 'Mar': 2, 'Apr': 3, 'May': 4,
    'Jun': 5, 'Jul': 6, 'Aug': 7, 'Sep': 8, 'Oct': 9,
    'Nov': 10, 'Dec': 11,
  };

  const currentYear = new Date().getFullYear();
  const filteredData = rawData.filter(item => {
    const date = new Date(item.Tanggal_Pengangkutan);
    const year = date.getFullYear();
    const matchesWilayah = document.querySelector('#wilayahFilter').value ? item.Wilayah_Pengangkutan === document.querySelector('#wilayahFilter').value : true;
    const matchesTahun = tahunFilter ? year === parseInt(tahunFilter) : year === currentYear;

    return matchesWilayah && matchesTahun;
  });

  filteredData.forEach(item => {
    const date = new Date(item.Tanggal_Pengangkutan);
    const month = date.toLocaleString('default', { month: 'short' });
    const year = date.getFullYear();
    const monthYear = `${month} ${year}`;

    if (tahunFilter ? year === parseInt(tahunFilter) : year === currentYear) {
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
  const options = {
    chart: {
      type: 'area',
      height: 350,
      fontFamily: 'Poppins',
    },
    series: [
      {
        name: 'Terangkut',
        data: terangkutData,
        color: '#368666',
      },
      {
        name: 'Tidak Terangkut',
        data: tidakTerangkutData,
        color: '#B5333D',
      },
      {
        name: 'Tertunda',
        data: tertundaData,
        color: '#F6A800',
      },
    ],
    xaxis: {
      categories: months,
    },
    stroke: {
      curve: 'smooth',
    },
  };

  const chartElement = document.querySelector('#chart');
  if (chartElement) {
    const chart = new ApexCharts(chartElement, options);
    chart.render();
  } else {
    console.error("Element chart not found!");
  }
}

document.querySelector('#wilayahFilter').addEventListener('change', fetchDataWithAJAX);
document.querySelector('#tahunFilter').addEventListener('change', fetchDataWithAJAX);

window.onload = function() {
  fetchDataWithAJAX();
};


// Filter
window.addEventListener('load', () => {
  (function() {
    const clearBtn = document.querySelector('#multiple-with-conditional-counter-trigger-clear');

    clearBtn.addEventListener('click', () => {
      const selectInstances = [
        HSSelect.getInstance('#kategoriFilter'),
        HSSelect.getInstance('#statusFilter')
      ];

      selectInstances.forEach(select => {
        if (select) {
          select.setValue([]);
        }
      });
    });
  })();
});



