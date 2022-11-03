"""
Start point of parser
"""
import time
import json
import urllib.request
from math import floor

from constants import HOST, PLAYERS_URL, DEFAULT_HTTP_HEADERS, SLEEP_BETWEEN_PARSE_IN_SECONDS, YEARS_TO_PARSE, FILE_PATH_WITH_PLAYERS
from model.player import Player
from html_parser.player_stats_parser import PlayerStatsParser
from html_parser.player_summary_parser import PlayerSummaryParser


def main():
    """Start point of parser"""
    player_summary_builders = parse_player_summaries()
    players_number = len(player_summary_builders)
    print('Players number:', players_number)

    players = []
    for i, player_summary_builder in enumerate(player_summary_builders):
        stats = parse_player_stats(player_summary_builder).build()
        summary = player_summary_builder.build()

        stats_per_year = {}
        for year in YEARS_TO_PARSE:
            stat_per_year = parse_player_stats(
                player_summary_builder, year).build()
            if stat_per_year.maps_played > 0:
                stats_per_year[year] = stat_per_year
            log_years_progress(year)
            time.sleep(SLEEP_BETWEEN_PARSE_IN_SECONDS)

        players.append(Player(summary, stats, stats_per_year))
        log_players_progress(i + 1, players_number)

    with open(FILE_PATH_WITH_PLAYERS, 'w+', encoding="utf-8") as file:
        file.write(json.dumps([player.to_dict() for player in players]))


def parse_player_summaries():
    """Parse players summaries info"""
    players_url = HOST + PLAYERS_URL
    players_request = urllib.request.Request(
        players_url, headers=DEFAULT_HTTP_HEADERS)
    with urllib.request.urlopen(players_request) as response:
        data = response.read()
        parser = PlayerSummaryParser()
        parser.feed(str(data))
        return parser.get_result()


def parse_player_stats(player_summary_builder, year=None):
    """Parse player info"""
    player_url = HOST + player_summary_builder.stats_url
    player_url += f"?startDate={year}-01-01&endDate={year}-12-31" if year else ''
    player_request = urllib.request.Request(
        player_url, headers=DEFAULT_HTTP_HEADERS)
    with urllib.request.urlopen(player_request) as response:
        data = response.read()
        parser = PlayerStatsParser(player_summary_builder)
        parser.feed(str(data))
        return parser.get_result()


def log_years_progress(current_year):
    """Log year parsing progress"""
    max_year = YEARS_TO_PARSE[0]
    min_year = YEARS_TO_PARSE[-1]
    print(max_year, '--', current_year, '--', min_year)


def log_players_progress(current_player, players_number):
    """Log player parsing progress"""
    progress_bar_size = 20
    percent = current_player / players_number
    completed = floor(progress_bar_size * percent)
    for _ in range(completed):
        print('|', end='')

    for _ in range(progress_bar_size - completed):
        print('.', end='')

    print('(', current_player, '/', players_number, ')', sep='')


if __name__ == '__main__':
    main()
