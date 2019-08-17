import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _textPeso = TextEditingController();
  TextEditingController _textAltura = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  String _textInfo = "Informe seus Dados";

  void calculate() {
    setState(() {
      double peso = double.parse(_textPeso.text);
      double altura = double.parse(_textAltura.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _textInfo = "Abaixo do Peso ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _textInfo = "Pesso Ideal ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _textInfo = "Levemente acima do peso ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 29.9 && imc <= 34.9) {
        _textInfo = "Obesidade grau 1 ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _textInfo = "Obesidade grau 2 ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 40) {
        _textInfo = "Obesidade grau 3 ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  void _resetField() {
    _textPeso.text = "";
    _textAltura.text = "";
    setState(() {
      _textInfo = "Informe seus Dados";
      _formKey = GlobalKey<FormState>();    // ADICIONE ESTA LINHA!

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: _resetField)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
        child: Form(
          key: _formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.person_outline,
              size: 120.0,
              color: Colors.deepPurple,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Peso (KG)",
                  labelStyle: TextStyle(color: Colors.deepPurple)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
              controller: _textPeso,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso!";
                  }
                }
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.deepPurple)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
              controller: _textAltura,
              validator: (value){
                if(value.isEmpty){
                  return "Insira Sua altura!";
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      calculate();
                    }
                  },
                  child: Text("Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Text(
              _textInfo,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
            )
          ],
        )),
      ),
    );
  }
}
