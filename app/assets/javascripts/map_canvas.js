var getPixels = function(img) {
  var c = getCanvas(img.width, img.height);
  var ctx = c.getContext('2d');
  ctx.drawImage(img, 0, 0);
  return ctx.getImageData(0,0,c.width,c.height);
};

var getCanvas = function(w, h) {
  var c = document.createElement('canvas');
  c.width = w;
  c.height = h;
  return c;
};

var filterImage = function(filter, image, var_args) {
  var args = [getPixels(image)];
  return filter.apply(null, args);
};

var grayscale = function(pixels, args) {
  var d = pixels.data;

  for (var i=0; i<d.length; i+=4) {
    if(d[i] == 255  && d[i+1] == 0 && d[i+2] == 255)
      d[i + 1] = 255
  }
  return pixels;
};

function loadImg(src, callback) {
  var sprite = new Image();
  sprite.onload = function() {
    callback(sprite);
  };
  sprite.src = src;
}

document.addEventListener("turbolinks:load", function() {
  if($('#map-image').length > 0){
    loadImg($('#map-image').data('src'), function(img) {
      var canvas = getCanvas(img.width, img.height)
      var ctx = canvas.getContext('2d')
      ctx.putImageData(filterImage(grayscale, img), 0, 0)
      $('#map-image').attr('src', canvas.toDataURL("image/png"))
    })
  }
})
