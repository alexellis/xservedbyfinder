(ns xservedbyfinder.core
  "Find the server names behind the load balancer"
  (:require [clj-http.client :as client])
  (:gen-class))

(defn target-url [] (or (System/getenv "TARGET_URL") "http://localhost:3000"))

(defn get-sample
  "Make a GET call to this url, and return the X-Served-By header property value from the response"
  [url]
  (get-in (client/get url) [:headers "X-Served-By"]))

(defn find-next-value
  "Find the next unique value returned by this function, given a set of values already
  found. Sample attempts number of times before giving up."
  [f found attempts]
  (loop [hit-run 1 sample (f)]
    (if (not (contains? found sample))
      sample
      (if (<= hit-run attempts)
        (recur (inc hit-run) (f))))))

(defn sample-attempts
  "Return the number of tries you should attempt to find the next unique value,
  given a set of unique values found so far. Increase this to increase confidence."
  [coll]
  (* 5 (count coll)))

(defn unique-values
  "Lazily compute unique values returned from the given function, assuming it is a
  random sampling, with reasonable confidence."
  ([f] (unique-values f #{}))
  ([f coll]
   (if-let [next (find-next-value f coll (sample-attempts coll))]
     (cons next (lazy-seq (unique-values f (conj coll next)))))))

(defn -main
  "Lazily print the unique X-Served-By headers in a GET response, as you collect them."
  []
  (doseq [id (unique-values #(get-sample (target-url)))]
    (println id)))
