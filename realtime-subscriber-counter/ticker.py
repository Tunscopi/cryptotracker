# ticker.py
import requests
import json
import sys
import argparse
import schedule
import time
import functools
import spidev
import time
import firebaseClient
import max7219.led as led
from custom_font import CUSTOM_FONT

# add command line arguments
parser = argparse.ArgumentParser(description='Crypto-currency tracker')

parser.add_argument('--crypto', dest='crypto',
                   help='The symbol for a cryptocurrency')

parser.add_argument('--ticker', dest='ticker', action='store_true',
                   help='Show a crypto ticker')


args = parser.parse_args()

spi = spidev.SpiDev()
spi.open(0,0)
spi.max_speed_hz = 1953000

firebaseApp = firebaseClient.cryptoApp()

def getUserFavoriteCryptos():
        returnedFavCryptos = []

        db = firebaseApp.database() 

        favoriteCryptos = db.child('user-currencies').get().val()

        fav = list(favoriteCryptos.items())
        returnedFavCryptos = [v[0] for v in fav]

        return returnedFavCryptos

def getCryptoTickerPriceMap(cryptos):
	ret = {};

	for c in cryptos:
		ret[c] = getCryptoPrice(c)

	return ret

def formatCryptoTicker(prev, current):
	ret = ''
	for key in current:
		if current[key] is not None:
			symbol = '\xfe'
			if key in prev:
				new = round(float(current[key]), 2)
				old = round(float(prev[key]), 2)
				if old > new:
					symbol = '\x1f'
				elif new > old:
					symbol = '\x1e'
			ret = ret + key + symbol + current[key] + ' '

	return ret

def getCryptoPrice(c):
	"""
	Fetches crypto currency prices. 
	If the specified currency does not exist, return None. Otherwise, return the price in USD. 

	API docs: https://coinmarketcap.com/api/
	"""

	try:
		symbol = c.upper()
		r = requests.get('https://api.coinmarketcap.com/v1/ticker/?convert=USD')
		data = json.loads(r.text)
		for coin in data:
			if (coin['symbol'] == symbol):
				price = "{0:.2f}".format(round(float(coin['price_usd']), 2))
				return price

		return None

	except Exception as e:
		print(str(e))
		return None


if __name__ == '__main__':
        device = led.matrix(cascaded = 4)
        device.orientation(90)

        if (args.ticker is not None): 
                oldPriceMap = {} 
                diffPriceMap = {} 

                while True: 
                        favCryptos = getUserFavoriteCryptos()
                        ret = getCryptoTickerPriceMap(favCryptos)
                        msg = formatCryptoTicker(oldPriceMap, ret)
                        device.show_message(msg + '         ', delay=0.1)
                        print(msg)

                        if ret != diffPriceMap: 
                                oldPriceMap = diffPriceMap
                                diffPriceMap = ret 

        else: 
                sys.exit(0);

	


