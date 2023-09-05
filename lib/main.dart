import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulário Flutter'),
        ),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController rgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: nomeController,
            decoration: InputDecoration(labelText: 'Nome Completo'),
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
          TextFormField(
            controller: nicknameController,
            decoration: InputDecoration(labelText: 'Nickname'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Campo obrigatório';
              } else if (value!.length < 5 || value.length > 15) {
                return 'O nickname deve ter entre 5 e 15 caracteres';
              }
              return null;
            },
          ),
          TextFormField(
            controller: idadeController,
            decoration: InputDecoration(labelText: 'Idade'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Campo obrigatório';
              }
              int idade = int.tryParse(value ?? '') ?? 0;
              if (idade == null || idade < 16 || idade > 100) {
                return 'A idade deve ser um número entre 16 e 100';
              }
              return null;
            },
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Campo obrigatório';
              }
                if (value != null && !validadorEmail(value)) {
                  return 'Email inválido';
                }
              return null;
            },
          ),
          TextFormField(
            controller: cpfController,
            decoration: InputDecoration(labelText: 'CPF'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Campo obrigatório';
              }
              if (value != null && !validadorCPF(value)) {
                return 'CPF inválido';
              }
              return null;
            },
          ),
          TextFormField(
            controller: rgController,
            decoration: InputDecoration(labelText: 'RG'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Campo obrigatório';
              }
              if (value != null && !validadorRG(value)) {
                return 'RG inválido';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
if (_formKey.currentState != null &&
    nomeController.text.isNotEmpty &&
    nicknameController.text.isNotEmpty &&
    idadeController.text.isNotEmpty &&
    emailController.text.isNotEmpty &&
    cpfController.text.isNotEmpty &&
    rgController.text.isNotEmpty) {
  if (_formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Dados Validados'),
      ),
    );
  }
}

            },
            child: Text('Validar Dados'),
          ),
        ],
      ),
    );
  }

  bool validadorEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool validadorCPF(String cpf) {
    final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
    return cpfRegex.hasMatch(cpf);
  }

  bool validadorRG(String rg) {
    final rgRegex = RegExp(r'^\d{8}-\d$');
    return rgRegex.hasMatch(rg);
  }
}
