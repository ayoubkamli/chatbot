import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 500,
          width: 400,
          color: Colors.black26,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "User name",
                    suffixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: const Icon(Icons.visibility),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      String username = usernameController.text;
                      String password = passwordController.text;
                      if (username == "admin" && password == "1234") {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, "/chat");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
