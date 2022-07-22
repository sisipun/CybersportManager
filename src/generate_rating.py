"""
Start point of generator
"""
import json
from math import ceil

from constants import FILE_PATH_WITH_PLAYERS, FILE_PATH_WITH_RATING, FILE_PATH_WITH_OVERALL_RATING, STATS_FOR_RATING_WITH_DIRECTION, RATING_GENERATION_MIN_MAPS, ALL_TIME, YEARS_TO_PARSE
from model.player import Player
from model.player_rating import PlayerRating


def main():
    """Start point of generator"""

    players = []
    with open(FILE_PATH_WITH_PLAYERS, 'r', encoding="utf-8") as file:
        data = file.read()
        players = [Player.from_dict(player) for player in json.loads(data)]

    stats_range = {
        year: {
            stat: get_range(stat, get_players_stats_by_year(
                players, year), reverse)
            for stat, reverse
            in STATS_FOR_RATING_WITH_DIRECTION.items()
        }
        for year
        in YEARS_TO_PARSE
    }
    stats_range[ALL_TIME] = {
        stat: get_range(stat, [player.stats for player in players], reverse)
        for stat, reverse
        in STATS_FOR_RATING_WITH_DIRECTION.items()
    }

    players_rating = {}
    for player in players:
        players_rating[player.summary.name] = {
            year: generate_rating_by_year(player, stats_range, year)
            for year
            in filter(lambda year: has_player_year_stats(player, year), YEARS_TO_PARSE)
        }
        players_rating[player.summary.name][ALL_TIME] = PlayerRating.from_dict({
            stat: stat_to_rating(player.stats.to_dict()[
                                 stat], stat, stats_range[ALL_TIME])
            for stat, _
            in STATS_FOR_RATING_WITH_DIRECTION.items()
        })

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


def get_range(stat_name, players_stats, reverse):
    """Get min-max range for player stat"""
    stat_values = [
        player_stats.to_dict()[stat_name]
        for player_stats
        in players_stats
    ]
    return (max(stat_values), min(stat_values)) if reverse else (min(stat_values), max(stat_values))


def get_players_stats_by_year(players, year):
    """Return player stats by year"""
    return [
        player.stats_per_year[year]
        for player
        in filter(lambda player: has_player_year_stats(player, year), players)
    ]


def has_player_year_stats(player, year):
    """Return has player stats with year"""
    return (
        year in player.stats_per_year
        and player.stats_per_year[year].maps_played > RATING_GENERATION_MIN_MAPS
    )


def generate_rating_by_year(player, stats_range, year):
    """Generate rating by year"""
    stats_by_year = player.stats_per_year[year].to_dict()
    return PlayerRating.from_dict({
        stat: stat_to_rating(
            stats_by_year[stat],
            stat,
            stats_range[year]
        )
        for stat, _
        in STATS_FOR_RATING_WITH_DIRECTION.items()
    })


def stat_to_rating(stat_value, stat_name, stats_range):
    """Get generate rating from player stat"""
    stat_range = stats_range[stat_name]
    return ceil(((stat_value - stat_range[0]) / (stat_range[1] - stat_range[0])) * 50 + 50)


if __name__ == '__main__':
    main()
