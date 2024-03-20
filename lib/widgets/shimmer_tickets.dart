import 'package:finpay/core/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTickets extends StatelessWidget {
  final int? length;
  const ShimmerTickets({super.key, this.length});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
      
            child: ListView.separated(
      itemCount: 8,
      shrinkWrap: true,
      primary: false,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      padding: const EdgeInsets.only(bottom: 10),
      itemBuilder: (context, index) =>
           Container(
              height: 90,
              decoration: BoxDecoration(
                color: HexColor(AppTheme.primaryColorString!).withOpacity(0.8),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
             
            ),
          ),
        
    );
  }
}
