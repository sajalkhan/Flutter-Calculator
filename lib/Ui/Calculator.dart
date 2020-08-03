import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String _output = '', operator = '', result = '0';
  double num1 = 0.0, num2 = 0.0;

  void calculate(String data)
  {
    if(data=='CLEAR'){
      _output = '0';
      num1 = 0;
      num2= 0;
    }
    else if(data == '+' || data=='-' || data =='*' || data=='/') {
        num1 = double.parse(_output);
        operator = data;
        _output = '0';
    }
    else if(data =='.'){
      if(_output.contains('.')) return;
      _output+=data;
    }
    else if(data == '=') {
      num2 = double.parse(_output);
      RegExp regex = RegExp(r"([.]*0)(?!.*\d)");   // remove trailing zero from a number

      if(operator == '+') _output = (num1+num2).toString().replaceAll(regex, '');
      if(operator == '-') _output = (num1-num2).toString().replaceAll(regex, '');
      if(operator == '*') _output = (num1*num2).toString().replaceAll(regex, '');
      if(operator == '/') _output = (num1/num2).toString().replaceAll(regex, '');
      num1 =0;
      num2=0;
      operator = '';
    }
    else {
      if(_output=='0' || _output=='00') _output = data;
      else _output+=data;
    }

    setState(() {
      result = (_output.contains('.') && data=='=')?  double.parse(_output).toStringAsFixed(2) : _output;
    });
  }

  Expanded createBtn(String btnText) {
    return Expanded(
      child: OutlineButton(
        padding: EdgeInsets.all(20.0),
        child: Text(btnText, style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700
        ),),
        color: Colors.blueGrey.shade200,
        onPressed: ()=> calculate(btnText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Calculator', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400
            ),),
            centerTitle: true,
            backgroundColor: Colors.orange.shade700,
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(result, style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                  ),),
                  padding: EdgeInsets.all(40),
                  margin: EdgeInsets.only(top: 30),
                  color: Colors.grey.shade200,
                  alignment: Alignment.centerRight,
                ),
                Expanded(
                  child: Divider(),
                ),
                new Row(
                  children: <Widget>[
                    createBtn('7'),
                    createBtn('8'),
                    createBtn('9'),
                    createBtn('/'),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    createBtn('4'),
                    createBtn('5'),
                    createBtn('6'),
                    createBtn('*'),
                  ],
                ),
               new Row(
                  children: <Widget>[
                    createBtn('1'),
                    createBtn('2'),
                    createBtn('3'),
                    createBtn('-'),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    createBtn('.'),
                    createBtn('0'),
                    createBtn('00'),
                    createBtn('+'),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    createBtn('CLEAR'),
                    createBtn('='),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
