// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
/*ref)
引用>Sprocketsでアセットをコンパイルするとき、Sprocketsはどのトップレベルターゲットをコンパイルするかを決める必要があります
https://qiita.com/arata0520/items/4330c2be8740bc560390
https://railsguides.jp/asset_pipeline.html#%E3%83%9E%E3%83%8B%E3%83%95%E3%82%A7%E3%82%B9%E3%83%88%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%A8%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%86%E3%82%A3%E3%83%96
*/
//= require jquery3
//= require popper
//= require bootstrap
import "@hotwired/turbo-rails"
import "controllers"
