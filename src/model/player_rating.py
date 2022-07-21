"""
Player rating models module
"""


class PlayerRating:
    """
    Player rating information
    """

    def __init__(
        self,
        headshot_percent,
        kill_death_ratio,
        damage_round_ratio,
        grenade_damage_round_ratio,
        kill_round_ratio,
        assist_round_ratio,
        death_round_ratio,
        saved_teammate_round_ratio,
        kast,
        impact
    ):
        self.headshot_percent = headshot_percent
        self.kill_death_ratio = kill_death_ratio
        self.damage_round_ratio = damage_round_ratio
        self.grenade_damage_round_ratio = grenade_damage_round_ratio
        self.kill_round_ratio = kill_round_ratio
        self.assist_round_ratio = assist_round_ratio
        self.death_round_ratio = death_round_ratio
        self.saved_teammate_round_ratio = saved_teammate_round_ratio
        self.kast = kast
        self.impact = impact

    def to_dict(self):
        """Convert model to dict"""
        return {
            "headshot_percent": self.headshot_percent,
            "kill_death_ratio": self.kill_death_ratio,
            "damage_round_ratio": self.damage_round_ratio,
            "grenade_damage_round_ratio": self.grenade_damage_round_ratio,
            "kill_round_ratio": self.kill_round_ratio,
            "assist_round_ratio": self.assist_round_ratio,
            "death_round_ratio": self.death_round_ratio,
            "saved_teammate_round_ratio": self.saved_teammate_round_ratio,
            "kast": self.kast,
            "impact": self.impact,
            "overall": self.overall
        }

    @staticmethod
    def from_dict(dictionary):
        """Convert from dict"""
        return PlayerRating(
            dictionary["headshot_percent"],
            dictionary["kill_death_ratio"],
            dictionary["damage_round_ratio"],
            dictionary["grenade_damage_round_ratio"],
            dictionary["kill_round_ratio"],
            dictionary["assist_round_ratio"],
            dictionary["death_round_ratio"],
            dictionary["saved_teammate_round_ratio"],
            dictionary["kast"],
            dictionary["impact"]
        )

    def __repr__(self):
        return f"""{{
        "headshot_percent": {self.headshot_percent},
        "kill_death_ratio": {self.kill_death_ratio},
        "damage_round_ratio": {self.damage_round_ratio},
        "grenade_damage_round_ratio": {self.grenade_damage_round_ratio},
        "kill_round_ratio": {self.kill_round_ratio},
        "assist_round_ratio": {self.assist_round_ratio},
        "death_round_ratio": {self.death_round_ratio},
        "saved_teammate_round_ratio": {self.saved_teammate_round_ratio},
        "kast": {self.kast},
        "impact": {self.impact},
        "overall": {self.overall}
        }}"""

    @property
    def overall(self):
        """Calculates overall rating"""
        return (
            + self.kast
            + self.impact
            + self.damage_round_ratio
            + 0.8 * self.assist_round_ratio
            + 0.8 * self.kill_round_ratio
            + 0.8 * self.kill_death_ratio
            + 0.8 * self.death_round_ratio
            + 0.3 * self.saved_teammate_round_ratio
            + 0.3 * self.headshot_percent
            + 0.3 * self.grenade_damage_round_ratio
        ) / 7.1
