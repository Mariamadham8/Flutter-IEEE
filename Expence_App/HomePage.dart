import 'package:flutter/material.dart';
import 'sqlDB.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String? selectedItem;
  double Total =0.00;
  SqlDb sqlDb = SqlDb();
  List<Map> tasks = [];
  List<String> months = [
  "jan",
  "feb",
  "march",
  "april",
  "may",
  "june",
  "july",
  "aug",
  "sep",
  "oct",
  "nov",
  "dec"
  ];
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? selectedDate;
  late final weekDay;


  @override
  void initState() {

    final today = DateTime.now();
    final day = today.day;
    final month = today.month;
    final year = today.year;
     weekDay = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ];

    super.initState();
    fetchTasks();
  }

  fetchTasks() async {
    List<Map> res = await sqlDb.Read("notes");
    setState(() {
      tasks = List<Map>.from(res);
      Total = 0;
      for (var task in tasks) {
        Total += int.tryParse(task['amount'].toString()) ?? 0;
      }
    });
  }

  add(String title, String? date, String category ,int amount) async {
    int res = await sqlDb.InsertData('''
      INSERT INTO notes (`title`, `date`, `category`,`amount`)
      VALUES ("$title", "$date", "$category","$amount")
    ''');

    if (res > 0) {
      fetchTasks();
    }
  }

  deleteTask(int id) async {
    await sqlDb.DeleteData("DELETE FROM notes WHERE id = $id");
    fetchTasks();
  }


  Future<void> showAddTaskSheet() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedItem,
                decoration: InputDecoration(border: OutlineInputBorder()),
                items: [
                  DropdownMenuItem(value: 'petsFood', child: Text("Pets Food")),
                  DropdownMenuItem(value: 'Food', child: Text("Food")),
                  DropdownMenuItem(value: 'Drinks', child: Text("Drinks")),
                  DropdownMenuItem(value: 'Junk Food', child: Text("Junk Food")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedItem = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Select Date",
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    selectedDate != null
                        ? selectedDate!.toString().split(' ')[0]
                        : 'No date selected',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      titleController.clear();
                      amountController.clear();
                      selectedDate = null;
                      selectedItem = null;
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      String title = titleController.text.trim();
                      String amountText = amountController.text.trim();

                      if (title.isNotEmpty && amountText.isNotEmpty && selectedItem != null && selectedDate != null) {
                        int amount = int.tryParse(amountText) ?? 0;
                        add(title, selectedDate!.toString().split(' ')[0], selectedItem!, amount);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Expenses",
              style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),

            ),
            const SizedBox(height: 4),
            Text(
              "${weekDay[DateTime.now().weekday ]} - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        actionsPadding: EdgeInsets.all(20),
        actions: [
          Icon(Icons.list,color: Colors.grey,),
        ],
      ),
    floatingActionButton: FloatingActionButton(onPressed: (){
          showAddTaskSheet();
        },

          backgroundColor: Colors.green,
          shape: CircleBorder(eccentricity: 0.1),
        child: Icon(Icons.add,color: Colors.white,),

        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      body:
         Column(
        children:[
          Padding(padding: EdgeInsets.all(20),child: Text("\$${Total}",style: TextStyle(fontSize: 40,fontWeight:FontWeight.bold,color: Colors.green),),),


          SizedBox(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: months.length,
              itemBuilder: (context, index) {
                Color? choose_Color() {
                  if (index == DateTime.now().month-1) {
                    return Colors.green;
                  } else if (index > DateTime.now().month-1) {
                    return Colors.grey[700];
                  } else {
                    return Colors.grey;
                  }
                }

                return Container(
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: choose_Color(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${months[index]}",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),

          Expanded(
        child: tasks.isEmpty
        ? const Center(child: Image(image:AssetImage("assets/HM.PNG"),height: 300, fit: BoxFit.cover,))
          : ListView.builder(
          itemCount:tasks.length,
          itemBuilder: (context, index) {
            var task=tasks[index];
            Widget getLeadingIcon(String category) {
              if (category == "Drinks") {
                return Text("☕",style: TextStyle(fontSize: 30),);
              } else if (category == "junk Food") {
                return  Text("🍔",style: TextStyle(fontSize: 30));
              } else if (category == "Pets Food") {
                return Text("🐶",style: TextStyle(fontSize: 30));
              }
              else
                {
                  return Text("🚕",style: TextStyle(fontSize: 30));
                }
            }
            return Dismissible(
              key: Key(task['id'].toString()),
              direction: DismissDirection.endToStart,
                onDismissed: (_) async {
                await sqlDb.DeleteData("DELETE FROM notes WHERE id = ${task['id']}");
                setState(() {
                  tasks.removeWhere((item) => item['id'] == task['id']);
                  Total =Total-task['amount'];
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Expence was Deleted")),
                );
              },
              background: Container(
                color: Colors.red[200],
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: getLeadingIcon(task['category']),
                  title: Text(task['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Text("-\$${task['amount']}"),
                  subtitle: Text("${weekDay[DateTime.now().weekday]} - ${task['date']}"),
                ),
              ),
            );

            }

        )
        ),
    ]
      )
    );
  }
}
