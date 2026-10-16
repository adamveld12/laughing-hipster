#!/bin/env bash


export AI_AGENT_DIR="${HOME}/.agents";
export AI_AGENT_SKILLS_DIR="${AI_AGENT_DIR}/skills";

export FILES_PLUGIN_AI_AGENT_SKILLS="${FILES_PLUGIN_ROOT}/skills";


# install opencode, jcode, codex and claude
if command -v brew >/dev/null 2>&1; then
	AGENTS=("opencode" "jcode" "codex" "claude")

	for agent in ${AGENTS[@]}; do
		if ! command -v $agent >/dev/null 2>&1; then
			brew install $agent
		fi
	done
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
}

[[ -f "${AI_AGENT_SKILLS_DIR}/tools" ]] || ai_setup_skills
