import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  String _result;

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';

    setState(() {
      _result = 'Favor preencher os campos';
    });
  }

  void calcularImc() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100.00;
    double imc = weight / (height * height);

    setState(() {
      _result = "IMC = ${imc.toStringAsPrecision(2)}\n";
      if (imc < 18.6)
        _result += "Abaixo do peso";
      else if (imc < 25.0)
        _result += "Peso ideal";
      else if (imc < 30.0)
        _result += "Levemente acima do peso";
      else if (imc < 35.0)
        _result += "Obesidade Grau I";
      else if (imc < 40.0)
        _result += "Observar Grau II";
      else
        _result += "Obsidade Grau III";
    });
  }

  //criação do corpo de app para a navegação
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: buildForm(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Toperson do IMC',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.yellowAccent,
      //theme: new ThemeData(
      //   primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black))),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.replay_circle_filled),
          color: Colors.black,
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  //Criando o Furmulario para colocar os itens dentro
  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //configuração do campo form de peso
          buildTextFormField(
              label: "Peso (kg)", // nome do campo que é preenchido
              error:
                  "Insira seu Peso!", //informa o erro de não preenchimentodo campo especifico
              controller: _weightController),
          // configuração do form do campo de altura
          buildTextFormField(
              label: "Altura (cm)", //passar a altura em centimentros
              error: "Insira a Altura!",
              controller: _heightController),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  //formatação do botão calcular
  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calcularImc();
          }
        },
        child: Text('CALCULAR', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  // mostar o resultado da conta em uma label
  // Fazer um pop up depois***
  /*Widget okButton = FlatButton(
    onPressed: (){},
    child: Text("Ok")
    );*/

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
      ),
    );
  }

  TextFormField buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      cursorColor: Colors.yellow,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}
