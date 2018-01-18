<script>

(function (window) {

  function array(arrayLike) {
    return window.Array.prototype.slice.call(arrayLike)
  }

  Object.defineProperty(window.NodeList.prototype, "asArray", {
    get: function () { return array(this) }
  });

  Object.defineProperty(window.Array.prototype, "flatten", {
    get: function () { return window.Array.prototype.concat.apply([], this) }
  });

  var hns = window.document.querySelectorAll("main").asArray.map(function (main) {
    return main.querySelectorAll("h1, h2, h3, h4, h5, h6").asArray;
  }).flatten.filter(function (hn) {
    return hn.hasAttribute("id");
  });

  hns.forEach(function (hn) {
    var a = window.document.createElement("a");
        a.className = "header-anchor";
        a.href = "#" + hn.id;
        a.textContent = "🔗";
    hn.append("\n");
    hn.append(a);
  });

})(new Function("return this")());

</script>
