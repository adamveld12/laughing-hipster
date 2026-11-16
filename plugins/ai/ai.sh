#!/bin/env bash


export AI_AGENT_DIR="${HOME}/.agents";
export AI_AGENT_SKILLS_DIR="${AI_AGENT_DIR}/skills";

export FILES_PLUGIN_AI_AGENT_SKILLS="${FILES_PLUGIN_ROOT}/skills";
export FILES_PLUGIN_AI_AGENTS_MD="${FILES_PLUGIN_ROOT}/AGENTS.md";


# install opencode, jcode, codex, claude, antigravity and pi
if command -v brew >/dev/null 2>&1; then
	AGENTS=("opencode" "jcode" "codex" "claude")

	for agent in ${AGENTS[@]}; do
		if ! command -v $agent >/dev/null 2>&1; then
			brew install $agent
		fi
	done

	# antigravity ships as a cask, and its binary (agy) differs from the package name
	if ! command -v agy >/dev/null 2>&1; then
		brew install --cask antigravity-cli
	fi

	# pi coding agent, it's binary (pi) differs from the package name
	if ! command -v pi >/dev/null 2>&1; then
		brew install pi-coding-agent
	fi

	if ! command -v otel-gui >/dev/null 2>&1; then
		brew install metafab/tap/otel-gui;
	fi

	export OTEL_EXPORTER_OTLP_ENDPOINT='http://localhost:4318';
	export OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT='true';
	alias omp="OTEL_SERVICE_NAME='omp' omp";
fi


function ai_install_3p_skills() {
	if command -v npx >/dev/null 2>&1; then
		npx skills add https://github.com/vercel-labs/skills --skill find-skills;
		npx skills add https://github.com/anthropics/skills --skill skill-creator;
		npx skills add https://github.com/leonxlnx/taste-skill --skill design-taste-frontend;
		npx skills add mattpocock/skills;
		npx skills add leonxlnx/taste-skill;
	else
		echo 'npx is not installed, cannot install skill.sh skills';
		return 1;
	fi
}


function ai_setup_skills() {
	mkdir -p ${AI_AGENT_SKILLS_DIR} || return 1;

	files_linkdir "${FILES_PLUGIN_AI_AGENT_SKILLS}/tools" "${AI_AGENT_SKILLS_DIR}/tools" true;
	files_linkdir "${FILES_PLUGIN_AI_AGENT_SKILLS}/agentic" "${AI_AGENT_SKILLS_DIR}/agentic" true;
}


# Link the shared plugins/ai/AGENTS.md into every agent's global instructions
# location. Existing regular files are left alone; move them aside to adopt.
function ai_setup_agents_md() {
	local SOURCE="${FILES_PLUGIN_AI_AGENTS_MD}";
	[[ -f "${SOURCE}" ]] || return 1;

	# Ensure machine-local override stub exists so @~/.config/ai/AGENTS.md imports never error.
	local LOCAL_OVERRIDE="${HOME}/.config/ai/AGENTS.md";
	[[ -e "${LOCAL_OVERRIDE}" ]] || { mkdir -p "${LOCAL_OVERRIDE%/*}" && : > "${LOCAL_OVERRIDE}"; };

	local TARGETS=(
		"${AI_AGENT_DIR}/AGENTS.md"
		"${HOME}/.omp/agent/AGENTS.md"
		"${HOME}/.claude/CLAUDE.md"
		"${HOME}/.codex/AGENTS.md"
		"${HOME}/.config/opencode/AGENTS.md"
		"${HOME}/.pi/agent/AGENTS.md"
		"${HOME}/.gemini/GEMINI.md"
	);

	local TARGET;
	for TARGET in "${TARGETS[@]}"; do
		[[ "${TARGET}" -ef "${SOURCE}" ]] && continue; # already linked
		if [[ -e "${TARGET}" && ! -L "${TARGET}" ]]; then
			files_debug_log "[ai] skipping ${TARGET}: regular file exists";
			continue;
		fi
		mkdir -p "${TARGET%/*}" && ln -fs "${SOURCE}" "${TARGET}";
	done
}

[[ -f "${AI_AGENT_SKILLS_DIR}/tools" ]] || ai_setup_skills
ai_setup_agents_md
