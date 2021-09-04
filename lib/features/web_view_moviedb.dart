import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewMovieDb extends StatefulWidget {
  final String id;
  const WebViewMovieDb({Key key, this.id}) : super(key: key);
  @override
  _WebViewMovieDbState createState() => _WebViewMovieDbState();
}

class _WebViewMovieDbState extends State<WebViewMovieDb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TheMovieDb'),
      ),
      body: WebView(
        initialUrl: 'https://www.themoviedb.org/movie/${widget.id}',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
