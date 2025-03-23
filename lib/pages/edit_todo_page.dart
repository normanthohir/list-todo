import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workshop_flutter_firebases/models/todo.dart';
import 'package:workshop_flutter_firebases/services/crud_services.dart';
import 'package:workshop_flutter_firebases/theme/colors.dart';
import 'package:workshop_flutter_firebases/utils/shared_functions.dart';
import 'package:workshop_flutter_firebases/widgets/shared_appbar.dart';
import 'package:workshop_flutter_firebases/widgets/shared_buttton.dart';
import 'package:workshop_flutter_firebases/widgets/shared_category_chips.dart';
import 'package:workshop_flutter_firebases/widgets/shared_text_form_field.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;
  const EditTodoPage({
    super.key,
    required this.todo,
  });

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _crudServices = CrudServices();
  final _sharedFunc = SharedFunctions();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedCategory;

  @override
  void initState() {
    _initalValue();
    super.initState();
  }

  void _initalValue() {
    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.description ?? '';
    _categoryController.text = widget.todo.category;
    _dateController.text =
        DateFormat('yyyy-MM-dd').format(widget.todo.createdAt);
    _startTimeController.text = widget.todo.startTime;
    _selectedDate = widget.todo.createdAt;
    _selectedCategory = widget.todo.category;
  }

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

  void _updateTodo() {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      final updatedTodo = Todo(
        id: widget.todo.id,
        title: _titleController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
        startTime: _startTimeController.text,
        createdAt: _selectedDate,
        updatedAt: DateTime.now(),
        userId: user!.uid,
      );
      try {
        _crudServices.updateTodo(updatedTodo);
        _sharedFunc.showSnackBar(
          context,
          message: 'Todo updated successfully',
        );
        Navigator.pop(context);
      } catch (e) {
        _sharedFunc.showSnackBar(
          context,
          message: 'Failed to update todo',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baground,
      appBar: const SharedAppbar(title: 'Edit Todo'),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SharedTextFormField(
                  title: 'Title',
                  Controller: _titleController,
                  labelText: 'Input Title',
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
                  readOnly: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Category cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SharedCategoryChips(
                    isSelected: (categories) => _selectedCategory == categories,
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
                    },
                  ),
                ),
                SharedTextFormField(
                  title: 'Date',
                  Controller: _dateController,
                  labelText: 'Select Date',
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
                  labelText: 'Select Start Time',
                  readOnly: true,
                  onTap: () => _selectTime(context),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Start Time cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                SharedButtton(
                  title: const Text('Update Todo'),
                  onPressed: _updateTodo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// class EditTodoPage extends StatelessWidget {
//   const EditTodoPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: SharedAppbar(title: 'Edit Todo'),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SharedTextFormField(
//                 title: 'Title',
//                 Controller: TextEditingController(),
//                 labelText: 'Input title',
//               ),
//               SharedTextFormField(
//                 title: 'Description',
//                 Controller: TextEditingController(),
//                 labelText: 'Input Description',
//               ),
//               SharedTextFormField(
//                 title: 'Category',
//                 Controller: TextEditingController(),
//                 labelText: 'Input Category',
//               ),
//               SizedBox(height: 10),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Wrap(
//                   spacing: 8,
//                   children: [
//                     ChoiceChip(
//                       label: Text('Low'),
//                       selected: false,
//                     ),
//                     ChoiceChip(
//                       label: Text('Low'),
//                       selected: false,
//                     ),
//                     ChoiceChip(
//                       label: Text('Low'),
//                       selected: false,
//                     ),
//                     ChoiceChip(
//                       label: Text('Low'),
//                       selected: false,
//                     ),
//                     ChoiceChip(
//                       label: Text('Low'),
//                       selected: false,
//                     ),
//                     ChoiceChip(
//                       label: Text('Low'),
//                       selected: false,
//                     ),
//                     ChoiceChip(
//                       label: Text('Low'),
//                       selected: false,
//                     ),
//                     ChoiceChip(
//                       label: Text('Low'),
//                       selected: false,
//                     ),
//                     ChoiceChip(
//                       label: Text('Low'),
//                       selected: false,
//                     ),
//                     ChoiceChip(
//                       label: Text('Low'),
//                       selected: false,
//                     ),
//                   ],
//                 ),
//               ),
//               SharedTextFormField(
//                 title: 'Date',
//                 Controller: TextEditingController(),
//                 labelText: 'Select date',
//               ),
//               SharedTextFormField(
//                 title: 'Start time',
//                 Controller: TextEditingController(),
//                 labelText: 'Select start time',
//               ),
//               SizedBox(height: 50),
//               SharedButtton(
//                 title: Text('Add Todo'),
//                 onPressed: () {},
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
