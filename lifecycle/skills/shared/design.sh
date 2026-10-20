# shellcheck shell=bash disable=SC2016,SC2154 # backticks in patterns are literal Markdown; root and lc are set by find_root
# design.sh — what the design skills' context scripts share (`skills-plan.md` §2): reading the argument
# line, where root-sot stands, the module's files and state, and a template with the headings the gate
# checks in its output.
#
# Sourced, never run, after build.sh: `. "$root/lifecycle/skills/shared/design.sh"`. Like build.sh it
# lives in `shared/`, which `bin/install-skills` doesn't copy; installed skills reach it through root-sot.
# Every function prints and returns 0, because a context script must exit 0.

# read_line [args…]: the argument line, from the arguments or the first line of stdin (the skills pass
# `$ARGUMENTS` in a quoted heredoc). Sets $line.
read_line() {
	line="${*:-}"
	if [ -z "$line" ] && [ ! -t 0 ]; then line=$(head -n 1 | tr -d '\r'); fi
	return 0
}

# split_line: from $line, sets $override (after `--override`), $module (the first word holding a slash
# that is a folder in root-sot, or, with $new_module=1, any `<area>/modules/<NN-slug>`), $flags (words
# starting `--`, with the word after `--touch-up`, `--steps` or `--from-note`), and $words (the rest).
split_line() {
	local w take=""
	override="" module="" flags="" words=""
	case $line in *--override*) override=${line#*--override}; line=${line%%--override*} ;; esac
	override=$(printf '%s' "$override" | sed "s/^[[:space:]\"']*//; s/[[:space:]\"']*\$//")
	for w in $line; do
		if [ -n "$take" ]; then flags="$flags $w"; take=""; continue; fi
		case $w in
		--touch-up | --steps | --from-note) flags="${flags:+$flags }$w"; take=1 ;;
		--*) flags="${flags:+$flags }$w" ;;
		*)
			if [ -z "$module" ] && [[ $w == */* ]] && { [ -d "$root/${w%/}" ] || { [ "${new_module:-0}" = 1 ] && [[ $w == */modules/* ]]; }; }; then
				module=${w%/} module=${module%/STATE.md}
			else
				words="${words:+$words }$w"
			fi
			;;
		esac
	done
	return 0
}

# where_block: root-sot's branch against its upstream, its uncommitted files, and the session's folder.
where_block() {
	local out up
	echo "## Where"
	echo "date: $(date +%F)"
	echo "root-sot: $(git -C "$root" rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git -C "$root" rev-parse --short HEAD 2>/dev/null)"
	out=$(timeout 30 git -C "$root" fetch --quiet 2>&1) || echo "root-sot fetch failed: ${out:-timed out} (read what is local, and say so)"
	up=$(git -C "$root" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
	if [ -n "$up" ]; then
		echo "upstream $up: $(git -C "$root" rev-list --count HEAD.."$up" 2>/dev/null) behind, $(git -C "$root" rev-list --count "$up"..HEAD 2>/dev/null) ahead"
	else
		echo "no upstream (a local branch)"
	fi
	git -C "$root" status --porcelain 2>/dev/null | head -n 8 | sed 's/^/  uncommitted: /'
	echo "this session's directory: $(pwd -P)"
	return 0
}

# modules_list [words]: every module folder, with the words of [words] its STATE.md or intake names.
modules_list() {
	local d r t hit
	for d in "$root"/*/modules/*/; do
		[ -d "$d" ] || continue
		d=${d%/} r=${d#"$root"/} hit=""
		for t in ${1:-}; do
			[ ${#t} -ge 4 ] || continue
			cat "$d/STATE.md" "$d/00-intake.md" 2>/dev/null | grep -qiF -- "$t" && hit="${hit:+$hit, }$t"
		done
		echo "- $r${hit:+ · names: $hit}"
	done
	return 0
}

# status_row <module>: the status.md header and the row that links to the module.
status_row() {
	local row
	row=$(grep -F "](../$1/)" "$lc/status.md" 2>/dev/null | head -n 1)
	if [ -n "$row" ]; then
		sed -n '1p' "$lc/status.md"
		echo "$row"
	else
		echo "status.md: no row links to $1/"
	fi
	return 0
}

# module_block <module>: its files, its status row, each phase file's version line, and STATE.md's
# top block.
module_block() {
	local m="$root/$1" f v
	echo "## The module: $1"
	if [ ! -d "$m" ]; then
		echo "(no such folder yet)"
		return 0
	fi
	echo "files: $(find "$m" -mindepth 1 -maxdepth 1 -not -name '.*' -printf '%f%y\n' | sed 's/d$/\//; s/f$//' | sort | paste -sd' ' -)"
	status_row "$1"
	for f in "$m"/0*.md "$m"/04b-design/README.md; do
		[ -f "$f" ] || continue
		v=$(grep -m 1 '^\*\*Version' "$f")
		echo "${f#"$m"/}: ${v:-no version line}"
	done
	[ -f "$m/04-wireframes.html" ] && echo "04-wireframes.html: $(grep -o -m 1 'draft [0-9][^<]*' "$m/04-wireframes.html" | head -n 1)"
	if ls "$m"/changes/*.md >/dev/null 2>&1; then
		echo "changes/: $(find "$m/changes" -maxdepth 1 -name '*.md' -printf '%f\n' | sort | paste -sd' ' -)"
	fi
	echo "### STATE.md, top block"
	if [ -f "$m/STATE.md" ]; then top_block "$m/STATE.md"; else echo "(no STATE.md)"; fi
	return 0
}

# headings_for <block>: the lines of required-headings.txt's [<block>] section, without comments.
headings_for() {
	awk -v want="[$1]" 'index($0, want) == 1 { on = 1; next } /^\[/ { on = 0 } on && NF && !/^#/' "$lc/templates/required-headings.txt"
	return 0
}

# template_block <template file> <headings block>: the template and the headings the gate checks.
template_block() {
	echo "## The template (lifecycle/templates/$1)"
	cat "$lc/templates/$1" 2>/dev/null || echo "(not found)"
	echo
	echo "## Its required headings (lifecycle/templates/required-headings.txt [$2])"
	headings_for "$2"
	return 0
}

# code_block <module>: the project's code checkout, its base branch and recent commits, or why not.
code_block() {
	local project cfg checkout b
	project=$(project_of "$1")
	cfg="$lc/projects/$project/config.md"
	if [ -z "$project" ] || [ ! -f "$cfg" ]; then
		echo "## Code checkout: no lifecycle/projects/ config serves $1 yet"
		return 0
	fi
	checkout=$(checkout_of "$cfg")
	if [ -z "$checkout" ]; then
		echo "## Code checkout: not on this machine (lifecycle/projects/$project/config.md names none here)"
		return 0
	fi
	echo "## Code checkout: $checkout (project $project)"
	code_state "$checkout"
	b=$(base_of "$checkout")
	echo "$b @ $(git -C "$checkout" rev-parse --short "$b" 2>/dev/null) · origin/$b @ $(git -C "$checkout" rev-parse --short "origin/$b" 2>/dev/null)"
	return 0
}

# ids_in <file> <section text> [prefix]: the criterion ids (AC-3, TK-1) in a section, sorted, one line.
ids_in() {
	local p='[A-Z]{2}'
	[ -f "$1" ] || return 0
	[ -n "${3:-}" ] && p=$3
	section "$1" "$2" | grep -oE "\b$p-[0-9]+\b" | sort -u | sort -t- -k1,1 -k2,2n | paste -sd' ' -
	return 0
}
