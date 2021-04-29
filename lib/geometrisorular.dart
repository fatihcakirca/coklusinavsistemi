//import 'dart:convert';
import 'dart:async';

import 'package:coklusinavsistemi/bitir.dart';
import 'package:flutter/material.dart';

class GeometriSorular extends StatefulWidget {
  @override
  _GeometriSorularState createState() => _GeometriSorularState();
}

String zamaniFormatla(int milisaniye) {
  var saniye = milisaniye ~/ 1000; // ~/ Tam sayı bölme işlemidir
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (saniye % 60).toString().padLeft(2, '0');

  return "$dakika:$saniyeler";
}

class _GeometriSorularState extends State<GeometriSorular> {
  String adSoyad = '';

  int mevcutsoru = 0;
  String mevcutcevap = '';
  int puan = 0;
  int kullanilansure = 0;

  Stopwatch _sayac;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _sayac = Stopwatch();
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {});
    });
    mevcutsoru = 0;
    mevcutcevap = '';
    puan = 0;
    kullanilansure = 0;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void BitireYolla(){
    var data = [];
    data.add(adSoyad);
    data.add(puan.toString());
    data.add(zamaniFormatla(kullanilansure));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Bitir(),
          settings: RouteSettings(
            arguments: data,
          ),
        ));
  }

  var sorular = [
    {
      'soru': 'Üçgenin dış açıları toplamı kaç derecedir?',
      'cevaplar': ['90', '180', '360'],
      'dogrucevap': '360'
    },
    {
      'soru': 'İki kenar uzunluğu 5 ve 7 cm olan bir üçgenin alabileceği en küçük ve en büyük tam sayı değerleri toplamı kaçtır?',
      'cevaplar': ['11', '12', '14'],
      'dogrucevap': '14'
    },
    {
      'soru': 'Beşgenin iç açılarından birinin ölçüsü kaç derecedir?',
      'cevaplar': ['105', '107', '108'],
      'dogrucevap': '108'
    },
    {
      'soru': 'Tümler iki açıdan biri diğerinin 4 katından 5 eksik olduğuna göre bu açılardan küçüğü kaç derecedir?',
      'cevaplar': ['15', '17', '19'],
      'dogrucevap': '19'
    },
    {
      'soru': 'Tümler iki açıdan biri diğerinin 4 katından 5 eksik olduğuna göre bu açılardan büyüğü kaç derecedir?',
      'cevaplar': ['70', '71', '72'],
      'dogrucevap': '71'
    },
    {
      'soru': 'Üçgenin iç açıları toplamı kaç derecedir?',
      'cevaplar': ['90', '180', '360'],
      'dogrucevap': '180'
    },
    {
      'soru': 'Bir küpün kaç köşesi vardır?',
      'cevaplar': ['4', '6', '8'],
      'dogrucevap': '8'
    },
    {
      'soru': 'Bir kare piramitin kaç köşesi vardır?',
      'cevaplar': ['5', '4', '3'],
      'dogrucevap': '5'
    },
    {'soru': 'Bütünler iki açıdan birinin ölçüsü diğerinin ölçüsünün 1/7 sinden 12 fazla ise açılardan büyüğü kaç derecedir?',
      'cevaplar': ['145', '146', '147'],
      'dogrucevap': '147'
    },
    {
      'soru': 'Bütünler iki açıdan birinin ölçüsü diğerinin ölçüsünün 1/7 sinden 12 fazla ise açılardan küçüğü kaç derecedir??',
      'cevaplar': ['33', '34', '35'],
      'dogrucevap': '33'
    },
  ];

  void kontrolEt() {
    if (mevcutsoru > 8) {
      mevcutsoru = 0;
      _timer.cancel();
      BitireYolla();
    } else {
      if (mevcutcevap == sorular[mevcutsoru]['dogrucevap']) {
        puan = puan + 10;
        mevcutsoru++;
        kullanilansure = kullanilansure + _sayac.elapsedMilliseconds;
        _sayac.reset();
      } else {
        puan = puan + 0;
        mevcutsoru++;
        kullanilansure = kullanilansure + _sayac.elapsedMilliseconds;
        _sayac.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = [];
    data = ModalRoute.of(context).settings.arguments;
    adSoyad = data[0];

    _sayac.start();
    if (_sayac.elapsedMilliseconds > 14999 && mevcutsoru < 9) {
      kullanilansure = kullanilansure + _sayac.elapsedMilliseconds;
      _sayac.reset(); // 15 saniyede cevap verilmezse diğer soruya geçiyor
      mevcutsoru++;
    }

    if (mevcutsoru == 9 && _sayac.elapsedMilliseconds > 14999) {
      Future.delayed(Duration.zero, () async {
        _sayac.reset(); // Sıfırlama
        _sayac.stop(); // Bitiş ekranına geldik artık
        _timer.cancel(); // Yeni ekrana geçtiğinde saymayı bitirsin
        mevcutsoru = 0;
        BitireYolla();
      });
    }

    List cevaplistesi = [];
    for (var u in sorular[mevcutsoru]['cevaplar']) {
      cevaplistesi.add(u);
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Geometri Sınavı', style: TextStyle(fontSize: 60.0)),
            Text('Ad-Soyad: ' + adSoyad, style: TextStyle(fontSize: 24.0)),
            Text(
              'Mevcut Soru /Toplam Soru: ' +
                  mevcutsoru.toString() +
                  ' / ' +
                  sorular.length.toString(),
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Puan: ' + puan.toString(),
              style: TextStyle(fontSize: 16),
            ),
            Text(
              sorular[mevcutsoru]['soru'].toString(),
              style: TextStyle(fontSize: 32),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    mevcutcevap = cevaplistesi[0].toString();
                  });
                  kontrolEt();
                },
                child: Text(
                  cevaplistesi[0],
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    mevcutcevap = cevaplistesi[1].toString();
                  });
                  kontrolEt();
                },
                child: Text(
                  cevaplistesi[1],
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    mevcutcevap = cevaplistesi[2].toString();
                  });
                  kontrolEt();
                },
                child: Text(
                  cevaplistesi[2],
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Text(zamaniFormatla(_sayac.elapsedMilliseconds),
                style: TextStyle(fontSize: 48.0)),
            Text('Kullanılan Süre: ' + zamaniFormatla(kullanilansure),
                style: TextStyle(fontSize: 48.0)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text('Anasayfaya Dön'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}