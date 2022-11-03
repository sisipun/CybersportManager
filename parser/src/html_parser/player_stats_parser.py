"""
Players stats parser module
"""
from html_parser.base_html_parser import BaseHtmlParser
from model.player import PlayerStatsBuilder


class PlayerStatsParser(BaseHtmlParser):
    """Players stats parser"""

    def __init__(self, player_summary_builder):
        super().__init__()
        self._player_stats_builder = PlayerStatsBuilder()
        self._player_summary_builder = player_summary_builder
        self.stat_row_number = 0
        self.breakdown_row_number = 0
        self.breakdown_number = 0
        self.spawn_index = 0

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
            'summaryRealname ' in self.find_attr(
                self._attrs_stack[-1], 'class')
        ):
            self._player_summary_builder.add_country(
                self.find_attr(attrs, 'title'))

    def handle_data(self, data):
        if (
            self._tags_stack[-1:-3:-1] == ['div', 'div'] and
            self.find_attr(self._attrs_stack[-2], 'class') and
            'summaryRealname ' in self.find_attr(
                self._attrs_stack[-2], 'class')
        ):
            self._player_summary_builder.add_real_name(data)

        try:
            if (
                self._tags_stack[-1] == 'div' and
                self.find_attr(
                    self._attrs_stack[-1], 'class') == 'summaryPlayerAge'
            ):
                self._player_summary_builder.add_age(int(data[:2]))
        except ValueError:
            pass

        if (
            self._tags_stack[-1:-3:-1] == ['a', 'div'] and
            self.find_attr(self._attrs_stack[-2], 'class') and
            'SummaryTeamname ' in self.find_attr(
                self._attrs_stack[-2], 'class')
        ):
            self._player_stats_builder.add_current_team(data)

        if (
            self._tags_stack[-1:-3:-1] == ['span', 'div'] and
            self.find_attr(self._attrs_stack[-2], 'class') == 'stats-row'
        ):
            self.handle_stats_row(data)

        if (
            self._tags_stack[-1] == 'div' and
            self.find_attr(
                self._attrs_stack[-1], 'class') == 'summaryStatBreakdownDataValue'
        ):
            self.handle_breakdown_row(data)

    def handle_stats_row(self, value):
        """Handle stats row"""
        try:
            if self.stat_row_number == 1:
                self._player_stats_builder.add_total_kills(int(value))
            elif self.stat_row_number == 2:
                self._player_stats_builder.add_headshot_percent(
                    float(value[:-1]))
            elif self.stat_row_number == 3:
                self._player_stats_builder.add_total_deaths(int(value))
            elif self.stat_row_number == 4:
                self._player_stats_builder.add_kill_death_ratio(float(value))
            elif self.stat_row_number == 5:
                self._player_stats_builder.add_damage_round_ratio(float(value))
            elif self.stat_row_number == 6:
                self._player_stats_builder.add_grenade_damage_round_ratio(
                    float(value))
            elif self.stat_row_number == 7:
                self._player_stats_builder.add_maps_played(int(value))
            elif self.stat_row_number == 8:
                self._player_stats_builder.add_rounds_played(int(value))
            elif self.stat_row_number == 9:
                self._player_stats_builder.add_kill_round_ratio(float(value))
            elif self.stat_row_number == 10:
                self._player_stats_builder.add_assist_round_ratio(float(value))
            elif self.stat_row_number == 11:
                self._player_stats_builder.add_death_round_ratio(float(value))
            elif self.stat_row_number == 12:
                self._player_stats_builder.add_saved_by_teammate_round_ratio(
                    float(value))
            elif self.stat_row_number == 13:
                self._player_stats_builder.add_saved_teammate_round_ratio(
                    float(value))
        except ValueError:
            pass

    def handle_breakdown_row(self, value):
        """Handle breakdown row"""
        try:
            if (
                self.breakdown_row_number == 1 and
                self.breakdown_number == 3
            ):
                self._player_stats_builder.add_kast(float(value[:-1]))
            elif (
                self.breakdown_row_number == 2 and
                self.breakdown_number == 4
            ):
                self._player_stats_builder.add_impact(float(value))
        except ValueError:
            pass

    def get_result(self):
        return self._player_stats_builder
