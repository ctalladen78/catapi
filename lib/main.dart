import 'package:flutter/material.dart';
import 'package:tiffany_cat/cat_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  await dotenv.load(fileName: '.env');
  String _uriGif = dotenv.env["URI_GIF"].toString();
  String _uriStatic = dotenv.env["URI_STATIC"].toString();
  CatApi catApi = CatApi(_uriGif, _uriStatic);
  runApp(MyApp(catApi));
}

class MyApp extends StatelessWidget {
  String _title = "Cat Api";
  CatApi catApi;
  MyApp(this.catApi);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(_title, this.catApi),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CatApi catApi;
  final String title;
  MyHomePage(this.title, this.catApi, {Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    widget.catApi.updateImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children:[
          widget.catApi.getImage(),
          Center(
            child: GestureDetector(
              onTap: (){
                setState(() {
                widget.catApi.updateImage();
                widget.catApi.showSpinner = true;
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
                  visible: widget.catApi.showSpinner,
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
