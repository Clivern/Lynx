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

function snapshot_restore_followup(id) {
    axios.get(_globals.task_status_endpoint.replace("UUID", id))
        .then((response) => {
            if (response.status >= 200) {
                show_notification(response.data.status);

                if (response.data.status == 'success') {
                    show_notification(_globals.restore_snapshot_success_message);
                } else if (response.data.status === 'failure') {
                    show_notification(_globals.restore_snapshot_failed_message);
                } else {
                    show_notification(_globals.restore_snapshot_pending_message);
                    setTimeout(() => { snapshot_restore_followup(id) }, 6000);
                }
            }
        })
        .catch((error) => {
            // Show error
            show_notification(error.response.data.errorMessage);
        });
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

// Profile Page
lynx_app.profile_api_screen = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#app_api_key',
        data() {
            return {
                apiKey: "*********************",
                isInProgress: false,
            }
        },
        methods: {
            showApiKeyAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                axios.get(_globals.fetch_api_key_endpoint)
                    .then((response) => {
                        if (response.status >= 200) {
                            this.apiKey = response.data.apiKey;
                        }
                    })
                    .catch((error) => {
                        this.isInProgress = false;
                        // Show error
                        show_notification(error.response.data.errorMessage);
                    });
            },

            rotateApiKeyAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                axios.post(_globals.rotate_api_key_endpoint, {})
                    .then((response) => {
                        if (response.status >= 200) {
                            this.apiKey = response.data.apiKey;
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
                            show_notification(_globals.new_user);
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

                inputs["members"] = $("form#add_team_form select[name='members']").val();

                axios.post(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(_globals.new_team);
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
            showTeamInfoAction(description) {
                $("div#team_info_modal_content").text(description);
            },

            editTeamAction(id) {
                let current = $('form#update_team_form input[name="uuid"]').val()
                if (current != "") {
                    $('form#update_team_form').attr('action', function(i, val) {
                        return val.replace(current, "UUID");
                    });
                }

                $('form#update_team_form input[name="uuid"]').val(id);
                $('form#update_team_form').attr('action', function(i, val) {
                    return val.replace('UUID', id);
                });

                axios.get($("#update_team_form").attr("action"))
                    .then((response) => {
                        if (response.status >= 200) {
                            $('form#update_team_form input[name="name"]').val(response.data.name);
                            $('form#update_team_form input[name="slug"]').val(response.data.slug);
                            $('form#update_team_form textarea[name="description"]').val(response.data.description);
                            $('form#update_team_form select[name="members"]').val(response.data.members);
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            formatDatetime(datatime) {
                return format_datetime(datatime);
            },

            deleteTeamAction(id) {
                if (confirm(_globals.delete_team_alert) != true) {
                    return;
                }

                axios.delete(_globals.delete_team_endpoint.replace("UUID", id), {})
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(_globals.delete_team_message);
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

lynx_app.edit_team_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#edit_team_modal',
        data() {
            return {
                isInProgress: false,
                users: []
            }
        },
        mounted() {
            this.loadData();
        },
        methods: {
            loadData() {
                axios.get($("#edit_team_modal").attr("data-action"), {
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
            updateTeamAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                inputs["members"] = $("form#update_team_form select[name='members']").val();

                axios.put(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(_globals.update_team_message);

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
                let current = $('form#update_user_form input[name="uuid"]').val()
                if (current != "") {
                    $('form#update_user_form').attr('action', function(i, val) {
                        return val.replace(current, "UUID");
                    });
                }

                $('form#update_user_form input[name="uuid"]').val(id);
                $('form#update_user_form').attr('action', function(i, val) {
                    return val.replace('UUID', id);
                });

                axios.get($("#update_user_form").attr("action"))
                    .then((response) => {
                        if (response.status >= 200) {
                            $('form#update_user_form input[name="name"]').val(response.data.name);
                            $('form#update_user_form select[name="role"]').val(response.data.role);
                            $('form#update_user_form input[name="email"]').val(response.data.email);
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            formatDatetime(datatime) {
                return format_datetime(datatime);
            },

            deleteUserAction(id) {
                if (confirm(_globals.delete_user_alert) != true) {
                    return;
                }

                axios.delete(_globals.delete_user_endpoint.replace("UUID", id), {})
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(_globals.delete_user_message);
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


lynx_app.edit_user_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#edit_user_modal',
        data() {
            return {
                isInProgress: false
            }
        },
        methods: {
            updateUserAction(event) {
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
                            show_notification(_globals.update_user_message);

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
            showProjectInfoAction(description) {
                $("div#project_info_modal_content").text(description);
            },

            editProjectAction(id) {
                let current = $('form#update_project_form input[name="uuid"]').val()
                if (current != "") {
                    $('form#update_project_form').attr('action', function(i, val) {
                        return val.replace(current, "UUID");
                    });
                }

                $('form#update_project_form input[name="uuid"]').val(id);
                $('form#update_project_form').attr('action', function(i, val) {
                    return val.replace('UUID', id);
                });

                axios.get($("#update_project_form").attr("action"))
                    .then((response) => {
                        if (response.status >= 200) {
                            $('form#update_project_form input[name="name"]').val(response.data.name);
                            $('form#update_project_form input[name="slug"]').val(response.data.slug);
                            $('form#update_project_form textarea[name="description"]').val(response.data.description);
                            $('form#update_project_form select[name="team_id"]').val(response.data.team.id);
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            formatDatetime(datatime) {
                return format_datetime(datatime);
            },

            viewProjectAction(id) {
                window.location.href = _globals.project_view_page.replace("UUID", id);
            },

            deleteProjectAction(id) {
                if (confirm(_globals.delete_project_alert) != true) {
                    return;
                }

                axios.delete(_globals.delete_project_endpoint.replace("UUID", id), {})
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(_globals.delete_project_message);
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


lynx_app.edit_project_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#edit_project_modal',
        data() {
            return {
                isInProgress: false,
                teams: []
            }
        },
        mounted() {
            this.loadDataAction();
        },
        methods: {
            loadDataAction() {
                axios.get($("#edit_project_modal").attr("data-action"), {
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
            updateProjectAction(event) {
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
                            show_notification(_globals.update_project_message);

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
                            show_notification(_globals.new_project);
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
                            show_notification(_globals.new_environment);
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
                let current = $('form#update_environment_form input[name="uuid"]').val()
                if (current != "") {
                    $('form#update_environment_form').attr('action', function(i, val) {
                        return val.replace(current, "UUID");
                    });
                }

                $('form#update_environment_form input[name="uuid"]').val(id);
                $('form#update_environment_form').attr('action', function(i, val) {
                    return val.replace('UUID', id);
                });

                axios.get($("#update_environment_form").attr("action"))
                    .then((response) => {
                        if (response.status >= 200) {
                            $('form#update_environment_form input[name="name"]').val(response.data.name);
                            $('form#update_environment_form input[name="slug"]').val(response.data.slug);
                            $('form#update_environment_form input[name="username"]').val(response.data.username);
                            $('form#update_environment_form input[name="secret"]').val(response.data.secret);
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            formatDatetime(datatime) {
                return format_datetime(datatime);
            },

            downloadEnvironmentStateAction(id) {
                window.location.href = _globals.download_environment_state_endpoint.replace("UUID", id);
            },

            viewEnvironmentAction(id) {
                let data = $("#proto_env_data").text();
                let env_endpoint = _globals.get_environment_endpoint.replaceAll("UUID", id);
                let project_endpoint = _globals.get_project_endpoint.replaceAll("UUID", _globals.project_uuid);

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
                if (confirm(_globals.delete_environment_alert) != true) {
                    return;
                }

                axios.delete(_globals.delete_environment_endpoint.replace("UUID", id), {})
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(_globals.delete_environment_message);
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

lynx_app.edit_environment_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#edit_environment_modal',
        data() {
            return {
                isInProgress: false
            }
        },
        methods: {
            updateEnvironmentAction(event) {
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
                            show_notification(_globals.update_environment_message);

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

// Snapshots list
lynx_app.snapshots_list = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#snapshots_list',
        data() {
            return {
                currentPage: 1,
                limit: 10,
                totalCount: 5,
                snapshots: []
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
            showSnapshotInfoAction(description) {
                $("div#snapshot_info_modal_content").text(description);
            },

            formatDatetime(datatime) {
                return format_datetime(datatime);
            },

            deleteSnapshotAction(id) {
                if (confirm(_globals.delete_snapshot_alert) != true) {
                    return;
                }

                axios.delete(_globals.delete_snapshot_endpoint.replace("UUID", id), {})
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(_globals.delete_snapshot_message);
                            setTimeout(() => { location.reload(); }, 2000);
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            restoreSnapshotAction(id) {
                if (confirm(_globals.restore_snapshot_alert) != true) {
                    return;
                }

                axios.post(_globals.restore_snapshot_endpoint.replace("UUID", id), {})
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(response.data.successMessage);
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            loadDataAction() {
                var offset = (this.currentPage - 1) * this.limit;

                axios.get($("#snapshots_list").attr("data-action"), {
                        params: {
                            offset: offset,
                            limit: this.limit
                        }
                    })
                    .then((response) => {
                        if (response.status >= 200) {
                            this.snapshots = response.data.snapshots;
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

// Add Snapshot Modal
lynx_app.add_snapshot_modal = (Vue, axios, $) => {

    return new Vue({
        delimiters: ['${', '}'],
        el: '#add_snapshot_modal',
        data() {
            return {
                isInProgress: false,
                teams: [],
                projects: [],
                environments: [],
                projectID: "",
                environmentID: "all"
            }
        },
        mounted() {
            this.loadData();
        },
        methods: {
            loadData() {
                axios.get($("#add_snapshot_modal").attr("data-team"), {
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

                axios.get($("#add_snapshot_modal").attr("data-project"), {
                        params: {
                            offset: 0,
                            limit: 10000
                        }
                    })
                    .then((response) => {
                        if (response.status >= 200) {
                            this.projects = response.data.projects;
                        }
                    })
                    .catch((error) => {
                        show_notification(error.response.data.errorMessage);
                    });
            },

            changeProjectAction(event) {
                axios.get($("#add_snapshot_modal").attr("data-environment").replace("UUID", this.projectID), {
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
            },

            addSnapshotAction(event) {
                event.preventDefault();
                this.isInProgress = true;

                let inputs = {};
                let _self = $(event.target);
                let _form = _self.closest("form");

                _form.serializeArray().map((item, index) => {
                    inputs[item.name] = item.value;
                });

                if (this.environmentID == "all") {
                    inputs["record_type"] = "project";
                    inputs["record_uuid"] = this.projectID;
                } else{
                    inputs["record_type"] = "environment";
                    inputs["record_uuid"] = this.environmentID;
                }

                axios.post(_form.attr('action'), inputs)
                    .then((response) => {
                        if (response.status >= 200) {
                            show_notification(_globals.new_snapshot);
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

$(document).ready(() => {
    axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': csrfToken
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

    if (document.getElementById("snapshots_list")) {
        lynx_app.snapshots_list(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("add_snapshot_modal")) {
        lynx_app.add_snapshot_modal(
            Vue,
            axios,
            $
        );
    }


    if (document.getElementById("app_api_key")) {
        lynx_app.profile_api_screen(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("edit_user_modal")) {
        lynx_app.edit_user_modal(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("edit_team_modal")) {
        lynx_app.edit_team_modal(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("edit_project_modal")) {
        lynx_app.edit_project_modal(
            Vue,
            axios,
            $
        );
    }

    if (document.getElementById("edit_environment_modal")) {
        lynx_app.edit_environment_modal(
            Vue,
            axios,
            $
        );
    }
});
