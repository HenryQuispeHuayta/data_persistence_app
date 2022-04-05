import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show SystemNavigator, rootBundle;
import 'package:csv/csv.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final cod = TextEditingController();
  String codigo = '';
  String d1 = '';
  String d2 = '';
  String d3 = '';
  String d4 = '';
  String d5 = '';
  String d6 = '';

  List<List<dynamic>> datos = [];
  bool a = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menejo Archivos'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Henry Quispe Huayta',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 100),
              child: TextField(
                controller: cod,
                decoration: InputDecoration(hintText: 'Codigo del Producto'),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      cargar();
                      // buscar();
                    },
                    child: Text('BUSCAR')),
                SizedBox(
                  width: 50.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      reiniciar();
                    },
                    child: Text('INICIALIZAR')),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            cambiar(),
          ],
        ),
      ),
    );
  }

  cargar() async {
    final rDatos = await rootBundle.loadString('assets/data/productos.txt');
    List<List<dynamic>> listaDatos = const CsvToListConverter().convert(rDatos);
    setState(() {
      datos = listaDatos;
    });
    List<String> b = [];
    for (int i = 0; i < datos.length; i++) {
      b = datos[i][0].toString().split(';');
      if (b[0] == cod.text) {
        setState(() {
          d1 = b[0];
          d2 = b[1];
          d3 = b[2];
          d4 = b[3];
          d5 = b[4];
          d6 = b[5];
        });
        a = false;
      }
    }
    if (a) {
      setState(() {
        vista();
      });
    }
  }

  Future vista() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('El numero no existe'),
              content: const Text('Volver a buscar?'),
              actions: [
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => homePage()),
                    );
                  },
                  child: const Text('Si'),
                ),
              ],
            ));
  }

  Widget cambiar() {
    if (a) {
      return Text(
        'INF - 325',
        style: TextStyle(fontSize: 90),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Codigo Producto',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  'Descripcion',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  'Uni ven',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  'Uni En',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  'Linea',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  'Existencia',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  ' : ',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  ' : ',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  ' : ',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  ' : ',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  ' : ',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  ' : ',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  d1,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  d2,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  d3,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  d4,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  d5,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  d6,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  reiniciar() {
    setState(() {
      d1 = '';
      d2 = '';
      d3 = '';
      d4 = '';
      d5 = '';
      d6 = '';
      cod.text = '';
      a = true;
    });
  }
}
