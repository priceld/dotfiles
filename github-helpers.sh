# Since switching to github and since starting to use the awesome `gh` CLI tool
# I've thought of lots of thing that would be nice to have/build to improve me
# workflow. Here's a place where I can work on/document some of those things.
# Ideas:
# - write a `gh` alias to checkout the branch for a given PR
# - write a query for fuzzy finding a list of PRs


# TODO: this should really be something like `gh pr status` to get PRs specific to me...but it isn't working
prs=$(gh pr list --json number,title,headRefName --template '{{range .}}{{tablerow (printf "#%v" .number) .title .headRefName}}{{end}}')
# Outputs:
# #337  AB#2115831 AX - Project Nashville: LM Thumb...  feature/AB-2115831-Add-AX-announcement-when...
# #336  Feature/ab 2014403 update the grading view ...  feature/AB-2014403-update-the-grading-view-...


basic_fzf_preview() {
  fzf --preview 'gh pr view {1}' --preview-window=:hidden --bind=space:toggle-preview
}
echo $prs | basic_fzf_preview
# The above is decent. Couple things I don't like:
# gh is shortening the line to fit...which is good for readability but bad for search ability
#  - I should probably just figure out how to print the whole title and branch name (I think I need to remove 'tablerow' from the template)
# The preview could be improved. I don't know if I should specify a template for it or what.

pr_preview() {
  fzf --preview 'gh pr view {1} --json number,title,body,author,labels --template "{{printf \"#%v\" .number}} {{.title}}\n\n{{.body}}\n"' --preview-window=:hidden,wrap --bind=space:toggle-preview
}
# This preview is better. The template needs to be expanded to include author and labels.
# I could probably get better formatting if I have to gotemplate do it for me...but I'd
# have to know the preview window size...
