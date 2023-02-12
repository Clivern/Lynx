let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

var lynx_app = lynx_app || {};

function show_notification(text) {
    $("#toast_notification").removeClass("hide");
    $("#toast_notification").addClass("show");
    $("#toast_notification").find(".toast-body").text(text);
}

function generateRandomCredentials() {
  const usernameChars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  const passwordChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#^&*()';

  let username = '';
  for (let i = 0; i < 8; i++) {
    username += usernameChars.charAt(Math.floor(Math.random() * usernameChars.length));
  }

  let password = '';
  for (let i = 0; i < 12; i++) {
    password += passwordChars.charAt(Math.floor(Math.random() * passwordChars.length));
  }

  return { username, password };
}

function format_datetime(datetime) {
    const originalDate = new Date(datetime);

    const formattedDate = originalDate.toLocaleString(
        'en-US',
        {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: true
        }
    );

    return formattedDate;
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
                            setTimeout(() => {
                                location.reload();
                            }, 2000);
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
                users: [],
                teamName: '',
                teamSlug: ''
            }
        },
        mounted() {
            this.loadData();
        },
        methods: {
            slugifyTeamName() {
                this.teamSlug = this.teamName.toLowerCase().replace(/\s+/g, '-');
            },
            loadData() {
                axios.get($("#add_team_modal").attr("data-action"), {
                        params: {
                            offset: 0,
                            limit: 10000
                        }
                    })
                    .then((response) => {
                        if (response.status >= 200) {
                            this.users = response.data.users;
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },
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
                            setTimeout(() => {
                                location.reload();
                            }, 2000);
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

// Teams list
lynx_app.teams_list = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#teams_list',
        data() {
            return {
                currentPage: 1,
                limit: 10,
                totalCount: 5,
                teams: []
            }
        },
        mounted() {
            this.loadDataAction();
        },
        computed: {
            totalPages() {
                return Math.ceil(this.totalCount / this.limit);
            }
        },
        methods: {
            editTeamAction(id) {
                console.log("Edit team with ID:", id);
            },

            formatDatetime(datatime) {
                return format_datetime(datatime);
            },

            deleteTeamAction(id) {
                if (confirm(i18n_globals.delete_team_alert) != true) {
                    return;
                }

                axios.delete(i18n_globals.delete_team_endpoint.replace("UUID", id), {})
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(i18n_globals.delete_team_message);
                            setTimeout(() => { location.reload(); }, 2000);
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },
            loadDataAction() {
                var offset = (this.currentPage - 1) * this.limit;

                axios.get($("#teams_list").attr("data-action"), {
                        params: {
                            offset: offset,
                            limit: this.limit
                        }
                    })
                    .then((response) => {
                        if (response.status >= 200) {
                            this.teams = response.data.teams;
                            this.limit = response.data._metadata.limit;
                            this.offset = response.data._metadata.offset;
                            this.totalCount = response.data._metadata.totalCount;
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },
            loadPreviousPageAction(event) {
                event.preventDefault();

                if (this.currentPage > 1) {
                    this.currentPage--;
                    this.loadDataAction();
                }
            },
            loadNextPageAction(event) {
                event.preventDefault();

                if (this.currentPage < this.totalPages) {
                    this.currentPage++;
                    this.loadDataAction();
                }
            }
        }
    });
}

// Users list
lynx_app.users_list = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#users_list',
        data() {
            return {
                currentPage: 1,
                limit: 10,
                totalCount: 5,
                users: []
            }
        },
        mounted() {
            this.loadDataAction();
        },
        computed: {
            totalPages() {
                return Math.ceil(this.totalCount / this.limit);
            }
        },
        methods: {
            editUserAction(id) {
                console.log("Edit user with ID:", id);
            },

            formatDatetime(datatime) {
                return format_datetime(datatime);
            },

            deleteUserAction(id) {
                if (confirm(i18n_globals.delete_user_alert) != true) {
                    return;
                }

                axios.delete(i18n_globals.delete_user_endpoint.replace("UUID", id), {})
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(i18n_globals.delete_user_message);
                            setTimeout(() => { location.reload(); }, 2000);
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            loadDataAction() {
                var offset = (this.currentPage - 1) * this.limit;

                axios.get($("#users_list").attr("data-action"), {
                        params: {
                            offset: offset,
                            limit: this.limit
                        }
                    })
                    .then((response) => {
                        if (response.status >= 200) {
                            this.users = response.data.users;
                            this.limit = response.data._metadata.limit;
                            this.offset = response.data._metadata.offset;
                            this.totalCount = response.data._metadata.totalCount;
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },
            loadPreviousPageAction(event) {
                event.preventDefault();

                if (this.currentPage > 1) {
                    this.currentPage--;
                    this.loadDataAction();
                }
            },
            loadNextPageAction(event) {
                event.preventDefault();

                if (this.currentPage < this.totalPages) {
                    this.currentPage++;
                    this.loadDataAction();
                }
            }
        }
    });
}

// Projects list
lynx_app.projects_list = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#projects_list',
        data() {
            return {
                currentPage: 1,
                limit: 10,
                totalCount: 5,
                projects: []
            }
        },
        mounted() {
            this.loadDataAction();
        },
        computed: {
            totalPages() {
                return Math.ceil(this.totalCount / this.limit);
            }
        },
        methods: {
            editProjectAction(id) {
                console.log("Edit project with ID:", id);
            },

            formatDatetime(datatime) {
                return format_datetime(datatime);
            },

            viewProjectAction(id) {
                window.location.href = i18n_globals.project_view_page.replace("UUID", id);
            },

            deleteProjectAction(id) {
                if (confirm(i18n_globals.delete_project_alert) != true) {
                    return;
                }

                axios.delete(i18n_globals.delete_project_endpoint.replace("UUID", id), {})
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(i18n_globals.delete_project_message);
                            setTimeout(() => { location.reload(); }, 2000);
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            loadDataAction() {
                var offset = (this.currentPage - 1) * this.limit;

                axios.get($("#projects_list").attr("data-action"), {
                        params: {
                            offset: offset,
                            limit: this.limit
                        }
                    })
                    .then((response) => {
                        if (response.status >= 200) {
                            this.projects = response.data.projects;
                            this.limit = response.data._metadata.limit;
                            this.offset = response.data._metadata.offset;
                            this.totalCount = response.data._metadata.totalCount;
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },
            loadPreviousPageAction(event) {
                event.preventDefault();

                if (this.currentPage > 1) {
                    this.currentPage--;
                    this.loadDataAction();
                }
            },
            loadNextPageAction(event) {
                event.preventDefault();

                if (this.currentPage < this.totalPages) {
                    this.currentPage++;
                    this.loadDataAction();
                }
            }
        }
    });
}

// Add Project Modal
lynx_app.add_project_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#add_project_modal',
        data() {
            return {
                isInProgress: false,
                teams: [],
                projectName: '',
                projectSlug: ''
            }
        },
        mounted() {
            this.loadData();
        },
        methods: {
            slugifyProjectName() {
                this.projectSlug = this.projectName.toLowerCase().replace(/\s+/g, '-');
            },
            loadData() {
                axios.get($("#add_project_modal").attr("data-action"), {
                        params: {
                            offset: 0,
                            limit: 10000
                        }
                    })
                    .then((response) => {
                        if (response.status >= 200) {
                            this.teams = response.data.teams;
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },
            addProjectAction(event) {
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
                            show_notification(i18n_globals.new_project);
                            setTimeout(() => {
                                location.reload();
                            }, 2000);
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

// Add Project Modal
lynx_app.add_environment_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#add_environment_modal',
        data() {
            return {
                isInProgress: false,
                environmentName: '',
                environmentSlug: '',
                environmentUsername: '',
                environmentSecret: ''
            }
        },
        mounted() {
            this.loadData();
        },
        methods: {
            slugifyEnvironmentName() {
                this.environmentSlug = this.environmentName.toLowerCase().replace(/\s+/g, '-');
            },
            loadData() {
                let credentials = generateRandomCredentials();

                this.environmentUsername = credentials.username;
                this.environmentSecret = credentials.password;

            },
            addEnvironmentAction(event) {
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
                            show_notification(i18n_globals.new_environment);
                            setTimeout(() => {
                                location.reload();
                            }, 2000);
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

// Environments list
lynx_app.environments_list = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#environments_list',
        data() {
            return {
                environments: []
            }
        },
        mounted() {
            this.loadDataAction();
        },
        methods: {
            editEnvironmentAction(id) {
                console.log("Edit environment with ID:", id);
            },

            formatDatetime(datatime) {
                return format_datetime(datatime);
            },

            viewEnvironmentAction(id) {
                let data = $("#proto_env_data").text();
                let env_endpoint = i18n_globals.get_environment_endpoint.replaceAll("UUID", id);
                let project_endpoint = i18n_globals.get_project_endpoint.replaceAll("UUID", i18n_globals.project_uuid);

                axios.get(env_endpoint, {})
                    .then((response) => {
                        if (response.status >= 200) {

                            let env_slug = response.data.slug;
                            let env_username = response.data.username;
                            let env_secret = response.data.secret;

                            axios.get(project_endpoint, {})
                                .then((response) => {
                                    if (response.status >= 200) {
                                        let project_slug = response.data.slug;
                                        let team_slug = response.data.team.slug;

                                        data = data.replaceAll("$team", team_slug);
                                        data = data.replaceAll("$project", project_slug);
                                        data = data.replaceAll("$env", env_slug);
                                        data = data.replaceAll("$username", env_username);
                                        data = data.replaceAll("$secret", env_secret);

                                        $("#env_data").text(data);

                                        $("button[data-bs-target='#show_environment_modal']").click();
                                    }
                                })
                                .catch((error) => {
                                    show_notification(error.response.data.errorMessage);
                                });

                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            deleteEnvironmentAction(id) {
                if (confirm(i18n_globals.delete_environment_alert) != true) {
                    return;
                }

                axios.delete(i18n_globals.delete_environment_endpoint.replace("UUID", id), {})
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(i18n_globals.delete_environment_message);
                            setTimeout(() => { location.reload(); }, 2000);
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            loadDataAction() {
                axios.get($("#environments_list").attr("data-action"), {
                        params: {
                            offset: 0,
                            limit: 10000
                        }
                    })
                    .then((response) => {
                        if (response.status >= 200) {
                            this.environments = response.data.environments;
                        }
                    })
                    .catch((error) => {
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

    if (document.getElementById("teams_list")) {
        lynx_app.teams_list(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("users_list")) {
        lynx_app.users_list(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("projects_list")) {
        lynx_app.projects_list(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("add_project_modal")) {
        lynx_app.add_project_modal(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("add_environment_modal")) {
        lynx_app.add_environment_modal(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("environments_list")) {
        lynx_app.environments_list(
            Vue,
            axios,
            $
        );
    }
    /*
    if (document.querySelector("#hosts_chart")) {
        let chart = new ApexCharts(document.querySelector("#hosts_chart"), hostsChart);
        chart.render();
    }*/
});
