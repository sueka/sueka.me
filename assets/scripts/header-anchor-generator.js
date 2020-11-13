(function() {
  var anchorageAndIds, array, elementClose, elementOpen, flatten, mains, patchOuter, text;

  patchOuter = IncrementalDOM.patchOuter, elementOpen = IncrementalDOM.elementOpen, elementClose = IncrementalDOM.elementClose, text = IncrementalDOM.text;

  array = function(arrayLike) {
    return Array.prototype.slice.call(arrayLike);
  };

  flatten = function(xss) {
    return Array.prototype.concat.apply([], xss);
  };

  mains = array(document.querySelectorAll('main'));

  anchorageAndIds = flatten([
    flatten(mains.map(function(main) {
      return array(main.querySelectorAll('h1, h2, h3, h4, h5, h6'));
    })).filter(function(hn) {
      return hn.hasAttribute('id');
    }).map(function(hn) {
      return {
        anchorage: hn,
        id: hn.id
      };
    }), flatten(mains.map(function(main) {
      return array(main.querySelectorAll('section, article, nav, aside'));
    })).filter(function(section) {
      return section.hasAttribute('id');
    }).map(function(section) {
      return {
        anchorage: section.querySelector('h1, h2, h3, h4, h5, h6'),
        id: section.id
      };
    })
  ]);

  anchorageAndIds.forEach(function(arg) {
    var anchorage, headerAnchor, id;
    anchorage = arg.anchorage, id = arg.id;
    headerAnchor = document.createElement('div');
    anchorage.appendChild(headerAnchor);
    return patchOuter(headerAnchor, function() {
      text(' ');
      elementOpen('a', null, ['class', 'header-anchor', 'href', '#' + id]);
      text('#');
      return elementClose('a');
    });
  });

  window.addEventListener('touchstart', (function() {}), false);

}).call(this);
