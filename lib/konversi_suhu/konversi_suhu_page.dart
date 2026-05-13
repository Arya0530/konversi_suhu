import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'konversi_suhu_cubit.dart';
import 'konversi_suhu_view.dart';

class KonversiSuhuPage extends StatelessWidget {
  const KonversiSuhuPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => KonversiSuhuCubit(),
      child: const KonversiSuhuView(),
    );
  }
}