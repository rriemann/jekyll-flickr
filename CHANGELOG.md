## HEAD

## 0.2.1 / 2024-01-01

  * fix: change cache name according to recommendation from <https://jekyllrb.com/tutorials/cache-api/>
  * feature: Add flexibility to searching for the right picture width and some minor issues (courtesy of <akarwande@coredigital.com>)

## 0.2.0 / 2021-02-25

  * dependencies: require Jekyll 4.x and use gem flickr instead of flickraw
  * use native Jekyll cache API (<https://jekyllrb.com/tutorials/cache-api/>) instead of jekyll-cache

## 0.1.3 / 2019-03-13

  * refactor: use simpler API provided by gem flickraw 0.9.10

## 0.1.2 / 2019-03-06

  * feature: reduce overhead due to class variables
  * fix: disable expiry of the cache

## 0.1.1 / 2017-04-09

  * feature: add CSS class `flickr` to HTML
  * feature: fallback to original image size if fallback `width_legacy` is not offered by Flickr API.

  * fix: remove debugging notice
  * fix: broken path to ruby lib
  * fix: add missing require for cache
  * fix: use 1024 instead of 800 as fallback width `width_legacy`, because 800 seems to be less often available.

## 0.1.0 / 2017-04-08

  * Birthday!
  * move monkey patched code to a proper Jekyll Tag plug-in
