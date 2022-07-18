"""
Players summary parser module
"""
from base_html_parser import BaseHtmlParser

from player import PlayerSummaryBuilder
from team import TeamSummaryBuilder


class PlayerSummaryParser(BaseHtmlParser):
    """Players summary parser"""

    def handle_starttag(self, tag, attrs):
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
        if self._tags_stack[-1:-5:-1] == ['a', 'td', 'tr', 'tbody']:
            self._current_player_builder.add_name(data)

    def handle_endtag(self, tag):
        if (
            tag == 'tr' and
            self._tags_stack[-1:-3:-1] == ['tr', 'tbody']
        ):
            self._result.append(self._current_player_builder.build())
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
            self._current_player_builder.add_team(self._current_team_builder.build())
            self._current_team_builder = TeamSummaryBuilder()

        super().handle_endtag(tag)

    def get_result(self):
        return self._result

    _current_player_builder = PlayerSummaryBuilder()
    _current_team_builder = TeamSummaryBuilder()
    _result = []
