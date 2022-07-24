"""
Start point of generator
"""
import json

from constants import FILE_PATH_WITH_PLAYERS, FILE_PATH_WITH_RATING, FILE_PATH_WITH_OVERALL_RATING, RATING_GENERATION_MIN_MAPS
from model.player import Player
from generator.rating_generator import RatingGenerator


def main():
    """Start point of generator"""

    players = []
    with open(FILE_PATH_WITH_PLAYERS, 'r', encoding="utf-8") as file:
        data = file.read()
        players = [Player.from_dict(player) for player in json.loads(data)]

    generator = RatingGenerator(players, RATING_GENERATION_MIN_MAPS)
    players_rating = generator.generate_rating()

    with open(FILE_PATH_WITH_RATING, 'w', encoding="utf-8") as file:
        file.write(json.dumps({
            name: {
                year: rating.to_dict()
                for year, rating
                in year_rating.items()
            }
            for name, year_rating
            in players_rating.items()
        }))

    with open(FILE_PATH_WITH_OVERALL_RATING, 'w', encoding="utf-8") as file:
        file.write(json.dumps({
            name: {
                year: rating.overall
                for year, rating
                in year_rating.items()
            }
            for name, year_rating
            in players_rating.items()
        }))


if __name__ == '__main__':
    main()
