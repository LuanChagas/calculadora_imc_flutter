import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';

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
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  Color corFundo;
  Color corFundoBlue = Colors.blue;
  Color corFundoGreen = Colors.green;
  Color corFundoOrange = Colors.orange;
  Color corFundoRed = Colors.red;

  var formKey = GlobalKey<FormState>();
  bool btnVisible = true;
  bool info = false;
  bool inputVisible = true;
  double result;

  void refresh() {
    setState(() {
      weightController.text = '';
      heightController.text = '';
      btnVisible = true;
      info = false;
      inputVisible = true;
      formKey = GlobalKey<FormState>();
    });
  }

  void mudarvisibility() {
    setState(() {
      info = true;
      inputVisible = false;
    });
  }

  void trocarCor(Color cor){
    setState(() {
      corFundo = cor;
    });
  }

  void calculate() {
    double altura = double.parse(heightController.text);
    double peso = double.parse(weightController.text);

    double total = peso / (altura * altura);

    if(total < 18.5){
       trocarCor(Colors.blue);
    } else if(total >= 18.5 && total <= 24.5 ){
      trocarCor(Colors.green);
    }else if (total <= 25 && total >= 29.9){
      trocarCor(Colors.orange);
    }else{
      trocarCor(Colors.red);
    }
    setState(() {
      info = true;
      inputVisible = false;
      result = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(244, 249, 85, 20),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 50,
              ),
              Text('  IMC CALCULATOR',
                  style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(color: Colors.black87, letterSpacing: 1)))
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                size: 40,
                textDirection: TextDirection.rtl,
                color: Colors.black54,
              ),
              onPressed: refresh,
            )
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Visibility(
                    visible: inputVisible,
                    child: TextFormField(
                      validator: (value){
                        if (value.isEmpty){
                          return 'Insira sua Altura';
                        }
                      },
                        controller: heightController,
                        autofocus: false,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.pink[100],
                          icon: Image.asset(
                            'assets/images/icon-height.png',
                            scale: .888,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(fontSize: 20)),
                  ),
                  Visibility(
                    visible: inputVisible,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: TextFormField(
                          validator: (value){
                        if (value.isEmpty){
                          return 'Insira seu Peso';
                        }
                      },
                          controller: weightController,
                          autofocus: false,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.pink[100],
                            icon: Image.asset(
                              'assets/images/icon-weight.png',
                              scale: .777,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40,
                      bottom: 20,
                    ),
                    child: Center(
                      child: Container(
                        child: Image.asset('assets/images/icon-genre.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Visibility(
                        visible: btnVisible,
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 50,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: (){
                                if(formKey.currentState.validate()){
                                  calculate();
                                }
                              },
                              color: Color.fromRGBO(244, 249, 85, 20),
                              child: Text(
                                "CALCULAR",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.black87, fontSize: 30.0)),
                              ),
                            ),
                          ),
                        )),
                  ),
                  Center(
                      child: Visibility(
                          visible: info,
                          child: Container(
                              width: 150,
                              height: 45,
                              child: Text('IMC',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(fontSize: 40.0)))))),
                  Center(
                    child: Visibility(
                      visible: info,
                      child: Container(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: corFundo,
                          child: Text(
                            '${result.toStringAsPrecision(2)}',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: info,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, bottom: 5, top: 20),
                          child: Text(
                            ' < 18,5',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.blue, fontSize: 16)),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 25, bottom: 5, top: 20),
                          child: Text(
                            '18,5 - 24,9',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.green, fontSize: 16)),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, bottom: 5, top: 20),
                          child: Text(
                            '25,0 - 29,9',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.orange, fontSize: 16)),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 30, bottom: 5, top: 20),
                          child: Text(
                            '> 30',
                            style: GoogleFonts.roboto(
                                textStyle:
                                    TextStyle(color: Colors.red, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: info,
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                                width: 110,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Abaixo \ndo peso',
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 90),
                              child: Container(
                                  width: 80,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Saudável',
                                    ),
                                  )),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 190),
                                child: Container(
                                    width: 150,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                        child: Text(
                                      '              Obesidade',
                                      textAlign: TextAlign.end,
                                    )))),
                            Padding(
                                padding: EdgeInsets.only(left: 170),
                                child: Container(
                                    width: 85,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'SobrePeso',
                                      ),
                                    ))),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
