"""
Team models module
"""


class TeamSummary:
    """
    Team summary information
    """

    def __init__(self, name, stats_url):
        self.name = name
        self.stats_url = stats_url

    def __repr__(self):
        return f"""{{
        "name": "{self.name}", 
        "stats_url": "{self.stats_url}"
        }}"""


class TeamSummaryBuilder:
    """
    Builder for team model
    """

    def __init__(self):
        self.name = ''
        self.stats_url = ''

    def add_name(self, name):
        """Enrich team with name information"""
        self.name = name
        return self

    def add_stats_url(self, stats_url):
        """Enrich team with stats url information"""
        self.stats_url = stats_url
        return self

    def build(self):
        """Build player"""
        return TeamSummary(self.name, self.stats_url)
