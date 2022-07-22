HOST = 'https://www.hltv.org'
PLAYERS_URL = '/stats/players'
DEFAULT_HTTP_HEADERS = {'User-Agent': 'CybersportManager'}

FILE_PATH_WITH_PLAYERS = "build/players.json"
FILE_PATH_WITH_RATING = "build/rating.json"
FILE_PATH_WITH_OVERALL_RATING = "build/overall_rating.json"

YEARS_TO_PARSE = ['2022', '2021', '2020',
                  '2019', '2018', '2017', '2016', '2015']
ALL_TIME = "all"

RATING_GENERATION_MIN_MAPS = 20

STATS_FOR_RATING_WITH_DIRECTION = {
    "headshot_percent": False,
    "kill_death_ratio": False,
    "damage_round_ratio": False,
    "grenade_damage_round_ratio": False,
    "kill_round_ratio": False,
    "assist_round_ratio": False,
    "death_round_ratio": True,
    "saved_teammate_round_ratio": False,
    "kast": False,
    "impact": False
}