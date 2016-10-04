
## Usage

* single run: rake who:served[https://www.raspberrypi.org/blog/the-little-computer-that-could/]
* multiple run run: rake who:served[https://www.raspberrypi.org/blog/the-little-computer-that-could/, 5]


* running the tasks on the container ` rake who:served[https://www.raspberrypi.org/blog/the-little-computer-that-could/,3] `

[[https://github.com/orieken/xservedbyfinder/blob/master/images/rake_task_output.png|alt=rake task]]


* if using rvm just install 2.3.1 ` rvm install ruby-2.3.1 `
* install bundler ` gem install bundler `
* install the bundle ` bundle install `

# Testing

* single run ` rspec spec `
* continuous testing run guard ` bundle exec guard `