"""
Players summary parser module
"""
from html_parser.base_html_parser import BaseHtmlParser

from model.player import PlayerSummaryBuilder
from model.team import TeamSummaryBuilder


class PlayerSummaryParser(BaseHtmlParser):
    """Players summary parser"""

    def __init__(self, from_index, to_index):
        super().__init__()
        self._from_index = from_index
        self._to_index = to_index

    def handle_starttag(self, tag, attrs):
        """Handle start tag"""
        super().handle_starttag(tag, attrs)

        if (
            tag == 'img' and
            self._tags_stack[-1:-5:-1] == ['a', 'td', 'tr', 'tbody'] and
            self.find_attr(self._attrs_stack[-2], 'class') == 'teamCol'
        ) or (
            tag == 'img' and
            self._tags_stack[-1:-6:-1] == ['a', 'span', 'td', 'tr', 'tbody'] and
            self.find_attr(self._attrs_stack[-3], 'class') == 'teamCol'
        ):
            title_attr = next(filter(lambda attr: attr[0] == 'title', attrs))
            self._current_team_builder.add_name(title_attr[1])

        if (
            tag == 'a' and
            self._tags_stack[-1:-5:-1] == ['a', 'td', 'tr', 'tbody'] and
            self.find_attr(self._attrs_stack[-2], 'class') == 'teamCol'
        ) or (
            tag == 'a' and
            self._tags_stack[-1:-6:-1] == ['a', 'span', 'td', 'tr', 'tbody'] and
            self.find_attr(self._attrs_stack[-3], 'class') == 'teamCol'
        ):
            href_attr = next(filter(lambda attr: attr[0] == 'href', attrs))
            self._current_team_builder.add_stats_url(href_attr[1])

        if (
            tag == 'a' and
            self._tags_stack[-1:-5:-1] == ['a', 'td', 'tr', 'tbody'] and
            self.find_attr(self._attrs_stack[-2], 'class') == 'playerCol '
        ):
            href_attr = next(filter(lambda attr: attr[0] == 'href', attrs))
            self._current_player_builder.add_stats_url(href_attr[1])

    def handle_data(self, data):
        """Handle tag data"""
        if self._tags_stack[-1:-5:-1] == ['a', 'td', 'tr', 'tbody']:
            self._current_player_builder.add_name(data)

    def handle_endtag(self, tag):
        """Handle end tag"""
        if (
            tag == 'tr' and
            self._tags_stack[-1:-3:-1] == ['tr', 'tbody']
        ):
            self._result.append(self._current_player_builder)
            self._current_player_builder = PlayerSummaryBuilder()

        if (
            tag == 'a' and
            self._tags_stack[-1:-5:-1] == ['a', 'td', 'tr', 'tbody'] and
            self.find_attr(self._attrs_stack[-2], 'class') == 'teamCol'
        ) or (
            tag == 'a' and
            self._tags_stack[-1:-6:-1] == ['a', 'span', 'td', 'tr', 'tbody'] and
            self.find_attr(self._attrs_stack[-3], 'class') == 'teamCol'
        ):
            self._current_player_builder.add_team(
                self._current_team_builder.build()
            )
            self._current_team_builder = TeamSummaryBuilder()

        super().handle_endtag(tag)

    def get_result(self):
        """Returns parsing result"""
        return self._result[self._from_index:self._to_index]

    _current_player_builder = PlayerSummaryBuilder()
    _current_team_builder = TeamSummaryBuilder()
    _result = []
    _from_index = None
    _to_index = None
