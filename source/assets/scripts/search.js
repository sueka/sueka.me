(function (window) {

  function array(arrayLike) {
    return Array.prototype.slice.call(arrayLike);
  }

  function search(patterns, posts) {
    return posts.filter(post => patterns.every(pattern => pattern.test(post.content)));
  }

  var qFields = array(document.querySelectorAll("input[name=q]"));

  fetch("/json/posts.json").then(response => response.json()).then(posts => {
    window.addEventListener("keyup", (event) => {
      if (qFields.includes(event.target)) {
        var q = event.target.value;

        var resultDiv = event.target.parentNode.querySelector(".search-result");
        resultDiv.innerHTML = "";

        if (q !== "") {
          var searchPatterns = q.split(" ").map(query => new RegExp(query, "i"));

          var ul = document.createElement("ul");
          var liContainer = document.createDocumentFragment();

          search(searchPatterns, posts).forEach(post => {
            var li = document.createElement("li"),
                a = document.createElement("a");
                a.href = post.url;
                a.lang = post.lang;
                a.hreflang = post.lang;
                a.textContent = post.title;

            li.appendChild(a);
            liContainer.appendChild(li);
          });

          ul.appendChild(liContainer);
          resultDiv.appendChild(ul);
        }
      }
    });
  });

})(new Function("return this")());
