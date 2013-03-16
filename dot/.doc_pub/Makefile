vpath  $(HOME)/.doc_pub
DOC: doc 
	asciidoc $? 
	cp -asf $(PWD)/*.html $(HOME)/.webdoc
	touch DOC
