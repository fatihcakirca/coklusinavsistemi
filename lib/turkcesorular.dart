//import 'dart:convert';
import 'dart:async';

import 'package:coklusinavsistemi/bitir.dart';
import 'package:flutter/material.dart';

class TurkceSorular extends StatefulWidget {
  @override
  _TurkceSorularState createState() => _TurkceSorularState();
}

String zamaniFormatla(int milisaniye) {
  var saniye = milisaniye ~/ 1000; // ~/ Tam sayı bölme işlemidir
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (saniye % 60).toString().padLeft(2, '0');

  return "$dakika:$saniyeler";
}

class _TurkceSorularState extends State<TurkceSorular> {
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
      'soru': 'Aşağıdakilerin hangisinde karşıt kavramlar bir arada kullanılmamıştır?',
      'cevaplar': ['Dost başa, düşman ayağa', 'Gündüz hayallerim, gece düşlerim', 'Hayat uzun, ince bir yoldur.'],
      'dogrucevap': 'Hayat uzun, ince bir yoldur.'
    },
    {
      'soru': 'Aşağıdaki cümlelerin hangisinde mektup sözcüğü genel anlamlı kullanılmıştır?',
      'cevaplar': ['Bu mektup iki hafta önce geldi.', 'Mektup, önemli bir haberleşme aracıdır.', 'Arkadaşın gönderdiği mektupu okumadım.'],
      'dogrucevap': 'Mektup, önemli bir haberleşme aracıdır.'
    },
    {
      'soru': 'Aşağıdaki cümlelerin hangisinde ad aktarmasına örnek yoktur?',
      'cevaplar': ['Ünlü kalemler, bu gazetede bir araya geldi.', 'Okul müdürü, öğrencilere türlü sorunlardan bahsetti.', 'Arkadaş, eve haber vermeden buraya geldi.'],
      'dogrucevap': 'Okul müdürü, öğrencilere türlü sorunlardan bahsetti.'
    },
    {
      'soru': 'Aşağıdaki cümlelerin hangisinde “darılmak, gücenmek” anlamında bir deyim kullanılmıştır?',
      'cevaplar': ['Bu kadarcık söz yüzünden bana gönül koyacağını nereden bilebilirdim?', 'Ne o, yüzünden düşen bir parça, kime kızdın yine', 'Onu kızdırmaya gelmez, ağzına geleni sayar, rezil eder bizi'],
      'dogrucevap': 'Bu kadarcık söz yüzünden bana gönül koyacağını nereden bilebilirdim?'
    },
    {
      'soru': '“Tutmak” sözcüğü aşağıdaki cümlelerin hangisinde mecaz anlamda kullanılmamıştır?',
      'cevaplar': ['İki erik yedim; midem tuttu yine.', 'Bu moda tutmadığı için eskiye dönüldü', 'Küçüğü havalara fırlatır, fırlatır, tutardı.'],
      'dogrucevap': 'Küçüğü havalara fırlatır, fırlatır, tutardı.'
    },
    {
      'soru': 'Aşağıdaki cümlelerin hangisinde soru zamiri vardır?',
      'cevaplar': ['Arkadaşın buraya ne zaman gelmiş?', 'Bu tabağı buraya kim koymuş olabilir?', 'Ben de onunla gidebilir miyim?'],
      'dogrucevap': 'Arkadaşın buraya ne zaman gelmiş?'
    },
    {
      'soru': 'Aşağıdaki cümlelerin hangisinde soru anlamı bir zamirle sağlanmıştır?',
      'cevaplar': ['Bunca sıkıntıya neden katlandınız?', 'Bu çiçeklere kaç para verdiniz?', 'Bu romanı kim okumak ister?'],
      'dogrucevap': 'Bu romanı kim okumak ister?'
    },
    {
      'soru': 'Aşağıdaki cümlelerin hangisinde soru anlamı bir sıfatla sağlanmıştır?',
      'cevaplar': ['Cumhuriyet edebiyatını hangi dönemlere ayırarak incelemek gerekir', 'Vitrindeki kıyafetlerden hangisini beğendiniz?', 'Basın toplantısı kim tarafından yapıldı?'],
      'dogrucevap': 'Cumhuriyet edebiyatını hangi dönemlere ayırarak incelemek gerekir?'
    },
    {
      'soru': 'Aşağıdaki tamlamalardan hangisi sıfat tamlamasıdır?',
      'cevaplar': ['Yuvarlak masa', 'Kapı Kolu', 'Masanın ayağı'],
      'dogrucevap': 'Yuvarlak masa'
    },
    {
      'soru': 'Aşağıdaki kelimelerden hangisinin yazımı doğrudur?',
      'cevaplar': ['Yanlız', 'Kibrit', 'Şöför'],
      'dogrucevap': 'Kibrit'
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
            Text('Türkçe Sınavı', style: TextStyle(fontSize: 60.0)),
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