/** @format */

import ApiService from "./api.service.js";

const getReadiness = () => {
	return ApiService.get("/_ready");
};

const getHealth = () => {
	return ApiService.get("/_health");
};

const auth = (apiKey) => {
	return ApiService.auth("/api/v1/role", apiKey);
};

export { getReadiness, getHealth, auth };
