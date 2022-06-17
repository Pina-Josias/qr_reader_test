import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_reader_test/main/factories/use_cases/use_cases.dart';
import 'package:qr_reader_test/presentation/presenters/home_notifier_presenter.dart';

/// Initilize provider presenter for Home Page
final homePagePresenter = homePageProvider();

/// Create the presenter notifier for Home Page
ChangeNotifierProvider<HomeNotifierPresenter> homePageProvider() =>
    ChangeNotifierProvider<HomeNotifierPresenter>(
      (ref) {
        return HomeNotifierPresenter(
          deleteCode: makeDeleteCodeUseCase(),
          loadCodes: makeLoadCodesUseCase(),
          saveCode: makeSaveCodeUseCase(),
        );
      },
    );
