import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workshop_flutter_firebases/models/profile.dart';
import 'package:workshop_flutter_firebases/models/todo.dart';
import 'package:workshop_flutter_firebases/pages/add_todo_page.dart';
import 'package:workshop_flutter_firebases/pages/detail_todo_page.dart';
import 'package:workshop_flutter_firebases/pages/edit_todo_page.dart';
import 'package:workshop_flutter_firebases/pages/profile_page.dart';
import 'package:workshop_flutter_firebases/services/authentication_services.dart';
import 'package:workshop_flutter_firebases/services/crud_services.dart';
import 'package:workshop_flutter_firebases/theme/colors.dart';
import 'package:workshop_flutter_firebases/utils/constants.dart';
import 'package:workshop_flutter_firebases/utils/shared_functions.dart';
import 'package:workshop_flutter_firebases/widgets/shared_appbar.dart';

class ListTodoPage extends StatefulWidget {
  const ListTodoPage({super.key});

  @override
  State<ListTodoPage> createState() => _ListTodoPageState();
}

class _ListTodoPageState extends State<ListTodoPage> {
  final _crudServices = CrudServices();
  final _authServices = AuthenticationServices();
  final _sharedFunc = SharedFunctions();
  List<Todo> _todos = [];
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Profile? _profile;

  @override
  void initState() {
    _fetchUserProfile();
    _crudServices.getTodos().listen((todos) {
      setState(() {
        _todos = todos;
      });
    });
    super.initState();
  }

  void _fetchUserProfile() async {
    final Profile = await _authServices.getCurrentUserProfile();
    setState(() {
      _profile = Profile;
    });
  }

  // untuk hapus todo
  void _deleteTodo(String todoId) async {
    _crudServices.deleteTodo(todoId);
  }

  // untuk menampilkan todo
  List<Todo> _getTodosForSelectedDay() {
    return _todos.where((todo) {
      final todoDate = todo.createdAt;
      return todoDate.day == _selectedDate.day &&
          todoDate.month == _selectedDate.month &&
          todoDate.year == _selectedDate.year;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baground,
      appBar: SharedAppbar(
        title: 'List Todo',
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.tertiary,
        foregroundColor: AppColors.feldgrau,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ProfilePage();
                  }),
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(greetingText()),
                        Text(
                          _profile?.name ?? '',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            TableCalendar(
              headerVisible: false,
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.week,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarBuilders: CalendarBuilders(
                todayBuilder: (context, day, events) {
                  return Container(
                    margin: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
                selectedBuilder: (context, day, events) {
                  return Container(
                    margin: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 10,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Padding(
            //         padding: EdgeInsets.only(bottom: 20),
            //         child: Row(
            //           children: [
            //             Card(
            //               color: AppColors.sean_green,
            //               child: Padding(
            //                 padding: EdgeInsets.all(8),
            //                 child: Text(
            //                   '12:00',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Expanded(
            //               child: GestureDetector(
            //                 onTap: () {
            //                   Navigator.push(context,
            //                       MaterialPageRoute(builder: (context) {
            //                     return DetailTodoPage();
            //                   }));
            //                 },
            //                 child: Card(
            //                   color: Colors.white,
            //                   shadowColor: Colors.blueGrey,
            //                   elevation: 5,
            //                   child: ListTile(
            //                     title: Text(
            //                       'meeting with client',
            //                       maxLines: 1,
            //                       overflow: TextOverflow.ellipsis,
            //                       style: TextStyle(
            //                           color: AppColors.black_olive,
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                     subtitle: Text(
            //                       'Online meeting',
            //                       maxLines: 1,
            //                       overflow: TextOverflow.ellipsis,
            //                       style: TextStyle(
            //                         color: AppColors.feldgrau,
            //                       ),
            //                     ),
            //                     trailing: IconButton(
            //                       onPressed: () {},
            //                       icon: Icon(
            //                         Icons.check_circle,
            //                         color: Colors.green,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // )

            if (_getTodosForSelectedDay().isEmpty)
              Expanded(
                child: Center(
                  child: Text('No todo for this day'),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _getTodosForSelectedDay().length,
                  itemBuilder: (BuildContext context, int index) {
                    var todoItem = _getTodosForSelectedDay()[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Dismissible(
                        key: Key(todoItem.id!),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _deleteTodo(todoItem.id!);
                        },
                        child: Row(
                          children: [
                            Card(
                              color: AppColors.sean_green,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  todoItem.startTime,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return EditTodoPage(todo: todoItem);
                                    }),
                                  );
                                },
                                child: Card(
                                  color: Colors.white,
                                  shadowColor: AppColors.black_olive,
                                  elevation: 3,
                                  child: ListTile(
                                      title: Text(
                                        todoItem.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                          color: todoItem.isCompleted
                                              ? AppColors.green
                                              : AppColors.black_olive,
                                          decoration: todoItem.isCompleted
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        todoItem.category,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.feldgrau,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          todoItem.isCompleted
                                              ? Icons.check_circle
                                              : Icons.radio_button_unchecked,
                                          color: todoItem.isCompleted
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          final user =
                                              FirebaseAuth.instance.currentUser;
                                          var todo =
                                              _getTodosForSelectedDay()[index];
                                          final updatedTodo = Todo(
                                            id: todo.id,
                                            title: todo.title,
                                            description: todo.description,
                                            category: todo.category,
                                            isCompleted: !todo.isCompleted,
                                            createdAt: todo.createdAt,
                                            updatedAt: DateTime.now(),
                                            startTime: todo.startTime,
                                            userId: user!.uid,
                                          );
                                          _crudServices.updateTodo(updatedTodo);
                                          _sharedFunc.showSnackBar(
                                            context,
                                            message:
                                                'Todo ${todo.title} ${todo.isCompleted ? 'uncompleted' : 'completed'}',
                                          );
                                        },
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
