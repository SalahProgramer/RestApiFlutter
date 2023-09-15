import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:restapi/model/post.dart';

import 'model/post.dart';
import 'model/post.dart';
import 'model/post.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

//delete
  Future<post1?>? deletPost() async {

    final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final responce=await http.delete(uri);
    if (responce.statusCode == 200) {
      return null;
    } else {
      throw Exception('Failed to delete post');
    }


  }


//update
  Future<post1> update(String title, String body) async {
    Map<String, dynamic> request = {
      "id": "101",
      "title": title,
      "body": body,
      "userId": "111"
    };
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final responce = await http.put(uri, body: request);
    print(responce.body+"                 kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"+responce.statusCode.toString());

    if (responce.statusCode == 200) {
      return post1.fromJson(json.decode(responce.body));
    } else {
      throw Exception('Failed to load post');
    }
  }


  //post(create)
  Future<post1> createPost(String title, String body) async {
    Map<String, dynamic> request = {
      "title": title,
      "body": body,
      'userId': "111"
    };
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final responce = await http.post(uri, body: request);

    if (responce.statusCode == 201) {
      return post1.fromJson(json.decode(responce.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

//get
  Future<post1> fetchData() async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await http.get(uri);
    print(response.body+"                 kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"+response.statusCode.toString());

    if (response.statusCode == 200) {
      return post1.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<post1?>? post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Rest API"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: true,
                child: FutureBuilder<post1?> (
future: post,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return CircularProgressIndicator(

                        color: Colors.green,
                        strokeWidth: 2,
                      );


                    }
                    else if(snapshot.hasData){
print(snapshot.data!.title.toString()+" gggggggggggggggggggggggggggggggggggg");
                      return
                        Text(snapshot.data!.title+"\n\n"+ snapshot.data!.description.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(overflow: TextOverflow.visible, height: 2),
                       );



                    }
                    else{


                      return Text("${snapshot.error}");

                    }





                  },


                )
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: OvalBorder(),
                  ),
                  onPressed: () {
                    setState(() {
                      post= fetchData();
                    });
                  },
                  child: Text("GET")),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      post= createPost("Top post","This is emample post");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: OvalBorder(),
                  ),
                  child: Text("POST")),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      post= update("Update post", "Update example post");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: OvalBorder(),
                  ),
                  child: Text("UPDATE")),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      post= deletPost();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: OvalBorder(),
                  ),
                  child: Text("DELETE"))
            ],
          ),
        ),
      ),
    );
  }
}
