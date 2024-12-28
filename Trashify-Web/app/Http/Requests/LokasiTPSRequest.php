<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class LokasiTPSRequest extends FormRequest
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
            'Wilayah_TPS' => 'required|in:Batu Ampar,Bengkong,Bulang,Galang,Lubuk Baja,Nongsa,Sagulung,Sei Beduk,Sekupang,Batam Kota,Belakang Padang,Batu Aji',
            'Titik_Koordinat' => 'required|string|max:255',
            'Status_TPS' => 'required|in:Kosong,Penuh',
        ];
    }

    public function messages()
    {
        return [
            'Kode_TPS.required' => 'Kode TPS wajib diisi.',
            'Kode_TPS.unique' => 'Kode TPS sudah ada, gunakan kode lain.',
            'Wilayah_TPS.required' => 'Wilayah TPS wajib dipilih.',
            'Wilayah_TPS.in' => 'Wilayah TPS tidak valid.',
            'Titik_Koordinat.required' => 'Titik koordinat wajib diisi.',
            'Status_TPS.required' => 'Status TPS wajib dipilih.',
            'Status_TPS.in' => 'Status TPS hanya boleh Kosong atau Penuh.',
        ];
    }
}
