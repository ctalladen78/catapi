
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatApi{
    StreamController<String> _imgCtrl = StreamController.broadcast();
    DefaultCacheManager manager = new DefaultCacheManager();
    bool showSpinner = false;
    String _uriGif;
    String _uriStatic;

    CatApi(this._uriGif, this._uriStatic);

    Widget getImage() {
      return StreamBuilder<String>(
        stream: _imgCtrl.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot){          
        if(snapshot.hasData && snapshot.connectionState == ConnectionState.active){
          showSpinner = false;
          return CachedNetworkImage(
            imageUrl: snapshot.data,
            cacheManager: manager,
          );
        }
        return Center(
          child: Image.network(this._uriStatic)
        );
      });
    }

    Future<void> updateImage() async {
      manager.emptyCache();
      _imgCtrl.sink.add(this._uriGif);
    }


}