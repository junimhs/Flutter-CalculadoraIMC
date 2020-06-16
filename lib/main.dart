import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculadora IMC',
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _info = "Calcule seu IMC";
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _reset() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _info = "Calcule seu IMC";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if(imc < 18.6){
        _info = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _info = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _info = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40){
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reset,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (KG)",
                  labelStyle: TextStyle(color: Colors.green)
                ),
                style: TextStyle(color: Colors.green, fontSize: 20.0),
                controller: pesoController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira seu peso";
                  }
                  try {
                    double.parse(value);
                  }catch(e) {
                    return "Insira apenas numeros";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (CM)",
                    labelStyle: TextStyle(color: Colors.green)
                  ),
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                  controller: alturaController,
                  validator: (value) {
                    if(value.isEmpty) {
                      return "Insira sua altura";
                    }
                    try {
                      double.parse(value);
                    }catch(e) {
                      return "Insira apenas numeros";
                    }
                  },
                ),
              ),
              Container(
                height: 50.0,
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      _calculate();
                    }
                  },
                  child: Text("Calcular",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(_info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}