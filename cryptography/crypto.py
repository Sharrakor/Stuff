import sys
import argparse

parser = argparse.ArgumentParser(description='Babby\'s first encryptor.')
parser.add_argument('infile', type=argparse.FileType('r'), default=sys.stdout, help='the name of the file to be encrypted')
parser.add_argument('key', help='a key to encrypt the file with')
parser.add_argument('-o','--outfile', nargs='?', type=argparse.FileType('w'), default=sys.stdout, help='the name of a file to output the encrypted information to')

args = parser.parse_args()

def main():	
	for line in args.infile:
		print(line, end='')
		## Todo: The actual cryptography part of the cryptography thing, just as soon as I've figured out how '>_>
		## Don't look to disappointed

	command = input("Exit? [Y/N]: ").lower()
	while command != "y":
		command = input("Exit? [Y/N]: ").lower()


main()
