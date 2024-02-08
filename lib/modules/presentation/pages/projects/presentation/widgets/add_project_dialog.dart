import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddProjectDialog extends HookWidget {
  const AddProjectDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const AddProjectDialog(),
    );
  }

  void _addProject({
    required BuildContext context,
    required String projectNumber,
    required String projectName,
    required String projectLocation,
    required String company,
  }) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final projectNumberController = useTextEditingController();
    final projectNameController = useTextEditingController();
    final projectLocationController = useTextEditingController();
    final companyController = useTextEditingController();

    return AlertDialog(
      title: const Text('Add Project'),
      content: _Form(
        formKey: formKey,
        projectNumberController: projectNumberController,
        projectNameController: projectNameController,
        projectLocationController: projectLocationController,
        companyController: companyController,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;

            _addProject(
              context: context,
              projectNumber: projectNumberController.text,
              projectName: projectNameController.text,
              projectLocation: projectLocationController.text,
              company: companyController.text,
            );
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({
    required this.formKey,
    required this.projectNumberController,
    required this.projectNameController,
    required this.projectLocationController,
    required this.companyController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController projectNumberController;
  final TextEditingController projectNameController;
  final TextEditingController projectLocationController;
  final TextEditingController companyController;

  String? _validateProjectName(String? text) {
    if (text == null || text.isEmpty) {
      return 'Project name is required';
    }

    return null;
  }

  String? _validateProjectNumber(String? text) {
    if (text == null || text.isEmpty) {
      return 'Project number is required';
    }

    return null;
  }

  String? _validateProjectLocation(String? text) {
    if (text == null || text.isEmpty) {
      return 'Project location is required';
    }

    return null;
  }

  String? _validateCompany(String? text) {
    if (text == null || text.isEmpty) {
      return 'Company is required';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: projectNumberController,
            validator: _validateProjectNumber,
            decoration: const InputDecoration(labelText: 'Project Number'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: projectNameController,
            validator: _validateProjectName,
            decoration: const InputDecoration(labelText: 'Project Name'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: projectLocationController,
            validator: _validateProjectLocation,
            decoration: const InputDecoration(labelText: 'Project Location'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: companyController,
            validator: _validateCompany,
            decoration: const InputDecoration(labelText: 'Company'),
          ),
        ],
      ),
    );
  }
}
