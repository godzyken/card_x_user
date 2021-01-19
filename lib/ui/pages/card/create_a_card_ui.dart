import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/helpers/helpers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateACardUi extends StatefulWidget {
  CreateACardUi({Key key}) : super(key: key);

  @override
  _CreateACardUiState createState() => _CreateACardUiState();
}

class _CreateACardUiState extends State<CreateACardUi> {
  final cardController = CardController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CardModelu cardModel;

  @override
  void initState() {
    print(Get.parameters);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
          image: NetworkImage(
              "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('create-a-card'.tr),
            backgroundColor: Colors.white10,
            elevation: 0,
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GetX<CardController>(
                initState: (state) =>
                    null,
                builder:(disposable) {
                  if(null) {
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if('' == null) {
                    cardModel.name = TextEditingController(
                      text: null,
                    );
                  }
                  return Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              LogoGraphicHeader(),
                              SizedBox(height: 48.0),
                              //TODO titre pro link to elasticsearch
                              //TODO titreFormField translate to labels on card
                              //TODO titre pro to validator list
                              FormInputFieldWithIcon(
                                controller: cardModel.name,
                                iconPrefix: Icons.business,
                                labelText: labels?.auth?.nameFormField,
                                validator: Validator(labels).name,
                                keyboardType: TextInputType.name,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                cardModel.name = value,
                                maxLines: 1,
                              ),
                              FormVerticalSpace(),
                              //TODO lieu controller link to elasticsearch
                              //TODO lieu translate to labels on card
                              FormInputFieldWithIcon(
                                controller: cardModel.name,
                                iconPrefix: Icons.location_on,
                                labelText: labels?.auth?.nameFormField,
                                // validator: Validator(labels).streetAdress,
                                keyboardType: TextInputType.streetAddress,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                cardModel.name = value,
                                maxLines: 2,
                              ),
                              FormVerticalSpace(),
                              //TODO Description pro
                              //TODO DescriptionFormField translate to labels on card
                              //TODO Description to validator list
                              FormInputFieldWithIcon(
                                controller: cardModel.name,
                                iconPrefix: Icons.description,
                                labelText: labels?.auth?.nameFormField,
                                // validator: Validator(labels).name,
                                keyboardType: TextInputType.multiline,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                cardModel.name = value,
                                maxLines: 5,
                              ),
                              FormVerticalSpace(),
                              //TODO Contact pro
                              //TODO ContactFormField translate to labels on card
                              //TODO Contact to validator list
                              FormInputFieldWithIcon(
                                controller: cardModel.name,
                                iconPrefix: Icons.contact_page,
                                labelText: labels?.auth?.emailFormField,
                                // validator: Validator(labels).name,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                cardModel.name= value,
                                maxLines: 2,
                              ),
                              FormVerticalSpace(),
                              //TODO Disponibility pro
                              //TODO DisponibilityFormField translate to labels on card
                              //TODO Disponibility to validator list
                              FormInputFieldWithIcon(
                                controller: cardModel.dateCreated,
                                iconPrefix: Icons.event_busy,
                                labelText: labels?.auth?.nameFormField,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                cardModel.dateCreated = value,
                                maxLines: 2,
                              ),
                              FormVerticalSpace(),
                              //TODO Horaire pro
                              //TODO HoraireFormField translate to labels on card
                              //TODO Horaire to validator list
                              FormInputFieldWithIcon(
                                controller: null,
                                iconPrefix: Icons.lock_clock,
                                labelText: labels?.auth?.nameFormField,
                                // validator: Validator(labels).name,
                                keyboardType: TextInputType.datetime,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                null,
                                maxLines: 2,
                              ),
                              FormVerticalSpace(),
                              //TODO Reference pro
                              //TODO ReferenceFormField translate to labels on card
                              //TODO Reference to validator list
                              FormInputFieldWithIcon(
                                controller: null,
                                iconPrefix: Icons.room_preferences,
                                labelText: labels?.auth?.nameFormField,
                                keyboardType: TextInputType.url,
                                // onChanged: (value) => cardController.updateCard(context),
                                onSaved: (value) =>
                                null,
                                maxLines: 2,
                              ),
                              Obx(
                                    () => null
                                    ? Container(
                                  child: Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.green,
                                      )),
                                )
                                    : FlatButton(
                                        onPressed: () => null,
                                        child: Text(
                                          "Change the value",
                                          style: TextStyle(color: Colors.white),
                                        )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
      ),
    );
  }
}
