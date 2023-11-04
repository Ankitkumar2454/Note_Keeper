import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_keeper/noteEditor.dart';
import 'package:notes_keeper/noteReader.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var value, title, description, createdDateTime;
  var totalDataCount;
  Future<List<dynamic>?> fetchData() async {
    var client = http.Client();
    var response;
    try {
      var url =
          Uri.parse('https://notesapp-i6yf.onrender.com/user/getAllNotes');
      response = await client.get(url);
      print(response.body);
      setState(() {
        value = jsonDecode(response.body);
        totalDataCount = value['data'].length;
        print(totalDataCount);
      });
    } catch (e) {
      print(e);
    }
    if (response == null) {
      print('No response received');
    } else if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      return null;
    }
  }

  @override
  void initState() {
    setState(() {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(value);

    String formatTimeAgo(String dateTimeString) {
      final dateTime = DateTime.parse(dateTimeString);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'Just now';
      }
    }

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: Icon(Icons.menu),
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(255, 236, 233, 233),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 50,
                  ),
                  Center(
                    child: Text(
                      "Search",
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: (value != null)
                ? Column(
                    children: [
                      NotesContainerData(formatTimeAgo, "To Do "),
                      NotesContainerData(formatTimeAgo, "Notes"),
                      NotesContainerData(formatTimeAgo, "Diary"),
                    ],
                  )
                : Container(
                    child: Center(child: Text("network problem")),
                  ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 1),
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.home_filled,
                      size: 30,
                      color: Color.fromARGB(255, 3, 45, 79),
                    ),
                    Text(
                      "DashBoard",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                    Text(
                      "To Do",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.sticky_note_2_sharp,
                      size: 30,
                      color: Colors.black,
                    ),
                    Text(
                      "Notes",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.book_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                    Text(
                      "Diary",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoteEditorScreen()),
            );
          },
          backgroundColor: Colors.yellow,
          label: Text("Add note"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  Column NotesContainerData(
      String formatTimeAgo(String dateTimeString), String taskName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$taskName",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 200,
          child: (value != null)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: totalDataCount,
                  itemBuilder: (context, index) {
                    // print(value["data"][0]["title"]);
                    // var title = value["data"][0]["title"];
                    title = value["data"][index]["title"];
                    description = value["data"][index]["description"];
                    createdDateTime =
                        value["data"][index]["createdAt"].toString();
                    final parsedDate = DateTime.parse(createdDateTime);
                    final formattedDate =
                        DateFormat('d MMM, y').format(parsedDate);

                    final now = DateTime.now();
                    final difference = now.difference(parsedDate);

                    final formattedTimeAgo = formatTimeAgo(createdDateTime);

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteReaderScreen(
                                  title: title,
                                  description: description,
                                  formattedDate: formattedDate)),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            border: Border.all(width: 3, color: Colors.grey),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Things To Do",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "$title",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "$description",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(22)),
                                  ),
                                  height: 40,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "$formattedTimeAgo",
                                          style: TextStyle(
                                            overflow: TextOverflow.clip,
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
        ),
      ],
    );
  }
}
