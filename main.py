"""
Start point of parser
"""
import urllib.request
from player_parser import PlayerParser

HOST = 'https://www.hltv.org'
PLAYERS_URL = '/stats/players'
DEFAULT_HTTP_HEADERS = {'User-Agent': 'CybersportManager'}


def main():
    """Parse html body to players list"""
    players = []
    players_url = HOST + PLAYERS_URL
    players_request = urllib.request.Request(players_url, headers=DEFAULT_HTTP_HEADERS)
    with urllib.request.urlopen(players_request) as response:
        data = response.read()
        parser = PlayerParser()
        parser.feed(str(data))
        players = parser.get_result()

    for player in players:
        player_url = HOST + player.stats_url
        player_request = urllib.request.Request(player_url, headers=DEFAULT_HTTP_HEADERS)
        with urllib.request.urlopen(player_request) as response:
            data = response.read()
            print(data)


if __name__ == '__main__':
    main()
