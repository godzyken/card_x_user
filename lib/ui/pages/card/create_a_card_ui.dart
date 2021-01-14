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
  final CardController cardController = CardController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CardModel cardModel;

  @override
  void initState() {
    print(Get.parameters);
    if (Get.parameters != null) {
      var id = Get.parameters["id"];
      if (id != null) {
        CardController.to.loadDetails(id).then((value) =>
            setState(() {
              cardModel = value;
              cardController.titreProController.text = cardModel.name as String;
            }));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: GetX(
            initState: (state) =>
                CardController.to.isLoadingDetails(Get.parameters.isNotEmpty),
            builder:(disposable) {
              if(CardController.to.isLoadingDetails.value) {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if(cardController.titreProController == null) {
                cardController.titreProController = TextEditingController(
                  text: cardController.titreProController.value.text,
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
                            controller: cardController.titreProController,
                            iconPrefix: Icons.business,
                            labelText: labels?.auth?.nameFormField,
                            validator: Validator(labels).name,
                            keyboardType: TextInputType.name,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                            cardController.titreProController.text = value,
                            maxLines: 1,
                          ),
                          FormVerticalSpace(),
                          //TODO lieu controller link to elasticsearch
                          //TODO lieu translate to labels on card
                          FormInputFieldWithIcon(
                            controller: cardController.lieuProController,
                            iconPrefix: Icons.location_on,
                            labelText: labels?.auth?.nameFormField,
                            // validator: Validator(labels).streetAdress,
                            keyboardType: TextInputType.streetAddress,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                            cardController.descriptionController.text = value,
                            maxLines: 2,
                          ),
                          FormVerticalSpace(),
                          //TODO Description pro
                          //TODO DescriptionFormField translate to labels on card
                          //TODO Description to validator list
                          FormInputFieldWithIcon(
                            controller: cardController.descriptionController,
                            iconPrefix: Icons.description,
                            labelText: labels?.auth?.nameFormField,
                            // validator: Validator(labels).name,
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                            cardController.descriptionController.text = value,
                            maxLines: 5,
                          ),
                          FormVerticalSpace(),
                          //TODO Contact pro
                          //TODO ContactFormField translate to labels on card
                          //TODO Contact to validator list
                          FormInputFieldWithIcon(
                            controller: cardController.contactProController,
                            iconPrefix: Icons.contact_page,
                            labelText: labels?.auth?.emailFormField,
                            // validator: Validator(labels).name,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                            cardController.contactProController.text = value,
                            maxLines: 2,
                          ),
                          FormVerticalSpace(),
                          //TODO Disponibility pro
                          //TODO DisponibilityFormField translate to labels on card
                          //TODO Disponibility to validator list
                          FormInputFieldWithIcon(
                            controller: cardController.dispoController,
                            iconPrefix: Icons.event_busy,
                            labelText: labels?.auth?.nameFormField,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                            cardController.dispoController.text = value,
                            maxLines: 2,
                          ),
                          FormVerticalSpace(),
                          //TODO Horaire pro
                          //TODO HoraireFormField translate to labels on card
                          //TODO Horaire to validator list
                          FormInputFieldWithIcon(
                            controller: cardController.horaireController,
                            iconPrefix: Icons.lock_clock,
                            labelText: labels?.auth?.nameFormField,
                            // validator: Validator(labels).name,
                            keyboardType: TextInputType.datetime,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                            cardController.horaireController.text = value,
                            maxLines: 2,
                          ),
                          FormVerticalSpace(),
                          //TODO Reference pro
                          //TODO ReferenceFormField translate to labels on card
                          //TODO Reference to validator list
                          FormInputFieldWithIcon(
                            controller: cardController.referenceController,
                            iconPrefix: Icons.room_preferences,
                            labelText: labels?.auth?.nameFormField,
                            keyboardType: TextInputType.url,
                            // onChanged: (value) => cardController.updateCard(context),
                            onSaved: (value) =>
                            cardController.referenceController.text = value,
                            maxLines: 2,
                          ),
                          Obx(
                                () => CardController.to.isAddingCard.value
                                ? Container(
                              child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.green,
                                  )),
                            )
                                : Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}
