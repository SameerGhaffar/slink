part of 'auth_cubit.dart';

class AuthState extends Equatable {
  DataState userState;

  AuthState({required this.userState});

  AuthState copyWith({DataState? userState}) {
    return AuthState(
      userState: userState ?? this.userState,
    );
  }

  @override
  List<Object?> get props => [userState];
}
