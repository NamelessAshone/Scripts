#! /usr/bin/env python3
'''
    This program is used to craw *ssr url* encoded by base64 or QR code.

    HOW TO INSTALL:
        1.Make sure you have installed Python3 and pip3.
        2.Using *pip3 install base64 requests dotenv os
          pyperclip bs4 PIL pyzbar*.
        3.If you are working on Linux, you need to install
          libzbar0 for pyzbar. For  Ubuntu, just like this
          *sudo apt-get install libzbar0*.

    :Author  ShuXin Shu
    :Date    2019年 05月 05日 星期日 16:03:35 CST
    :License MIT-License

    :Todo refactor this using pipelines.
'''
import base64
import requests
import dotenv
import os
import pyperclip
from bs4 import BeautifulSoup
from PIL import Image
from pyzbar.pyzbar import decode
from io import BytesIO


def get_url():
    dotenv.load_dotenv('.env')
    url = os.getenv('VPN') or 'http://www.ssrandvmess.club/'
    return url


def get_html(url):
    respone = requests.get(url)
    # with open('./index.html', 'r') as f:
    #     html = f.read()
    return respone.text


def parse_data(html):
    soup = BeautifulSoup(html, 'html.parser')
    results = []
    for tag in soup.find_all('input'):
        results.append(tag.get('value'))
    return results


def decode_ssr_url(datas):
    def decode_helper(data):
        if data[0:4] == 'data':
            header, encoded = data.split(',', 1)
            decode_str = base64.b64decode(encoded)
            img_data = BytesIO(decode_str)
            img = Image.open(img_data)
            qrcode = decode(img)
            url = qrcode[0].data
            return url
        else:
            return base64.standard_b64decode(data)

    return [decode_helper(data) for data in datas]


if __name__ == '__main__':
    url = get_url()
    html = get_html(url)
    datas = parse_data(html)
    results = decode_ssr_url(datas)
    pyperclip.copy('\n'.join([res.decode() for res in results]))
    # print([res.decode() for res in results], sep='\n')
