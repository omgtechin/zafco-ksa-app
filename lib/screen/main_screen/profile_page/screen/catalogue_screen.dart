import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';


import '../../../../core/constant.dart';
import '../../../../core/enum/connection_status.dart';
import '../../../../core/services/pdf_download_service.dart';
import '../../../../model/data_model/catalogue_model.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../widget/loading_idicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CataloguePage extends StatefulWidget {
  const CataloguePage({Key? key}) : super(key: key);

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  @override
  void initState() {
    var data = Provider.of<ProfileProvider>(context, listen: false);
    SchedulerBinding.instance
        .addPostFrameCallback((_) => data.getCatalogue(context: context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.catalogue,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: Colors.black),
        ),
      ),
      body: Consumer<ProfileProvider>(builder: (context, data, _) {
        if (data.connectionStatus == ConnectionStatus.done) {
          List<Catalogues> catalogues = data.catalogueModel.catalogues;
          return catalogues.isEmpty?  Center(
            child: Text(AppLocalizations.of(context)!.noCatalogueFound),
          ): SingleChildScrollView(
            child: Column(
              children: [
                ...catalogues
                    .map((catalogue) => Container(
                  decoration: Constant().boxDecoration,
                  margin:
                  EdgeInsets.only(left: 12, right: 12, bottom: 18),
                  child: ExpansionTile(
                    expandedCrossAxisAlignment:
                    CrossAxisAlignment.start,
                    expandedAlignment: Alignment.centerLeft,
                    title: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 80,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Image.network(
                              catalogue.brand.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, bottom: 12, right: 18),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Divider(
                              thickness: .5,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.5),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            ...catalogue.files
                                .map((file) => Padding(
                              padding: const EdgeInsets.only(
                                  right: 18.0),
                              child: InkWell(
                                onTap: () async {
                                  FileDownloadService service =
                                  FileDownloadService();
                                  showDialog(
                                      context: context,
                                      builder: (builder) {
                                        return AlertDialog(
                                            title: Row(
                                              children: [
                                                Text(
                                                    "Downloading..."),
                                                Spacer(),
                                                CircularProgressIndicator(),
                                              ],
                                            ));
                                      });
                                  await service.downloadFile(
                                      url: file.file,
                                      name: "${file.name}.pdf");
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.05),
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(
                                              8)),
                                      border: Border.all(
                                          color: Theme.of(
                                              context)
                                              .primaryColor)),
                                  child: Text(
                                    file.name,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColor,
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w700),
                                  ),
                                ),
                              ),
                            ))
                                .toList()
                          ],
                        ),
                      )
                    ],
                  ),
                ))
                    .toList()
              ],
            ),
          );
        } else if (data.connectionStatus == ConnectionStatus.error) {
          return Center(
            child: Text(AppLocalizations.of(context)!.wrongText),
          );
        } else {
          return Center(
            child: LoadingIndicator(),
          );
        }
      }),
    );
  }
}
