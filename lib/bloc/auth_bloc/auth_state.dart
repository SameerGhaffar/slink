part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final DataState userState;
  final int tabIndex;

  const AuthState({required this.userState, required this.tabIndex});

  AuthState copyWith({DataState? userState, int? index}) {
    return AuthState(
      userState: userState ?? this.userState,
      tabIndex: index ??  tabIndex,
    );
  }

  @override
  List<Object?> get props => [userState, tabIndex];
}
