function array(arrayLike) {
  return Array.prototype.slice.call(arrayLike);
}

function search(patterns, posts) {
  return posts.filter(post => patterns.every(pattern => pattern.test(post.content)));
}

const qFields = array(document.querySelectorAll("input[name=q]"));

fetch("/json/posts.json").then(response => response.json()).then(posts => {
  window.addEventListener("keyup", (event) => {
    if (qFields.includes(event.target)) {
      const q = event.target.value;

      const resultDiv = event.target.parentNode.querySelector(".search-result");
      resultDiv.innerHTML = "";

      if (q !== "") {
        const searchPatterns = q.split(" ").map(query => new RegExp(query, "i"));
        // const exceprtPattern = new RegExp("(?:[^>](?!<))+" + q.replace(" ", "|") + "[^<]+(?:</)", "i");

        const ul = document.createElement("ul");
        const liContainer = document.createDocumentFragment();

        search(searchPatterns, posts).forEach(post => {
          const li = document.createElement("li");
          const a = document.createElement("a");
                a.href = post.url;
                a.lang = post.lang;
                a.hreflang = post.lang;
                a.textContent = post.title;
          // const div = document.createElement("div");
          //     div.innerHTML = exceprtPattern.exec(post.content)[0];

          li.appendChild(a);
          liContainer.appendChild(li);
        });

        ul.appendChild(liContainer);
        resultDiv.appendChild(ul);
      }
    }
  });
});
