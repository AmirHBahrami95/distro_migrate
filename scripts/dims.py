#!/usr/bin/python3

import argparse

par= argparse.ArgumentParser(
	prog='dims',
	description='usage: get all coefficients of a dimensions (x,y)',
	epilog='made by @amirh'
)

par.add_argument('-v','--verbose',default=False)
par.add_argument('-t','--to',nargs='?',default=5,type=int)
par.add_argument('-s','--step',nargs='?',default=1,type=int)
par.add_argument('dims',metavar='dim',nargs=2,type=int)

#dims=[309,353]
args=par.parse_args()
print(args)

x=args.dims[0]
y=args.dims[1]

for i in range(1,args.to,args.step):
	if args.verbose:
		print(f"( {i} ) - {i*x} x {i*y}")
	else:
		print(f"{i*x} x {i*y}")
