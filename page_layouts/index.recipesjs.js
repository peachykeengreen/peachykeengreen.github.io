window.allSiteRecipes = [
  {{ $first := true }}{{ range $i, $e := .Site.RegularPages }}{{ if ne $e.Params.slug "about" }}{{ if not $first }},{{ end }}"{{ $e.RelPermalink }}"{{ $first = false }}{{ end }}{{ end }}
];

function pickRandomSiteRecipe(e) {
  if (e) e.preventDefault();
  if (window.allSiteRecipes && window.allSiteRecipes.length > 0) {
    const randomIndex = Math.floor(Math.random() * window.allSiteRecipes.length);
    window.location.href = window.allSiteRecipes[randomIndex];
  }
}
