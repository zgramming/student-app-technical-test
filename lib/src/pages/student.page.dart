import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';
import '../models/model/student/student.model.dart';
import '../utils/async_state.dart';
import '../utils/function.dart';
import '../view_model/student_cubit.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  static Future<void> onDetail(
    BuildContext context,
    StudentModel item,
  ) async {
    context.pushNamed(routeDetailStudent, pathParameters: {
      'id': item.id.toString(),
    });
  }

  static Future<void> onAdd(BuildContext context) async {
    context.pushNamed(routeStudentForm, pathParameters: {
      'id': '-1',
    });
  }

  static Future<void> onEdit(
    BuildContext context,
    StudentModel item,
  ) async {
    context.pushNamed(routeStudentForm, pathParameters: {
      'id': item.id.toString(),
    });
  }

  static Future<void> onDelete(BuildContext context, StudentModel item) async {
    await context.read<StudentCubit>().delete(item.id);
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync =
        context.select<StudentCubit, AsyncState<List<StudentModel>?>>(
      (value) => value.state.onGetAll,
    );

    return MultiBlocListener(
      listeners: [
        // Listen onDelete event
        BlocListener<StudentCubit, StudentState>(
          listenWhen: (previous, current) =>
              previous.onDelete != current.onDelete,
          listener: (context, state) {
            if (state.onDelete is AsyncLoading) {
              const message = 'Deleting...';
              showSnackbar(
                context: context,
                message: message,
                backgroundColor: Colors.blue,
              );
            }

            if (state.onDelete is AsyncError) {
              final error = state.onDelete.message;
              showSnackbar(
                context: context,
                message: error ?? 'Unknown error',
                backgroundColor: Colors.red,
              );
            }

            if (state.onDelete is AsyncSuccess) {
              const message = 'Delete success';
              showSnackbar(
                context: context,
                message: message,
                backgroundColor: Colors.green,
              );
            }
          },
        ),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          Builder(builder: (context) {
            if (studentsAsync is AsyncLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (studentsAsync is AsyncError) {
              final error = studentsAsync.message;
              return Center(
                child: Text(
                  error ?? 'Unknown error',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            final students = context.select<StudentCubit, List<StudentModel>>(
              (value) => value.state.items,
            );
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              itemCount: students.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    onTap: () => onDetail(context, student),
                    leading: CircleAvatar(
                      radius: 15,
                      child: Text('${index + 1}'),
                    ),
                    title: Text(student.name),
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        IconButton(
                          onPressed: () => onEdit(context, student),
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () => onDelete(context, student),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => onAdd(context),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
