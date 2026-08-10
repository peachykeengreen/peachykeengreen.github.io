window.allSiteRecipes = [
  {{ range $i, $e := (where .Site.RegularPages "Type" "ne" "page") }}{{ if $i }},{{ end }}"{{ $e.RelPermalink }}"{{ end }}
];

function pickRandomSiteRecipe(e) {
  if (e) e.preventDefault();
  if (window.allSiteRecipes && window.allSiteRecipes.length > 0) {
    const randomIndex = Math.floor(Math.random() * window.allSiteRecipes.length);
    window.location.href = window.allSiteRecipes[randomIndex];
  }
}
