import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/color_palette_viewmodel.dart';
import '../widgets/palette_card.dart';
import 'add_palette_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  Color _backgroundColor = Colors.white; 
  double _fabRotation = 0; 

 
  Color _generateRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(centerTitle: true,
        title: Text('Color Palettes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: PaletteSearch());
            },
          ),
        ],
      ),
      body: Consumer<ColorPaletteViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.palettes.isEmpty) {
            return const Center(
              child: Text(
                'No palettes available. Add one by clicking the button below.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: viewModel.palettes.length,
            itemBuilder: (context, index) {
              final palette = viewModel.palettes[index];
              return PaletteCard(
                palette: palette,
                onDelete: () => viewModel.deletePalette(palette.id),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.end, 
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _backgroundColor = _generateRandomColor(); 
                _fabRotation += pi / 4; 
              });
            },
            child: const Icon(Icons.color_lens),
            tooltip: 'Change Background Color',
            heroTag: 'colorFab', 
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPaletteView()),
              );
            },
            child: const Icon(Icons.add),
            tooltip: 'Add Palette',
            heroTag: 'addFab', 
          ),
        ],
      ),
    );
  }
}
class PaletteSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; 
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); 
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final viewModel = Provider.of<ColorPaletteViewModel>(context, listen: false);
    final searchResults = viewModel.palettes
        .where((palette) =>
            palette.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (searchResults.isEmpty) {
      return const Center(child: Text('No palettes found.'));
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final palette = searchResults[index];
        return PaletteCard(
          palette: palette,
          onDelete: () => viewModel.deletePalette(palette.id),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final viewModel = Provider.of<ColorPaletteViewModel>(context, listen: false);
    final suggestions = viewModel.palettes
        .where((palette) =>
            palette.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final palette = suggestions[index];
        return ListTile(
          title: Text(palette.name),
          onTap: () {
            query = palette.name;
            showResults(context);
          },
        );
      },
    );
  }
}
