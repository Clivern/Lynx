let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

var lynx_app = lynx_app || {};

function show_notification(text) {
    $("#toast_notification").removeClass("hide");
    $("#toast_notification").addClass("show");
    $("#toast_notification").find(".toast-body").text(text);
}

// Install Page
lynx_app.install_screen = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#app_install',
        data() {
            return {
                isInProgress: false,
            }
        },
        methods: {
            installAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                axios.post(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(response.data.successMessage);
                            location.reload();
                        }
                    })
                    .catch((error) => {
                        this.isInProgress = false;
                        // Show error
                        show_notification(error.response.data.errorMessage);
                    });
            }
        }
    });

}

// Login Page
lynx_app.login_screen = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#app_login',
        data() {
            return {
                isInProgress: false,
            }
        },
        methods: {
            loginAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                axios.post(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(response.data.successMessage);
                            Cookies.set('_token', response.data.token);
                            Cookies.set('_uid', response.data.user);
                            location.reload();
                        }
                    })
                    .catch((error) => {
                        this.isInProgress = false;
                        // Show error
                        show_notification(error.response.data.errorMessage);
                    });
            }
        }
    });

}

// Settings Page
lynx_app.settings_screen = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#app_settings',
        data() {
            return {
                isInProgress: false,
            }
        },
        methods: {
            settingsAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                axios.put(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(response.data.successMessage);
                        }
                    })
                    .catch((error) => {
                        this.isInProgress = false;
                        // Show error
                        show_notification(error.response.data.errorMessage);
                    });
            }
        }
    });

}

// Profile Page
lynx_app.profile_screen = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#app_profile',
        data() {
            return {
                isInProgress: false,
            }
        },
        methods: {
            profileAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                axios.post(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(response.data.successMessage);
                        }
                    })
                    .catch((error) => {
                        this.isInProgress = false;
                        // Show error
                        show_notification(error.response.data.errorMessage);
                    });
            }
        }
    });

}

// Add User Modal
lynx_app.add_user_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#add_user_modal',
        data() {
            return {
                isInProgress: false,
            }
        },
        methods: {
            addUserAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                axios.post(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(i18n_globals.new_user);
                            setTimeout(() => { location.reload(); }, 2000);
                        }
                    })
                    .catch((error) => {
                        this.isInProgress = false;
                        // Show error
                        show_notification(error.response.data.errorMessage);
                    });
            }
        }
    });

}

// Add Team Modal
lynx_app.add_team_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#add_team_modal',
        data() {
            return {
                isInProgress: false,
            }
        },
        methods: {
            addTeamAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                inputs["members"] = $("[name='members']").val();

                axios.post(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(i18n_globals.new_team);
                            setTimeout(() => { location.reload(); }, 2000);
                        }
                    })
                    .catch((error) => {
                        this.isInProgress = false;
                        // Show error
                        show_notification(error.response.data.errorMessage);
                    });
            }
        }
    });

}

// Add Group Modal
lynx_app.add_group_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#add_group_modal',
        data() {
            return {
                isInProgress: false,
            }
        },
        methods: {
            addGroupAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                axios.post(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(i18n_globals.new_group);
                            setTimeout(() => { location.reload(); }, 2000);
                        }
                    })
                    .catch((error) => {
                        this.isInProgress = false;
                        // Show error
                        show_notification(error.response.data.errorMessage);
                    });
            }
        }
    });

}

// Add Host Modal
lynx_app.add_host_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#add_host_modal',
        data() {
            return {
                isInProgress: false,
            }
        },
        methods: {
            addGroupAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                axios.post(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(i18n_globals.new_host);
                            location.reload();
                        }
                    })
                    .catch((error) => {
                        this.isInProgress = false;
                        // Show error
                        show_notification(error.response.data.errorMessage);
                    });
            }
        }
    });

}

$(document).ready(() => {
    axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': csrfToken,
        'X-User-Token': Cookies.get('_token') || '',
        'X-User-Id': Cookies.get('_uid') || ''
    };

    if (document.getElementById("app_install")) {
        lynx_app.install_screen(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("app_login")) {
        lynx_app.login_screen(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("app_settings")) {
        lynx_app.settings_screen(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("app_profile")) {
        lynx_app.profile_screen(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("add_user_modal")) {
        lynx_app.add_user_modal(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("add_team_modal")) {
        lynx_app.add_team_modal(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("add_group_modal")) {
        lynx_app.add_group_modal(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("add_host_modal")) {
        lynx_app.add_host_modal(
            Vue,
            axios,
            $
        );
    }

    if (document.querySelector("#hosts_chart")) {
        let chart = new ApexCharts(document.querySelector("#hosts_chart"), hostsChart);
        chart.render();
    }
});
