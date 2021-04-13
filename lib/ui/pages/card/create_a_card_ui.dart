import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';

class CreateACardUi extends StatelessWidget {
  final String? uid;
  final CardUserModel? cardUserModel;

  const CreateACardUi({Key? key, this.uid, this.cardUserModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final labels = AppLocalizations.of(context)!;
    final FormXController fx = FormXController.to;

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
            title: Text(labels.card!.createACard!),
            backgroundColor: Colors.white10,
            elevation: 0,
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GetX<AuthController>(
                initState: (state) => AuthController.to,
                builder: (disposable) {
                  if (disposable.firestoreUser!.value?.uid == null) {
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return buildFormEditCard(_formKey, disposable, fx, labels);
                },
              ),
            ),
          )),
    );
  }

  Form buildFormEditCard(
      GlobalKey<FormState> _formKey,
      AuthController disposable,
      FormXController fx,
      AppLocalizations_Labels labels) {
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
                Avatar(disposable.firestoreUser!.value),
                SizedBox(height: 48.0),
                //TODO titre pro link to elasticsearch
                FormInputFieldWithIcon(
                  controller: fx.jobTitle.value,
                  iconPrefix: Icons.business,
                  labelText: labels.card?.title,
                  // validator: helpers.Validator(labels).name,
                  keyboardType: TextInputType.name,
                  onChanged: (value) => fx.jobTitle.value,
                  onSaved: (value) => fx.cardUserModel.value.job = value,
                  maxLines: 1,
                ),
                FormVerticalSpace(),
                //TODO lieu controller link to elasticsearch
                FormInputFieldWithIcon(
                  controller: fx.jobLocation.value,
                  iconPrefix: Icons.location_on,
                  labelText: labels.card?.location,
                  // validator: Validator(labels).streetAdress,
                  keyboardType: TextInputType.streetAddress,
                  onChanged: (value) => fx.jobLocation.value,
                  onSaved: (value) => fx.cardUserModel.value.location = value,
                  maxLines: 2,
                ),
                FormVerticalSpace(),
                //TODO activity controller link to elasticsearch
                FormInputFieldWithIcon(
                  controller: fx.jobActivitySector.value,
                  iconPrefix: Icons.local_activity,
                  labelText: labels.card?.activity,
                  // validator: Validator(labels).streetAdress,
                  keyboardType: TextInputType.name,
                  onChanged: (value) => fx.jobActivitySector.value,
                  onSaved: (value) => fx.cardUserModel.value.activity = value,
                  maxLines: 2,
                ),
                FormVerticalSpace(),
                FormInputFieldWithIcon(
                  controller: fx.jobDesc.value,
                  iconPrefix: Icons.description,
                  labelText: labels.card?.description,
                  // validator: Validator(labels).name,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) => fx.jobDesc.value,
                  onSaved: (value) =>
                      fx.cardUserModel.value.description = value,
                  maxLines: 5,
                ),
                FormVerticalSpace(),
                //TODO Contact pro validator list
                FormInputFieldWithIcon(
                  controller: fx.jobContact.value,
                  iconPrefix: Icons.contact_page,
                  labelText: labels.card?.contact,
                  // validator: Validator(labels).name,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => fx.jobContact.value,
                  onSaved: (value) => fx.cardUserModel.value.contact = value,
                  maxLines: 2,
                ),
                FormVerticalSpace(),
                //TODO number pro validator list
                FormInputFieldWithIcon(
                  controller: fx.jobNumber.value,
                  iconPrefix: Icons.call,
                  labelText: labels.card?.phoneNumber,
                  // validator: helpers.Validator(labels).number,
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) => fx.jobNumber.value,
                  onSaved: (value) => fx.cardUserModel.value.number = value,
                  maxLines: 2,
                ),
                FormVerticalSpace(),
                //TODO image to validator list
                FormInputFieldWithIcon(
                  controller: fx.jobImage.value,
                  iconPrefix: Icons.image,
                  labelText: labels.card?.image,
                  keyboardType: TextInputType.url,
                  onChanged: (value) => fx.cardUserModel.value,
                  onSaved: (value) => fx.cardUserModel.value.image = value,
                ),
                FormVerticalSpace(),
                //TODO dateCreated to validator list
                FormInputFieldWithIcon(
                  controller: fx.jobSchedules.value,
                  iconPrefix: Icons.today,
                  labelText: labels.card?.schedules,
                  onChanged: (value) => fx.jobSchedules.value,
                  onSaved: (value) => fx.cardUserModel.value.schedules = value,
                  maxLines: 2,
                ),
                FormVerticalSpace(),
                Obx(
                  () => fx.jobAvailability.value
                      ? Container(
                          child: Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Colors.green,
                          )),
                        )
                      : TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              fx.submitFunc.value;
                              fx.updateTheValues();
                              Database().saveACard(fx.cardUserModel.value,
                                  disposable.firestoreUser!.value!.uid!);
                            } else {
                              return print("erreur d'enregistrement");
                            }
                          },
                          child: Text(
                            "Save the Card",
                            style: TextStyle(color: Colors.white),
                          )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
