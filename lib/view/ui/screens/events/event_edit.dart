import 'package:cfit/constants.dart';
import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';
import 'package:cfit/view/ui/screens/home/widgets/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class EventEdit extends StatelessWidget {
  final EventsModel event;
  EventEdit({Key? key, required this.event}) : super(key: key);

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    String idUser = Get.find<UserController>().idLocal;

    List<String> array1 = [];
    List<String> busca = [idUser];

    bool exists = false;

    if (event.users_checkin != null) {
      for (var v in event.users_checkin!) {
        if (v == idUser) {
          exists = true;
        }
      }
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          //EventsScreen.loadData(true);
        },
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                      color: kPrimaryColor,
                    ),
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                        right: 25,
                        left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.dashboard),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffffffff)),
                              shape: BoxShape.circle,
                              //color: Color(0xffffffff),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        const Text(
                          'Meu Evento',
                          style: TextStyle(
                            fontSize: 28,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 20,
                              height: 60,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.55,
                    child: Container(
                      padding: const EdgeInsets.only(right: 12, left: 12),
                      decoration: const BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 15.0,
                              offset: Offset(0.0, 0.75))
                        ],
                        color: Colors.white,
                      ),
                      child: CustomScrollView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: <Widget>[
                          SliverToBoxAdapter(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              event.tipo ?? '',
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      event.nome ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconText(
                                          icon: Icons.location_on_outlined,
                                          text: (event.rua ?? '') +
                                              ' ' +
                                              (event.numero ?? '') +
                                              ' ' +
                                              (event.bairro ?? '') +
                                              ' ' +
                                              (event.cidade ?? ''),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Text(
                                      'Descrição',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 10, 0),
                                            width: 5,
                                            height: 5,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black),
                                          ),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                maxWidth: 400),
                                          ),
                                          Flexible(
                                            child: Text(
                                              event.descricao ?? '',
                                              style: const TextStyle(
                                                  wordSpacing: 2.5,
                                                  height: 1.5),
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /*
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 12),
                                        child: const Text(
                                          "A BETTER BLOG FOR WRITING",
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Writing  /  Project"),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextBody(
                                          text:
                                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Faucibus a pellentesque sit amet porttitor eget. Ipsum nunc aliquet bibendum enim facilisis gravida."),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextBody(
                                          text:
                                              "Montes nascetur ridiculus mus mauris vitae ultricies leo. Vitae purus faucibus ornare suspendisse sed nisi lacus sed viverra. Magna sit amet purus gravida. In dictum non consectetur a erat nam. Et egestas quis ipsum suspendisse ultrices. Tempor orci dapibus ultrices in iaculis nunc sed augue. Feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam. Feugiat nisl pretium fusce id velit ut tortor pretium."),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextHeadlineSecondary(
                                          text: "Secondary Headline Example"),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextBody(
                                          text:
                                              "Nullam lobortis faucibus cursus. Sed aliquam semper mi sit amet interdum. Aliquam felis quam, ultrices ut elementum a, porta vel ex. Pellentesque at tempus magna. Vestibulum viverra lectus quis laoreet ullamcorper. Nunc finibus orci in luctus hendrerit. Ut dui mi, lacinia hendrerit elit ut, malesuada luctus enim."),
                                    ),
                                    const TextBlockquote(
                                        text:
                                            "Arcu ac tortor dignissim convallis aenean et tortor. Neque vitae tempus quam pellentesque nec nam aliquam. Dictum varius duis at consectetur lorem donec massa sapien faucibus. Etiam tempor orci eu lobortis elementum nibh tellus molestie nunc. Ac odio tempor orci dapibus ultrices in iaculis nunc sed."),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextBody(
                                          text:
                                              "Sed elementum tempus egestas sed sed risus. Mauris in aliquam sem fringilla ut morbi tincidunt. Placerat vestibulum lectus mauris ultrices eros. Et leo duis ut diam. Auctor neque vitae tempus quam. Nec nam aliquam sem et tortor consequat. Suspendisse interdum consectetur libero id faucibus nisl. Ornare suspendisse sed nisi lacus sed viverra. Tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. Egestas purus viverra accumsan in nisl nisi."),
                                    ),*/
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        const Slidable(
                          // Specify a key if the Slidable is dismissible.
                          key: ValueKey(0),

                          // The end action pane is the one at the right or the bottom side.
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                flex: 2,
                                onPressed: doNothing,
                                backgroundColor: Color(0xFF7BC043),
                                foregroundColor: Colors.white,
                                icon: Icons.archive,
                                label: 'Archive',
                              ),
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Color(0xFF0392CF),
                                foregroundColor: Colors.white,
                                icon: Icons.save,
                                label: 'Save',
                              ),
                            ],
                          ),

                          // The child of the Slidable is what the user sees when the
                          // component is not dragged.
                          child: ListTile(
                            leading: FlutterLogo(size: 72.0),
                            title: Text('Three-line ListTile'),
                            subtitle: Text(
                                'A sufficiently long subtitle warrants three lines.'),
                            trailing: Icon(Icons.back_hand),
                            isThreeLine: true,
                          ),
                        ),
                        Slidable(
                          // Specify a key if the Slidable is dismissible.
                          key: const ValueKey(1),

                          // The start action pane is the one at the left or the top side.
                          startActionPane: const ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: ScrollMotion(),

                            // All actions are defined in the children parameter.
                            children: [
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Color(0xFF21B7CA),
                                foregroundColor: Colors.white,
                                icon: Icons.share,
                                label: 'Share',
                              ),
                            ],
                          ),

                          // The end action pane is the one at the right or the bottom side.
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            dismissible: DismissiblePane(onDismissed: () {}),
                            children: const [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                              SlidableAction(
                                // An action can be bigger than the others.
                                onPressed: doNothing,
                                backgroundColor: Color(0xFF7BC043),
                                foregroundColor: Colors.white,
                                icon: Icons.archive,
                                label: 'Archive',
                              ),
                            ],
                          ),

                          // The child of the Slidable is what the user sees when the
                          // component is not dragged.
                          child: const ListTile(title: Text('Slide me')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextBody extends StatelessWidget {
  final String text;

  const TextBody({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Text(
        text,
      ),
    );
  }
}

class TextHeadlineSecondary extends StatelessWidget {
  final String text;

  const TextHeadlineSecondary({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
      ),
    );
  }
}

class TextBlockquote extends StatelessWidget {
  final String text;

  const TextBlockquote({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: const BoxDecoration(
          border: Border(left: BorderSide(width: 2, color: Color(0xFF333333)))),
      padding: const EdgeInsets.only(left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
