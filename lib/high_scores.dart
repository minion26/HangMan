import 'database.dart';
import 'package:flutter/material.dart';

class HighScores extends StatelessWidget {
  final Database db = Database();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(207, 207, 196, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(207, 207, 196, 1.0),
        title: Center(
          child: Text(
            'High Scores',
            style: TextStyle(
              fontFamily: 'AmaticSC',
              fontSize: 60.0,
            ),
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          // asteapta lista din db, cat asteaota nu face nimic
          future: db.readScores(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // cand are date, face tabelul
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Medal',
                        style:
                            TextStyle(fontFamily: "AmaticSC", fontSize: 30.0),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Score',
                        style:
                            TextStyle(fontFamily: "AmaticSC", fontSize: 30.0),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Date',
                        style:
                            TextStyle(fontFamily: "AmaticSC", fontSize: 30.0),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(snapshot.data!.length, (index) {
                    if (index == 0) {
                      return DataRow(cells: <DataCell>[
                        DataCell(
                          Container(
                            width: 50, // adjust the width as needed
                            child: Image.asset('assets/medals/gold.png'),
                          ),
                        ),
                        DataCell(Text('${snapshot.data![index]['score']}')),
                        DataCell(Text('${snapshot.data![index]['date']}')),
                      ]);
                    } else if (index == 1) {
                      return DataRow(cells: <DataCell>[
                        DataCell(
                          Container(
                            width: 50, // adjust the width as needed
                            child: Image.asset('assets/medals/silver.png'),
                          ),
                        ),
                        DataCell(Text('${snapshot.data![index]['score']}')),
                        DataCell(Text('${snapshot.data![index]['date']}')),
                      ]);
                    } else if (index == 2) {
                      return DataRow(cells: <DataCell>[
                        DataCell(
                          Container(
                            width: 50, // adjust the width as needed
                            child: Image.asset('assets/medals/bronze.png'),
                          ),
                        ),
                        DataCell(Text('${snapshot.data![index]['score']}')),
                        DataCell(Text('${snapshot.data![index]['date']}')),
                      ]);
                    } else {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Container(
                              width: 50, // adjust the width as needed
                              child: Image.asset(
                                  'assets/medals/participation.png'),
                            ),
                          ),
                          DataCell(Text('${snapshot.data![index]['score']}')),
                          DataCell(Text('${snapshot.data![index]['date']}')),
                        ],
                      );
                    }
                  }
                      // (index) => DataRow(
                      //   cells: <DataCell>[
                      //     DataCell(Text('${snapshot.data![index]['score']}')),
                      //     DataCell(Text('${snapshot.data![index]['date']}')),
                      //   ],
                      // ),
                      ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        // child: FutureBuilder<List<Map<String, dynamic>>>(
        //   future: db.readScores(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //         itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index) {
        //           return Text(
        //               'Score: ${snapshot.data![index]['score']}, Date: ${snapshot.data![index]['date']}');
        //         },
        //       );
        //     } else if (snapshot.hasError) {
        //       return Text('Error: ${snapshot.error}');
        //     } else {
        //       return CircularProgressIndicator();
        //     }
        //   },
        // ),
      ),
    );
  }
}
