class HomeScreenState {
  HomeScreenState({
    this.selectedDot = 0,
    this.totalBalance = "\$100000",
    this.income = "\$10,000",
    this.expenses = "\$5,000",
    this.accountName = 'Default Account',
  });

  final int selectedDot;
  final String totalBalance;
  final String income;
  final String expenses;
  final String accountName;

  HomeScreenState copyWith({
    int? selectedDot,
    String? totalBalance,
    String? income,
    String? expenses,
    String? accountName,
  }) {
    return HomeScreenState(
      selectedDot: selectedDot ?? this.selectedDot,
      totalBalance: totalBalance ?? this.totalBalance,
      income: income ?? this.income,
      expenses: expenses ?? this.expenses,
      accountName: accountName ?? this.accountName,
    );
  }
}
