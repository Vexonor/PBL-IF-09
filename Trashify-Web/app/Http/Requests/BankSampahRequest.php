<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class BankSampahRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'Nama_Bank_Sampah' => 'required|string|max:255',
            'Jenis_Sampah' => 'required|in:Plastik,Kaca,Kertas,Logam,Organik,Elektronik',
            'Harga_Sampah' => 'required|min:0',
            'Nama_Pemilik' => 'required|string|max:255',
            'No_Telp' => 'required|string|max:15|regex:/^\+?[0-9]*$/',
            'Wilayah_BankSampah' => 'required|in:Batu Ampar,Bengkong,Bulang,Galang,Lubuk Baja,Nongsa,Sagulung,Sei Beduk,Sekupang,Batam Kota,Belakang Padang,Batu Aji',
            'Titik_Koordinat' => 'required|string|max:255',
            'Jam_Buka' => 'required',
            'Jam_Tutup' => 'required|after:Jam_Buka',
            'Status_Operasional' => 'required|in:Buka,Tutup',
        ];
    }

    public function messages()
    {
        return [
            'Nama_Bank_Sampah.required' => 'Nama Bank Sampah wajib diisi.',
            'Jenis_Sampah.required' => 'Jenis sampah wajib dipilih.',
            'Harga_Sampah.required' => 'Harga sampah wajib diisi.',
            'Harga_Sampah.numeric' => 'Harga sampah harus berupa angka.',
            'Nama_Pemilik.required' => 'Nama pemilik wajib diisi.',
            'No_Telp.required' => 'Nomor telepon wajib diisi.',
            'No_Telp.regex' => 'Format nomor telepon tidak valid.',
            'Wilayah_BankSampah.required' => 'Wilayah Bank Sampah wajib dipilih.',
            'Titik_Koordinat.required' => 'Titik koordinat wajib diisi.',
            'Jam_Buka.required' => 'Jam buka wajib diisi.',
            'Jam_Buka.date_format' => 'Jam buka harus menggunakan format HH:MM.',
            'Jam_Tutup.required' => 'Jam tutup wajib diisi.',
            'Jam_Tutup.date_format' => 'Jam tutup harus menggunakan format HH:MM.',
            'Jam_Tutup.after' => 'Jam tutup harus lebih besar dari jam buka.',
            'Status_Operasional.required' => 'Status operasional wajib dipilih.',
        ];
    }
}
