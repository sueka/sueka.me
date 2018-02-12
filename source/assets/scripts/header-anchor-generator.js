(function (window) {

  function array(arrayLike) {
    return Array.prototype.slice.call(arrayLike);
  }

  function flatten(xss) {
    return Array.prototype.concat.apply([], xss);
  }

  const mains = array(window.document.querySelectorAll("main"));

  const anchorageAndIds = flatten(mains.map(function (main) {
    return array(main.querySelectorAll("h1, h2, h3, h4, h5, h6"));
  })).filter(function (hn) {
    return hn.hasAttribute("id");
  }).map(function (hn) {
    return {
      "anchorage": hn,
      "id": hn.id,
    };
  }).concat(flatten(mains.map(function (main) {
    return array(main.querySelectorAll("section, article, nav, aside"));
  })).filter(function (section) {
    return section.hasAttribute("id");
  }).map(function (section) {
    return {
      "anchorage": section.querySelector("h1, h2, h3, h4, h5, h6"),
      "id": section.id,
    };
  }));

  anchorageAndIds.forEach(function (anchorageAndId) {
    const space = window.document.createTextNode(" ");
    const a = window.document.createElement("a");
          a.className = "header-anchor";
          a.href = "#" + anchorageAndId.id;
          a.textContent = "🔗";
    anchorageAndId.anchorage.appendChild(space);
    anchorageAndId.anchorage.appendChild(a);
  });

  window.addEventListener("touchstart", function () {
  }, false);

})(new Function("return this")());
