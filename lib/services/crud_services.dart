import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:workshop_flutter_firebases/models/todo.dart';

class CrudServices {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createTodo(Todo todo) async {
    try {
      final newTodoRef = _dbRef.child('todos').push();
      todo.id = newTodoRef.key;
      final todoJson = todo.toJson();
      await newTodoRef.set(todoJson);
    } catch (e) {
      rethrow;
    }
  }

  // untuk getlisnya
  Stream<List<Todo>> getTodos() {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not found');
    }
    final todosRef =
        _dbRef.child('todos').orderByChild('userId').equalTo(user.uid);
    return todosRef.onValue.map((event) {
      final todos = <Todo>[];
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        data.forEach((key, value) {
          final todo = Todo.fromJson(Map<String, dynamic>.from(value));
          todos.add(todo);
        });
      }
      return todos;
    });
  }

// update
  Future<void> updateTodo(Todo todo) async {
    await _dbRef.child('todos/${todo.id}').update(todo.toJson());
  }

// delete
  Future<void> deleteTodo(String id) async {
    await _dbRef.child('todos/$id').remove();
  }
}
