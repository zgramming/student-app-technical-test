// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/model/student/student.model.dart';
import '../utils/async_state.dart';
import '../utils/enum.dart';
import '../utils/extension.dart';
import '../view_model/student_cubit.dart';

class _RowSpan extends StatelessWidget {
  const _RowSpan({
    Key? key,
    required this.title,
    required this.value,
    // ignore: unused_element
    this.titleStyle,
    // ignore: unused_element
    this.valueStyle,
  }) : super(key: key);

  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: valueStyle,
          ),
        ),
      ],
    );
  }
}

class StudentDetailPage extends StatefulWidget {
  const StudentDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  Future<void> init() async {
    context.read<StudentCubit>().getById(widget.id);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  Widget build(BuildContext context) {
    final studentAsync =
        context.select<StudentCubit, AsyncState<StudentModel?>>(
      (value) => value.state.onGetById,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Student'),
      ),
      body: Builder(builder: (context) {
        if (studentAsync is AsyncLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (studentAsync is AsyncError) {
          return Center(
            child: Text(studentAsync.message ?? 'Error'),
          );
        }

        final student = studentAsync.data;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            margin: const EdgeInsets.only(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _RowSpan(title: "Name", value: "${student?.name}"),
                  const SizedBox(height: 20.0),
                  _RowSpan(
                    title: "Birth Date",
                    value: "${student?.birthDate.format("dd MMMM yyyy")}",
                  ),
                  const SizedBox(height: 20.0),
                  _RowSpan(title: "Age", value: "${student?.age}"),
                  const SizedBox(height: 20.0),
                  _RowSpan(
                    title: "Gender",
                    value: "${student?.gender.valueStringReadable}",
                  ),
                  const SizedBox(height: 20.0),
                  _RowSpan(title: "Address", value: "${student?.address}"),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
