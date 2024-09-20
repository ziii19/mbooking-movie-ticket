part of 'booking_cubit.dart';

class BookingState {
  const BookingState(
      {this.movieTitle,
      this.movieImage,
      this.movieRuntime,
      this.movieGenres,
      this.cinema,
      this.seats = const [],
      this.wathcingDate,
      this.wathcingTime,
      this.price,
      this.discount = 0,
      this.trxId,
      this.uid,
      this.trxTime,
      this.status});

  final String? movieTitle;
  final String? movieImage;
  final int? movieRuntime;
  final List<String>? movieGenres;
  final String? cinema;
  final List<String>? seats;
  final int? wathcingDate;
  final int? wathcingTime;
  final int? price;
  final int? discount;
  final String? trxId;
  final String? uid;
  final int? trxTime;
  final String? status;

  factory BookingState.initial() => const BookingState();

  SeatStatus seatStatusChecker(String seat, List<String> reservedSeats) =>
      reservedSeats.contains(seat)
          ? SeatStatus.reserved
          : seats!.contains(seat)
              ? SeatStatus.selected
              : SeatStatus.available;

  int get total {
    return (price! * seats!.length) - discount!;
  }

  BookingState copyWith({
    String? movieTitle,
    String? movieImage,
    int? movieRuntime,
    List<String>? movieGenres,
    String? cinema,
    List<String>? seats,
    int? wathcingDate,
    int? wathcingTime,
    int? price,
    int? discount,
    String? trxId,
    String? uid,
    int? trxTime,
    String? status,
  }) {
    return BookingState(
      movieTitle: movieTitle ?? this.movieTitle,
      movieImage: movieImage ?? this.movieImage,
      movieRuntime: movieRuntime ?? this.movieRuntime,
      movieGenres: movieGenres ?? this.movieGenres,
      cinema: cinema ?? this.cinema,
      seats: seats ?? this.seats,
      wathcingDate: wathcingDate ?? this.wathcingDate,
      wathcingTime: wathcingTime ?? this.wathcingTime,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      trxId: trxId ?? this.trxId,
      uid: uid ?? this.uid,
      trxTime: trxTime ?? this.trxTime,
      status: status ?? this.status,
    );
  }
}
