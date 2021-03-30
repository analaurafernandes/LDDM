import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp()); //código em apenas uma linha

//DECLARAÇÃO DE VARIÁVEIS
var valor_conta         = 0.0;
var valor_bebidas       = 0.0;
var num_pessoas         = 0.0;
var num_pessoas_beberam = 0.0;
var valor_por_pessoa    = 0.0;
var grupo_bebida        = 0.0;
var grupo_sem_bebida    = 0.0;
var valor_garcom        = 0.0;
var valor_quem_comeu    = 0.0;
var valor_quem_bebeu    = 0.0;
bool selecionado        = false;
final valor_total       = TextEditingController();
final bebidas       = TextEditingController();
final pessoas       = TextEditingController();
final pessoas_bebidas       = TextEditingController();

var bonus = 10.0;
List<String> resultado = List<String>.filled(7, '0');
String label = "Bônus:";

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
    @override
    Widget build(BuildContext context){
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData(primaryColor: Colors.deepPurple[200]),
       home: HomePage()
     );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text("Divisor de Contas", style: TextStyle(color: Colors.white)),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: _body(context),
        extendBody: true,
        extendBodyBehindAppBar: true
    );
  }

  _body(BuildContext context){
      if(selecionado) {
            return Container(
                    color: Colors.white,
                      child: ListView(
                          children: <Widget>[
                            _labelCaixaTexto("Digite o valor da Conta:"),
                            _caixaTexto("valor_conta", valor_total),
                            _labelCaixaTexto("Digite o valor das Bebidas:"),
                            _caixaTexto("valor_bebidas", bebidas),
                            _labelCaixaTexto("Digite o número de pessoas que irão dividir a conta:"),
                            _caixaTexto("num_pessoas", pessoas),
                            _labelCaixaTexto("Digite o número de pessoas que irão dividir a bebida:"),
                            _caixaTexto("num_pessoas_beberam", pessoas_bebidas),
                            _switchBebidas(),
                            _labelCaixaTexto("Porcentagem do Garçom:"),
                            _sliderBonusConta(),
                            _botaoCalcular(),
                            Padding(
                              padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                              child: ListTile(
                                leading: Icon(Icons.monetization_on_outlined),
                                title: Text("Valor total: R\$:" + resultado[0]),
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                              child: ListTile(
                                leading: Icon(Icons.brunch_dining),
                                title: Text('Valor por pessoa com bebida: R\$:' + resultado[3]),
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                              child: ListTile(
                                leading: Icon(Icons.lunch_dining),
                                title: Text('Valor por pessoa sem bebida: R\$:' + resultado[4]),
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                              child: ListTile(
                                leading: Icon(Icons.group_rounded),
                                title: Text('Valor do grupo com bebida: R\$:' + resultado[6]),
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                              child: ListTile(
                                leading: Icon(Icons.group_rounded),
                                title: Text('Valor do grupo sem bebida: R\$:' + resultado[5]),
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                              child:ListTile(
                                leading: Icon(Icons.food_bank),
                                title: Text('Valor do garçom: R\$:' + resultado[2]),
                              )
                            )
                          ]
                      )
            );
      }
      else {
            return Container(
                    color: Colors.white,
                      child: ListView(
                          children: <Widget>[
                            _labelCaixaTexto("Digite o valor da Conta:"),
                            _caixaTexto("valor_conta", valor_total),
                            _labelCaixaTexto("Digite o número de pessoas que irão dividir a conta:"),
                            _caixaTexto("num_pessoas", pessoas),
                            _switchBebidas(),
                            _labelCaixaTexto("Porcentagem do Garçom:"),
                            _sliderBonusConta(),
                            _botaoCalcular(),
                            ListTile(
                              leading: Icon(Icons.monetization_on_outlined),
                              title: Text("Valor total: R\$:" + resultado[0]),
                            ),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text('Valor por pessoa: R\$:' + resultado[1]),
                            ),
                            ListTile(
                              leading: Icon(Icons.food_bank),
                              title: Text('Valor do garçom: R\$:' + resultado[2]),
                            ),
                          ]
                      )
                );
      }
    }

  _labelCaixaTexto(String texto){
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.fromLTRB(32, 32, 32, 0),
            child:Text(texto,
                style: TextStyle(fontSize: 16))
        ));
  }
  _caixaTexto(variavel, nomeCaixaTexto){
    return Padding(
        padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: nomeCaixaTexto,
          onChanged: (String valor){
            setState(() {
              if(variavel == "valor_conta")
                valor_conta = double.parse(valor);
              else if(variavel == "valor_bebidas")
                valor_bebidas = double.parse(valor);
              else if(variavel == "num_pessoas_beberam")
                num_pessoas_beberam = double.parse(valor);
              else
                num_pessoas = double.parse(valor);
            });
          },
        )
    );
  }
  _switchBebidas(){
    return Padding(
        padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
        child: SwitchListTile(
        activeColor: Colors.green[200],
        title: Text("Considerar bebidas:"),
        value: selecionado,
        onChanged: (bool valor){
            setState(() {
              selecionado = valor;
            });
            resultado.fillRange(0, resultado.length - 1, '0');
        })
    );
  }
  _sliderBonusConta(){
    return Padding(
        padding: EdgeInsets.fromLTRB(10,0,10,10),
          child: Slider(
          value: bonus,
          min: 0,
          max: 100,
          label: label,
          divisions: 20,
          inactiveColor: Colors.green[200],
          activeColor: Colors.green[200],
          onChanged: (double valor){
            setState((){
              bonus = valor;
              label = "Bônus: " + valor.toString();
            });
          }
      )
    );
  }
  _botaoCalcular(){
    return Padding(
        padding: EdgeInsets.fromLTRB(86, 0, 86, 32),
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple[200])),
            child: Text("CALCULAR A CONTA"),
            onPressed: (){
                if(selecionado)
                  _calculaContaBebida();
                else
                  _calculaConta();
                setState(() {
                  resultado = [valor_conta.toStringAsPrecision(2), valor_por_pessoa.toStringAsPrecision(2), valor_garcom.toStringAsPrecision(2), valor_quem_bebeu.toStringAsPrecision(2),
                    valor_quem_comeu.toStringAsPrecision(2), grupo_sem_bebida.toStringAsPrecision(2), grupo_bebida.toStringAsPrecision(2)];
                  valor_conta = valor_por_pessoa = valor_garcom = valor_quem_bebeu = valor_quem_comeu = grupo_sem_bebida = grupo_bebida = 0.0;
                  _resetCaixasTexto();
                });
          }
      )
    );
  }
  _resetCaixasTexto(){
    valor_total.clear();
    pessoas.clear();
    bebidas.clear();
    pessoas_bebidas.clear();
  }
  _calculaContaBebida(){
    valor_quem_comeu = ((valor_conta - valor_bebidas)/num_pessoas);
    valor_quem_bebeu = (valor_bebidas/num_pessoas_beberam) + valor_quem_comeu;
    valor_quem_comeu *= 1 + bonus/100;
    valor_quem_bebeu *= 1 + bonus/100;
    grupo_bebida = valor_quem_bebeu * num_pessoas_beberam;
    grupo_sem_bebida = valor_quem_comeu * (num_pessoas - num_pessoas_beberam);
    valor_garcom = valor_conta * bonus/100;
    valor_conta += valor_garcom;
  }
  _calculaConta(){
    valor_garcom = valor_conta * bonus/100;
    valor_conta += valor_garcom;
    valor_por_pessoa = (valor_conta)/num_pessoas;
  }
}