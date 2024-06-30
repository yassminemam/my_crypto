import 'package:hive/hive.dart';
part 'user_holding.g.dart';

@HiveType(typeId: 0)
class UserHolding extends HiveObject{
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? symbol;
  @HiveField(2)
  double? quantity;
  @HiveField(3)
  double? currentPrice;
  @HiveField(4)
  double? totalPrice;

  UserHolding({this.name, this.symbol, this.quantity, this.currentPrice,
      this.totalPrice});
}
