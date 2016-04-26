FROM nacyot/prolog-swi:apt
MAINTAINER Simon K T Burrows <sktburrows@gmail.com>

ENV TARGET_URL 'http://localhost:3000/'
ENV ITERATIONS 25

ADD ./main.pl /main.pl

CMD ["swipl", "-s", "/main.pl", "-g", "main"]
