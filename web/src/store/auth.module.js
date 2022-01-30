/** @format */

import { auth } from "@/common/health.api";

const state = () => ({
	authResult: {},
});

const getters = {
	getAuth: (state) => {
		return state.authResult;
	},
};

const actions = {
	async authAction(context, apiKey) {
		const result = await auth(apiKey);
		context.commit("SET_AUTH_RESULT", result.data);
		return result;
	},
};

const mutations = {
	SET_AUTH_RESULT(state, authResult) {
		state.authResult = authResult;
	},
};

export default {
	namespaced: true,
	state,
	getters,
	actions,
	mutations,
};
