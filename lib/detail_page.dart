import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:list_kuliner/http_helper.dart';
import 'package:list_kuliner/styles.dart';
import 'package:list_kuliner/makanan.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailPage extends StatelessWidget {
  final Makanan makanan;

  // final String nama;
  // final String detail;
  // final String deskripsi;
  // final String gambar;
  // final String waktubuka;
  // final String harga;
  // final String kalori;
  // final List<String> gambarlain;
  // final List<Map<String, String>> bahan;

  HttpHelper api = HttpHelper();

  DetailPage({super.key, required this.makanan, required this.api});

  // DetailPage(
  //     {super.key,
  //     required this.nama,
  //     required this.detail,
  //     required this.deskripsi,
  //     required this.gambar,
  //     required this.waktubuka,
  //     required this.harga,
  //     required this.kalori,
  //     required this.gambarlain,
  //     required this.bahan,
  //     required this.api});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: pageBgColor,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Stack(
                children: <Widget>[
                  CarouselSlider(
                      items: makanan.gambarlain
                          .asMap()
                          .entries
                          .map((item) => InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GalleryWidget(
                                              gambarlain: makanan.gambarlain,
                                              index: item.key,
                                            ))),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 3.0, right: 3.0),
                                  child: Hero(
                                    tag: item.value,
                                    child: Image.asset(
                                      item.value,
                                      scale: 0.5,
                                      fit: BoxFit.cover,
                                      width: 1000.0,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                      options:
                          CarouselOptions(height: 250, viewportFraction: 0.9)),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Text(
                  makanan.nama,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: [
                        const Icon(Icons.access_time_filled,
                            color: Color.fromARGB(255, 255, 230, 0)),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          makanan.waktubuka,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          makanan.kalori,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.monetization_on, color: Colors.green),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          makanan.harga,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  makanan.deskripsi,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Bahan Racikan',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Column(
                            children: [
                              Image.asset(makanan.bahan[index].values.first,
                                  width: 52),
                              Text(makanan.bahan[index].keys.first),
                            ],
                          ),
                        ),
                    separatorBuilder: (_, index) => const SizedBox(
                          width: 15,
                        ),
                    itemCount: makanan.bahan.length),
              ),
              const SizedBox(
                height: 50,
              )
            ])));
  }
}

class GalleryWidget extends StatefulWidget {
  final List gambarlain;
  final int index;
  final PageController pageController;
  GalleryWidget({super.key, required this.gambarlain, required this.index})
      : pageController = PageController(initialPage: index);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late int currentIndex = widget.index;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          PhotoViewGallery.builder(
            itemCount: widget.gambarlain.length,
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(widget.gambarlain[index]),
                  initialScale: PhotoViewComputedScale.contained * 1.0,
                  minScale: PhotoViewComputedScale.contained * 1.0,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: widget.gambarlain[index]));
            },
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: widget.pageController,
            onPageChanged: onPageChanged,
            scrollDirection: Axis.horizontal,
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              '${currentIndex + 1} / ${widget.gambarlain.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                decoration: null,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
