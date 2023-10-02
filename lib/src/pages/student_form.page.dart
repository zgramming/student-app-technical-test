import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../models/model/student/form_student_create_or_update.model.dart';
import '../models/model/student/student.model.dart';
import '../utils/async_state.dart';
import '../utils/enum.dart';
import '../utils/extension.dart';
import '../utils/fonts.dart';
import '../utils/function.dart';
import '../utils/styles.dart';
import '../view_model/student_cubit.dart';

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final now = DateTime.now();

  DateTime? selectedBirthDate;
  bool isMale = true;
  bool isEdit = false;

  Future<void> onTapBirthDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (date == null) return;
    // Fill age field automatically when user select birth date
    setState(() {
      selectedBirthDate = date;
      birthDateController.text = date.format("dd MMMM yyyy");

      final diffOnYear = now.difference(date).inDays / 365;
      ageController.text = diffOnYear.toStringAsFixed(0);
    });
  }

  Future<void> onSubmit() async {
    try {
      final validate = _formKey.currentState?.validate() ?? false;
      if (!validate) return;

      final isEdit = widget.id > 0;

      if (selectedBirthDate == null) {
        throw Exception("Birth date is required");
      }

      final name = nameController.text;
      final age = int.tryParse(ageController.text) ?? 0;
      final address = addressController.text;
      final form = FormStudentCreateOrUpdateModel(
        name: name,
        birthDate: selectedBirthDate!,
        age: age,
        gender: isMale ? GenderEnum.male : GenderEnum.female,
        address: address,
      );

      if (isEdit) {
        context.read<StudentCubit>().update(form.copyWith(id: widget.id));
      } else {
        context.read<StudentCubit>().create(form);
      }
    } catch (e) {
      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> init() async {
    if (widget.id > 0) {
      isEdit = true;
      context.read<StudentCubit>().getById(widget.id);
    } else {
      isEdit = false;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    ageController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentAsync =
        context.select<StudentCubit, AsyncState<StudentModel?>>(
      (value) => value.state.onGetById,
    );

    return MultiBlocListener(
      listeners: [
        // Listen onGetById event
        BlocListener<StudentCubit, StudentState>(
          listenWhen: (previous, current) =>
              previous.onGetById != current.onGetById,
          listener: (context, state) {
            if (state.onGetById is AsyncLoading) {
              const message = 'Loading...';
              showSnackbar(
                context: context,
                message: message,
                backgroundColor: Colors.blue,
              );
            }

            if (state.onGetById is AsyncError) {
              final error = state.onGetById.message;
              showSnackbar(
                context: context,
                message: error ?? 'Unknown error',
                backgroundColor: Colors.red,
              );
            }

            if (state.onGetById is AsyncSuccess) {
              final data = state.onGetById.data;
              if (data != null) {
                nameController.text = data.name;
                birthDateController.text =
                    data.birthDate.format("dd MMMM yyyy");
                ageController.text = data.age.toString();
                addressController.text = data.address;
                isMale = data.gender == GenderEnum.male;
                selectedBirthDate = data.birthDate;

                setState(() {});
              }
            }
          },
        ),

        // Listen onCreated event
        BlocListener<StudentCubit, StudentState>(
          listenWhen: (previous, current) =>
              previous.onCreate != current.onCreate,
          listener: (context, state) {
            if (state.onCreate is AsyncLoading) {
              const message = 'Creating...';
              showSnackbar(
                context: context,
                message: message,
                backgroundColor: Colors.blue,
              );
            }

            if (state.onCreate is AsyncError) {
              final error = state.onCreate.message;
              showSnackbar(
                context: context,
                message: error ?? 'Unknown error',
                backgroundColor: Colors.red,
              );
            }

            if (state.onCreate is AsyncSuccess) {
              const message = 'Create success';
              showSnackbar(
                context: context,
                message: message,
                backgroundColor: Colors.green,
              );

              // Back to previous page
              context.pop();
            }
          },
        ),

        // Listen onUpdate event
        BlocListener<StudentCubit, StudentState>(
          listenWhen: (previous, current) =>
              previous.onUpdate != current.onUpdate,
          listener: (context, state) {
            if (state.onUpdate is AsyncLoading) {
              const message = 'Updating...';
              showSnackbar(
                context: context,
                message: message,
                backgroundColor: Colors.blue,
              );
            }

            if (state.onUpdate is AsyncError) {
              final error = state.onUpdate.message;
              showSnackbar(
                context: context,
                message: error ?? 'Unknown error',
                backgroundColor: Colors.red,
              );
            }

            if (state.onUpdate is AsyncSuccess) {
              const message = 'Update success';
              showSnackbar(
                context: context,
                message: message,
                backgroundColor: Colors.green,
              );

              // Back to previous page
              context.pop();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Student Form'),
        ),
        body: Builder(builder: (context) {
          if (studentAsync is AsyncLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (studentAsync is AsyncError) {
            return Center(
              child: Text(studentAsync.message ?? 'Unknown error'),
            );
          }

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _FormColumn(
                    title: "Name Student",
                    child: TextFormField(
                      controller: nameController,
                      decoration: inputDecorationRounded().copyWith(
                        hintText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  _FormColumn(
                    title: "Birth Date",
                    child: TextFormField(
                      controller: birthDateController,
                      readOnly: true,
                      decoration: inputDecorationRounded().copyWith(
                        hintText: 'Birth Date',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Birth Date is required';
                        }
                        return null;
                      },
                      onTap: onTapBirthDate,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _FormColumn(
                    title: "Age",
                    child: TextFormField(
                      controller: ageController,
                      readOnly: true,
                      decoration: inputDecorationRounded().copyWith(
                        hintText: 'Age',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Age is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  _FormColumn(
                    title: "Gender",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RadioListTile.adaptive(
                          title: const Text("Male"),
                          value: true,
                          groupValue: isMale,
                          onChanged: (value) {
                            setState(() {
                              isMale = value as bool;
                            });
                          },
                        ),
                        RadioListTile.adaptive(
                          title: const Text("Female"),
                          value: false,
                          groupValue: isMale,
                          onChanged: (value) {
                            setState(() {
                              isMale = value as bool;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _FormColumn(
                    title: "Address",
                    child: TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 3,
                      maxLines: 5,
                      decoration: inputDecorationRounded().copyWith(
                        hintText: 'Address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Address is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onSubmit,
                      style: elevatedButtonStyle().copyWith(),
                      child: const Text('Save'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _FormColumn extends StatelessWidget {
  const _FormColumn({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: bodyFont.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
