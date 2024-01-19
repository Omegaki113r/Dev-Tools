import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/const/app_constants.dart';
import 'package:dev_tools/const/app_strings.dart';
import 'package:dev_tools/providers/data_streamer_provider.dart';
import 'package:dev_tools/widgets/soft_button.dart';
import 'package:dev_tools/widgets/soft_card.dart';
import 'package:dev_tools/widgets/soft_divider.dart';
import 'package:dev_tools/widgets/soft_dropdown.dart';
import 'package:dev_tools/widgets/soft_text.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

enum StreamerType { SERIAL, WEBSOCKET, MQTT }

class DataStreamerView extends StatefulWidget {
  const DataStreamerView({super.key});

  @override
  State<DataStreamerView> createState() => _DataStreamerViewState();
}

class _DataStreamerViewState extends State<DataStreamerView> {
  StreamerType _currentStreamer = StreamerType.SERIAL;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 500),
      length: 3,
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: color2,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (value) {
              setState(() {
                switch (value) {
                  case 0:
                    _currentStreamer = StreamerType.SERIAL;
                    break;
                  case 1:
                    _currentStreamer = StreamerType.WEBSOCKET;
                    break;
                  case 2:
                    _currentStreamer = StreamerType.MQTT;
                    break;
                }
              });
            },
            tabs: [
              Tab(
                height: 75,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: _currentStreamer == StreamerType.SERIAL
                      ? SoftText.titleFlat(
                          "Serial",
                          key: UniqueKey(),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color2),
                        )
                      : SoftText.title(
                          "Serial",
                          key: ValueKey(2),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color1),
                        ),
                ),
              ),
              Tab(
                height: 75,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: _currentStreamer == StreamerType.WEBSOCKET
                      ? SoftText.titleFlat(
                          "Web Socket",
                          key: ValueKey(1),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color2),
                        )
                      : SoftText.title(
                          "Web Socket",
                          key: ValueKey(2),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color1),
                        ),
                ),
              ),
              Tab(
                height: 75,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: _currentStreamer == StreamerType.MQTT
                      ? SoftText.titleFlat(
                          "MQTT",
                          key: ValueKey(1),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color2),
                        )
                      : SoftText.title(
                          "MQTT",
                          key: ValueKey(2),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color1),
                        ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 125,
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SoftButton(
                        LBL_CONNECT,
                        ButtonType.FLAT,
                        width: 150,
                        height: 45,
                        onPressed: () {
                          print("state changed");
                        },
                      ),
                      const Gap(20),
                      Consumer<DataStreamerProvider>(
                          builder: (context, provider, child) {
                        return SoftDropDown(
                            width: 185,
                            height: 45,
                            itemList: provider.portList.keys.toList(),
                            onChanged: (value) {
                              provider.selectedSerialPortChanged(value);
                              print(value);
                            });
                      }),
                      const Spacer(),
                    ],
                  ),
                ),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              // child: SoftCard(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: color6,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-10, -10),
                        blurRadius: 20,
                        spreadRadius: -10,
                        color: Color(0xFF312C5E),
                        inset: true,
                      ),
                      BoxShadow(
                        offset: Offset(10, 10),
                        blurRadius: 20,
                        spreadRadius: -10,
                        color: Color(0xFF050227),
                        inset: true,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 40,
                      ),
                      child: SelectableText(
                          // "hel\n",
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at felis imperdiet, accumsan lacus tempor, aliquet ligula. Donec convallis commodo sapien, id tempor erat fringilla a. Nam diam nisi, consectetur at viverra id, mollis at lectus. Nunc non rhoncus nulla. Morbi tincidunt at libero at faucibus. Mauris dignissim nibh purus, at rutrum tortor posuere at. Phasellus dapibus risus ante, ac sagittis lacus sollicitudin euismod. Vestibulum fringilla fringilla odio. In venenatis, ex in facilisis tempus, velit elit finibus augue, sit amet gravida odio elit non tortor.Aenean faucibus hendrerit ex, pharetra posuere neque hendrerit nec. Cras lacus leo, accumsan eget ultricies nec, sagittis at sapien. Vivamus aliquam magna non dolor mollis pretium. Fusce lorem velit, eleifend mattis porttitor quis, semper eu eros. Vivamus pulvinar non velit a viverra. Morbi in tristique odio, sit amet condimentum sapien. Nam tristique mollis hendrerit. Pellentesque bibendum congue nunc eget lobortis. Duis commodo libero magna. Donec mattis interdum eros, varius dictum mauris semper ac. Aenean sit amet lorem purus. Pellentesque et egestas velit. Fusce varius consequat lobortis.Nunc et consectetur lectus. Cras suscipit augue a tellus faucibus sodales. Aliquam ullamcorper, felis eget facilisis cursus, quam tortor elementum ex, ac sollicitudin nisl turpis sed velit. Aenean placerat tristique eros, vitae vehicula purus. Proin quis sollicitudin libero. Integer id luctus quam, eu porta lacus. Suspendisse quis dapibus nulla. Aliquam vehicula congue turpis. Proin ac ex eget nisi laoreet faucibus. Donec eget aliquet risus. Integer et facilisis justo, quis pulvinar enim. Vestibulum auctor lacus dui, quis luctus nibh suscipit vel.Vestibulum volutpat dolor nec dui posuere, non iaculis felis tristique. Praesent nec sodales magna, ac vestibulum mi. Vivamus ullamcorper mollis enim, quis convallis quam elementum imperdiet. Etiam id tempus tellus. Donec pharetra vestibulum quam nec vulputate. Nunc ut arcu facilisis, luctus libero a, euismod nunc. Quisque vel suscipit velit, non volutpat dui. Maecenas id magna sed turpis efficitur feugiat eu eu quam. Sed erat dui, rutrum sed purus eget, ultricies vulputate ante. Pellentesque vestibulum consectetur neque et auctor. Vestibulum pellentesque ligula laoreet ipsum cursus tristique. Pellentesque elementum arcu ut dui egestas rutrum. Nam lorem lacus, rhoncus eget condimentum at, dignissim eu dolor. Curabitur rutrum, mauris ut interdum mollis, enim justo elementum nulla, vel convallis leo felis quis augue.Quisque convallis, tortor vitae elementum malesuada, lorem tellus bibendum sapien, in ullamcorper nulla nibh ut risus. Etiam luctus elit vel enim tincidunt, et faucibus dolor tincidunt. Donec sit amet volutpat leo. Ut convallis justo vitae neque suscipit molestie. Pellentesque aliquam euismod lacus, vitae laoreet risus. Phasellus luctus dolor eget enim fermentum, rutrum porta tortor rhoncus. Pellentesque consequat felis quis dolor egestas, in rhoncus tortor feugiat. Vestibulum imperdiet enim non metus ultrices, eu lobortis nulla semperUt fringilla neque ut facilisis lobortis. In rhoncus erat id felis viverra, nec cursus arcu molestie. Donec ac efficitur purus. Nullam vitae placerat nunc. Aenean pretium porta dui, vel rutrum ligula sollicitudin eu. Nullam dictum convallis magna, eget lacinia sapien mattis at. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla ultricies, dui at ullamcorper fermentum, erat ante laoreet risus, non tincidunt mauris libero eu tortor. Proin sed dui id sem mattis pellentesque id ac metus. Etiam euismod nunc at ullamcorper vulputate. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut rhoncus quis lorem sed rutrum. Ut magna orci, vehicula ac imperdiet eu, suscipit quis massa. Vestibulum eu viverra ex.Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Quisque nec vulputate risus. Mauris et arcu nec lectus ornare vulputate quis quis erat. Pellentesque fringilla pulvinar mi, ut rutrum nibh facilisis ut. Donec venenatis interdum suscipit. Aenean cursus augue at dolor mollis ultricies. Proin id laoreet ligula, eu vestibulum purus. In dignissim ac libero in pellentesque. Nunc dapibus lacus quis nisi vulputate eleifend. Fusce a arcu urna. Nullam venenatis lorem a condimentum pharetra. Suspendisse fermentum, dui at interdum efficitur, orci ante scelerisque libero, vitae imperdiet tellus mi at sapien.Aenean auctor tristique tellus quis pharetra. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue et ante at pulvinar. Nunc eu arcu cursus, dictum nibh non, finibus dolor. Mauris vel finibus odio, faucibus malesuada sapien. Cras ut odio diam. Sed magna neque, aliquam vitae nibh sed, ultricies efficitur ligula. Vestibulum commodo risus non massa maximus, vitae eleifend eros mollis. Nam rhoncus non massa quis gravida. Aenean imperdiet vitae leo in porttitor. Proin eget sem ut nibh congue feugiat at aliquam eros. Sed enim massa, mattis vel sollicitudin nec, commodo ac quam. Etiam volutpat in nulla tempor interdum.Nulla sollicitudin imperdiet magna nec tempus. Maecenas quis molestie odio. Aliquam placerat enim at justo auctor, non ultrices nibh semper. Quisque vehicula rhoncus ante, sed malesuada eros condimentum sit amet. Proin viverra metus quis sodales blandit. Phasellus ipsum tortor, fringilla non nisi eu, lobortis bibendum est. Donec commodo pellentesque tortor, quis gravida dui volutpat eu. Ut augue eros, pulvinar eu tellus vel, cursus laoreet mauris. Donec auctor consequat nunc, ac volutpat diam cursus cursus. Fusce pulvinar enim et neque pellentesque, sed facilisis urna dapibus. Vivamus eleifend congue tortor, in pulvinar tortor molestie a. Nullam efficitur libero ut gravida porta. In dictum pharetra lectus in rhoncus. Mauris sed ante velit. Integer ac faucibus nisl, eget accumsan justo.Sed in nunc porta tellus tincidunt iaculis auctor eget diam. Sed pulvinar nunc eget lorem condimentum, eu ornare nisl blandit. Aliquam turpis purus, consequat sit amet sodales eu, lacinia eu lorem. Proin accumsan sagittis velit, ac porta augue porta ut. Aenean vehicula aliquam auctor. Vivamus eleifend nec diam sed pharetra. Vestibulum aliquam dictum nisi a fringilla. Donec vulputate massa leo, vitae vestibulum metus hendrerit vitae. Ut eu enim non odio porttitor luctus.",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ),
                ),
              ),
              // ),
            ),
          )
        ],
      ),
    );
  }
}
