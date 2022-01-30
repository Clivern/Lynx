/** @format */

import {
	createRole,
	getRoles,
	deleteRole,
	getInterfaces,
} from "@/common/role.api";

const state = () => ({
	createRoleResult: {},
	getRolesResult: {},
	deleteRoleResult: {},
	getInterfacesResult: {},
});

const getters = {
	createRole: (state) => {
		return state.createRoleResult;
	},
	getRoles: (state) => {
		return state.getRolesResult;
	},
	getInterfaces: (state) => {
		return state.getInterfacesResult;
	},
	deleteRole: (state) => {
		return state.deleteRoleResult;
	},
};

const actions = {
	async createRoleAction(context, payload) {
		const result = await createRole(payload);
		context.commit("SET_CREATE_ROLE_RESULT", result.data);
		return result;
	},
	async getRolesAction(context) {
		const result = await getRoles();
		context.commit("SET_GET_ROLES_RESULT", result.data);
		return result;
	},
	async getInterfacesAction(context) {
		const result = await getInterfaces();
		context.commit("SET_GET_INTERFACES_RESULT", result.data);
		return result;
	},
	async deleteRoleAction(context, payload) {
		const result = await deleteRole(payload);
		context.commit("SET_DELETE_ROLE_RESULT", result.data);
		return result;
	},
};

const mutations = {
	SET_CREATE_ROLE_RESULT(state, createRoleResult) {
		state.createRoleResult = createRoleResult;
	},
	SET_GET_ROLES_RESULT(state, getRolesResult) {
		state.getRolesResult = getRolesResult;
	},
	SET_GET_INTERFACES_RESULT(state, getInterfacesResult) {
		state.getInterfacesResult = getInterfacesResult;
	},
	SET_DELETE_ROLE_RESULT(state, deleteRoleResult) {
		state.deleteRoleResult = deleteRoleResult;
	},
};

export default {
	namespaced: true,
	state,
	getters,
	actions,
	mutations,
};
