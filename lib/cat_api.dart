
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatApi{
    StreamController<String> _imgCtrl = StreamController.broadcast();
    DefaultCacheManager manager = new DefaultCacheManager();
    bool showSpinner = false;

    CatApi();

    void getImageJson(String uri) {
      _imgCtrl.sink.add(uri);
    }

    Widget getImage() {
      return StreamBuilder<String>(
        stream: _imgCtrl.stream,
       builder: (BuildContext context, AsyncSnapshot snapshot){          
        print(snapshot);
        if(snapshot.hasData && snapshot.connectionState == ConnectionState.active){
          showSpinner = false;
          return CachedNetworkImage(
            imageUrl: snapshot.data,
            cacheManager: manager,
          );
        }
        return Center(
          child: Image.network("https://cataas.com/cat")
        );
      });
    }

    Future<void> updateImage() async {
      manager.emptyCache();
      // await DefaultCacheManager().removeFile('https://cataas.com/c/gif');
      getImageJson("https://cataas.com/c/gif");
    }


}