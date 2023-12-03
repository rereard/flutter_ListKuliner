import 'package:flutter/material.dart';
import 'package:list_kuliner/detail_page.dart';
import 'package:list_kuliner/makanan.dart';
import 'package:list_kuliner/http_helper.dart';

class ListItem extends StatelessWidget {
  HttpHelper api = HttpHelper();
  final Makanan makanan;

  ListItem({super.key, required this.makanan, required this.api});
  // final String nama;
  // final String detail;
  // final String deskripsi;
  // final String gambar;
  // final String waktubuka;
  // final String harga;
  // final String kalori;
  // final List<String> gambarlain;
  // final List<Map<String, String>> bahan;
  // const ListItem(
  //     {super.key,
  //     required this.nama,
  //     required this.detail,
  //     required this.deskripsi,
  //     required this.gambar,
  //     required this.waktubuka,
  //     required this.harga,
  //     required this.kalori,
  //     required this.gambarlain,
  //     required this.bahan});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    makanan: makanan,
                    api: api,
                  ))),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 178, 178, 178),
              offset: Offset(1.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        height: 100,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                api.url + makanan.gambarlain[0],
                height: 75,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  makanan.nama,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  makanan.deskripsi,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Text(
                  makanan.harga,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
