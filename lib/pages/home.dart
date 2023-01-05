
import 'package:flutter/material.dart';
import 'package:peticiones_http/models/album.dart';
import 'package:peticiones_http/pages/common/album_tile.dart';
import 'package:peticiones_http/services/album_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Album>> albumList;

  @override
  void initState() {
    super.initState();
    final albumApi = AlbumApi();
    albumList = albumApi.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Peticiones HTTP')),
      body: FutureBuilder<List<Album>>(
          future: albumList,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  Album album = snapshot.data![index];
                  debugPrint(album.toString());
                  return AlbumTile(
                      url: album.url,
                      title: album.title,
                      id: album.id.toString());
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
