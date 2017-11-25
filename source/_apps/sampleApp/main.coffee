---
---

checkPrimality = (n) ->
  if n.constructor != Number || n != (Math.floor n) || n <= 1
    false
  else
    pfcs =
      if n < 4
        []
      else
        [2].concat(_ for _ in [3 .. Math.sqrt n] by 2)
    pfcs.every (x) -> n % x != 0

addEventListener 'submit', (e) ->
  form = document.forms[0]
  res = document.querySelector('#res')
  if e.target == form
    n = +form.elements.namedItem('n').value
    res.textContent =
      if checkPrimality n
        'Yes'
      else
        'No'
  e.preventDefault()
  false
