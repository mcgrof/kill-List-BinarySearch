all test:

test:
	@prove -I old/ -r t
	@prove -I new/ -r t
