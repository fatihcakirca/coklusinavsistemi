//import 'dart:convert';
import 'dart:async';

import 'package:coklusinavsistemi/bitir.dart';
import 'package:flutter/material.dart';

class FizikSorular extends StatefulWidget {
  @override
  _FizikSorularState createState() => _FizikSorularState();
}

String zamaniFormatla(int milisaniye) {
  var saniye = milisaniye ~/ 1000; // ~/ Tam sayı bölme işlemidir
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (saniye % 60).toString().padLeft(2, '0');

  return "$dakika:$saniyeler";
}

class _FizikSorularState extends State<FizikSorular> {
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
      'soru': 'Aşağıdaki dalgalardan hangisi boyuna yayılan mekanik dalgadır?',
      'cevaplar': ['Ses dalgaları', 'Su dalgaları', 'Yay dalgaları'],
      'dogrucevap': 'Ses dalgaları'
    },
    {
      'soru': 'Aşağıdakilerden hangisi fizik biliminin ilgi alanına girmez?',
      'cevaplar': ['Yanma olayı', 'Dünyanın manyetik alanı', 'Yüksek hızlı trenler'],
      'dogrucevap': 'Yanma olayı'
    },
    {
      'soru': 'Küresel ısınma, buzulların erimesi, iklimlendirme konuları fizik biliminin hangi alt alanı ile ilgilidir?',
      'cevaplar': ['Termodinamik', 'Optik', 'Katıhal Fiziği'],
      'dogrucevap': 'Katıhal Fiziği'
    },
    {
      'soru': 'Yıldırım ve şimşek olayını fiziğin alt alanlarından hangisi inceler?',
      'cevaplar': ['Optik', 'Elektrik', 'Mekanik'],
      'dogrucevap': 'Elektrik'
    },
    {
      'soru': 'Bir okuldaki ısınma problemini çözmek isteyen biri temelde fiziğin hangi alt dalıyla ilgili çalışma yapmalıdır?',
      'cevaplar': ['Optik', 'Nükleer Fizik', 'Termodinamik'],
      'dogrucevap': 'Termodinamik'
    },
    {
      'soru': 'Aşağıdakilerden hangisi SI birim sisteminde kullanılan bir birim değildir?',
      'cevaplar': ['Metre', 'Gram', 'Saniye'],
      'dogrucevap': 'Gram'
    },
    {
      'soru': 'Tıp bilimi olan Radyolojide, kemiklerimizin filmi çekilirken fiziğin hangi alt alanı kullanılmaktadır?',
      'cevaplar': ['Nükleer Fizik', 'Gezegen hareketlerinin gözlenmesi', 'Barajlarda kurulan santrallerden elektrik elde edilmesi'],
      'dogrucevap': 'Nükleer Fizik'
    },
    {
      'soru': 'Fizik bilimi aşağıdaki bilim dallarından hangisine doğrudan katkıda bulunmaz?',
      'cevaplar': ['Biyoloji', 'Astronomi', 'Psikoloji'],
      'dogrucevap': 'Psikoloji'
    },
    {
      'soru': 'Verilen durumlardan hangisi nükleer fiziğin incelediği konular arasındadır?',
      'cevaplar': ['Hidrojen atomunun helyuma dönüşmesi', 'Lazer ile ince kesimlerin hassas yapılabilmesi', 'Atomlarda elektron dizilimi'],
      'dogrucevap': 'Hidrojen atomunun helyuma dönüşmesi'
    },
    {
      'soru': 'Aşağıdaki birimlerden hangisi fizik bilimine göre temel bir büyüklüğe aittir?',
      'cevaplar': ['Litre', 'Newton', 'Amper'],
      'dogrucevap': 'Amper'
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
            Text('Fizik Sınavı', style: TextStyle(fontSize: 60.0)),
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