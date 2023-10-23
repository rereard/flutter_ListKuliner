import 'package:flutter/material.dart';
import 'package:list_kuliner/list_item.dart';
import 'package:list_kuliner/makanan.dart';
import 'package:list_kuliner/styles.dart';
// import 'package:list_kuliner/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.list_alt_sharp, size: 30),
          SizedBox(width: 10),
          Text('List Kuliner', style: textHeader1),
        ]),
        Expanded(
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: listMakanan.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ListItem(
                nama: listMakanan[index].nama,
                deskripsi: listMakanan[index].deskripsi,
                gambar: listMakanan[index].gambar,
                detail: listMakanan[index].detail,
                waktubuka: listMakanan[index].waktubuka,
                harga: listMakanan[index].harga,
                kalori: listMakanan[index].kalori,
                gambarlain: listMakanan[index].gambarlain,
                bahan: listMakanan[index].bahan,
              );
            },
          ),
        )
      ],
    );
  }
}
