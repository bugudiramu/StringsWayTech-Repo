import 'package:flutter/material.dart';
import 'package:news/pages/detailnews.dart';

class NewsTab extends StatefulWidget {
  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  var news = [
    {
      'id': 1,
      'title':
          'Kashmir Live: India slams downgrading of ties, says Pak can not take unilateral decisions',
      'image': 'images/placeholder.png',
      'desc':
          'Restrictions will be eased to allow people in Kashmir to offer Friday prayers. With situation relatively peaceful in Jammu, security forces have been put on high alert across Kashmir preempting possible protests against the scraping of special status to Jammu and Kashmir. This cane after Prime Minister Narendra Modi addressed the nation on Kashmir on Thursday. In his televised address, PM Modi said the decision was taken to usher in development in Jammu, Kashmir and Ladakh and assured that the state will not be a Union Territory for long. The PM also assured the people that the government was ensuring they don not face any difficulties in celebrating Eid on August 12.',
      'pubby': 'StringsWayTech',
    },
    {
      'id': 2,
      'title':
          'Kashmir Live: India slams downgrading of ties, says Pak can not take unilateral decisions',
      'image': 'images/placeholder.png',
      'desc':
          'Restrictions will be eased to allow people in Kashmir to offer Friday prayers. With situation relatively peaceful in Jammu, security forces have been put on high alert across Kashmir preempting possible protests against the scraping of special status to Jammu and Kashmir. This cane after Prime Minister Narendra Modi addressed the nation on Kashmir on Thursday. In his televised address, PM Modi said the decision was taken to usher in development in Jammu, Kashmir and Ladakh and assured that the state will not be a Union Territory for long. The PM also assured the people that the government was ensuring they don not face any difficulties in celebrating Eid on August 12.',
      'pubby': 'StringsWayTech',
    },
    {
      'id': 3,
      'title':
          'Kashmir Live: India slams downgrading of ties, says Pak can not take unilateral decisions',
      'image': 'images/placeholder.png',
      'desc':
          'Restrictions will be eased to allow people in Kashmir to offer Friday prayers. With situation relatively peaceful in Jammu, security forces have been put on high alert across Kashmir preempting possible protests against the scraping of special status to Jammu and Kashmir. This cane after Prime Minister Narendra Modi addressed the nation on Kashmir on Thursday. In his televised address, PM Modi said the decision was taken to usher in development in Jammu, Kashmir and Ladakh and assured that the state will not be a Union Territory for long. The PM also assured the people that the government was ensuring they don not face any difficulties in celebrating Eid on August 12.',
      'pubby': 'StringsWayTech',
    },
    {
      'id': 4,
      'title':
          'Kashmir Live: India slams downgrading of ties, says Pak can not take unilateral decisions',
      'image': 'images/placeholder.png',
      'desc':
          'Restrictions will be eased to allow people in Kashmir to offer Friday prayers. With situation relatively peaceful in Jammu, security forces have been put on high alert across Kashmir preempting possible protests against the scraping of special status to Jammu and Kashmir. This cane after Prime Minister Narendra Modi addressed the nation on Kashmir on Thursday. In his televised address, PM Modi said the decision was taken to usher in development in Jammu, Kashmir and Ladakh and assured that the state will not be a Union Territory for long. The PM also assured the people that the government was ensuring they don not face any difficulties in celebrating Eid on August 12.',
      'pubby': 'StringsWayTech',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.title;
    return ListView.builder(
      itemCount: news == null ? 0 : news.length,
      itemBuilder: (BuildContext context, int i) {
        return Column(
          children: <Widget>[
            Hero(
              tag: news[i]['id'],
              child: Container(
                // color: Colors.yellow,
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                alignment: Alignment.topLeft,
                child: Image.asset(
                  news[i]['image'],
                  height: 40.0,
                  width: 40.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
              alignment: Alignment.topLeft,
              child: Text(
                news[i]['title'],
                style: title,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("2 mins ago"),
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetaileNews(
                            title: news[i]['title'],
                            image: news[i]['image'],
                            desc: news[i]['desc'],
                            pubby: news[i]['pubby'],
                            id:news[i]['id'],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
