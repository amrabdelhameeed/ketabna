import 'package:flutter/material.dart';
import 'package:ketabna/core/models/category_model.dart';

class CategoryItem extends StatefulWidget {
  CategoryItem({Key? key, required this.categoryModel}) : super(key: key);
  final CategoryModel categoryModel;
  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          widget.categoryModel.imagePath,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          right: 1 / 10,
          top: 1 / 10,
          child: IconButton(
            splashRadius: 1,
            iconSize: 28,
            tooltip: 'select',
            color: Colors.white,
            onPressed: () {
              setState(() {
                widget.categoryModel.isSelected =
                    !widget.categoryModel.isSelected;
              });
            },
            icon: Icon(
              !widget.categoryModel.isSelected
                  ? Icons.check_box_outline_blank
                  : Icons.check_box,
            ),
          ),
        ),
        Positioned(
          left: 5,
          bottom: 5,
          child: Container(
            width: 100,
            color: Colors.grey.shade300,
            child: Text(
              widget.categoryModel.categoryName,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.grey.shade700,
                    fontSize: 18,
                  ),
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
