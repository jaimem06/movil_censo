//adb kill-server, adb start-server
//fstful
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movil_censo/controller/Service.dart';
import 'package:movil_censo/views/dashView.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController correoControl = TextEditingController();
  final TextEditingController claveControl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void inicio() {
    FToast ftoast = FToast();
    ftoast.init(context);
    setState(() {
      if (_formKey.currentState!.validate()) {
        Map<String, String> data = {
          "correo": correoControl.text,
          "clave": claveControl.text
        };
        log(data.toString());
        Service c = Service();

        c.session(data).then((value) async {
          log(value.datos.toString());
          log(value.token);
          if (value.code == '200') {
            // Muestra el toast de éxito
            ftoast.showToast(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.green,
                ),
                child: Text(
                  'Inicio de sesión exitoso: ${value.user}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              gravity: ToastGravity.BOTTOM,
              toastDuration: const Duration(seconds: 3),
            );
            // Redirige a la pantalla principal
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashState()),
            );
          } else {
            ftoast.showToast(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color.fromARGB(255, 24, 118, 241),
                ),
                child: Text(value.datos['error']),
              ),
              gravity: ToastGravity.CENTER,
              toastDuration: const Duration(seconds: 3),
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            // Permite desplazamiento si el contenido es demasiado largo
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centra los widgets verticalmente
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "BIENVENIDO!",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "CENSO LOGIN",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Ingrese sus Datos",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 300,
                  child: TextFormField(
                    controller: correoControl,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      suffixIcon: Icon(Icons.alternate_email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su correo';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 300,
                  child: TextFormField(
                    controller: claveControl,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: const InputDecoration(
                      labelText: 'Clave',
                      suffixIcon: Icon(Icons.key),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su clave';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: 300,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    onPressed: inicio,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    child: const Text("INGRESAR"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
