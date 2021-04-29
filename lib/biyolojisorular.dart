//import 'dart:convert';
import 'dart:async';

import 'package:coklusinavsistemi/bitir.dart';
import 'package:flutter/material.dart';

class BiyolojiSorular extends StatefulWidget {
  @override
  _BiyolojiSorularState createState() => _BiyolojiSorularState();
}

String zamaniFormatla(int milisaniye) {
  var saniye = milisaniye ~/ 1000; // ~/ Tam sayı bölme işlemidir
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (saniye % 60).toString().padLeft(2, '0');

  return "$dakika:$saniyeler";
}

class _BiyolojiSorularState extends State<BiyolojiSorular> {
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
      'soru': 'Mitoz bölünme ile ilgili aşağıdaki ifadelerden hangisi doğrudur?',
      'cevaplar': ['Tek hücreli canlılarda büyüme ve gelişmeyi sağlar', 'Haploit kromozomlu hücrelerde gerçekleşmez.', 'Oluşan hücrelerin genetik yapıları aynıdır.'],
      'dogrucevap': 'Oluşan hücrelerin genetik yapıları aynıdır.'
    },
    {
      'soru': 'Hücre döngüsünün interfaz evresinde hangi olay gerçekleşmez?',
      'cevaplar': ['ATP üretimi', 'İğ ipliklerinin sentezlenmesi', 'Protein sentezi'],
      'dogrucevap': 'İğ ipliklerinin sentezlenmesi'
    },
    {
      'soru': 'Mayoz bölünmeye ait aşağıdaki evrelerin hangisindeki hücrede kromozom sayısı bir önceki evrenin iki katı olur?',
      'cevaplar': ['Profaz 2 ', 'Anafaz 2', 'Telofaz 2'],
      'dogrucevap': 'Anafaz 2'
    },
    {
      'soru': 'Aşağıdaki kan gruplarından hangisinin genotipini öğrenmek için kontrol çaprazlaması yapmaya gerek yoktur?',
      'cevaplar': ['ABRh-', 'BRh+', '0Rh+'],
      'dogrucevap': 'ABRh-'
    },
    {
      'soru': 'Aşağıdaki özelliklerden hangisine ait genler gonozomal kromozomlarda bulunmaz?',
      'cevaplar': ['Balık pulluluk', 'Hemofili', 'Göz rengi'],
      'dogrucevap': 'Göz rengi'
    },
    {
      'soru': 'Aşağıdaki ekolojik kavramlardan hangisi diğerlerinin tümünü kapsar?',
      'cevaplar': ['Biyosfer', 'Habitat', 'Ekosistem'],
      'dogrucevap': 'Biyosfer'
    },
    {
      'soru': 'Doğal çevrenin bozulmasında ve kirliliğin oluşmasında aşağıdakilerden hangisi en az etkilidir?',
      'cevaplar': ['Endüstriyel atıklar', 'Besin atıkları', 'Nükleer atıklar'],
      'dogrucevap': 'Besin atıkları'
    },
    {
      'soru': 'Magna Carta hangi ülkenin kralıyla yapılmış bir sözleşmedir?',
      'cevaplar': ['İnsan', 'Koyun', 'Mantar'],
      'dogrucevap': 'Mantar'
    },
    {
      'soru': 'Aşağıdaki organizmalardan hangisi besin piramidinin ikinci trofik düzeyinde bulunmaz?',
      'cevaplar': ['Tilki', 'Tırtıl', 'Tavşan'],
      'dogrucevap': 'Tilki'
    },
    {
      'soru': 'Aşağıdaki ekolojik birimlerden hangisinin kapsamı diğerlerinden daha geniştir?',
      'cevaplar': ['Ekosistem', 'Biyom', 'Habitat'],
      'dogrucevap': 'Biyom'
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
            Text('Biyoloji Sınavı', style: TextStyle(fontSize: 60.0)),
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