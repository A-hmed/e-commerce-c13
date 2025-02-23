import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/auth/data/model/request/register_request.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<ApiResult<void>> execute(RegisterRequest request) =>
      _repository.register(request);
}
