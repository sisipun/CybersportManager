"""
Rating generatro module
"""

from math import ceil

from constants import STATS_FOR_RATING_WITH_DIRECTION, ALL_TIME, YEARS_TO_PARSE, MIN_RATING
from model.player_rating import PlayerRating


class RatingGenerator:
    """Rating generator"""

    def __init__(self, players, min_maps_played):
        self.min_maps_played = min_maps_played
        self.players = players

        self.stats_range = {
            year: {
                stat: self._get_range(stat, self._get_players_stats_by_year(
                    self.players, year), reverse)
                for stat, reverse
                in STATS_FOR_RATING_WITH_DIRECTION.items()
            }
            for year
            in YEARS_TO_PARSE
        }
        self.stats_range[ALL_TIME] = {
            stat: self._get_range(
                stat, [player.stats for player in self.players], reverse)
            for stat, reverse
            in STATS_FOR_RATING_WITH_DIRECTION.items()
        }

    def generate_rating(self):
        """Generate players rating"""
        players_rating = {}
        for player in self.players:
            players_rating[player.summary.name] = {
                year: self._generate_rating_by_year(
                    player, self.stats_range, year)
                for year
                in filter(lambda year: self._has_player_year_stats(player, year), YEARS_TO_PARSE)
            }
            players_rating[player.summary.name][ALL_TIME] = PlayerRating.from_dict({
                stat: self._stat_to_rating(player.stats.to_dict()[
                    stat], stat, self.stats_range[ALL_TIME])
                for stat, _
                in STATS_FOR_RATING_WITH_DIRECTION.items()
            })
        return players_rating

    def _get_range(self, stat_name, players_stats, reverse):
        """Get min-max range for player stat"""
        stat_values = [
            player_stats.to_dict()[stat_name]
            for player_stats
            in players_stats
        ]
        if stat_values == []:
            return (0, 0)
        return (max(stat_values), min(stat_values)) if reverse else (min(stat_values), max(stat_values))

    def _get_players_stats_by_year(self, players, year):
        """Return player stats by year"""
        return [
            player.stats_per_year[year]
            for player
            in filter(lambda player: self._has_player_year_stats(player, year), players)
        ]

    def _has_player_year_stats(self, player, year):
        """Return has player stats with year"""
        return (
            year in player.stats_per_year
            and player.stats_per_year[year].maps_played > self.min_maps_played
        )

    def _generate_rating_by_year(self, player, stats_range, year):
        """Generate rating by year"""
        stats_by_year = player.stats_per_year[year].to_dict()
        return PlayerRating.from_dict({
            stat: self._stat_to_rating(
                stats_by_year[stat],
                stat,
                stats_range[year]
            )
            for stat, _
            in STATS_FOR_RATING_WITH_DIRECTION.items()
        })

    def _stat_to_rating(self, stat_value, stat_name, stats_range):
        """Get generate rating from player stat"""
        stat_range = stats_range[stat_name]
        return ceil(((stat_value - stat_range[0]) / (stat_range[1] - stat_range[0])) * (100 - MIN_RATING) + MIN_RATING)
