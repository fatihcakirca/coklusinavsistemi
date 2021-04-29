import 'package:coklusinavsistemi/hata.dart';
import 'package:coklusinavsistemi/turkcesorular.dart';
import 'package:coklusinavsistemi/matematiksorular.dart';
import 'package:coklusinavsistemi/geometrisorular.dart';
import 'package:coklusinavsistemi/fiziksorular.dart';
import 'package:coklusinavsistemi/kimyasorular.dart';
import 'package:coklusinavsistemi/biyolojisorular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coklusinavsistemi/bitir.dart';
import 'package:coklusinavsistemi/hakkinda.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'coklusinavsistemi',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/turkcesorular': (context) => TurkceSorular(),
        '/matematiksorular': (context) => MatematikSorular(),
        '/geometrisorular': (context) => GeometriSorular(),
        '/fiziksorular': (context) => FizikSorular(),
        '/kimyasorular': (context) => KimyaSorular(),
        '/biyolojisorular': (context) => BiyolojiSorular(),
        '/bitir': (context) => Bitir(),
        '/hakkinda': (context) => Hakkinda(),
        '/hata': (context) => Hata(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String adSoyad = '';

  void kontrol1() {
    if (adSoyad.length > 0) {
      var data = [];
      data.add(adSoyad);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TurkceSorular(),
            settings: RouteSettings(
              arguments: data,
            ),
          ));
    } else {
      Navigator.pushNamed(context, '/hata');
    }
  }

  void kontrol2() {
    if (adSoyad.length > 0) {
      var data = [];
      data.add(adSoyad);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MatematikSorular(),
            settings: RouteSettings(
              arguments: data,
            ),
          ));
    } else {
      Navigator.pushNamed(context, '/hata');
    }
  }

  void kontrol3() {
    if (adSoyad.length > 0) {
      var data = [];
      data.add(adSoyad);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GeometriSorular(),
            settings: RouteSettings(
              arguments: data,
            ),
          ));
    } else {
      Navigator.pushNamed(context, '/hata');
    }
  }

  void kontrol4() {
    if (adSoyad.length > 0) {
      var data = [];
      data.add(adSoyad);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FizikSorular(),
            settings: RouteSettings(
              arguments: data,
            ),
          ));
    } else {
      Navigator.pushNamed(context, '/hata');
    }
  }

  void kontrol5() {
    if (adSoyad.length > 0) {
      var data = [];
      data.add(adSoyad);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KimyaSorular(),
            settings: RouteSettings(
              arguments: data,
            ),
          ));
    } else {
      Navigator.pushNamed(context, '/hata');
    }
  }

  void kontrol6() {
    if (adSoyad.length > 0) {
      var data = [];
      data.add(adSoyad);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BiyolojiSorular(),
            settings: RouteSettings(
              arguments: data,
            ),
          ));
    } else {
      Navigator.pushNamed(context, '/hata');
    }
  }

  void _adSoyadKaydet(String text) {
    setState(() {
      adSoyad = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool butonpasif = true;
    if (adSoyad.length > 0) {
      butonpasif = false;
    } else {
      butonpasif = true;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Çoklu Sınav Sistemi', style: TextStyle(fontSize: 60.0)),
            Text('Adınız ve Soyadınız:',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Adınızı ve Soyadınızı giriniz',
                  ),
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  onChanged: (text) {
                    _adSoyadKaydet(text);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: butonpasif ? null : kontrol1,
                //onPressed: kontrol,
                child: Text('Türkçe Sınavına Başla'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: butonpasif ? null : kontrol2,
                //onPressed: kontrol,
                child: Text('Matematik Sınavına Başla'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: butonpasif ? null : kontrol3,
                //onPressed: kontrol,
                child: Text('Geometri Sınavına Başla'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: butonpasif ? null : kontrol4,
                //onPressed: kontrol,
                child: Text('Fizik Sınavına Başla'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: butonpasif ? null : kontrol5,
                //onPressed: kontrol,
                child: Text('Kimya Sınavına Başla'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: butonpasif ? null : kontrol6,
                //onPressed: kontrol,
                child: Text('Biyoloji Sınavına Başla'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Hakkinda()),
                  );
                },
                child: Text('Hakkında'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}