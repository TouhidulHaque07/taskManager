
class acountModel{
  final String accountID;
  final String accountName;
  final String accountType;
  final String accountNumber;
  late double balance;

  acountModel(
      {required this.accountID,
      required this.accountName,
      required this.accountType,
      required this.accountNumber,
      required this.balance});
}