//import 'dart:convert';
import 'dart:async';

import 'package:coklusinavsistemi/bitir.dart';
import 'package:flutter/material.dart';

class KimyaSorular extends StatefulWidget {
  @override
  _KimyaSorularState createState() => _KimyaSorularState();
}

String zamaniFormatla(int milisaniye) {
  var saniye = milisaniye ~/ 1000; // ~/ Tam sayı bölme işlemidir
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (saniye % 60).toString().padLeft(2, '0');

  return "$dakika:$saniyeler";
}

class _KimyaSorularState extends State<KimyaSorular> {
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
      'soru': 'Aşağıdakilerden hangisi asitlerin özelliklerinden biri değildir?',
      'cevaplar': ['Tadı ekşidir.', 'Fenolftalein çözeltisi ile pembe renk verir.', 'Sulu çözeltisi elektriği iletir.'],
      'dogrucevap': 'Fenolftalein çözeltisi ile pembe renk verir.'
    },
    {
      'soru': 'Aşağıdakilerden hangisi baziktir.?',
      'cevaplar': ['Elma', 'Sirke', 'Sabun'],
      'dogrucevap': 'Sabun'
    },
    {
      'soru': 'Aşağıdakilerden hangisinin sulu çözeltisi elektrik akımını iletmez?',
      'cevaplar': ['Sülfürik asit', 'Şeker', 'Amonyak'],
      'dogrucevap': 'Şeker'
    },
    {
      'soru': 'Aşağıdakilerden hangisi temizlik malzemeleri sınıfına girmez?',
      'cevaplar': ['Reçine', 'Sabun', 'Çamaşır suyu'],
      'dogrucevap': 'Reçine'
    },
    {
      'soru': 'Geleneksel adı nişadır olan bileşiğin sistematik adı hangi seçenekte verilmiştir?',
      'cevaplar': ['Amonyum klorür', 'Amonyum nitrat', 'Amonyak'],
      'dogrucevap': 'Amonyum klorür'
    },
    {
      'soru': 'Aşağıdakilerden hangisi kimyacıların kariyer alanı değildir?',
      'cevaplar': ['Gıda sanayi', 'Hampetrolün çıkarılması', 'Petrol ve doğalgaz'],
      'dogrucevap': 'Hampetrolün çıkarılması'
    },
    {
      'soru': 'Karbon tetraflorür bileşiğinin formülü hangi seçenekte verilmiştir?',
      'cevaplar': ['CH4', 'CF4', 'CCl4'],
      'dogrucevap': 'CF4'
    },
    {
      'soru': 'Kimyacılar hangi işte çalışmazlar?',
      'cevaplar': ['Hampetrolün işlenmesi', 'Asit, baz ve tuz üretimi', 'Yer altından kömürün çıkarılması'],
      'dogrucevap': 'Yer altından kömürün çıkarılması'
    },
    {
      'soru': 'Aşağıdakilerden hangisi çevreyi kirleten ağır metal değildir?',
      'cevaplar': ['Kurşun', 'Altın', 'Cıva'],
      'dogrucevap': 'Altın'
    },
    {
      'soru': 'Aşağıdaki gazlardan hangisi atmosferi kirleten gazlardan değildir?',
      'cevaplar': ['CH4', 'CO', 'O2'],
      'dogrucevap': 'O2'
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
            Text('Kimya Sınavı', style: TextStyle(fontSize: 60.0)),
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