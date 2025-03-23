import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workshop_flutter_firebases/models/todo.dart';
import 'package:workshop_flutter_firebases/services/crud_services.dart';
import 'package:workshop_flutter_firebases/theme/colors.dart';
import 'package:workshop_flutter_firebases/utils/shared_functions.dart';
import 'package:workshop_flutter_firebases/widgets/shared_appbar.dart';
import 'package:workshop_flutter_firebases/widgets/shared_buttton.dart';
import 'package:workshop_flutter_firebases/widgets/shared_category_chips.dart';
import 'package:workshop_flutter_firebases/widgets/shared_text_form_field.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  // untuk crud
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _crudServices = CrudServices();
  final _sharedFunc = SharedFunctions();

// membuat variabel untuk menyimpa tanggal category sama waktu
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedCategory;
// pilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await _sharedFunc.selectDate(
      context,
      _selectedDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            _selectedDate!.toLocal().toString().split(' ')[0];
      });
    }
  }

// pilih waktu
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await _sharedFunc.selectStartTime(
      context,
      _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _startTimeController.text = _sharedFunc.formatTimeOfDay(_selectedTime!);
      });
    }
  }

  // fungsi untuk menambahkan todo
  void _addTodo() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _sharedFunc.showSnackBar(context, message: 'User not found');
        return;
      }
      final newTodo = Todo(
        title: _titleController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
        createdAt: DateTime.parse(_dateController.text),
        startTime: _startTimeController.text,
        userId: user.uid,
      );
      // masukan ke firebases Store
      _crudServices.createTodo(newTodo);
      Navigator.pop(context);
      _sharedFunc.showSnackBar(
        context,
        message: 'Todo added successfully',
        backgroundColor: Colors.green,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baground,
      appBar: SharedAppbar(title: 'Add Todo'),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SharedTextFormField(
                  title: 'Title',
                  Controller: _titleController,
                  labelText: 'Input title',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                ),
                SharedTextFormField(
                  title: 'Description',
                  Controller: _descriptionController,
                  labelText: 'Input Description',
                ),
                SharedTextFormField(
                  title: 'Category',
                  Controller: _categoryController,
                  labelText: 'Input Category',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Category cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SharedCategoryChips(
                      isSelected: (categories) =>
                          _selectedCategory == categories,
                      onSelected: (selected, categories) {
                        setState(() {
                          if (selected) {
                            _selectedCategory = categories;
                            _categoryController.text = categories;
                          } else {
                            _selectedCategory = null;
                            _categoryController.clear();
                          }
                        });
                      }),
                ),
                SharedTextFormField(
                  title: 'Date',
                  Controller: _dateController,
                  labelText: 'Select date',
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Date cannot be empty';
                    }
                    return null;
                  },
                ),
                SharedTextFormField(
                  title: 'Start Time',
                  Controller: _startTimeController,
                  readOnly: true,
                  labelText: 'Select Start Time',
                  onTap: () => _selectTime(context),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Start Time cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                SharedButtton(
                  title: Text('Add Todo'),
                  onPressed: () {
                    _addTodo();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
