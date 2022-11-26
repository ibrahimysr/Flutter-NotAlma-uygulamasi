import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:not_alma_uygulamasi/main.dart';
import 'package:not_alma_uygulamasi/notlardao.dart';

import 'Notlar.dart';

class NotDetay extends StatefulWidget {
  late notlar Not;

  NotDetay(this.Not);

  @override
  State<NotDetay> createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  var tfNotbaslik = TextEditingController();
  var tfNotDetay = TextEditingController();
  var tfNotTarih = TextEditingController();

  Future<void> sil() async {
    await notlardao().Notsil(widget.Not.not_id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AnaSayfa()));
  }

  Future<void> guncelle() async {
    await notlardao().NotGuncelle(
        widget.Not.not_id, tfNotbaslik.text, tfNotDetay.text, tfNotTarih.text);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AnaSayfa()));
  }

  @override
  void initState() {
    tfNotbaslik.text = widget.Not.not_baslik;
    tfNotDetay.text = widget.Not.not_detay;
    tfNotTarih.text = widget.Not.not_tarih;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay Sayfası"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            child: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text("Sil", style: TextStyle(color: Colors.red)),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text("Güncelle", style: TextStyle(color: Colors.blue)),
              ),
            ],
            onSelected: (menuItemValue) {
              if (menuItemValue == 1) {
                sil();
              }
              if (menuItemValue == 2) {
                guncelle();
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 40, left: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfNotbaslik,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: "Başlık Giriniz", icon: Icon(Icons.subtitles)),
              ),
              TextField(
                controller: tfNotDetay,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: "Detay Giriniz",
                    icon: Icon(Icons.edit_note_outlined)),
              ),
              TextField(
                controller: tfNotTarih,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: "Tarih Giriniz", icon: Icon(Icons.date_range)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
