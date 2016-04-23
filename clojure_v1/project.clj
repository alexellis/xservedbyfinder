(defproject xservedbyfinder "0.1.0-SNAPSHOT"
  :description "xservedbyfinder in clojure"
  :url "http://example.com/FIXME"
  :license {:name "MIT License"}
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [clj-http "2.0.0"]]
  :main ^:skip-aot xservedbyfinder.core
  :uberjar-name "xservedbyfinder.jar"
  :profiles {:uberjar {:aot :all}
             :dev     {:global-vars {*print-length* 20}}}
  )
