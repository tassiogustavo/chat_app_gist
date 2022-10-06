import 'package:chat_messenger_app/models/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class ShopViewPage extends StatefulWidget {
  const ShopViewPage({Key? key, required this.loadData}) : super(key: key);
  final Future<List<ShopModel>> loadData;

  @override
  State<ShopViewPage> createState() => _ShopViewPageState();
}

class _ShopViewPageState extends State<ShopViewPage> {
  bool isSelected = false;

  final List<String> _listChipFilter = [
    'Camiseta',
    'Short',
    'Tênis',
    'Boné',
    'Blusa',
    'Regata',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _listChipFilter.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ChoiceChip(
                      label: Text(_listChipFilter[index]),
                      selectedColor: Colors.amber,
                      selected: isSelected,
                      onSelected: (newState) {
                        setState(() {
                          isSelected = newState;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 3,
                  child: buildCardShop(0),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: buildCardShop(1),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 3,
                  child: buildCardShop(2),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: buildCardShop(3),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 3,
                  child: buildCardShop(4),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: buildCardShop(5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildCardShop(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FutureBuilder(
          future: widget.loadData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text("Carregando..."));
            } else {
              List<ShopModel>? member = snapshot.data;
              return FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                fit: BoxFit.cover,
                image: member![index].img,
              );
            }
          },
        ),
      ),
    );
  }
}
