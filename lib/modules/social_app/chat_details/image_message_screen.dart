import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/layout/social_app/cubit/cubit.dart';
import 'package:first_app/layout/social_app/cubit/states.dart';
import 'package:first_app/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/social_app/social_user_model.dart';

class ImageUploaded extends StatelessWidget {
  SocialUserModel? userModel;
  String? message1 = '';

  ImageUploaded({super.key,this.userModel,});

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getMessages(receiverId: userModel!.uId!,);
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Image',
            ),
          ),
          body: ConditionalBuilder(
            condition: state is SocialUploadMessageImageSuccessState && messageImg != '',
            builder: (context) => Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Card(
                        borderOnForeground: true,
                        child: Image.network(
                          messageImg ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: ()
                    {
                      if (messageImg != null)
                      {
                        SocialCubit.get(context).sendMessage(
                          receiverId: userModel!.uId!,
                          dateTime: DateTime.now().toString(),
                          text: message1!,
                          image: messageImg ?? '',
                          warning: false,
                        );
                        messageImg = null;
                        // Scroll to the last message
                        //0scrollDown();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter some text or select an image.')),
                        );
                      }
                      Navigator.pop(context);
                    },
                    child: Icon(IconBroken.Send),
                  ),
                ),
              ],
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}