import 'package:flutter/material.dart';
import 'package:tiffany_cat/cat_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Cat Api'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  CatApi _catApi = CatApi();

  @override
  void initState() {
    super.initState();
    _catApi.updateImage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children:[
          _catApi.getImage(),
          Center(
            child: GestureDetector(
              onTap: (){
                setState(() {
                _catApi.updateImage();
                _catApi.showSpinner = true;
                });
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), 
                  color: Colors.amber
                  ),
                child: Visibility(
                  visible: _catApi.showSpinner,
                  child: CircularProgressIndicator(
                    valueColor:AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                  replacement: Container(),
                )
              ),

            ),
          )
        ]),
    );
  }
}
