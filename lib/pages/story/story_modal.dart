import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stories/flutter_stories.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:lifeapp/pages/story/story.dart';

class StoryModal extends StatefulWidget {
  const StoryModal({Key? key}) : super(key: key);

  @override
  State<StoryModal> createState() => _StoryModalState();
}

class _StoryModalState extends State<StoryModal> with TickerProviderStateMixin {
  List<StoryModel> stories = [];

  @override
  void initState() {
    super.initState();
    stories.add(StoryModel(
        text:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
        image:
            'https://img.freepik.com/premium-photo/view-manhattan-sunset-new-york-city_268835-463.jpg'));
    stories.add(StoryModel(
        text:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
        image:
            'https://traveltomorrow.com/wp-content/uploads/2020/10/KXLI6726-1.jpg'));
    stories.add(StoryModel(
        text:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
        image:
            'https://cdn-prod.medicalnewstoday.com/content/images/articles/325/325466/man-walking-dog.jpg'));
    stories.add(StoryModel(
        text: 'd',
        image:
            'https://t4.ftcdn.net/jpg/02/83/83/93/360_F_283839302_yt6JIsE96Pj4PydFDcBNKDUnuSpYB9h0.jpg'));
    stories.add(StoryModel(
        text: 'awd',
        image:
            'https://t4.ftcdn.net/jpg/02/83/83/93/360_F_283839302_yt6JIsE96Pj4PydFDcBNKDUnuSpYB9h0.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Story(
      onFlashForward: Navigator.of(context).pop,
      onFlashBack: Navigator.of(context).pop,
      momentCount: 5,
      topOffset: 20,
      momentDurationGetter: (idx) => const Duration(seconds: 5),
      momentBuilder: (context, i) => _buildStoryItem(stories[i]),
    ));
  }

  Widget _buildStoryItem(StoryModel story) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
              imageUrl: story.image!,
              placeholder: (context, url) => ColoredBox(color: Colors.grey)),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.7),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: defaultText(story.text!,
                fontSize: 20, color: Colors.white, textAlign: TextAlign.center),
          ))
        ],
      ),
    );
  }
}
