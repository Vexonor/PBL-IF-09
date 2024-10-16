import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PengaturanProfil extends StatefulWidget {
  const PengaturanProfil({super.key});

  @override
  State<PengaturanProfil> createState() => _PengaturanProfilState();
}

class _PengaturanProfilState extends State<PengaturanProfil> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _nomorController = TextEditingController();
  final _alamatController = TextEditingController();
  final _jenisKelaminController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> _ubahProfil() async {
    if (_namaController.text.trim().isEmpty &&
        _emailController.text.trim().isEmpty &&
        _nomorController.text.trim().isEmpty &&
        _alamatController.text.trim().isEmpty &&
        _jenisKelaminController.text.trim().isEmpty) {
      _munculkanPesanError('Data diri tidak boleh kosong!');
      return;
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PengaturanProfil()),
      );
    }
  }

  void _munculkanPesanError(String message) {
    showDialog(
      context: context,
      builder: (alert) => AlertDialog(
        title: Text(
          'Ubah Profil Gagal',
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                  const Color.fromARGB(255, 59, 142, 110)),
            ),
            onPressed: () {
              Navigator.of(alert).pop();
            },
            child: Text(
              'Oke',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 142, 110),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Kembali',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    'Ubah Profil',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Form(
                            key: _formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20),
                                _buildInput(_namaController, Icons.person,
                                    'Nama Lengkap'),
                                _buildInput(_emailController, Icons.email,
                                    'Alamat Email'),
                                _buildInput(_nomorController, Icons.phone,
                                    'Nomor Telepon'),
                                _buildInput(_alamatController, Icons.home,
                                    'Alamat Tempat Tinggal'),
                                _buildInput(_jenisKelaminController, Icons.wc,
                                    'Jenis Kelamin'),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 75.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 59, 142, 110),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: _ubahProfil,
                                      child: Text(
                                        'Simpan',
                                        style: GoogleFonts.poppins(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
      TextEditingController controller, IconData icon, String label) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            labelText: label,
            labelStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
