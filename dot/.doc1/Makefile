vpath  $(HOME)/.doc1
vpath  privdoc $(HOME)/.priv/doc
DOC: doc privdoc
	markdown $?>$(HOME)/.webdoc/$(notdir  $?).html
	touch DOC
