<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PetugasRequest extends FormRequest
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
            // Validation User
            'Nama' => 'required|string|max:255',
            'Tanggal_Lahir' => 'required|date|before_or_equal:today',
            'Jenis_Kelamin' => 'required|in:Laki-laki,Perempuan',
            'Alamat' => 'required|string|max:500',
            'No_Telp' => 'required|string|max:15|regex:/^\+?[0-9]*$/',
            'email' => 'required|email',
            'password' => 'nullable|string|min:6',

            // Validation Petugas
            'Wilayah_Bertugas' => 'required|in:Batu Ampar,Bengkong,Bulang,Galang,Lubuk Baja,Nongsa,Sagulung,Sei Beduk,Sekupang,Batam Kota,Belakang Padang,Batu Aji',
            'Tanggal_Bergabung' => 'required|date|before_or_equal:today',
            'Status_Keaktifan' => 'required|in:Aktif,Izin,Cuti',
        ];
    }

    public function messages()
    {
        return [
            // Message Error for User
            'Nama.required' => 'Nama wajib diisi.',
            'Tanggal_Lahir.required' => 'Tanggal lahir wajib diisi.',
            'Tanggal_Lahir.before' => 'Tanggal lahir harus sebelum hari ini.',
            'Jenis_Kelamin.required' => 'Jenis kelamin wajib diisi.',
            'Jenis_Kelamin.in' => 'Jenis kelamin hanya boleh Laki-laki atau Perempuan.',
            'Alamat.required' => 'Alamat wajib diisi.',
            'No_Telp.required' => 'Nomor telepon wajib diisi.',
            'No_Telp.regex' => 'Format nomor telepon tidak valid.',
            'email.required' => 'Email wajib diisi.',
            'email.email' => 'Format email tidak valid.',
            'email.unique' => 'Email sudah digunakan.',
            'password.min' => 'Password minimal harus memiliki 6 karakter.',

            // Message Error for Petugas
            'Wilayah_Bertugas.required' => 'Wilayah bertugas wajib diisi.',
            'Wilayah_Bertugas.in' => 'Wilayah bertugas tidak valid.',
            'Tanggal_Bergabung.required' => 'Tanggal bergabung wajib diisi.',
            'Tanggal_Bergabung.before_or_equal' => 'Tanggal bergabung harus sebelum atau sama dengan hari ini.',
            'Status_Keaktifan.required' => 'Status keaktifan wajib diisi.',
            'Status_Keaktifan.in' => 'Status keaktifan hanya boleh Aktif, Izin, atau Cuti.',
        ];
    }
}
