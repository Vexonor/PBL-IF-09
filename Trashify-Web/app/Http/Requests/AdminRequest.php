<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AdminRequest extends FormRequest
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

            // Validation Admin
            'Role_Admin' => 'required|in:Master,Admin',
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

            // Message Error for Admin
            'Role_Admin.required' => 'Role admin wajib diisi.',
            'Role_Admin.in' => 'Role admin hanya boleh Master atau Admin.',
        ];
    }
}
