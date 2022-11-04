import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie_app/media_list.dart';
import 'package:movie_app/common/MediaProvider.dart';
import 'package:movie_app/model/Media.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  final MediaProvider movieProvider = new MoviesProvider();
  final MediaProvider serieProvider = new SeriesProvider();
  PageController? _pageController;
  int _page = 0;
  MediaType mediaType = MediaType.movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Cueva de Ana UTXJ 191004",
          style: TextStyle(fontFamily: "Oswald"),
        ),
        backgroundColor: Color.fromARGB(212, 215, 24, 24),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new DrawerHeader(child: new Material()),
          new ListTile(
            title: new Text("Peliculas"),
            selected: mediaType == MediaType.movie,
            trailing: new Icon(Icons.local_movies),
            onTap: () {
              _changeMediaType(MediaType.movie);
              Navigator.of(context).pop;
            },
          ),
          new Divider(
            height: 5.0,
          ),
          new ListTile(
            title: new Text("Televisión"),
            selected: mediaType == MediaType.serie,
            trailing: new Icon(Icons.live_tv),
            onTap: () {
              _changeMediaType(MediaType.serie);
              Navigator.of(context).pop;
            },
          ),
          new Divider(
            height: 5.0,
          ),
          new ListTile(
            title: new Text("Cerrar"),
            trailing: new Icon(Icons.close),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      )),
      body: new PageView(
        children: _getMediaList(mediaType),
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: _getFooterItems(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  List<BottomNavigationBarItem> _getFooterItems() {
    return [
      new BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up), label: ("Populares")),
      new BottomNavigationBarItem(
          icon: Icon(Icons.update), label: ("Proximamente")),
      new BottomNavigationBarItem(
          icon: Icon(Icons.star), label: ("Mejor Valoradas")),
    ];
  }

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<Widget> _getMediaList(MediaType mediaType) {
    return (mediaType == MediaType.movie)
        ? <Widget>[
            new MediaList(movieProvider, "popular"),
            new MediaList(movieProvider, "upcoming"),
            new MediaList(movieProvider, "top_rated")
          ]
        : <Widget>[
            new MediaList(serieProvider, "popular"),
            new MediaList(serieProvider, "on_the_air"),
            new MediaList(serieProvider, "top_rated")
          ];
  }

  void _navigationTapped(int page) {
    _pageController?.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
