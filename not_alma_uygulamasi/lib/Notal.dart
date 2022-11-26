import 'package:flutter/material.dart';
import 'package:not_alma_uygulamasi/main.dart';
import 'package:not_alma_uygulamasi/notlardao.dart';

class NotAl extends StatefulWidget {
  const NotAl({Key? key}) : super(key: key);

  @override
  State<NotAl> createState() => _NotAlState();
}

class _NotAlState extends State<NotAl> {
  var tfNotbaslik = TextEditingController();
  var tfNotDetay = TextEditingController();
  var tfNotTarih = TextEditingController();

  Future<void> ekle() async {
    await notlardao()
        .Notekle(tfNotbaslik.text, tfNotDetay.text, tfNotTarih.text);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AnaSayfa()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Al"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfNotbaslik,
                decoration:const  InputDecoration(hintText: "Başlık Giriniz"),
              ),
              TextField(
                controller: tfNotDetay,
                decoration:const  InputDecoration(hintText: "Detay Giriniz"),
              ),
              TextField(
                controller: tfNotTarih,
                decoration:const  InputDecoration(hintText: "Tarih Giriniz"),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ekle();
        },
        tooltip: 'Not Al',
        label: const Text("Kayıt et"),
        icon:const  Icon(Icons.save),
      ),
    );
  }
}
