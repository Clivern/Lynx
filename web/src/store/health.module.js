/** @format */

import { getReadiness, getHealth } from "@/common/health.api";

const state = () => ({
	readiness: {},
	health: {},
});

const getters = {
	getReadiness: (state) => {
		return state.readiness;
	},
	getHealth: (state) => {
		return state.health;
	},
};

const actions = {
	async fetchReadiness({ commit }) {
		const result = await getReadiness();
		commit("SET_READINESS", result.data);
		return result;
	},

	async fetchHealth({ commit }) {
		const result = await getHealth();
		commit("SET_HEALTH", result.data);
		return result;
	},
};

const mutations = {
	SET_READINESS(state, readiness) {
		state.readiness = readiness;
	},
	SET_HEALTH(state, health) {
		state.health = health;
	},
};

export default {
	namespaced: true,
	state,
	getters,
	actions,
	mutations,
};
