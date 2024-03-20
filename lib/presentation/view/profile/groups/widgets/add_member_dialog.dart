part of '../group_members_screen.dart';

class AddMemberDialog extends StatelessWidget {
  final HomeController homeController;
  final GlobalKey<FormState> form;
  final TextEditingController usernameController;
  final TextEditingController nicknameController;

  const AddMemberDialog({
    super.key,
    required this.homeController,
    required this.form,
    required this.usernameController,
    required this.nicknameController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       Stack(
        children: [
          Form(
            key: form,
            child: Column(
              children: [
                CustomTextFormField(
                  fillColor: AppTheme.isLightTheme == false
                      ? const Color(0xff323045)
                      : HexColor(AppTheme.primaryColorString!).withOpacity(0.05),
                  hintText: 'member username',
                  textEditingController: usernameController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'member username required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  fillColor: AppTheme.isLightTheme == false
                      ? const Color(0xff323045)
                      : HexColor(AppTheme.primaryColorString!).withOpacity(0.05),
                  hintText: 'member nickname',
                  textEditingController: nicknameController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'member nickname required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          homeController.loadingEditGroupMember.value
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2,
                    sigmaY: 2,
                  ),
                  child: const SizedBox(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
