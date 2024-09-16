part of '../profile_page.dart';

class _UserProfile extends StatelessWidget {
  const _UserProfile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is UserSuccess) {
          final user = state.user;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.border,
                  image: user.photoUrl == null
                      ? null
                      : DecorationImage(
                          image: NetworkImage(user.photoUrl!),
                          fit: BoxFit.cover,
                        ),
                ),
                child: user.photoUrl == null
                    ? const Center(
                        child: Icon(
                          Icons.person_2_rounded,
                          size: 60,
                          color: AppColors.outline,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 24.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalize(user.name),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        height: 2,
                      ),
                    ),
                    BuildUserInfo(
                      icon: Icons.phone,
                      text: user.phoneNumber == null
                          ? '08xxxxxxxxx'
                          : user.phoneNumber.toString(),
                    ),
                    BuildUserInfo(
                      icon: Icons.mail_outline,
                      text: user.email,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_note,
                  color: AppColors.white,
                ),
              )
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
