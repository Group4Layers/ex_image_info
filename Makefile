
# Launching

# make pre-publish

# Init

# git init
# git config user.email rnoz.commits@gmail.com
# git config user.name rNoz

pre-publish: words
	mix test; \
	mix coveralls; \
	mix docs;

words:
	bash support/words.sh

wip:
	bash support/wip.sh
