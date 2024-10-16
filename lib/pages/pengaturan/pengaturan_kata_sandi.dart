import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PengaturanKataSandi extends StatefulWidget {
  const PengaturanKataSandi({super.key});

  @override
  State<PengaturanKataSandi> createState() => _PengaturanKataSandiState();
}

class _PengaturanKataSandiState extends State<PengaturanKataSandi> {
  final _kataSandiLamaController = TextEditingController();
  final _kataSandiBaruController = TextEditingController();
  final _konfirmasiKataSandiBaruController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> _gantiKataSandi() async {
    if (_kataSandiLamaController.text.trim().isEmpty &&
        _kataSandiBaruController.text.trim().isEmpty &&
        _konfirmasiKataSandiBaruController.text.trim().isEmpty) {
      _munculkanPesanError('Kata Sandi tidak boleh kosong!');
      return;
    } else if (_kataSandiBaruController.text !=
        _konfirmasiKataSandiBaruController.text) {
      _munculkanPesanError("Kata Sandi tidak sesuai!");
      return;
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PengaturanKataSandi()),
      );
    }
  }

  void _munculkanPesanError(String message) {
    showDialog(
      context: context,
      builder: (alert) => AlertDialog(
        title: Text(
          'Ganti Kata Sandi Gagal',
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
                    'Ganti Kata Sandi',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                                Text(
                                  'Untuk memperbarui kata sandi anda, Mohon masukkan kada sandi anda yang lama',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 20),
                                _buildInput(_kataSandiLamaController,
                                    'Kata Sandi Lama'),
                                _buildInput(_kataSandiBaruController,
                                    'Kata Sandi Baru'),
                                _buildInput(_konfirmasiKataSandiBaruController,
                                    'Konfirmasi Kata Sandi Baru'),
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
                                      onPressed: _gantiKataSandi,
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
                                const SizedBox(height: 15),
                                Text(
                                  'Atau jika anda lupa kata sandi sebelumnya bisa menggunakan fitur Lupa Kata Sandi',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
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

  Widget _buildInput(TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
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
