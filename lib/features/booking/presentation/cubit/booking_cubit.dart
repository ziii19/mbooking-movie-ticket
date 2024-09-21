import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/constants/movie_booking_properti.dart';
import 'package:mbooking/core/constants/transaction_status.dart';
import 'package:mbooking/features/transaction/data/models/transaction_model.dart';

import '../../../../core/constants/cinema.dart';
import '../../../../core/constants/seat_status.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingState.initial());

  void pickSeat(String seat) {
    final seats = state.seats ?? []; // Menangani null
    final updatedSeats = [...seats]; // Menangani null

    if (!updatedSeats.contains(seat)) {
      updatedSeats.add(seat); // Tambahkan jika tidak ada
    } else {
      updatedSeats.remove(seat); // Hapus jika ada
    }

    emit(state.copyWith(seats: updatedSeats));
  }

  void addDiscount(int discount) {
    emit(state.copyWith(discount: discount));
  }

  void updateState({
    String? movieTitle,
    String? movieImage,
    int? movieRuntime,
    List<String>? movieGenres,
    int? cinema,
    List<String>? seats,
    int? wathcingDate,
    int? wathcingTime,
    int? price,
    int? disc,
    String? trxId,
    String? uid,
  }) {
    emit(
      state.copyWith(
        movieTitle: movieTitle ?? state.movieTitle,
        movieImage: movieImage ?? state.movieImage,
        movieRuntime: movieRuntime ?? state.movieRuntime,
        movieGenres: movieGenres ?? state.movieGenres,
        cinema: cinema ?? state.cinema,
        seats: seats ?? state.seats,
        wathcingDate: wathcingDate ?? state.wathcingDate,
        wathcingTime: wathcingTime ?? state.wathcingTime,
        price: price ?? state.price,
        discount: disc ?? state.discount,
        trxId: trxId,
        uid: uid,
      ),
    );
  }

  void resetState() {
    emit(BookingState.initial());
  }
}
