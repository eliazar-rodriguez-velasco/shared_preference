import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final formulario = new GlobalKey<FormState>();
  String _usuario;
  String _contrasena;
  String _Celectronico;

  String nombre = '';
  String contrasena = '';
  String correoElectronico = '';

  final _U = TextEditingController();
  final _CA = TextEditingController();
  final _CO = TextEditingController();

  String GN = '';
  // ignore: non_constant_identifier_names
  String GC = '';


  @override
  Widget build(BuildContext context) {
    setState(() {
      obtener();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        centerTitle: true,
        title: Text('Crear cuenta', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Form(
              key: formulario,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.nature_people,
                                size: 30,
                                color: Colors.cyan,
                              ),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 22.0, left: 22.0),
                              child: TextFormField(
                                validator: (valor) =>
                                    valor.length < 1 ? 'faltan letras' : null,
                                controller: _U,
                                onSaved: (valor) => _usuario = valor,
                                decoration:
                                    InputDecoration(labelText: 'Usuario'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.lock_outline,
                                  size: 35, color: Colors.cyan),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 22.0, left: 22.0),
                              child: TextFormField(
                                controller: _CA,
                                validator: (valor) => valor.length < 7
                                    ? 'debe contener por lo menos 7 caracteres'
                                    : null,
                                onSaved: (valor) => _contrasena = valor,
                                decoration:
                                    InputDecoration(labelText: 'Contraseña'),
                                obscureText: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.mail_outline,
                                  size: 30, color: Colors.cyan),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 22.0, left: 22.0),
                              child: TextFormField(
                                controller: _CO,
                                validator: (valor) => !valor.contains('@')
                                    ? 'para ser un correo se necesita un @'
                                    : null,
                                onSaved: (valor) => _Celectronico = valor,
                                decoration: InputDecoration(labelText: 'Email'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 60,
                          child: RaisedButton(
                            onPressed: () {
                              final form = formulario.currentState;
                              if (form.validate()) {
                                setState(() {
                                  nombre = _U.text;
                                  correoElectronico = _CO.text;
                                  guardar();
                                });
                                Page();
                              }
                            },
                            color: Colors.blueGrey[600],
                            child: Text(
                              'Registrarse',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _Login();
  }


  // ignore: non_constant_identifier_names
  Future _Login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('_sesion')) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey[600],
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'buen dia',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Los datos ingresados son:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('$GN'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('$GC'),
              ),
              SizedBox(height: 22.0),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 60,
                    child: MaterialButton(
                      onPressed: () {
                        salir();
                      },
                      color: Colors.blueGrey[600],
                      child: Text(
                        'salir',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }));
    }
  }

  // ignore: non_constant_identifier_names
  void Page() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('_sesion', true);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[600],
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'HOLA',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Se ingresaron estos datos:',
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(nombre),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(correoElectronico),
            ),
            SizedBox(height: 22.0),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  height: 60,
                  child: MaterialButton(
                    onPressed: () {
                      salir();
                    },
                    color: Colors.blueGrey,
                    child: Text(
                      'salir',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }

  Future<void> salir() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('_sesion', false);
    setState(() {
      GN = '';
      GC = '';
    });
    Navigator.pop(context);
  }


  Future<void> obtener() async {
    SharedPreferences datos = await SharedPreferences.getInstance();
    setState(() {
      GN = datos.get('nombre') ?? nombre;
      GC = datos.get('correo') ?? correoElectronico;
    });
  }


  Future<void> guardar() async {
    SharedPreferences datos = await SharedPreferences.getInstance();
    datos.setString('nombre', _U.text);
    datos.setString('correo', _CO.text);
  }
}
