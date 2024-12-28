    document.addEventListener('DOMContentLoaded', () => {
        const menuToggle = document.querySelector('.menuToggle');
        const sidebar = document.querySelector('.sidebar');
        const menuItems = document.querySelectorAll('.sidebar ul li');

        menuToggle.addEventListener('click', () => {
            sidebar.classList.toggle('active');
            menuToggle.classList.toggle('active');
        });

        menuItems.forEach(item => {
            item.addEventListener('click', () => {
                menuItems.forEach(i => i.classList.remove('active'));
                item.classList.add('active');
            });
        });
    });