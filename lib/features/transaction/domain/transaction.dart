import 'package:mbooking/features/transaction/data/models/transaction_model.dart';

class Transaction {
  final String trxId;
  final String uid;
  final int trxTime;
  final String movieImage;
  final String movieTitle;
  final int movieRuntime;
  final List<String> movieGenres;
  final String wathcingDate;
  final String wathcingTime;
  final String cinema;
  final String cinemaLocation;
  final int price;
  final int discount;
  final String status;
  final List<String> seats;
  Transaction({
    required this.trxId,
    required this.uid,
    required this.trxTime,
    required this.movieImage,
    required this.movieTitle,
    required this.movieRuntime,
    required this.movieGenres,
    required this.wathcingDate,
    required this.wathcingTime,
    required this.cinema,
    required this.cinemaLocation,
    required this.price,
    required this.discount,
    required this.status,
    required this.seats,
  });

  TransactionModel toModel() => TransactionModel(
        trxId: trxId,
        uid: uid,
        trxTime: trxTime,
        movieImage: movieImage,
        movieTitle: movieTitle,
        movieRuntime: movieRuntime,
        movieGenres: movieGenres,
        wathcingDate: wathcingDate,
        wathcingTime: wathcingTime,
        cinema: cinema,
        cinemaLocation: cinemaLocation,
        price: price,
        discount: discount,
        status: status,
        seats: seats,
      );
}
