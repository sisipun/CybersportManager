"""
Start point of generator
"""
import json
from math import ceil

from model.player import Player
from model.player_rating import PlayerRating

FILE_PATH_WITH_PLAYERS = "build/players.json"
FILE_PATH_TO_STORE = "build/rating.json"
STATS_FOR_RATING_WITH_DIRECTION = {
    "headshot_percent": False,
    "kill_death_ratio": False,
    "damage_round_ratio": False,
    "grenade_damage_round_ratio": False,
    "kill_round_ratio": False,
    "assist_round_ratio": False,
    "death_round_ratio": True,
    "saved_teammate_round_ratio": False,
    "kast": False,
    "impact": False
}


def main():
    """Start point of generator"""

    players = []
    with open(FILE_PATH_WITH_PLAYERS, 'r', encoding="utf-8") as file:
        data = file.read()
        players = [Player.from_dict(player) for player in json.loads(data)]

    player_stats = [player.stats for player in players]
    stats_range = {stat: get_range(stat, player_stats, reverse)
                   for stat, reverse in STATS_FOR_RATING_WITH_DIRECTION.items()}

    players_rating = {}
    for player in players:
        player_stat = player.stats.to_dict()
        player_rating_dict = {stat: generate_rating(player_stat[stat], stat, stats_range)
                              for stat, _ in STATS_FOR_RATING_WITH_DIRECTION.items()}
        player_rating = PlayerRating.from_dict(player_rating_dict)
        players_rating[player.summary.name] = player_rating

    with open(FILE_PATH_TO_STORE, 'w', encoding="utf-8") as file:
        file.write(json.dumps({name: rating.to_dict()
                   for name, rating in players_rating.items()}))


def get_range(stat_name, players_stats, reverse):
    """Get min-max range for player stat"""
    stat_values = [player_stats.to_dict()[stat_name]
                   for player_stats in players_stats]
    return (max(stat_values), min(stat_values)) if reverse else (min(stat_values), max(stat_values))


def generate_rating(stat_value, stat_name, stats_range):
    """Get generate rating from player stat"""
    stat_range = stats_range[stat_name]
    return ceil(((stat_value - stat_range[0]) / (stat_range[1] - stat_range[0])) * 50 + 50)


if __name__ == '__main__':
    main()
