// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expense_tracker/pages/add_transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';
import '../controller/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper();

  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  DateTime today = DateTime.now();
  List<FlSpot> dataSet = [];

  List<FlSpot> getPlotPoints(Map entireData) {
    dataSet = [];
    entireData.forEach((key, value) {
      if (value['type'] == "Expense" &&
          (value['date'] as DateTime).month == today.month) {
        dataSet.add(
          FlSpot(
            (value['date'] as DateTime).day.toDouble(),
            (value['amount'] as int).toDouble(),
          ),
        );
      }
    });
    return dataSet;
  }

  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      if (value["type"] == "Income") {
        totalBalance += (value["amount"] as int);
        totalIncome += (value["amount"] as int);
      } else {
        totalBalance -= (value["amount"] as int);
        totalExpense += (value["amount"] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        backgroundColor: Colors.grey[350],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => const AddTransPage(),
              ),
            )
                //     .whenComplete(() {
                //   setState(() {});
                // });
                .then((value) {
              setState(() {});
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          child: const Icon(
            Icons.add_outlined,
            size: 32.0,
          ),
        ),
        body: FutureBuilder<Map>(
            future: dbHelper.fetch(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Oopssss !!! There is some error !",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "You haven't added Any Data !",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  );
                }
                getTotalBalance(snapshot.data!);
                getPlotPoints(snapshot.data!);
                return ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                        12.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    32.0,
                                  ),
                                  color: Colors.white,
                                ),
                                child: CircleAvatar(
                                  maxRadius: 32.0,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/applogo.png",
                                    width: 2000.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                " Welcome User",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                              color: Colors.white70,
                            ),
                            padding: EdgeInsets.all(
                              12.0,
                            ),
                            child: Icon(
                              Icons.settings,
                              size: 35.0,
                              color: Colors.grey[800],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.all(12.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.black87,
                              Color.fromARGB(255, 52, 69, 78),
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              24.0,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '\nTotal Balance',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25.0,
                                //fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              "₹ $totalBalance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 36.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  cardIncome(
                                    totalIncome.toString(),
                                  ),
                                  cardExpense(
                                    totalExpense.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Expenses",
                        style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    dataSet.length < 2
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 6,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 40.0,
                            ),
                            margin: EdgeInsets.all(
                              12.0,
                            ),
                            child: Text(
                              "Not enough Values to Render Chart",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 6,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 40.0,
                            ),
                            margin: EdgeInsets.all(
                              12.0,
                            ),
                            height: 400.0,
                            child: LineChart(
                              LineChartData(
                                borderData: FlBorderData(
                                  show: true,
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                      spots: getPlotPoints(snapshot.data!),
                                      isCurved: false,
                                      barWidth: 2.5,
                                      colors: [
                                        Color.fromARGB(255, 34, 79, 101),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Recent Transactions",
                        style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Map dataAtIndex;
                        try {
                          dataAtIndex = snapshot.data![index];
                        } catch (e) {
                          // deleteAt deletes that key and value,
                          // hence makign it null here., as we still build on the length.
                          return Container();
                        }
                        if (dataAtIndex['type'] == "Income") {
                          return incomeTile(
                              dataAtIndex["amount"], dataAtIndex["note"]);
                        } else {
                          return expenseTile(
                              dataAtIndex["amount"], dataAtIndex["note"]);
                        }
                      },
                    ),
                    //
                    SizedBox(
                      height: 60.0,
                    ), //
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    "You haven't added Any Data !",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                );
              }
            }));
  }

  Widget cardIncome(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
            padding: EdgeInsets.all(
              6.0,
            ),
            margin: EdgeInsets.only(
              right: 10.0,
            ),
            child: Icon(
              Icons.arrow_downward,
              size: 28.0,
              color: Colors.green[700],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Income",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "\u20B9 $value",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardExpense(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
            padding: EdgeInsets.all(
              6.0,
            ),
            margin: EdgeInsets.only(
              right: 10.0,
            ),
            child: Icon(
              Icons.arrow_upward,
              size: 28.0,
              color: Colors.red[700],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Expense",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "\u20B9 $value",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget expenseTile(int value, String note) {
    return InkWell(
      splashColor: Colors.black,
      // onTap: () {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     deleteInfoSnackBar,
      //   );
      // },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 182, 184, 190),
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_up_outlined,
                          size: 28.0,
                          color: Colors.red[700],
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "Debit",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "- $value",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        note,
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget incomeTile(int value, String note) {
    return InkWell(
      splashColor: Colors.black,
      // onTap: () {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     deleteInfoSnackBar,
      //   );
      // },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 182, 184, 190),
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_down_outlined,
                          size: 28.0,
                          color: Colors.green[700],
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "Credit",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "+ $value",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        note,
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
