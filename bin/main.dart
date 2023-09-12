

import 'package:http/http.dart' as http;
import 'package:dart_rss/dart_rss.dart';

void main() {
  final client = http.Client();

  // RSS feed
  client
      .get(Uri.parse('https://1tourtv.online/blog-list/feed/'))
      .then((response) {
    return response.body;
  }).then((bodyString) {
    final channel = RssFeed.parse(bodyString);
    //print(channel.items.first.content!.value);
    final firstNews = channel.items.first.content!.value;
    final listOfFirstNews = firstNews.split('<p>');
    listOfFirstNews[0] = listOfFirstNews[0].substring(listOfFirstNews[0].indexOf('src=')+5, listOfFirstNews[0].length - listOfFirstNews[0].indexOf('src=')+5);
    final image = (listOfFirstNews[0].substring(0, listOfFirstNews[0].indexOf("\"")));

    final title = channel.items.first.title;
    final description = channel.items.first.description!.split('</p>')[0].replaceAll('<', '').replaceAll('>', '').replaceAll('p', '');
    String content = "";

    for (String s in listOfFirstNews.sublist(1, listOfFirstNews.length-1)){
      content += s.replaceAll('<', '').replaceAll('>', '').replaceAll('p', '').replaceAll('br', '').replaceAll('/', '').replaceAll('\\', '').replaceAll('\n', '').replaceAll('&nbs;', '');
      content += '\n\n';
    }
    print(title);
    print(description);
    print(image);
    print(content);
  });


}
