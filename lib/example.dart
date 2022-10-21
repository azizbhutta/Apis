import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class example extends StatefulWidget {
  const example({Key? key}) : super(key: key);

  @override
  State<example> createState() => _exampleState();
}

class _exampleState extends State<example> {

  List<photos> photosList =[];
  Future<List<photos>> getphotos ()async {
    final response = await http.get(Uri.parse ('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200){
      for ( Map i in data){
        photos Photos = photos(title: i['title'], url: i['url'] , id: i['id']);
        photosList.add(Photos);
      }
        return photosList ;
    } else {
      return photosList ;
    }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title :const Text('Api Example')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder (
                future: getphotos (),
                builder: (context ,AsyncSnapshot<List<photos>> snapshot){
              return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context , index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  subtitle: Text(snapshot.data![index].id.toString()),
                  title: Text('Notes Id:'+snapshot.data![index].title.toString()),
                );
              });
            }),
          )
        ],
      ),
    );
  }
}

class photos {
  String title , url ;
  int id;
photos ({required this.title, required this.url, required this.id });
}