import 'package:flutter/material.dart';
import 'package:movil_censo/views/sidebar/ConfiguracionView.dart';
import 'package:movil_censo/views/sidebar/RegistrarCensadoView.dart';
import 'package:movil_censo/views/sidebar/RegistrarCensoView.dart';

void main() {
  runApp(DashState());
}

class DashState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menú Censo'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Registrar Censo'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrarCensoView(),
                      ));
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Registrar Censado'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrarCensadoView(),
                      ));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configuraciones'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Configuracionview(),
                      ));
                },
              ),
              // Aqui agregar pantalla
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title:
                    Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
                onTap: () {
                  // Aqui logica cerrar sesion
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Text(
            'Hola Mundo, aqui pantalla principal',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
