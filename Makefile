# default is top one
# TODO I think we're supposed to list all files here, not just one, everywhere? :)
replaceinpdf: replaceinpdf.cr
	crystal build replaceinpdf.cr

spec: spec.cr
	crystal spec.cr
