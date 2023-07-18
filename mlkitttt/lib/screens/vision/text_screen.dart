import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mlkitttt/services/image_service.dart';

class TextScreen extends StatefulWidget{
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  late TextRecognizer _textRecognizer;
  late String _text;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    _text = '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _textAppBar(),
      body: _textBody(context),
    );
  }

  AppBar _textAppBar(){
    return AppBar(
      title: const Text("Text Recognition"),
      actions: [
        IconButton(
          onPressed: ()async{
            await ImageService.takeImage().then((value){
              if(value != null){
                _processImage(value);
              }
            });
          },
          icon: const Icon(Icons.image),
        )
      ],
    );
  }

  Widget _textBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
        child: Text(
          _text,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage)async{
    final recognizedText = await _textRecognizer.processImage(inputImage);
    setState(() {
      _text = recognizedText.text;
    });
  }
}