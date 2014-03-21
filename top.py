from re import findall
from sys import argv
from collections import defaultdict, OrderedDict, Counter
from itertools import islice

class Homework:	
	def __init__(self):
		if len(sys.argv) < 2:
			print('usage: python top.py {file}')
			exit(1)
		f = open(sys.argv[1])
		
		pairs = []

		counting_pairs = defaultdict(dict)

		try:
			for i, line in enumerate(f):	
				user_songs = re.findall("\w+", line)
				pairs += list(zip(user_songs[1:], user_songs[2:]))

		except IOError as err:
			print(err)
		finally:		
			print('Without Counter:')					
			for pair in pairs:
				if(pair in counting_pairs):
					counting_pairs[pair] += 1
				else:
					counting_pairs[pair] = 1
			
			oDict = OrderedDict(sorted(counting_pairs.items(), key=lambda t: t[1], reverse=True))

			for pair in islice(oDict.items(), 0, 10):
				print(pair)

			print('Using Counter:')
			for pair in Counter(pairs).most_common(10):
				print(pair)

			f.close()

Homework()			
