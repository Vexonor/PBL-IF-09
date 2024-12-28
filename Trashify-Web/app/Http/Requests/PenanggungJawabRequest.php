<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PenanggungJawabRequest extends FormRequest
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
            'Kode_Pengaduan' => 'required|exists:Pengaduan,Kode_Pengaduan',
            'ID_Petugas' => 'required|exists:Petugas_Kebersihan,ID_Petugas',
            'Kategori_Pengaduan' => 'required|in:Pengumpulan Sampah,Tempat Sampah Liar,Kondisi TPS,Lainnya',
            'Status_Pengaduan' => 'required|in:Selesai,Sedang Diproses,Belum Selesai',
        ];
    }

    public function messages()
    {
        return [
            'Kode_Pengaduan.required' => 'Kode Laporan wajib diisi.',
            'Kode_Pengaduan.exists' => 'Kode Laporan tidak valid atau tidak ditemukan.',
            'ID_Petugas.required' => 'ID Petugas wajib diisi.',
            'ID_Petugas.exists' => 'ID Petugas tidak valid atau tidak ditemukan.',
            'Kategori_Pengaduan.required' => 'Kategori Laporan wajib diisi.',
            'Kategori_Pengaduan.in' => 'Kategori Laporan harus salah satu dari: Pengumpulan Sampah, Tempat Sampah Liar, Kondisi TPS, atau Lainnya.',
            'Status_Pengaduan.required' => 'Status Laporan wajib diisi.',
            'Status_Pengaduan.in' => 'Status Laporan harus salah satu dari: Selesai, Sedang Diproses, atau Belum Selesai.',
        ];
    }
}
