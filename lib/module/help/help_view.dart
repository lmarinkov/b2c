import 'package:flutter/material.dart';
import '../../widget/navigation_drawer.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HelpPage extends StatelessWidget {
  static const String routeName = '/help';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help'),),
      drawer: NavigationDrawer(),
      body: HelpPageView(),
    );
  }
}

class HelpPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HelpPageState();
}

class HelpPageState extends State<HelpPageView>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: MarkdownBody(
                data: '# Help\n'
                    '![Direct Contact](http://dk.b2b-translation.de/images/searchResults.png#100x100)\n'
                    '---\n\n'
                    '\n'
                    '## **_Add Interpreter_** Workflow\n'
                    '---\n\n'
                    '### Go to the **My Profile**\n'
                    'Tap on the menu item My Profile\n'
                    '#### Add all Languages that you provide as Interpreter\n'
                    'Click on the Selection Arrow of the Box. A list of languages will be displayed. Select a language from the list.\n'
                    'After a language is selected a cosserponding chip item with the language name will be shown. This chip element may be removed by clicking on the exit icon\n'
                    'Continue this process till all languages are provided.\n'
                    '#### Click on the Chip if you are Certified Interpreter\n'
                    'Alternative clicks on the Certified Interpreter Chip will toogle a tick which marks a certification is available. The tick marks certification\n'
                    '#### Provide your First and Lastname\n'
                    '#### Provide your Phone Number\n'
                    'Your Phone Number will be verified\n'
                    '#### Provide your email\n'
                    '#### Provide years of expirience\n'
                    'Years of Expirience indicates how many years one has worked as an Interpreter\n\n'
                    '---\n\n'
                    '## **_Find Interpreter_** Workflow\n'
                    '---\n\n'
                    '### Set the **Home Location**\n'
                    'The home location is used to calculate the distance between your location and the location of the Interpreter\n'
                    '### Provide one or more **Languages** that will be interpreted.\n'
                    'Note that the current locale of the App will be included automatically in the Search. For example if the app is installed on a mobile with german locale and you need a interpreter from bulgarian to german then one should provide only bulgarian as language.\n'
                    '### Provide the **Distance Within**\n'
                    'Only Interpreters within the provided distance are considered.\n'
                    '### Provide the **Years of Expirience**\n'
                    'Interpreters with minimun the provided years of expierience will be considered for the Search\n'
                    '![Stop](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Vienna_Convention_road_sign_B2a.svg/240px-Vienna_Convention_road_sign_B2a.svg.png#30x30)\n'
                    '#### Note that at least one Language must be provided before a Search may be executed!'
            )));
  }
}