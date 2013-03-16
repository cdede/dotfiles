vpath  $(HOME)/.doc_pub
DOC: doc s
	asciidoc doc
	ls -1 s/*.a | xargs   -i asciidoc  {}
	cp -asf $(PWD)/*.html $(HOME)/.webdoc
	touch DOC
