part of '../group_members_screen.dart';

class NoMembersCard extends StatelessWidget {
  final GroupModel group;
  final HomeController homeController;
  const NoMembersCard(
      {super.key, required this.group, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          group.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
        ),
        Text(
          'Created At: ${group.creationDate}, ${group.creationTime}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 10,
                color: Colors.white,
              ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              Flexible(
                child: AutoSizeText(
                  minFontSize: 8,
                 group.about,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                ),
              ),
              const Icon(
                Icons.people_alt_rounded,
                color: Color.fromARGB(255, 255, 191, 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.members,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 191, 1)),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    '${homeController.groupMembers.length}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 191, 1)),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
