ruby_v1
=========

Basic Ruby example - more are welcomed, especially you if you have a different twist, approach or aspect of the language to highlight.

**Installation:**

Install Ruby - which is available by default on MacOS with developer tools.

```
gem install rspec
```

**Running the example:**

```
$ REQUESTS=100 TARGET_URL=http://localhost:3000/ ruby app.rb
Raspberry Pi 12
Raspberry Pi 16
Raspberry Pi 1a
Raspberry Pi 1e
Raspberry Pi 2
Raspberry Pi 6
Raspberry Pi a
Raspberry Pi e
```

**Running unit tests**

```
$ rspec *_spec.rb -f documentation

collates
  one item and prints it
  two items and prints them in order asc
  two clashing items, but only records one

Finished in 0.00158 seconds (files took 0.15132 seconds to load)
3 examples, 0 failures
```
