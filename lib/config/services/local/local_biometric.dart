import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';

import '../../error_handler.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> availableBiometric() async {
    final bool canAuthenticate =
        await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    if (!canAuthenticate) {
      return false;
    }
    final List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      return false;
    }
    if (!availableBiometrics.contains(BiometricType.fingerprint) &&
        !!availableBiometrics.contains(
          BiometricType.face,
        )) {
      return false;
    }
    return true;
  }

  Future<Either<Failure, bool>> verifyFingerPrint() async {
    final bool didAuthenticate = await _auth.authenticate(
      localizedReason: 'Please authenticate to Proceed',
      options: const AuthenticationOptions(
        biometricOnly: true,
      ),
    );
    if (didAuthenticate) {
      return const Right(true);
    } else {
      return Left(
        ServiceFailure('sign in cancelled'),
      );
    }
  }
}
