import 'package:flutter/material.dart';
import 'sqlDB.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  SqlDb sqlDb = SqlDb();
  List<Map> tasks = [];

  TextEditingController taskController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  fetchTasks() async {
    List<Map> res = await sqlDb.Read("notes");
    setState(() {
      tasks = res;
    });
  }

  addTask(String task, String? dueDate) async {
    int res = await sqlDb.InsertData('''
      INSERT INTO notes (`task`, `duedate`, `isDone`)
      VALUES ("$task", "$dueDate", 0)
    ''');

    if (res > 0) {
    fetchTasks();
    }
  }

  deleteTask(int id) async {
    await sqlDb.DeleteData("DELETE FROM notes WHERE id = $id");
    fetchTasks();
  }

  toggleDone(int id, int currentStatus) async {
    int newStatus = currentStatus == 1 ? 0 : 1;
    await sqlDb.UpdataData(
        "UPDATE notes SET isDone = $newStatus WHERE id = $id");
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
                controller: taskController,
                decoration: const InputDecoration(
                  labelText: "Task",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
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
                    icon: const Icon(Icons.calendar_today),
                  ),
                  Text(selectedDate != null
                      ? "${selectedDate!.toLocal()}".split(' ')[0]
                      : "No due date"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      taskController.clear();
                      selectedDate = null;
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      String task = taskController.text.trim();
                      if (task.isNotEmpty) {
                        addTask(task, selectedDate?.toString().split(' ')[0]);
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
    final today = DateTime.now();
    final day = today.day;
    final month = today.month;
    final year = today.year;
    final weekDay = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ][today.weekday % 7];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Tasker",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: CircleBorder(eccentricity: 0.1),
        onPressed: showAddTaskSheet,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  "$day/$month/$year",
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
                const SizedBox(width: 50),
                Text(
                  weekDay,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text("No tasks yet"))
                : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                var task = tasks[index];
                bool isOverdue = false;
                if (task['duedate'] != null &&
                    task['duedate'].toString().isNotEmpty) {
                  DateTime taskDate =
                      DateTime.tryParse(task['duedate']) ?? DateTime.now();
                  DateTime now = DateTime.now();
                  isOverdue = taskDate.isBefore(
                      DateTime(now.year, now.month, now.day));
                }

                return Card(
                  color: isOverdue && task['isDone'] != 1
                      ? Colors.red[100]
                      : null,
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        task['isDone'] == 1
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: task['isDone'] == 1
                            ? Colors.green
                            : Colors.grey,
                        size: 28,
                      ),
                      onPressed: () {
                        toggleDone(task['id'], task['isDone']);
                      },
                    ),
                    title: Text(
                      task['task'],
                      style: TextStyle(
                        decoration: task['isDone'] == 1
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: isOverdue && task['isDone'] != 1
                            ? Colors.red
                            : null,
                        fontWeight: isOverdue && task['isDone'] != 1
                            ? FontWeight.bold
                            : null,
                      ),
                    ),
                    subtitle: task['duedate'] != null
                        ? Text(
                      "Due: ${task['duedate']}",
                      style: TextStyle(
                        color: isOverdue && task['isDone'] != 1
                            ? Colors.red[700]
                            : null,
                      ),
                    )
                        : null,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteTask(task['id']);
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
