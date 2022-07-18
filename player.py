"""
Player models module
"""


class PlayerSummary:
    """
    Player summary information
    """

    def __init__(self, stats_url, name, teams):
        self.stats_url = stats_url
        self.name = name
        self.teams = teams

    def __repr__(self):
        return f"""{{
        "name": "{self.name}", 
        "stats_url": "{self.stats_url}", 
        "teams": "{self.teams}"
        }}"""


class PlayerSummaryBuilder:
    """
    Builder for player summary model
    """

    def __init__(self):
        self.stats_url = ''
        self.name = ''
        self.teams = []

    def add_stats_url(self, stats_url):
        """Enrich player with stats url information"""
        self.stats_url = stats_url
        return self

    def add_name(self, name):
        """Enrich player with name information"""
        self.name = name
        return self

    def add_team(self, team):
        """Enrich player with team information"""
        self.teams.append(team)
        return self

    def build(self):
        """Build player"""
        return PlayerSummary(self.stats_url, self.name, self.teams)


class Player:
    """
    Player full information
    """

    def __init__(
        self,
        name,
        real_name,
        teams,
        current_team,
        country,
        age,
        total_kills,
        total_deaths,
        headshot_percent,
        kill_death_ratio,
        maps_played,
        rounds_played,
        damage_round_ratio,
        grenade_damage_round_ratio,
        kill_round_ratio,
        assist_round_ratio,
        death_round_ratio,
        saved_by_teammate_round_ratio,
        saved_teammate_round_ratio,
        kast,
        impact
    ):
        self.name = name
        self.real_name = real_name
        self.teams = teams
        self.current_team = current_team
        self.country = country
        self.age = age
        self.total_kills = total_kills
        self.total_deaths = total_deaths
        self.headshot_percent = headshot_percent
        self.kill_death_ratio = kill_death_ratio
        self.maps_played = maps_played
        self.rounds_played = rounds_played
        self.damage_round_ratio = damage_round_ratio
        self.grenade_damage_round_ratio = grenade_damage_round_ratio
        self.kill_round_ratio = kill_round_ratio
        self.assist_round_ratio = assist_round_ratio
        self.death_round_ratio = death_round_ratio
        self.saved_by_teammate_round_ratio = saved_by_teammate_round_ratio
        self.saved_teammate_round_ratio = saved_teammate_round_ratio
        self.kast = kast
        self.impact = impact

    def __repr__(self):
        return f"""{{
            "name": "{self.name}", 
            "real_name": "{self.real_name}", 
            "teams": {self.teams},
            "current_team": "{self.current_team}",
            "country": "{self.country}",
            "age": "{self.age}",
            "total_kills": "{self.total_kills}",
            "total_death": "{self.total_deaths}",
            "headshot_percent": "{self.headshot_percent}",
            "kill_death_ratio": "{self.kill_death_ratio}",
            "maps_played": "{self.maps_played}",
            "rounds_played": "{self.rounds_played}",
            "damage_round_ratio": "{self.damage_round_ratio}",
            "grenade_damage_round_ratio": "{self.grenade_damage_round_ratio}",
            "kill_round_ratio": "{self.kill_round_ratio}",
            "assist_round_ratio": "{self.assist_round_ratio}",
            "death_round_ratio": "{self.death_round_ratio}",
            "saved_by_teammate_round_ratio": "{self.saved_by_teammate_round_ratio}",
            "saved_teammate_round_ratio": "{self.saved_teammate_round_ratio}",
            "kast": "{self.kast}",
            "impact": "{self.impact}"
        }}"""


