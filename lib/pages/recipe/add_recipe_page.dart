import 'package:flutter/material.dart';
import 'package:recipy_frontend/repositories/recipe_repository.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rezept hinzufügen"),
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
                    return 'Bitte gibt einen Namen für das neue Rezept ein';
                  }
                  return null;
                },
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Rezeptname',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var success =
                      await RecipeRepository.addRecipe(nameController.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success
                          ? 'Neues Rezept hinzugefügt!'
                          : 'Rezept konnte nicht hinzugefügt werden!'),
                    ),
                  );

                  if (success) {
                    Navigator.pop(context, true);
                  }
                }
              },
              child: const Text('Rezept hinzufügen'),
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
