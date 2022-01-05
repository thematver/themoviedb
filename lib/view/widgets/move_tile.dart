import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:themoviedb/model/movie.dart';
import 'package:themoviedb/view/view.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var snackBar = SnackBar(
          content: Text(movie.title ?? "Название фильма"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black),
          ],
          color: Colors.white,
        ),
        child: SizedBox(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _Thumbnail(movie.posterPath),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _MovieInformation(
                    id: movie.id,
                    title: movie.title,
                    overview: movie.overview,
                    releaseDate: movie.releaseDate,
                    isFavorite: false,
                    isAdult: movie.adult,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final String? posterPath;
  const _Thumbnail(this.posterPath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(2)),
      child: posterPath != null
          ? Image.network("https://image.tmdb.org/t/p/w500$posterPath")
          : Container(height: 200, color: Colors.grey, width: 135),
    );
  }
}

class _MovieInformation extends StatelessWidget {
  final String? title;
  final String? overview;
  final DateTime? releaseDate;
  final bool? isFavorite;
  final bool? isAdult;
  final int id;

  const _MovieInformation({
    Key? key,
    required this.id,
    String? title,
    String? overview,
    this.releaseDate,
    this.isAdult = false,
    this.isFavorite = false,
  })  : title = title ?? "Название фильма",
        overview = overview ?? "Описание фильма",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title ${isAdult! ? '18+' : ''}",
          overflow: TextOverflow.fade,
          maxLines: 2,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Text(
            "$overview",
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 4,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        _Footer(
          releaseDate: releaseDate,
          id: id,
        ),
      ],
    );
  }
}

class _Footer extends StatefulWidget {
  final int id;
  final DateTime? releaseDate;
  const _Footer({
    Key? key,
    required this.id,
    this.releaseDate,
  }) : super(key: key);

  @override
  State<_Footer> createState() => _FooterState();
}

class _FooterState extends State<_Footer> {
  late Box<bool> favoritesBox;

  @override
  void initState() {
    favoritesBox = Hive.box("favoriteMovies");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(width: 10),
            Text(
              DateFormat.prettify(widget.releaseDate),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: favoritesBox.listenable(),
          builder: (context, Box<bool> box, _) {
            return FavoriteButton(
              isFavorite: box.get(widget.id) ?? false,
              onFavoriteChanged: (val) {
                box.put(widget.id, val);
              },
            );
          },
        ),
      ],
    );
  }
}
