import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_directoryapp/services.dart';

class Studentdirectory extends StatefulWidget {
  const Studentdirectory({super.key});

  @override
  State<Studentdirectory> createState() => _StudentdirectoryState();
}

class _StudentdirectoryState extends State<Studentdirectory> {
  String? _selectedgender;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController classconntroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  void editbox(DocumentSnapshot doc) {
    namecontroller.text = doc["name"];
    classconntroller.text = doc["class"];
    _selectedgender = doc["gender"];
    phonecontroller.text = doc["phonenumber"];
    showModalBottomSheet(
      isScrollControlled:true,
      context:context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Edit the details"),
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(hintText:"fullname"),
            ),TextField(
              controller: classconntroller,
              decoration: InputDecoration(hintText:"class"),

            ),TextField(
              controller: phonecontroller,
              decoration: InputDecoration(hintText:"phonenumber"),
            ),

              DropdownButtonFormField<String>(value: _selectedgender,
              decoration: InputDecoration(hintText:"gender"),
              items:
               ['MALE','FEMALE']
               .map((e) => DropdownMenuItem( value :e child: Text(e)))
               .toList(),
               onChanged: (value) {
                 setState(() {
                   _selectedgender = value;

                 });
               },
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                (doc.id, namecontroller.text, _selectedgender!,classconntroller.text,phonecontroller.text,context)
              },
              child: Text("UPDATE"),
              )
            
          ],
        );

      },
    );  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          "STUDENT DIRECTORY",
          style: TextStyle(
            color: const Color.fromARGB(255, 224, 227, 229),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("STUDENT DATA", style: TextStyle(fontSize: (25))),
                    SizedBox(height: 15),
                    Align(alignment: Alignment.topLeft, child: Text("NAME")),

                    TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        hintText: "full name",
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(alignment: Alignment.topLeft, child: Text("GENTER")),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: "select gender",
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                      ),
                      value: _selectedgender,
                      items: ['MALE', 'FEMALE']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedgender = value;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    Align(alignment: Alignment.topLeft, child: Text("CLASS")),
                    TextField(
                      controller: classcontroller,
                      decoration: InputDecoration(
                        hintText: "Class",
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("PHONE NUMBER"),
                    ),
                    TextField(
                      controller: phonenumbercontroller,
                      decoration: InputDecoration(
                        hintText: "phone no",
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        addstudent(
                          namecontroller.text,
                          _selectedgender!,
                          classcontroller.text,
                          phonenumbercontroller.text,
                          context,
                        );
                      },
                      child: Text("ADD"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add, color: const Color.fromARGB(255, 235, 237, 237)),
      ),
      body: StreamBuilder(
        stream: getstudents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final studentdata = snapshot.data!.docs;
          return ListView.builder(
            itemCount: studentdata.length,
            itemBuilder: (context, index) {
              final student = studentdata[index];
              return ListTile(
                title: Text(
                  studentdata[index]["name"],
                  style: TextStyle(fontSize: 26),
                ),
                subtitle: Row(
                  children: [
                    Text(studentdata[index]["gender"]),
                    SizedBox(width: 10),
                    Text(studentdata[index]["class"]),
                    SizedBox(width: 10),
                    Text(studentdata[index]["phonenumber"]),
                    SizedBox(width: 10),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        editbox(student);
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
