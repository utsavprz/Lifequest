import 'package:flutter/material.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/campaign.dart';
import 'package:lifequest/providers/campaign_provider.dart';
import 'package:intl/intl.dart';

class CampaignList extends StatefulWidget {
  const CampaignList({super.key});

  @override
  State<CampaignList> createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList> {
  List<Campaign> campaignLst = container.read(campaignProvider);

  final dateFormat = DateFormat.yMMMMd();
  final timeFormat = DateFormat.jm();

  getDate(String datetimeOrganized) {
    final dateTime = DateTime.tryParse(datetimeOrganized);
    final dateOrganized =
        dateTime != null ? dateFormat.format(dateTime) : 'Invalid date format';
    final timeOrganized = dateTime != null ? timeFormat.format(dateTime) : '';

    return {
      'dateOrganized': dateOrganized,
      'timeOrganized': timeOrganized,
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: campaignLst.length,
      itemBuilder: (context, index) {
        print(campaignLst);
        return Card(
            elevation: 3,
            margin: const EdgeInsetsDirectional.symmetric(vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        campaignLst[index].name.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 0.5,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 93, 93, 93)),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location:',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            'Event Date:',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            'Event Time:',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(children: [
                            Text(
                              campaignLst[index].streetName.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              ', ',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              campaignLst[index].city.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ]),
                          Text(
                            getDate(campaignLst[index]
                                .datetimeOrganized
                                .toString())['dateOrganized'],
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            getDate(campaignLst[index]
                                .datetimeOrganized
                                .toString())['timeOrganized'],
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
            // ListTile(
            //   title: Text(campaignLst[index].name.toString()),
            //   subtitle: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Wrap(children: [
            //         Text(campaignLst[index].streetName.toString()),
            //         const Text(', '),
            //         Text(campaignLst[index].city.toString())
            //       ]),
            //       Text(getDate(campaignLst[index].datetimeOrganized.toString())[
            //           'dateOrganized'])
            //     ],
            //   ),
            // ),
            );
      },
    );
  }
}
