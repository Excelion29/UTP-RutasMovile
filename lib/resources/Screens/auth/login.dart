import 'package:iipvm/resources/widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iipvm/services/auth_services.dart';

class LoginScreen extends StatelessWidget {
  
  final dniController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            image: NetworkImage(
              'https://i.pinimg.com/736x/30/20/75/30207535669114cde4c3bfbd51297b3f.jpg',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    userInput(dniController, 'DNI', TextInputType.text, false),
                    userInput(passwordController, 'Password', TextInputType.visiblePassword, true),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.only(left: 70, right: 70),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          backgroundColor: const Color.fromARGB(255, 18, 120, 138),
                        ),
                        child: const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                        onPressed: () async {
                          try {
                            await Provider.of<AuthService>(context, listen: false).login(dniController.text, passwordController.text);
                            Navigator.of(context).pushReplacementNamed('/');
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failed to login frame')),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget login(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(
            onPressed: () {},
            child: const Text('Login'),
          ),
        ],
      ),
    );
    }

  Widget userInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType, bool password) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          obscureText: password,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

}