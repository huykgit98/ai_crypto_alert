import 'package:ai_crypto_alert/features/home/presentation/home_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenNotifier extends Notifier<HomeScreenState> {
  @override
  HomeScreenState build() {
    return HomeScreenState();
  }

  void swipeCard(bool isLeftSwipe) {
    final newDot = isLeftSwipe
        ? (state.selectedDot + 1).clamp(0, 4)
        : (state.selectedDot - 1).clamp(0, 4);

    // List of account names
    final accountNames = [
      'Default Account',
      'Savings Account',
      'Checking Account',
      'Investment Account',
      'Retirement Account'
    ];

    // Update other data as per the selected card
    final updatedBalance = '\$${100000 + newDot * 1000}';
    final updatedIncome = '\$${10000 + newDot * 500}';
    final updatedExpenses = '\$${5000 + newDot * 300}';
    final updatedAccountName = accountNames[newDot];

    state = state.copyWith(
      selectedDot: newDot,
      totalBalance: updatedBalance,
      income: updatedIncome,
      expenses: updatedExpenses,
      accountName: updatedAccountName,
    );
  }
}

final homeScreenProvider =
    NotifierProvider<HomeScreenNotifier, HomeScreenState>(
  HomeScreenNotifier.new,
);

final totalBalanceVisibilityProvider = StateProvider<bool>((ref) => true);
