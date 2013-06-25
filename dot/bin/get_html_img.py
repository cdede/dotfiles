import re
from optparse import OptionParser
from bs4 import BeautifulSoup

def get_img(filename):
    img_url_list = []
    with open(filename, 'r') as file1:
        htmls = file1.readlines()
    for html in htmls:
        soup = BeautifulSoup(html)
        l1 = soup.findAll('img')
        for i in l1:
            print i['src']

def arg_parse():
    parser = OptionParser()
    parser.add_option('-f','--filename', help='html filename'
            , default='')
    return parser.parse_args()

def main():
    (options,args) = arg_parse()
    filename = options.filename
    get_img(filename)

if __name__ == '__main__':
    main()
