import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/services/firebaseauth.dart';
import 'package:movie_app/services/firebaseuserservices.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _mode = ref.watch(modeProvider);
    final seedata = ref.watch(streamuserProvider);

    return Drawer(
      backgroundColor: _mode ? const Color(0xFF878484) : Colors.white,
      child: seedata.when(
        data: (data) {
          return Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              //image//
              const CircleAvatar(
                radius: 90,
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCczoMDFIc77qVeqtnJ26h8Yen0WXNfyLTIg&usqp=CAU"),
              ),

              //datas in drawer//
              ListTile(
                title: Text(
                  "name",
                  style: TextStyle(
                      color: !_mode ? const Color(0xff0a141c) : Colors.white,
                      fontFamily: "Righteous",
                      fontSize: ResponsiveSize.width(14, context)),
                ),
                subtitle: Text(
                  data.data() == null ? "Unknown" : data.data()!.name,
                  style: TextStyle(
                      color: !_mode ? const Color(0xff0a141c) : Colors.white,
                      fontFamily: "Righteous",
                      fontSize: ResponsiveSize.width(20, context)),
                ),
              ),
              const Divider(),

              //email text//
              ListTile(
                title: Text(
                  "Email",
                  style: TextStyle(
                      color: !_mode ? const Color(0xff0a141c) : Colors.white,
                      fontFamily: "Righteous",
                      fontSize: ResponsiveSize.width(14, context)),
                ),
                subtitle: Text(
                  data.data() == null ? "Unknown" : data.data()!.email,
                  style: TextStyle(
                      color: !_mode ? const Color(0xff0a141c) : Colors.white,
                      fontFamily: "Righteous",
                      fontSize: ResponsiveSize.width(20, context)),
                ),
              ),
              const Divider(),

              //help text//
              ListTile(
                title: Text(
                  "Help",
                  style: TextStyle(
                      color: !_mode ? const Color(0xff0a141c) : Colors.white,
                      fontFamily: "Righteous",
                      fontSize: ResponsiveSize.width(20, context)),
                ),
              ),
              const Divider(),
              //mode text and switch//
              ListTile(
                title: Text(
                  "Mode",
                  style: TextStyle(
                      color: !_mode ? const Color(0xff0a141c) : Colors.white,
                      fontFamily: "Righteous",
                      fontSize: ResponsiveSize.width(20, context)),
                ),
                trailing: Switch(
                  activeColor: Colors.white,
                  activeTrackColor: Colors.black,
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  value: _mode,
                  onChanged: (value) {
                    ref.read(modeProvider.notifier).state = value;
                  },
                ),
              ),
              const Divider(),

              ListTile(
                leading: ElevatedButton.icon(
                    onPressed: () async {
                      await ref.read(authProvider).logout();
                    },
                    icon: const Icon(Icons.logout_outlined),
                    label: const Text("Logout")),
              ),
              const Divider(),
            ],
          );
        },
        error: (error, stackTrace) {
          return const Center(child: Text("an error occured"));
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
