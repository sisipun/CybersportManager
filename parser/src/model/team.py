"""
Team models module
"""

import json


class TeamSummary:
    """
    Team summary information
    """

    def __init__(self, stats_url, name):
        self.name = name
        self.stats_url = stats_url

    def to_dict(self):
        """Convert model to dict"""
        return {
            "stats_url": self.stats_url,
            "name": self.name
        }

    @staticmethod
    def from_dict(dictionary):
        """Convert from dict"""
        return TeamSummary(
            dictionary["stats_url"],
            dictionary["name"]
        )

    def __repr__(self):
        return f"""{{
        "name": {json.dumps(self.name)}, 
        "stats_url": "{self.stats_url}"
        }}"""


class TeamSummaryBuilder:
    """
    Builder for team model
    """

    def __init__(self):
        self.stats_url = ''
        self.name = ''

    def add_stats_url(self, stats_url):
        """Enrich team with stats url information"""
        self.stats_url = stats_url
        return self

    def add_name(self, name):
        """Enrich team with name information"""
        self.name = name
        return self

    def build(self):
        """Build player"""
        return TeamSummary(self.stats_url, self.name)
