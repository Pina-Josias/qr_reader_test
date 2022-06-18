import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_feature/features/usecases/use_cases.dart';
import 'package:qr_reader_test/presentation/presenters/home_notifier_presenter.dart';

/// Initilize provider presenter for Home Page
final homePagePresenter = homePageProvider();

/// Create the presenter notifier for Home Page
ChangeNotifierProvider<HomeNotifierPresenter> homePageProvider() =>
    ChangeNotifierProvider<HomeNotifierPresenter>(
      (ref) {
        return HomeNotifierPresenter(
          deleteCode: GetIt.I<DeleteCodeUseCase>(),
          loadCodes: GetIt.I<LoadCodesUseCase>(),
          saveCode: GetIt.I<SaveCodeUseCase>(),
        );
      },
    );
