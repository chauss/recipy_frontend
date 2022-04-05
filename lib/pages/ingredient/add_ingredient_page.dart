import 'package:flutter/material.dart';
import 'package:recipy_frontend/repositories/ingredient_repository.dart';

class AddIngredientPage extends StatefulWidget {
  const AddIngredientPage({Key? key}) : super(key: key);

  @override
  State<AddIngredientPage> createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new ingredient"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name for the new ingredient';
                  }
                  return null;
                },
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingredient name',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var success = await IngredientRepository.addIngredient(
                      nameController.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success
                          ? 'Added new ingredient!'
                          : 'Failed to add new ingredient!'),
                    ),
                  );

                  if (success) {
                    Navigator.pop(context, true);
                  }
                }
              },
              child: const Text('Add new ingredient'),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
