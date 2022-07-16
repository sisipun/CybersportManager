"""
Players parser module
"""
from html.parser import HTMLParser

from player import PlayerBuilder


class PlayerParser(HTMLParser):
    """Players parser"""

    def handle_starttag(self, tag, attrs):
        if tag in self._self_closed_tags:
            return
        self._stack.append(tag)

        if self._stack[-1:-5:-1] == ['a', 'td', 'tr', 'tbody']:
            href_attr = next(filter(lambda attr: attr[0] == 'href', attrs))
            if href_attr:
                self._current_player_builder.add_stats_url(href_attr[1])

    def handle_data(self, data):
        if self._stack[-1:-5:-1] == ['a', 'td', 'tr', 'tbody']:
            self._current_player_builder.add_name(data)

    def handle_endtag(self, tag):
        if self._stack[-1:-3:-1] == ['tr', 'tbody']:
            self._players.append(self._current_player_builder.build())
            self._current_player_builder = PlayerBuilder()

        self._stack.pop()

    def error(self, message):
        print('Error while parsing players info')
        print(message)

    def get_result(self):
        """
        Returns players list
        """
        return self._players

    _stack = []
    _players = []
    _current_player_builder = PlayerBuilder()
    _self_closed_tags = ['img']
