import 'package:flutter/material.dart';
import 'package:ketabna/core/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Name",
                style: textStyleBig,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "My Books",
                style: textStyleBig,
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: CustomListTile(value: true),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatefulWidget {
  const CustomListTile({Key? key, required this.value}) : super(key: key);
  final bool value;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("Book Name"),
      trailing: Switch(
          value: value,
          onChanged: (val) {
            setState(() {
              value = val;
            });
          }),
    );
  }
}
