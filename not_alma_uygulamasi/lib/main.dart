import 'package:flutter/material.dart';
import 'package:not_alma_uygulamasi/Notal.dart';
import 'package:not_alma_uygulamasi/Notdetay.dart';
import 'package:not_alma_uygulamasi/notlardao.dart';

import 'Notlar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  Future<List<notlar>> Tumnotlar() async {
    var Notlist = await notlardao().TumNotlar();

    return Notlist;
  }

  Future<void> sil(int not_id) async {
    await notlardao().Notsil(not_id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AnaSayfa()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Sayfa"),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
      ),
      body: FutureBuilder<List<notlar>>(
          future: Tumnotlar(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var Notlist = snapshot.data;
              return ListView.builder(
                  itemCount: Notlist!.length,
                  itemBuilder: (context, indeks) {
                    var Not = Notlist[indeks];

                    return ListTile(
                      title: Text(
                        Not.not_baslik,
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(Not.not_tarih),
                      leading:
                         const Icon(Icons.edit_note_outlined, color: Colors.black),
                      trailing: PopupMenuButton(
                        child: const Icon(Icons.open_in_new),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 1,
                            child: Text(
                              "Sil",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            child: Text(
                              "Güncelle",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                        onCanceled: () {
                          print("Seçim yapılmadı");
                        },
                        onSelected: (MenuItemValue) {
                          if (MenuItemValue == 1) {
                            sil(Not.not_id);
                          } else if (MenuItemValue == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotDetay(Not)));
                          }
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotDetay(Not)));
                      },
                    );
                  });
            } else {
              return const Center();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NotAl()));
        },
        tooltip: 'Not Al',
        child: const Icon(Icons.add),
      ),
    );
  }
}
