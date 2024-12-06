import 'package:flutter/material.dart';
import 'package:responsi_010/register.dart';
import 'package:responsi_010/screen/categories_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  late SharedPreferences loginData;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? true);
    if (newUser == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CategoriesPage()),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 205, 68, 0),
              Color.fromARGB(255, 239, 156, 88),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "LOGIN FORM",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(183, 177, 74, 0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 200, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    String username = usernameController.text.trim();
                    String password = passwordController.text.trim();

                    String? savedUsername = loginData.getString('username');
                    String? savedPassword = loginData.getString('password');

                    if (username == savedUsername &&
                        password == savedPassword) {
                      loginData.setBool("login", true);
                      loginData.setString("currentUsernme",
                          username); // untuk menyimpan username
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoriesPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid username or password'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text(
                      "Belum punya akun? Registrasi disini",
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
