# default is top one
replaceinpdf: $(wildcard *.cr)
	crystal build replaceinpdf.cr

#specify that spec isn't a file :|
.PHONY: spec

spec:
	crystal spec.cr
