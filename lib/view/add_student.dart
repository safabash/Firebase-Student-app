import 'package:authentication/controller/add_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddStudentController>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  hintText: 'Input Name',
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  hintText: 'Input Age',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    provider.createUser(
                        name: nameController.text, age: ageController.text);
                  },
                  child: const Text('Add')),
            ],
          ),
        ),
      ),
    );
  }
}
