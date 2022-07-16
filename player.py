"""
Player models module
"""


class Player:
    """
    Player basic information
    """

    def __init__(self, name, stats_url):
        self.name = name
        self.stats_url = stats_url


    def __repr__(self):
        return f"Name: {self.name}, Stats Url: {self.stats_url}"


class PlayerBuilder:
    """
    Builder for player model
    """

    def __init__(self) -> None:
        self.code = ''
        self.name = ''
        self.stats_url = ''

    def add_name(self, name):
        """Enrich player with name information"""
        self.name = name
        return self

    def add_stats_url(self, stats_url):
        """Enrich player with stats url information"""
        self.stats_url = stats_url
        return self

    def build(self):
        """Build player"""
        return Player(self.name, self.stats_url)


class PlayerStats:
    """
    Player stats information
    """

    def __init__(self):
        pass
