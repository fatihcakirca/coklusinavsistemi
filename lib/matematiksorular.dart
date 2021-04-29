//import 'dart:convert';
import 'dart:async';

import 'package:coklusinavsistemi/bitir.dart';
import 'package:flutter/material.dart';

class MatematikSorular extends StatefulWidget {
  @override
  _MatematikSorularState createState() => _MatematikSorularState();
}

String zamaniFormatla(int milisaniye) {
  var saniye = milisaniye ~/ 1000; // ~/ Tam sayı bölme işlemidir
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (saniye % 60).toString().padLeft(2, '0');

  return "$dakika:$saniyeler";
}

class _MatematikSorularState extends State<MatematikSorular> {
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
      'soru': 'a ve b birer doğal sayı, a.b = 36 olduğuna göre a+b en çok kaçtır?',
      'cevaplar': ['12', '18', '37'],
      'dogrucevap': '37'
    },
    {
      'soru': 'x,y,z birer rakam; 91x+9y+z=298 olduğuna göre x+y+z kaçtır?',
      'cevaplar': ['11', '12', '13'],
      'dogrucevap': '12'
    },
    {
      'soru': 'a, b, c farklı rakamlar olmak üzere; 4a-7b+3c ifadesinin değeri en az kaç olabilir? ',
      'cevaplar': ['-59', '-60', '-61'],
      'dogrucevap': '-60'
    },
    {
      'soru': 'Bir sayının 18 ile bölümünden kalan 12 ise 9 ile bölümünden kalan kaçtır?',
      'cevaplar': ['2', '3', '4'],
      'dogrucevap': '3'
    },
    {
      'soru': 'Altı basamaklı m3m24n sayısı 30 ile tam olarak bölünebildiğine göre en büyük m değeri kaçtır?',
      'cevaplar': ['6', '8', '9'],
      'dogrucevap': '9'
    },
    {
      'soru': 'a ve b birer doğal sayı, a.b = 25 olduğuna göre a+b en az kaçtır?',
      'cevaplar': ['8', '10', '12'],
      'dogrucevap': '10'
    },
    {
      'soru': 'Aşağıdakilerden hangisi bir asal sayı değildir?',
      'cevaplar': ['71', '81', '91'],
      'dogrucevap': '81'
    },
    {
      'soru': 'x ve y doğal sayıları için a.b = 10 ise 3a+b nin alabileceği en büyük değeri nedir ? ',
      'cevaplar': ['30', '31', '32'],
      'dogrucevap': '31'
    },
    {
      'soru': 'x ve y doğal sayıları için 3x+5y = 30 ise x in alabileceği kaç farklı değer vardır ?',
      'cevaplar': ['2', '3', '4'],
      'dogrucevap': '3'
    },
    {
      'soru': 'Ardışık 20 tek sayıdan en büyüğü en küçüğünden kaç fazladır?',
      'cevaplar': ['36', '37', '38'],
      'dogrucevap': '38'
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
            Text('Matematik Sınavı', style: TextStyle(fontSize: 60.0)),
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