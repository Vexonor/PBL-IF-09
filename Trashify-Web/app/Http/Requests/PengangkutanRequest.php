<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PengangkutanRequest extends FormRequest
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
            'Kode_TPS' => 'required|exists:Lokasi_TPS,Kode_TPS',
            'ID_Petugas' => 'required|exists:Petugas_Kebersihan,ID_Petugas',
            'Tanggal_Pengangkutan' => 'required|date|before_or_equal:today',
            'Jam_Pengangkutan' => 'required',
            'Status_Pengangkutan' => 'required|in:Selesai,Belum Selesai,Tertunda',
        ];
    }

    public function messages()
    {
        return [
            'Kode_TPS.required' => 'Kode TPS wajib diisi.',
            'Kode_TPS.exists' => 'Kode TPS tidak valid.',
            'ID_Petugas.required' => 'ID Petugas wajib diisi.',
            'ID_Petugas.exists' => 'ID Petugas tidak valid.',
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
