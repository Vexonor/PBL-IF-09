import 'package:flutter/material.dart';
import 'package:trashify/controllers/auth/verification_controller.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final VerificationController controller = VerificationController();
  bool _hasFetchedData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetchedData) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      controller.setUserId(args['userId']);
      fetchVerification();
      _hasFetchedData = true;
    }
  }

  Future<void> fetchVerification() async {
    await controller.fetchVerification(context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
    final List<TextEditingController> controllers =
        List.generate(6, (index) => TextEditingController());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 142, 110),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.black),
                              onPressed: () {
                                if (mounted) {
                                  Navigator.pushNamed(context, '/daftar');
                                }
                              },
                            ),
                          ],
                        ),
                        Icon(
                          Icons.email_outlined,
                          size: 64.0,
                          color: const Color.fromARGB(255, 59, 142, 110),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Verifikasi Email',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Masukkan 6 digit kode yang telah dikirimkan ke ${controller.verificationInformation?['email'] ?? 'your-email@example.com'}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            return SizedBox(
                              width: 40.0,
                              height: 50.0,
                              child: TextFormField(
                                controller: controllers[index],
                                enabled: !controller.isProcessing,
                                focusNode: focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 59, 142, 110)),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty && index < 5) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index + 1]);
                                  } else if (value.isEmpty && index > 0) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index - 1]);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Kode tidak tidak boleh kosong!';
                                  }
                                  return null;
                                },
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Tidak menerima kode atau kode yang dikirim sudah kadaluwarsa?',
                          style:
                              TextStyle(fontSize: 14.0, color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: controller.isProcessing
                              ? null
                              : () {
                                  setState(() {
                                    controller.isProcessing = true;
                                  });
                                  controller.resendOtp(context).then((_) {
                                    setState(() {
                                      controller.isProcessing = false;
                                    });
                                  }).catchError((error) {
                                    setState(() {
                                      controller.isProcessing = false;
                                    });
                                  });
                                },
                          child: Text(
                            'Kirim Ulang',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: const Color.fromARGB(255, 59, 142, 110),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: controller.isProcessing
                              ? null
                              : () {
                                  setState(() {
                                    controller.isProcessing = true;
                                  });
                                  String verificationCode =
                                      controllers.map((c) => c.text).join();
                                  controller
                                      .verification(context, verificationCode)
                                      .then((_) {
                                    setState(() {
                                      controller.isProcessing = false;
                                    });
                                  }).catchError((error) {
                                    setState(() {
                                      controller.isProcessing = false;
                                    });
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 59, 142, 110),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 80.0,
                              vertical: 12.0,
                            ),
                          ),
                          child: Text(
                            'Verifikasi',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
