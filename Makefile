all:
	@ if [ ! -d /home/fschlute/data/frontend ]; then \
		mkdir -p /home/fschlute/data/frontend; \
	fi
	@ if [ ! -d /home/fschlute/data/backend ]; then \
		mkdir -p /home/fschlute/data/backend; \
	fi
	@ if ! grep -q "fschlute.42.fr" /etc/hosts; then  \
		echo "127.0.0.1	fschlute.42.fr" >> /etc/hosts; \
	fi
	cd srcs && docker-compose up --build && cd -

clean:
	cd srcs && docker-compose down && cd -

fclean: 
	cd srcs && docker-compose down --rmi all --volumes && cd - 
	rm -rf /home/fschlute/data/frontend/*
	rm -rf /home/fschlute/data/backend/*

re: fclean all

