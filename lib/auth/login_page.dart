import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:londri/auth/register_page.dart';
import 'package:londri/service/auth_service.dart';

import '../utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController emailC = TextEditingController();
TextEditingController passwordC = TextEditingController();

bool seePass = true;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFDEF0F2),
        body: Center(
          child: SizedBox(
            height: sizeHeight,
            width: sizeWidth * 0.85,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //teks londri
                    SizedBox(
                      height: sizeHeight * 0.08,
                      width: sizeWidth * 0.60,
                      child:
                          const Image(image: AssetImage('images/londri.png')),
                    ),
                    SizedBox(
                      height: sizeHeight * 0.07,
                    ),
                    //form login
                    Container(
                      height: sizeHeight * 0.45,
                      width: sizeWidth * 0.80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Column(
                        children: [
                          SizedBox(
                            height: sizeHeight * 0.03,
                          ),
                          //text login
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          SizedBox(
                            height: sizeHeight * 0.03,
                          ),
                          //email
                          Container(
                            width: sizeWidth * 0.70,
                            height: sizeHeight * 0.07,
                            decoration: BoxDecoration(
                                color: const Color(0xFFDEF0F2),
                                borderRadius: BorderRadius.circular(30)),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailC,
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: const Icon(Icons.person, size: 26),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                hintText: 'Email',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizeHeight * 0.03,
                          ),
                          //password
                          Container(
                            width: sizeWidth * 0.70,
                            height: sizeHeight * 0.07,
                            decoration: BoxDecoration(
                                color: const Color(0xFFDEF0F2),
                                borderRadius: BorderRadius.circular(30)),
                            child: TextField(
                              obscureText: seePass,
                              controller: passwordC,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        seePass = !seePass;
                                      });
                                    },
                                    icon: seePass
                                        ? const Icon(
                                            Icons.visibility_off,
                                            size: 26,
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                            size: 26,
                                          )),
                                isDense: true,
                                prefixIcon: const Icon(Icons.lock, size: 26),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                hintText: 'Password',
                              ),
                            ),
                          ),
                          //lupa password
                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: TextButton(
                          //       onPressed: () {},
                          //       child: const Text(
                          //         'Lupa password?',
                          //         style: TextStyle(color: Colors.black),
                          //       )),
                          // ),
                          SizedBox(
                            height: sizeHeight * 0.04,
                          ),
                          //button login
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              fixedSize:
                                  Size(sizeWidth * 0.30, sizeHeight * 0.06),
                              backgroundColor: Colors.lightBlueAccent[200],
                              elevation: 0,
                            ),
                            onPressed: () async {
                              if (emailC.text.isEmpty) {
                                return Utils.showSnackBar(
                                    'Email tidak boleh kosong', Colors.red);
                              }
                              if (emailC.text.contains('@')) {
                                if (passwordC.text.isEmpty) {
                                  return Utils.showSnackBar(
                                      'Password tidak boleh kosong',
                                      Colors.red);
                                }
                                if (passwordC.text.length < 6) {
                                  return Utils.showSnackBar(
                                      'Password minimal 6 karakter',
                                      Colors.red);
                                }
                                AuthService().login(emailC.text.trim(),
                                    passwordC.text.trim(), context);
                              } else {
                                Utils.showSnackBar(
                                    'Email harus terdapat ${'@'}', Colors.red);
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          SizedBox(
                            height: sizeHeight * 0.02,
                          ),
                          //import 'package:flutter/gestures.dart';
                          RichText(
                              text: TextSpan(
                            text: 'Belum memiliki akun?',
                            style: const TextStyle(color: Colors.black),
                            children: [
                              const WidgetSpan(child: SizedBox(width: 5)),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const RegisterPage()),
                                            (route) => false),
                                  text: 'Register',
                                  style: const TextStyle(color: Colors.blue)),
                            ],
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
