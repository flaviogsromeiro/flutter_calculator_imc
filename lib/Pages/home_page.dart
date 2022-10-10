import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _info = 'Informe seus dados';

  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void reset() {
    setState(() {
      weigthController.text = '';
      heigthController.text = '';
      _info = 'Informe seus dados';
    });
  }

  void calculate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        var weight = double.parse(weigthController.text);
        // ignore: unnecessary_type_check
        assert(weight is double);
        var height = double.parse(heigthController.text) / 100;
        // ignore: unnecessary_type_check
        assert(height is double);
        double imc = weight / (height * height);

        if (imc < 17) {
          _info = 'Muito abaixo do peso (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 17 && imc <= 18.49) {
          _info = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 18.5 && imc <= 24.99) {
          _info = 'Peso normal (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 25 && imc <= 29.99) {
          _info = 'Acima do peso (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 30 && imc <= 34.99) {
          _info = '	Obesidade I (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 35 && imc <= 39.99) {
          _info = 'Obesidade II (severa) (${imc.toStringAsPrecision(4)})';
        } else {
          _info = 'Obesidade III (mórbida) (${imc.toStringAsPrecision(4)})';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AppBar(
            toolbarHeight: 70,
            backgroundColor: const Color(0xFF2C6ED1),
            title: const Text(
              'Calculadora IMC',
              style: TextStyle(fontSize: 25),
            ),
            actions: [
              IconButton(
                onPressed: reset,
                icon: const Icon(
                  Icons.autorenew_rounded,
                  color: Colors.white,
                  size: 40,
                ),
                padding: const EdgeInsets.only(right: 20),
                alignment: Alignment.center,
              ),
            ],
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Color(0xFF2C6ED1),
                  ),
                  TextFormField(
                    controller: weigthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle:
                          TextStyle(color: Color(0xFF2C6ED1), fontSize: 25),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Insira seu peso';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: heigthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle:
                          TextStyle(color: Color(0xFF2C6ED1), fontSize: 25),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Insira sua altura';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ElevatedButton(
                      onPressed: calculate,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C6ED1),
                          fixedSize: const Size(0, 40)),
                      child: const Text(
                        "Calcular",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Text(
                    _info,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Color(0xFF2C6ED1), fontSize: 25.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
