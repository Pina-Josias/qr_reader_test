import 'package:flutter/material.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';
import 'package:qr_code_feature/features/failures/cache_failure.dart';
import 'package:qr_code_feature/features/usecases/use_cases.dart';

/// Presenter for Home Page to manage the state of the view
class HomeNotifierPresenter extends ChangeNotifier {
  /// Create a new instance of [HomeNotifierPresenter]
  /// and inyect dependencies of use cases
  HomeNotifierPresenter({
    required DeleteCodeUseCase deleteCode,
    required LoadCodesUseCase loadCodes,
    required SaveCodeUseCase saveCode,
  })  : _deleteCode = deleteCode,
        _loadCodes = loadCodes,
        _saveCode = saveCode {
    _loading = false;
    _scannedCodes = List.empty();
  }

  /// `Use Cases Inyection`
  final DeleteCodeUseCase _deleteCode;
  final LoadCodesUseCase _loadCodes;
  final SaveCodeUseCase _saveCode;

  /// `Variables`
  late bool _loading;
  late List<ScannedCodeEntity> _scannedCodes;

  /// `Getters`
  /// Get loading state of the view
  bool get loading => _loading;

  /// Get scanned codes from cache data
  List<ScannedCodeEntity> get scannedCodes => _scannedCodes;

  /// `Setters`
  void _setScannedCodes(List<ScannedCodeEntity> codes) {
    _scannedCodes = codes;
    notifyListeners();
  }

  void _updateLoadingState(bool state) {
    _loading = state;
    notifyListeners();
  }

  /// `Procedures`

  /// Load codes from cache data by a use case
  Future<void> loadCodesFromUseCase() async {
    _updateLoadingState(!_loading);
    final _codesResponse = await _loadCodes.call(null);
    CacheFailure? _failure;
    if (_codesResponse!.isLeft) {
      _failure = _codesResponse.left as CacheFailure;
      _setScannedCodes(List.empty());
    } else {
      _failure = null;
      final _codes = _codesResponse.right.codes;
      _setScannedCodes(_codes);
    }

    _updateLoadingState(!_loading);
    if (_failure != null) return Future.error(_failure);
  }

  /// Save a new code to cache data by a use case
  Future<void> saveCodeToUseCase(ScannedCodeEntity code) async {
    _updateLoadingState(!_loading);
    final _exist = scannedCodes.any(
      (element) =>
          element.code == code.code && element.codeType == code.codeType,
    );

    CacheFailure? _errorFailure;

    if (_exist) {
      _errorFailure = const CacheFailure(error: 'Code already exists');
      _updateLoadingState(!_loading);
      return Future.error(_errorFailure);
    }

    final _codesCopy = [code, ..._scannedCodes];
    final _paramsSaveCode = ParamsSaveCode(codes: _codesCopy);
    final _saveCodeResponse = await _saveCode.call(_paramsSaveCode);
    if (_saveCodeResponse!.isLeft) {
      _errorFailure = _saveCodeResponse.left as CacheFailure;
    } else {
      _setScannedCodes(_codesCopy);
    }
    _updateLoadingState(!_loading);
    if (_errorFailure != null) return Future.error(_errorFailure);
  }

  /// Save a new code to cache data by a use case
  Future<void> deleteCodeToUseCase(ScannedCodeEntity code) async {
    _updateLoadingState(!_loading);
    CacheFailure? _errorFailure;
    final _codesCopy =
        _scannedCodes.where((element) => element != code).toList();
    final _paramsSaveCode = ParamsDeleteCode(codes: _codesCopy);
    final _saveCodeResponse = await _deleteCode.call(_paramsSaveCode);
    if (_saveCodeResponse!.isLeft) {
      _errorFailure = _saveCodeResponse.left as CacheFailure;
    } else {
      _setScannedCodes(_codesCopy);
    }
    _updateLoadingState(!_loading);
    if (_errorFailure != null) return Future.error(_errorFailure);
  }
}
