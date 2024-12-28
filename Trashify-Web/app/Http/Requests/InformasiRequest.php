<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class InformasiRequest extends FormRequest
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
            'ID_Petugas' => 'required|exists:Petugas_Kebersihan,ID_Petugas',
            'Wilayah_Pengangkutan' => 'required|in:Batu Ampar,Bengkong,Bulang,Galang,Lubuk Baja,Nongsa,Sagulung,Sei Beduk,Sekupang,Batam Kota,Belakang Padang,Batu Aji',
            'Titik_Koordinat' => 'required|string|max:255',
            'Tanggal_Pengangkutan' => 'required|date|before_or_equal:today',
            'Jam_Pengangkutan' => 'required',
            'Status_Pengangkutan' => 'required|in:Selesai,Belum Selesai,Tertunda',
        ];
    }

    public function messages()
    {
        return [
            'ID_Petugas.required' => 'ID Petugas wajib diisi.',
            'ID_Petugas.exists' => 'ID Petugas tidak valid.',
            'Wilayah_Pengangkutan.required' => 'Wilayah pengangkutan wajib diisi.',
            'Wilayah_Pengangkutan.in' => 'Wilayah pengangkutan harus salah satu dari daftar wilayah yang valid.',
            'Titik_Koordinat.required' => 'Titik koordinat wajib diisi.',
            'Tanggal_Pengangkutan.required' => 'Tanggal pengangkutan wajib diisi.',
            'Tanggal_Pengangkutan.date' => 'Tanggal pengangkutan harus berupa format tanggal yang valid.',
            'Tanggal_Pengangkutan.before_or_equal' => 'Tanggal pengangkutan tidak boleh melebihi hari ini.',
            'Jam_Pengangkutan.required' => 'Jam pengangkutan wajib diisi.',
            'Jam_Pengangkutan.date_format' => 'Jam pengangkutan harus dalam format jam:menit (24 jam).',
            'Status_Pengangkutan.required' => 'Status pengangkutan wajib diisi.',
            'Status_Pengangkutan.in' => 'Status pengangkutan harus Selesai, Belum Selesai, atau Tertunda.',
        ];
    }
}
