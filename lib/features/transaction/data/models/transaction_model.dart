import 'package:mbooking/features/transaction/domain/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.trxId,
    required super.uid,
    required super.trxTime,
    required super.movieId,
    required super.movieImage,
    required super.movieTitle,
    required super.movieRuntime,
    required super.movieGenres,
    required super.wathcingDate,
    required super.wathcingTime,
    required super.cinema,
    required super.cinemaLocation,
    required super.price,
    required super.discount,
    required super.status,
    required super.seats,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trxId': trxId,
      'uid': uid,
      'trxTime': trxTime,
      'movieId': movieId,
      'movieImage': movieImage,
      'movieTitle': movieTitle,
      'movieRuntime': movieRuntime,
      'movieGenres': movieGenres,
      'wathcingDate': wathcingDate,
      'wathcingTime': wathcingTime,
      'cinema': cinema,
      'cinemaLocation': cinemaLocation,
      'price': price,
      'discount': discount,
      'status': status,
      'seats': seats,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      trxId: map['trxId'] as String,
      uid: map['uid'] as String,
      trxTime: map['trxTime'] as int,
      movieId: map['movieId'] as int,
      movieImage: map['movieImage'] as String,
      movieTitle: map['movieTitle'] as String,
      movieRuntime: map['movieRuntime'] as int,
      movieGenres: List<String>.from(map['movieGenres'] ?? []),
      wathcingDate: map['wathcingDate'] as String,
      wathcingTime: map['wathcingTime'] as String,
      cinema: map['cinema'] as String,
      cinemaLocation: map['cinemaLocation'] as String,
      price: map['price'] as int,
      discount: map['discount'] as int,
      status: map['status'] as String,
      seats: List<String>.from(map['seats'] ?? []),
    );
  }

  TransactionModel copyWith({
    String? trxId,
    String? uid,
    int? trxTime,
    int? movieId,
    String? movieImage,
    String? movieTitle,
    int? movieRuntime,
    List<String>? movieGenres,
    String? wathcingDate,
    String? wathcingTime,
    String? cinema,
    String? cinemaLocation,
    int? price,
    int? discount,
    String? status,
    List<String>? seats,
  }) {
    return TransactionModel(
      trxId: trxId ?? this.trxId,
      uid: uid ?? this.uid,
      trxTime: trxTime ?? this.trxTime,
      movieId: movieId ?? this.movieId,
      movieImage: movieImage ?? this.movieImage,
      movieTitle: movieTitle ?? this.movieTitle,
      movieRuntime: movieRuntime ?? this.movieRuntime,
      movieGenres: movieGenres ?? this.movieGenres,
      wathcingDate: wathcingDate ?? this.wathcingDate,
      wathcingTime: wathcingTime ?? this.wathcingTime,
      cinema: cinema ?? this.cinema,
      cinemaLocation: cinemaLocation ?? this.cinemaLocation,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      status: status ?? this.status,
      seats: seats ?? this.seats,
    );
  }
}
