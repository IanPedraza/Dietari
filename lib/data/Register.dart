import 'package:dietari/data/datasources/TestsDataSource.dart';
import 'package:dietari/data/datasources/TipsDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/framework/firebase/FirebaseTestsDataSource.dart';
import 'package:dietari/data/framework/firebase/FirebaseTipsDataSource.dart';
import 'package:dietari/data/framework/firebase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/repositories/TestsRepository.dart';
import 'package:dietari/data/repositories/TipsRepository.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/AddTestUseCase.dart';
import 'package:dietari/data/usecases/AddUserTestUseCase.dart';
import 'package:dietari/data/usecases/AddUserUseCase.dart';
import 'package:dietari/data/usecases/GetTestUseCase.dart';
import 'package:dietari/data/usecases/GetTestsUseCase.dart';
import 'package:dietari/data/usecases/GetTipsUseCase.dart';
import 'package:dietari/data/usecases/GetUserHistoryUseCase.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/GetUserListenerUseCase.dart';
import 'package:dietari/data/usecases/GetUserTestUseCase.dart';
import 'package:dietari/data/usecases/GetUserTipsUseCase.dart';
import 'package:dietari/data/usecases/GetUserUseCase.dart';
import 'package:dietari/data/usecases/SendPasswordResetEmailUseCase.dart';
import 'package:dietari/data/usecases/SignInWithEmailUseCase.dart';
import 'package:dietari/data/usecases/SignInWithGoogleUseCase.dart';
import 'package:dietari/data/usecases/SignOutUseCase.dart';
import 'package:dietari/data/usecases/SignUpWithEmailUseCase.dart';
import 'package:dietari/data/usecases/UpdateUserUseCase.dart';
import 'package:injector/injector.dart';

import 'datasources/AuthDataSource.dart';
import 'framework/firebase/FirebaseAuthDataSource.dart';

class Register {
  static void regist() {
    final injector = Injector.appInstance;

    /*********** Data Sources **********/

    injector.registerDependency<AuthDataSource>(() => FirebaseAuthDataSource());

    injector
        .registerDependency<TestsDataSource>(() => FirebaseTestsDataSource());

    injector.registerDependency<TipsDataSource>(() => FirebaseTipsDataSource());

    injector.registerDependency<UserDataSource>(() => FirebaseUserDataSouce());

    /*********** Repositories **********/

    injector.registerDependency<AuthRepository>(
        () => AuthRepository(authDataSource: injector.get<AuthDataSource>()));

    injector.registerDependency<TestsRepository>(() =>
        TestsRepository(testsDataSource: injector.get<TestsDataSource>()));

    injector.registerDependency<TipsRepository>(
        () => TipsRepository(tipsDataSource: injector.get<TipsDataSource>()));

    injector.registerDependency<UserRepository>(
        () => UserRepository(userDataSource: injector.get<UserDataSource>()));

    /*********** Use Cases **********/

    injector.registerDependency<AddTestUseCase>(
        () => AddTestUseCase(testsRepository: injector.get<TestsRepository>()));

    injector.registerDependency<AddUserTestUseCase>(() =>
        AddUserTestUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<AddUserUseCase>(
        () => AddUserUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<GetUserListenerUseCase>(() =>
        GetUserListenerUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<GetTestsUseCase>(() =>
        GetTestsUseCase(testsRepository: injector.get<TestsRepository>()));

    injector.registerDependency<GetTestUseCase>(
        () => GetTestUseCase(testsRepository: injector.get<TestsRepository>()));

    injector.registerDependency<GetTipsUseCase>(
        () => GetTipsUseCase(tipsRepository: injector.get<TipsRepository>()));

    injector.registerDependency<GetUserHistoryUseCase>(() =>
        GetUserHistoryUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<GetUserIdUseCase>(
        () => GetUserIdUseCase(authRepository: injector.get<AuthRepository>()));

    injector.registerDependency<GetUserTestUseCase>(() =>
        GetUserTestUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<GetUserTipsUseCase>(() =>
        GetUserTipsUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<GetUserUseCase>(
        () => GetUserUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<SendPasswordResetEmailUseCase>(() =>
        SendPasswordResetEmailUseCase(
            authRepository: injector.get<AuthRepository>()));

    injector.registerDependency<SignInWithEmailUseCase>(() =>
        SignInWithEmailUseCase(authRepository: injector.get<AuthRepository>()));

    injector.registerDependency<SignInWithGoogleUseCase>(() =>
        SignInWithGoogleUseCase(
            authRepository: injector.get<AuthRepository>()));

    injector.registerDependency<SignOutUseCase>(
        () => SignOutUseCase(authRepository: injector.get<AuthRepository>()));

    injector.registerDependency<SignUpWithEmailUseCase>(() =>
        SignUpWithEmailUseCase(authRepository: injector.get<AuthRepository>()));

    injector.registerDependency<UpdateUserUseCase>(() =>
        UpdateUserUseCase(userRepository: injector.get<UserRepository>()));
  }
}
