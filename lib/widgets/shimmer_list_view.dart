import 'package:finpay/core/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListView extends StatelessWidget {
  final int? length;
  const ShimmerListView({super.key, this.length});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
      child: ListView.separated(
        itemCount:length?? 3,
        shrinkWrap: true,
        primary: false,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        padding: const EdgeInsets.only(bottom: 10),
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: HexColor(AppTheme.primaryColorString!),
          ),
          title: const Divider(
            thickness: 5,
          ),
          subtitle: const Divider(
            thickness: 5,
          ),
          trailing: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                child: Divider(
                  thickness: 5,
                ),
              ),
              SizedBox(
                width: 20,
                child: Divider(
                  thickness: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
