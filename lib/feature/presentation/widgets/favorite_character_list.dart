import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_app/feature/presentation/bloc/favorite_character_list_cubit/favorite_character_list_cubit.dart';
import 'package:marvel_app/feature/presentation/widgets/character_card.dart';
import 'package:marvel_app/feature/presentation/widgets/try_again_button.dart';

class FavoriteCharacterList extends StatelessWidget {
  const FavoriteCharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCharacterListCubit, FavoriteCharacterListState>(
      builder: (context, state) {
        if (state is FavoriteCharacterListLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        }
        if (state is FavoriteCharacterListLoaded) {
          if (state.characters.isEmpty) {
            return Center(
                child: Text(
              'Favorite character list is empty',
              style:
                  GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700),
            ));
          }
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: state.characters.length,
              itemBuilder: (context, i) => CharacterCard(
                    id: state.characters[i].id,
                    name: state.characters[i].name,
                    description: state.characters[i].description,
                    image: state.characters[i].image,
                  ));
        }
        if (state is FavoriteCharacterListFailure) {
          return Center(
            child: Column(
              children: [
                Text(
                  'Something went wrong',
                  style: GoogleFonts.inter(
                      fontSize: 22, fontWeight: FontWeight.w700),
                ),
                TryAgainButton(function: () {
                  context
                      .read<FavoriteCharacterListCubit>()
                      .getFavoriteCharacterList();
                }),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
