(function (window) {

  function array(arrayLike) {
    return Array.prototype.slice.call(arrayLike);
  }

  Object.defineProperty(NodeList.prototype, "asArray", {
    get: function () {
      return array(this);
    }
  });

  Object.defineProperty(Array.prototype, "flatten", {
    get: function () {
      return Array.prototype.concat.apply([], this);
    }
  });

  Array.prototype.flatMap = function (f) {
    return this.map(f).flatten;
  };

  var mains = window.document.querySelectorAll("main").asArray;

  var anchorageAndIds = mains.flatMap(function (main) {
    return main.querySelectorAll("h1, h2, h3, h4, h5, h6").asArray;
  }).filter(function (hn) {
    return hn.hasAttribute("id");
  }).map(function (hn) {
    return {
      "anchorage": hn,
      "id": hn.id,
    };
  }).concat(mains.flatMap(function (main) {
    return main.querySelectorAll("section, article, nav, aside").asArray;
  }).filter(function (section) {
    return section.hasAttribute("id");
  }).map(function (section) {
    return {
      "anchorage": section.querySelector("h1, h2, h3, h4, h5, h6"),
      "id": section.id,
    };
  }));

  anchorageAndIds.forEach(function (anchorageAndId) {
    var a = window.document.createElement("a");
        a.className = "header-anchor";
        a.href = "#" + anchorageAndId.id;
        a.textContent = "🔗";
    anchorageAndId.anchorage.appendChild(a);
  });

  window.addEventListener("touchstart", function () {
  }, false);

})(new Function("return this")());
