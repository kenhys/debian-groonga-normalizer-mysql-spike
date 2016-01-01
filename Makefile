master:
	@if [ ! -d groonga-normalizer-mysql ]; then \
		git clone https://github.com/groonga/groonga-normalizer-mysql.git; \
	else \
		(cd groonga-normalizer-mysql; git pull --rebase) \
	fi

upstream: master
	rsync -az --delete --exclude=changelog groonga-normalizer-mysql/packages/debian/ debian/

update-image:
	DIST=sid sudo pbuilder --update

source:
	./buildpkg.sh source

build: tmpfs
	./buildpkg.sh build 2>&1 | tee build-$$(date +'%Y%m%d').log && ./buildpkg.sh copy-pkg

tmpfs:
	./buildpkg.sh mount
