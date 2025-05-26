import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKalkulator());
}

class AplikasiKalkulator extends StatelessWidget {
  const AplikasiKalkulator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Sederhana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HalamanUtamaKalkulator(),
    );
  }
}

class HalamanUtamaKalkulator extends StatefulWidget {
  const HalamanUtamaKalkulator({Key? key}) : super(key: key);

  @override
  State<HalamanUtamaKalkulator> createState() => _StateHalamanUtamaKalkulator();
}

class _StateHalamanUtamaKalkulator extends State<HalamanUtamaKalkulator> {
  String _hasilTampilan = "0"; // Output yang ditampilkan di layar kalkulator
  String _angkaSaatIni = ""; // Angka yang sedang diketik pengguna
  double _angkaPertama = 0.0; // Angka pertama dalam operasi
  double _angkaKedua = 0.0; // Angka kedua dalam operasi
  String _operatorAktif = ""; // Operator yang dipilih (+, -, x, /)
  bool _bersihkanTampilan = false; // Penanda apakah tampilan harus dibersihkan untuk angka baru
  String _tampilanOperator = ""; // Operator yang ditampilkan di layar

  void tombolDitekan(String teksTombol) {
    if (teksTombol == "CLEAR") {
      _hasilTampilan = "0";
      _angkaSaatIni = "";
      _angkaPertama = 0.0;
      _angkaKedua = 0.0;
      _operatorAktif = "";
      _bersihkanTampilan = false;
      _tampilanOperator = ""; // Reset tampilan operator
    } else if (teksTombol == "+" ||
        teksTombol == "-" ||
        teksTombol == "x" ||
        teksTombol == "/") {
      if (_angkaSaatIni.isNotEmpty) {
        _angkaPertama = double.parse(_angkaSaatIni);
      }
      _operatorAktif = teksTombol;
      _angkaSaatIni = "";
      _bersihkanTampilan = true;
      _tampilanOperator = teksTombol; // Set tampilan operator
    } else if (teksTombol == ".") {
      if (_angkaSaatIni.contains(".")) {
        return; // Jangan tambahkan titik jika sudah ada
      }
      _angkaSaatIni = _angkaSaatIni + teksTombol;
    } else if (teksTombol == "=") {
      if (_angkaSaatIni.isNotEmpty) {
        _angkaKedua = double.parse(_angkaSaatIni);
      }

      if (_operatorAktif == "+") {
        _hasilTampilan = (_angkaPertama + _angkaKedua).toString();
      }
      if (_operatorAktif == "-") {
        _hasilTampilan = (_angkaPertama - _angkaKedua).toString();
      }
      if (_operatorAktif == "x") {
        _hasilTampilan = (_angkaPertama * _angkaKedua).toString();
      }
      if (_operatorAktif == "/") {
        if (_angkaKedua != 0) {
          _hasilTampilan = (_angkaPertama / _angkaKedua).toString();
        } else {
          _hasilTampilan = "Error"; // Pembagian dengan nol
        }
      }

      _angkaPertama = 0.0;
      _angkaKedua = 0.0;
      _operatorAktif = "";
      _angkaSaatIni = _hasilTampilan; // Hasil menjadi angka pertama untuk perhitungan selanjutnya
      _bersihkanTampilan = true;
      _tampilanOperator = ""; // Reset tampilan operator setelah perhitungan
    } else {
      if (_bersihkanTampilan) {
        _angkaSaatIni = "";
        _bersihkanTampilan = false;
      }
      _angkaSaatIni = _angkaSaatIni + teksTombol;
      _hasilTampilan = _angkaSaatIni;
      _tampilanOperator = ""; // Hapus tampilan operator saat angka baru ditekan
    }

    setState(() {
      if (_hasilTampilan.endsWith(".0")) {
        _hasilTampilan = _hasilTampilan.substring(0, _hasilTampilan.length - 2); // Hapus .0 jika ada
      }
    });
  }

  Widget buatTombol(String teksTombol, Color warnaTombol, Color warnaTeks) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: warnaTombol,
            padding: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            teksTombol,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: warnaTeks,
            ),
          ),
          onPressed: () => tombolDitekan(teksTombol),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator Sederhana"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Tampilan operator aktif
                Text(
                  _tampilanOperator,
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey,
                  ),
                ),
                // Tampilan output utama
                Text(
                  _hasilTampilan,
                  style: const TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buatTombol("7", Colors.grey[850]!, Colors.white),
                  buatTombol("8", Colors.grey[850]!, Colors.white),
                  buatTombol("9", Colors.grey[850]!, Colors.white),
                  buatTombol("/", Colors.orange, Colors.white),
                ],
              ),
              Row(
                children: <Widget>[
                  buatTombol("4", Colors.grey[850]!, Colors.white),
                  buatTombol("5", Colors.grey[850]!, Colors.white),
                  buatTombol("6", Colors.grey[850]!, Colors.white),
                  buatTombol("x", Colors.orange, Colors.white),
                ],
              ),
              Row(
                children: <Widget>[
                  buatTombol("1", Colors.grey[850]!, Colors.white),
                  buatTombol("2", Colors.grey[850]!, Colors.white),
                  buatTombol("3", Colors.grey[850]!, Colors.white),
                  buatTombol("-", Colors.orange, Colors.white),
                ],
              ),
              Row(
                children: <Widget>[
                  buatTombol(".", Colors.grey[850]!, Colors.white),
                  buatTombol("0", Colors.grey[850]!, Colors.white),
                  buatTombol("00", Colors.grey[850]!, Colors.white),
                  buatTombol("+", Colors.orange, Colors.white),
                ],
              ),
              Row(
                children: <Widget>[
                  buatTombol("CLEAR", Colors.redAccent, Colors.white),
                  buatTombol("=", Colors.green, Colors.white),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}