import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:insta_closet/config/storage.dart';
import 'package:insta_closet/services/rest_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@singleton
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthEvent>((event, emit) async {
      if (event is AppStarted) {
        await storage.prepareAuth();
        var accessToken = await storage.getAuthToken();
        if (storage.auth.user?.id != null && accessToken != null) {
          emit(state.copyWith(
              auth: storage.auth, status: AuthenticationStatus.authenticated));
        } else {
          emit(state.copyWith(
              auth: null, status: AuthenticationStatus.unauthenticated));
        }
      }

      if (event is LoggedIn) {
        storage.save(event.auth);
        emit(state.copyWith(
            auth: event.auth, status: AuthenticationStatus.authenticated));
      }

      if (event is LoggedOut) {
        await Future.wait([
          storage.delete(),
        ]);
        RestService.dispose();

        emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
      }
    });
  }
}

AuthStorage storage = AuthStorage.instance;
RestService dio = RestService();
