import 'package:flutter_bloc/flutter_bloc.dart';

// 1. STATE: Tempat nyimpen data dan rumus
class SuhuState {
  final double inputSuhu;
  final String satuanAsal;

  SuhuState({this.inputSuhu = 10.0, this.satuanAsal = 'Celcius'});

  // Rumus konversi suhu tetap di sini biar rapi
  double getHasil(String target) {
    double celcius = 0;
    switch (satuanAsal) {
      case 'Celcius': celcius = inputSuhu; break;
      case 'Fahrenheit': celcius = (inputSuhu - 32) * 5 / 9; break;
      case 'Kelvin': celcius = inputSuhu - 273.15; break;
      case 'Reamur': celcius = inputSuhu * 5 / 4; break;
    }
    switch (target) {
      case 'Celcius': return celcius;
      case 'Fahrenheit': return (celcius * 9 / 5) + 32;
      case 'Kelvin': return celcius + 273.15;
      case 'Reamur': return celcius * 4 / 5;
      default: return 0;
    }
  }
}

// 2. CUBIT: Fungsi untuk ngubah data (State)
class KonversiSuhuCubit extends Cubit<SuhuState> {
  KonversiSuhuCubit() : super(SuhuState());

  void updateAngka(double angkaBaru) {
    emit(SuhuState(inputSuhu: angkaBaru, satuanAsal: state.satuanAsal));
  }

  void updateSatuan(String satuanBaru) {
    emit(SuhuState(inputSuhu: state.inputSuhu, satuanAsal: satuanBaru));
  }
}