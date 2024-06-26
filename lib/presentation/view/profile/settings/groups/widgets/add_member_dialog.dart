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
                  enabled: usernameController.text.isNotEmpty?false:true,
                  fillColor: AppTheme.isLightTheme == false
                      ? const Color(0xff323045)
                      : HexColor(AppTheme.primaryColorString!).withOpacity(0.05),
                  hintText: AppLocalizations.of(context)!.member_name,
                  textEditingController: usernameController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return   AppLocalizations.of(context)!.member_name_cant_be_empty;
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
                  hintText: AppLocalizations.of(context)!.member_nickname,
                  textEditingController: nicknameController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return AppLocalizations.of(context)!.member_nickname_cant_be_empty;
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
