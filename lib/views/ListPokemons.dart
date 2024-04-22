import 'package:flutter/material.dart';
import 'package:pokemon_api_scroll/controllers/PokemonController.dart';
import 'package:pokemon_api_scroll/models/Pokemon.dart';

class ListPokemons extends StatefulWidget {
  const ListPokemons({Key? key}) : super(key: key);

  @override
  State<ListPokemons> createState() => _ListPokemonsState();
}

class _ListPokemonsState extends State<ListPokemons> {
  final PokemonController _controller = PokemonController();
  int _offset = 0;
  bool _loading = false;
  List<Pokemon> _pokemons = [];
  ScrollController _scrollController = ScrollController();
  Size? _size;

  @override
  void initState() {
    super.initState();
    getPokemons();
    _scrollController.addListener(() {
      double max = _scrollController.position.maxScrollExtent;
      double current = _scrollController.position.pixels;
      if (current + 300 >= max && !_loading) {
        getPokemons();
      }
    });
  }

  void getPokemons() async {
    _loading = true;
    setState(() {});
    List<Pokemon> pokemons = await _controller.getPokemons(offset: _offset);
    _pokemons.addAll(pokemons);
    setState(() {
      _offset += 20;
      _loading = false;
    });

    double currentPosition = _scrollController.position.pixels;
    double max = _scrollController.position.maxScrollExtent;
    double offset = currentPosition + 100;
    if (offset > max) createAnimate(offset);
  }

  createAnimate(double offset) {
    _scrollController.animateTo(offset,
        duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        _pokemons = await _controller.getPokemons(offset: 0);
        setState(() {
         _offset = 0;
        });
      },
      child: Stack(
        children: [createListView(), if (_loading) createProgress()],
      ),
    );
  }

  createProgress() {
    return Positioned(
      bottom: 10,
      left: (_size!.width / 2) - 15,
      child: const CircularProgressIndicator(),
    );
  }

  ListView createListView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _pokemons.length,
      itemBuilder: (context, index) {
        Pokemon pokemon = _pokemons[index];
        return ListTile(
          title: Text(pokemon.name),
          subtitle: Text(pokemon.url),
        );
      },
    );
  }
}
