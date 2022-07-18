"""
Start point of parser
"""
import time
import urllib.request
from math import floor

from player_parser import PlayerParser
from player_summary_parser import PlayerSummaryParser

HOST = 'https://www.hltv.org'
PLAYERS_URL = '/stats/players'
DEFAULT_HTTP_HEADERS = {'User-Agent': 'CybersportManager'}


def main():
    """Start point of parser"""
    player_summaries = parse_player_summaries()
    players_number = len(player_summaries)
    print('Players number:', players_number)

    players = []
    for i, player_summary in enumerate(player_summaries):
        players.append(parse_player(player_summary))
        log_progress(i + 1, players_number)
        time.sleep(1)
        break

    with open('result.json', 'w', encoding="utf-8") as file:
        file.write(str(players))


def parse_player_summaries():
    """Parse players summaries info"""
    players_url = HOST + PLAYERS_URL
    players_request = urllib.request.Request(players_url, headers=DEFAULT_HTTP_HEADERS)
    with urllib.request.urlopen(players_request) as response:
        data = response.read()
        parser = PlayerSummaryParser()
        parser.feed(str(data))
        return parser.get_result()


def parse_player(player_summary):
    """Parse player info"""
    player_url = HOST + player_summary.stats_url
    player_request = urllib.request.Request(player_url, headers=DEFAULT_HTTP_HEADERS)
    with urllib.request.urlopen(player_request) as response:
        data = response.read()
        parser = PlayerParser(player_summary)
        parser.feed(str(data))
        return parser.get_result()


def log_progress(current_player, players_number):
    """Log parsing progress"""
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
