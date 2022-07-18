"""
Players parser module
"""
from base_html_parser import BaseHtmlParser

from player import PlayerBuilder


class PlayerParser(BaseHtmlParser):
    """Players parser"""

    def __init__(self, summary):
        super().__init__()
        self._player_builder = PlayerBuilder(summary)
        self.stat_row_number = 0
        self.breakdown_row_number = 0
        self.breakdown_number = 0

    def handle_starttag(self, tag, attrs):
        super().handle_starttag(tag, attrs)

        if (
            tag == 'div' and
            super().find_attr(attrs, 'class') == 'stats-row'
        ):
            self.stat_row_number += 1

        if (
            tag == 'div' and
            super().find_attr(attrs, 'class') == 'summaryStatBreakdownRow'
        ):
            self.breakdown_row_number += 1

        if (
            tag == 'div' and
            super().find_attr(attrs, 'class') and
            'summaryStatBreakdown ' in super().find_attr(attrs, 'class')
        ):
            self.breakdown_number += 1

        if (
            tag == 'img' and
            self._tags_stack[-1] == 'div' and
            self.find_attr(self._attrs_stack[-1], 'class') and
            'summaryRealname ' in self.find_attr(self._attrs_stack[-1], 'class')
        ):
            self._player_builder.add_country(self.find_attr(attrs, 'title'))

    def handle_data(self, data):
        if (
            self._tags_stack[-1:-3:-1] == ['div', 'div'] and
            self.find_attr(self._attrs_stack[-2], 'class') and
            'summaryRealname ' in self.find_attr(self._attrs_stack[-2], 'class')
        ):
            self._player_builder.add_real_name(data)

        if (
            self._tags_stack[-1] == 'div' and
            self.find_attr(self._attrs_stack[-1], 'class') == 'summaryPlayerAge'
        ):
            self._player_builder.add_age(data)

        if (
            self._tags_stack[-1:-3:-1] == ['a', 'div'] and
            self.find_attr(self._attrs_stack[-2], 'class') and
            'SummaryTeamname ' in self.find_attr(self._attrs_stack[-2], 'class')
        ):
            self._player_builder.add_current_team(data)

        if (
            self._tags_stack[-1:-3:-1] == ['span', 'div'] and
            self.find_attr(self._attrs_stack[-2], 'class') == 'stats-row'
        ):
            self.handle_stats_row(data)

        if (
            self._tags_stack[-1] == 'div' and
            self.find_attr(self._attrs_stack[-1], 'class') == 'summaryStatBreakdownDataValue'
        ):
            self.handle_breakdown_row(data)

    def handle_stats_row(self, value):
        """Handle stats row"""
        if self.stat_row_number == 1:
            self._player_builder.add_total_kills(value)
        elif self.stat_row_number == 2:
            self._player_builder.add_headshot_percent(value)
        elif self.stat_row_number == 3:
            self._player_builder.add_total_deaths(value)
        elif self.stat_row_number == 4:
            self._player_builder.add_kill_death_ratio(value)
        elif self.stat_row_number == 5:
            self._player_builder.add_damage_round_ratio(value)
        elif self.stat_row_number == 6:
            self._player_builder.add_grenade_damage_round_ratio(value)
        elif self.stat_row_number == 7:
            self._player_builder.add_maps_played(value)
        elif self.stat_row_number == 8:
            self._player_builder.add_rounds_played(value)
        elif self.stat_row_number == 9:
            self._player_builder.add_kill_round_ratio(value)
        elif self.stat_row_number == 10:
            self._player_builder.add_assist_round_ratio(value)
        elif self.stat_row_number == 11:
            self._player_builder.add_death_round_ratio(value)
        elif self.stat_row_number == 12:
            self._player_builder.add_saved_by_teammate_round_ratio(value)
        elif self.stat_row_number == 13:
            self._player_builder.add_saved_teammate_round_ratio(value)

    def handle_breakdown_row(self, value):
        """Handle breakdown row"""
        if (
            self.breakdown_row_number == 1 and
            self.breakdown_number == 3
        ):
            self._player_builder.add_kast(value)
        elif (
            self.breakdown_row_number == 2 and
            self.breakdown_number == 4
        ):
            self._player_builder.add_impact(value)

    def get_result(self):
        return self._player_builder.build()
