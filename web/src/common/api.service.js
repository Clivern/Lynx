/** @format */

import axios from "axios";

const ApiService = {
	getURL(endpoint) {
		let apiURL = "";

		if (process.env.CHAOS_DASHBOARD_URL) {
			apiURL = process.env.CHAOS_DASHBOARD_URL.replace(/\/$/, "");
		}

		return apiURL + endpoint;
	},

	getHeaders(apiKey = null) {
		if (localStorage.getItem("x_api_key") != null && apiKey == null) {
			apiKey = localStorage.getItem("x_api_key");
		}

		return {
			crossdomain: true,

			headers: {
				"X-API-Key": apiKey,
				"X-Client-ID": "dashboard",
				"X-Requested-With": "XMLHttpRequest",
				"Content-Type": "application/json",
			},
		};
	},

	get(endpoint) {
		return axios.get(this.getURL(endpoint), this.getHeaders());
	},

	delete(endpoint) {
		return axios.delete(this.getURL(endpoint), this.getHeaders());
	},

	post(endpoint, data = {}) {
		return axios.post(this.getURL(endpoint), data, this.getHeaders());
	},

	put(endpoint, data = {}) {
		return axios.put(this.getURL(endpoint), data, this.getHeaders());
	},

	auth(endpoint, apiKey) {
		return axios.get(this.getURL(endpoint), this.getHeaders(apiKey));
	},
};

export default ApiService;
