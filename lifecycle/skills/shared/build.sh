# shellcheck shell=bash disable=SC2016 # backticks in patterns are literal Markdown
# build.sh — what the build skills' context scripts share: finding root-sot, the gate, a module's
# project and config, its code checkout, and the stage's section in the plan or change note.
#
# Sourced, never run: `. "$root/lifecycle/skills/shared/build.sh"` after `find_root`. It lives in
# `shared/`, which has no SKILL.md, so `bin/install-skills` doesn't copy it; the installed skills reach
# it through root-sot. Every function prints and returns 0, because a context script must exit 0: a
# failing injected command aborts the skill before Claude sees it (`skills-plan.md` §0 *The gate*).

# find_root <skill dir>: sets $root and $lc. An installed copy names root-sot in its `.root-sot`
# (written by `bin/install-skills`); a skill run from its own folder in root-sot is three levels down.
# Prints the reason and returns 1 when neither leads to a checkout with `lifecycle/bin/gate`.
find_root() {
	if [ -f "$1/.root-sot" ]; then root=$(head -n 1 "$1/.root-sot" | tr -d '\r'); else root=$(cd "$1/../../.." && pwd -P); fi
	lc="$root/lifecycle"
	if [ ! -f "$lc/bin/gate" ]; then
		echo "ROOT-SOT NOT FOUND · looked in \"$root\" ($([ -f "$1/.root-sot" ] && echo "from $1/.root-sot" || echo "three levels above $1, and there is no .root-sot"))."
		echo "Rerun bin/install-skills from the root-sot checkout, then invoke the skill again."
		return 1
	fi
}

# gate <module> <phase> [args]: runs root-sot's gate by its real path, from wherever the session is.
gate() { bash "$lc/bin/gate" "$@"; }

# section <file> <text>: the first h2 whose text contains <text>, up to the next h1 or h2, without
# its heading; headings inside code fences don't count.
section() {
	[ -f "$1" ] || return 0
	awk -v want="$2" '
		{ sub(/\r$/, "") }
		/^[ \t]*(```|~~~)/ { fence = !fence }
		!fence && /^##?[ \t]/ {
			if (on) exit
			t = tolower($0); gsub(/[`*_]/, "", t)
			if ($0 ~ /^##[ \t]/ && index(t, tolower(want))) { on = 1; next }
		}
		on { print }
	' "$1"
}

# stages <module dir>: every stage the module defines, as "<id><TAB><file>", read as the gate reads
# them: the h3s under the build plan's "The stages", then under each change note's h2 holding "stage".
stages() {
	local f
	[ -f "$1/07-build-plan.md" ] && section "$1/07-build-plan.md" "the stages" | awk '/^###[ \t]/ { gsub(/[`*_]/, "", $2); print $2 "\t07-build-plan.md" }'
	for f in "$1"/changes/*.md; do
		[ -f "$f" ] && section "$f" "stage" | awk -v f="changes/${f##*/}" '/^###[ \t]/ { gsub(/[`*_]/, "", $2); print $2 "\t" f }'
	done
	return 0
}

# stage_source <module dir> <stage>: the file that defines the stage, relative to the module folder.
stage_source() { stages "$1" | awk -F'\t' -v s="$2" 'tolower($1) == tolower(s) { print $2; exit }'; }

# stage_section <file> <stage>: the stage's h3, with its heading, up to the next h1, h2 or h3.
stage_section() {
	[ -f "$1" ] || return 0
	awk -v want="$2" '
		{ sub(/\r$/, "") }
		/^[ \t]*(```|~~~)/ { fence = !fence }
		!fence && /^#{1,3}[ \t]/ {
			if (on) exit
			if ($0 ~ /^###[ \t]/) { w = $2; gsub(/[`*_]/, "", w); if (tolower(w) == tolower(want)) on = 1 }
		}
		on { print }
	' "$1"
}

# find_module <stage>: the module folders, relative to root-sot, that define <stage>, one per line.
find_module() {
	local d
	for d in "$root"/*/modules/*/; do
		d=${d%/}
		[ -n "$(stage_source "$d" "$1")" ] && printf '%s\n' "${d#"$root"/}"
	done
	return 0
}

# project_of <module, relative>: the project whose config folder serves it — the module's top folder,
# except Root's own areas (`ecosystem/`), whose code is root-app.
project_of() {
	local top=${1%%/*}
	case $top in
	ecosystem) echo root-app ;;
	*) [ -d "$lc/projects/$top" ] && echo "$top" ;;
	esac
}

# config_cell <config.md> <row label>: the second cell of the first table row whose label contains it.
config_cell() {
	[ -f "$1" ] || return 0
	awk -F'|' -v want="$2" 'index(tolower($2), tolower(want)) { sub(/^[ \t]+/, "", $3); sub(/[ \t]+$/, "", $3); print $3; exit }' "$1"
}

# checkout_of <config.md>: this machine's checkout of the project's code repo, or nothing. Tries every
# backticked path in the Paths rows that name a checkout (Windows `E:\x` read as Git Bash's `/e/x`,
# `~` as $HOME), then a sibling of root-sot named after the repo.
checkout_of() {
	local p repo
	{
		awk -F'|' 'tolower($2) ~ /checkout/ && tolower($2) !~ /root-sot|where each/ { print $3 }' "$1" |
			grep -o '`[^`]*`' | tr -d '`' | grep -v '[<>]'
		repo=$(config_cell "$1" "Code repo" | grep -o '`[^`]*`' | head -n 1 | tr -d '`')
		[ -n "$repo" ] && echo "$(dirname "$root")/${repo##*/}"
	} | while IFS= read -r p; do
		# shellcheck disable=SC1003,SC2088 # tr's argument is one backslash; the ~ is a literal from config.md
		case $p in
		[A-Za-z]:\\*) p="/$(printf '%s' "${p:0:1}" | tr '[:upper:]' '[:lower:]')$(printf '%s' "${p:2}" | tr '\\' '/')" ;;
		"~/"*) p="$HOME/${p#"~/"}" ;;
		esac
		if [ -d "$p/.git" ] || [ -f "$p/.git" ]; then (cd "$p" && pwd -P); break; fi
	done
}

# code_state <checkout>: fetch, then the branch, HEAD and status, and the worktrees.
code_state() {
	local out
	out=$(timeout 30 git -C "$1" fetch --quiet 2>&1) || echo "fetch failed: ${out:-timed out} (read what is local, and say so)"
	echo "HEAD: $(git -C "$1" rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git -C "$1" rev-parse --short HEAD 2>/dev/null)"
	git -C "$1" status -sb 2>/dev/null | head -n 12
	echo "worktrees:"
	git -C "$1" worktree list 2>/dev/null | sed 's/^/  /'
}

# top_block <STATE.md>: the newest block, from its first h2 to the next.
top_block() { [ -f "$1" ] && awk '/^## /{ if (on) exit; on = 1 } on' "$1"; return 0; }

# lanes <STATE.md>: every *Lanes in flight* line and table row in the five live blocks.
lanes() {
	[ -f "$1" ] || return 0
	awk '/^## / { n++ } n >= 1 && n <= 5' "$1" | awk '
		/^\*\*Lanes in flight/ { print "  " $0; on = 1; next }
		on && /^\|/ { print "  " $0; next }
		on && /^$/ { next }
		{ on = 0 }
	'
}

# rows_naming <file> <word>: the lines of an open-work file that name a stage or milestone, as a word.
rows_naming() {
	[ -f "$1" ] || return 0
	grep -n -w -F -- "$2" "$1" | head -n 30
}