class PlayerBuilder:
    """
    Builder for player model
    """

    def __init__(self, player_summary):
        self.name = player_summary.name
        self.real_name = ''
        self.teams = player_summary.teams
        self.current_team = ''
        self.country = ''
        self.age = 0
        self.total_kills = 0
        self.total_deaths = 0
        self.headshot_percent = 0
        self.kill_death_ratio = 0
        self.maps_played = 0
        self.rounds_played = 0
        self.damage_round_ratio = 0
        self.grenade_damage_round_ratio = 0
        self.kill_round_ratio = 0
        self.assist_round_ratio = 0
        self.death_round_ratio = 0
        self.saved_by_teammate_round_ratio = 0
        self.saved_teammate_round_ratio = 0
        self.kast = 0
        self.impact = 0

    def add_real_name(self, real_name):
        """Enrich player with real name information"""
        self.real_name = real_name
        return self

    def add_current_team(self, current_team):
        """Enrich player with current team information"""
        self.current_team = current_team
        return self

    def add_country(self, country):
        """Enrich player with country information"""
        self.country = country
        return self

    def add_age(self, age):
        """Enrich player with age information"""
        self.age = age
        return self

    def add_total_kills(self, total_kills):
        """Enrich player with total kills information"""
        self.total_kills = total_kills
        return self

    def add_total_deaths(self, total_deaths):
        """Enrich player with total deaths information"""
        self.total_deaths = total_deaths
        return self

    def add_headshot_percent(self, headshot_percent):
        """Enrich player with headshot percent information"""
        self.headshot_percent = headshot_percent
        return self

    def add_kill_death_ratio(self, kill_death_ratio):
        """Enrich player with kill death ratio information"""
        self.kill_death_ratio = kill_death_ratio
        return self

    def add_maps_played(self, maps_played):
        """Enrich player with maps played information"""
        self.maps_played = maps_played
        return self

    def add_rounds_played(self, rounds_played):
        """Enrich player with rounds played information"""
        self.rounds_played = rounds_played
        return self

    def add_damage_round_ratio(self, damage_round_ratio):
        """Enrich player with damage round ratio information"""
        self.damage_round_ratio = damage_round_ratio
        return self

    def add_grenade_damage_round_ratio(self, grenade_damage_round_ratio):
        """Enrich player with grenade damage round ratio information"""
        self.grenade_damage_round_ratio = grenade_damage_round_ratio
        return self

    def add_kill_round_ratio(self, kill_round_ratio):
        """Enrich player with kill round ratio information"""
        self.kill_round_ratio = kill_round_ratio
        return self

    def add_assist_round_ratio(self, assist_round_ratio):
        """Enrich player with assist round ratio information"""
        self.assist_round_ratio = assist_round_ratio
        return self

    def add_death_round_ratio(self, death_round_ratio):
        """Enrich player with death round ratio information"""
        self.death_round_ratio = death_round_ratio
        return self

    def add_saved_by_teammate_round_ratio(self, saved_by_teammate_round_ratio):
        """Enrich player with saved by teammate round ratio information"""
        self.saved_by_teammate_round_ratio = saved_by_teammate_round_ratio
        return self

    def add_saved_teammate_round_ratio(self, saved_teammate_round_ratio):
        """Enrich player with saved teammate round ratio information"""
        self.saved_teammate_round_ratio = saved_teammate_round_ratio
        return self

    def add_kast(self, kast):
        """Enrich player with kast information"""
        self.kast = kast
        return self

    def add_impact(self, impact):
        """Enrich player with impact information"""
        self.impact = impact
        return self

    def build(self):
        """Build player"""
        return Player(
            self.name,
            self.real_name,
            self.teams,
            self.current_team,
            self.country,
            self.age,
            self.total_kills,
            self.total_deaths,
            self.headshot_percent,
            self.kill_death_ratio,
            self.maps_played,
            self.rounds_played,
            self.damage_round_ratio,
            self.grenade_damage_round_ratio,
            self.kill_round_ratio,
            self.assist_round_ratio,
            self.death_round_ratio,
            self.saved_by_teammate_round_ratio,
            self.saved_teammate_round_ratio,
            self.kast,
            self.impact
        )
