"""
Base html parser module
"""
from html.parser import HTMLParser


class BaseHtmlParser(HTMLParser):
    """Base html parser"""

    def handle_starttag(self, tag, attrs):
        if tag not in self._self_closed_tags:
            self._tags_stack.append(tag)
            self._attrs_stack.append(attrs)

    def handle_endtag(self, tag):
        self._tags_stack.pop()
        self._attrs_stack.pop()

    def error(self, message):
        print('Error while parsing players info')
        print(message)

    def find_attr(self, attrs, name):
        """Returns attribute by name"""
        return next(filter(lambda attr: attr[0] == name, attrs), [None, None])[1]

    def get_result(self):
        """Returns result"""
        pass

    _tags_stack = []
    _attrs_stack = []
    _self_closed_tags = ['img']
