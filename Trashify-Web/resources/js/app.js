import './bootstrap';
import 'preline';

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



