// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../core/style/images_asset.dart';
import '../../../../data/models/wallet_model.dart';

class DebitCard extends StatelessWidget {
  final WalletModel walletModel;
  const DebitCard({super.key, required this.walletModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          walletModel.hidden.value
              ? DefaultImages.disabledDebitcard
              : DefaultImages.debitcard,
          fit: BoxFit.fill,
          width: double.infinity,
          height: 180,
        ),
        Positioned(
          left: 65,
          top: 22,
          child: Text(
            walletModel.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
          ),
        ),
        Positioned(
          left: 65,
          top: 75,
          child: Text(
            '${walletModel.price} ${walletModel.currency}',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
          ),
        ),
      ],
    );
  }
}
