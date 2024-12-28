/** @type {import('tailwindcss').Config} */
import preline from 'preline/plugin';
import forms from '@tailwindcss/forms';

export default {
    content: [
    "./resources/**/*.blade.php",
    "./resources/**/*.js",
    "./resources/**/*.vue",
    'node_modules/preline/dist/*.js',
    './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
  ],
  theme: {
    extend: {
      colors: {
        "Genoa" : "#368666",
        "Aquamarine" : "#B5FFCE",
        "Orange-Peel" : "#FF9900",
        "Shalimar" : "FFF3AE",
        "Flamingo" : "F15950",
        "Beauty-Bush" : "EEB3B0",
        "Brick-Red" : "#B5333D",
        "Medium-Carmine" : "#B6333C",
        "Charcoal" : "#323232"
        },
        fontFamily: {
          poppins: ["Poppins", "mono"],
        },
    },
  },
  plugins: [
    preline,
    forms,
  ],
}