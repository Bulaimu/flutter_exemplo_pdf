import 'package:exemplo_pdf/funcoes.dart';
import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numero = 1;

  String _platformVersion;
  Permission permission;

  @override
  void initState() {
    super.initState();
    initplatform();
  }

  initplatform() async {
    String platfrom;
    try {
      platfrom = await SimplePermissions.platformVersion;
    } on PlatformException {
      platfrom = "platform not found";
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platfrom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: RaisedButton(
      //     child: Text("Gerar PDF"),
      //     onPressed: () {
      //       print("Gerar PDF");
      //       criarPDF(numero);
      //       numero++;
      //     },
      //   ),
      // ),

      body: SafeArea(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("platform version is $_platformVersion\n"),
              new Divider(height: 10.0),
              new DropdownButton(
                items: _getDropDownItems(),
                value: permission,
                onChanged: onDropDownChanged,
              ),
              new Divider(height: 10.0),
              new RaisedButton(
                onPressed: checkpermission,
                color: Colors.greenAccent,
                child: new Text("verificar permissão"),
              ),
              new Divider(height: 10.0),
              new RaisedButton(
                onPressed: requestPermission,
                color: Colors.orange,
                child: new Text("requisitar permissao"),
              ),
              new Divider(height: 10.0),
              new RaisedButton(
                onPressed: getstatus,
                color: Colors.blueAccent,
                child: new Text("recuperar o Status"),
              ),
              new Divider(height: 10.0),
              new RaisedButton(
                onPressed: SimplePermissions.openSettings,
                color: Colors.redAccent,
                child: new Text("abrir configuração de permissões"),
              ),
              new Divider(height: 10.0),
              RaisedButton(
                child: Text("Gerar PDF"),
                onPressed: () {
                  print("Gerar PDF");
                  criarPDF(numero);
                  numero++;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDropDownChanged(Permission value) {
    setState(() => this.permission = value);
    print(permission);
  }

  void checkpermission() async {
    bool result = await SimplePermissions.checkPermission(permission);
    print("permission is " + result.toString());
  }

  void requestPermission() async {
    PermissionStatus result = await SimplePermissions.requestPermission(permission);
    print("request :" + result.toString());
  }

  void getstatus() async {
    PermissionStatus result = await SimplePermissions.getPermissionStatus(permission);
    print("permission status is :" + result.toString());
  }

  List<DropdownMenuItem<Permission>> _getDropDownItems() {
    List<DropdownMenuItem<Permission>> items = new List();
    Permission.values.forEach((permission) {
      var item = new DropdownMenuItem(
          child: new Text(getPermissionString(permission)), value: permission);
      items.add(item);
    });
    return items;
  }
}
