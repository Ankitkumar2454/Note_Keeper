import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteReaderScreen extends StatefulWidget {
  var title, description, formattedDate;
  NoteReaderScreen({this.title, this.description, formattedDate});
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    var formattedDate = DateFormat('d MMM, yyyy').format(date).toString();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 92, 4, 108),
          elevation: 0,
          toolbarHeight: 80,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                Icon(
                  Icons.arrow_circle_left_outlined,
                  color: Colors.white,
                ),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          actions: [
            Text(
              "Templetes",
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
            SizedBox(
              width: 30,
            ),
            Icon(
              Icons.menu,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$formattedDate",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${widget.title}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "${widget.description}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
