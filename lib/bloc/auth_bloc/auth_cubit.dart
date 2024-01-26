import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:slink/utils/functions.dart';
import 'package:slink/utils/state.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(userState: DataState.waiting));

  Future<void> logIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      emit(state.copyWith(userState: DataState.loading));
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(state.copyWith(userState: DataState.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(userState: DataState.fail));
      Functions.showSnackBar(context, e.code.toString());
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      emit(state.copyWith(userState: DataState.loading));
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(state.copyWith(userState: DataState.success));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(userState: DataState.fail));
    }
  }

  Future<void> logOut() async {
    try {
      emit(state.copyWith(userState: DataState.loading));
      await FirebaseAuth.instance.signOut();
      emit(state.copyWith(userState: DataState.success));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(userState: DataState.fail));
    }
  }
}
