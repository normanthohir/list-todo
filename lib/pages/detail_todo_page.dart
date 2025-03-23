import 'package:flutter/material.dart';
import 'package:workshop_flutter_firebases/widgets/shared_appbar.dart';

class DetailTodoPage extends StatelessWidget {
  const DetailTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppbar(title: 'Detail Todo'),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Title Todo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Card(
                  color: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Low',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text(
                  '31 oktober 2024',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '|',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '20.00 PM',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(height: 15),
            Divider(),
            SizedBox(height: 15),
            Expanded(
              child: Text(
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Aliquam nobis sint necessitatibus mollitia? Nemo ut quisquam vel officiis. Tenetur ipsum mollitia at, quibusdam ex facilis. Odio minus pariatur itaque explicabo.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
