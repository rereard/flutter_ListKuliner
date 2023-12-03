import 'package:flutter/material.dart';
import 'package:list_kuliner/list_item.dart';
import 'package:list_kuliner/makanan.dart';
import 'package:list_kuliner/styles.dart';
import 'package:list_kuliner/http_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// import 'package:list_kuliner/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpHelper api = HttpHelper();
  Future<List<Makanan>> fetchmakanan() async {
    final response = await api.getAPI();

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((makanan) => new Makanan.fromJson(makanan))
          .toList();
    } else {
      throw Exception();
    }
  }

  late Future<List<Makanan>> futuremakanan;

  @override
  void initState() {
    super.initState();
    futuremakanan = fetchmakanan();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Makanan>>(
        future: futuremakanan,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                var makanan = (snapshot.data as List<Makanan>)[index];
                return ListItem(makanan: makanan, api: api);
              },
              itemCount: (snapshot.data as List<Makanan>).length,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
    // return Column(
    //   children: [
    //     const SizedBox(height: 20),
    //     const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    //       Icon(Icons.list_alt_sharp, size: 30),
    //       SizedBox(width: 10),
    //       Text('List Kuliner', style: textHeader1),
    //     ]),
    //     Expanded(
    //       child: ListView.builder(
    //         // shrinkWrap: true,
    //         itemCount: listMakanan.length,
    //         padding: const EdgeInsets.all(10),
    //         itemBuilder: (context, index) {
    //           return ListItem(
    //             nama: listMakanan[index].nama,
    //             deskripsi: listMakanan[index].deskripsi,
    //             gambar: listMakanan[index].gambar,
    //             detail: listMakanan[index].detail,
    //             waktubuka: listMakanan[index].waktubuka,
    //             harga: listMakanan[index].harga,
    //             kalori: listMakanan[index].kalori,
    //             gambarlain: listMakanan[index].gambarlain,
    //             bahan: listMakanan[index].bahan,
    //           );
    //         },
    //       ),
    //     )
    //   ],
    // );
  }
}
