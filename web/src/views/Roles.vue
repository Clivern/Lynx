<!-- @format -->

<template>
	<section>
		<div class="columns is-desktop is-centered">
			<div class="column"></div>
			<div class="column is-three-quarters">
				<b-table
					:data="data"
					ref="table"
					paginated
					per-page="20"
					:opened-detailed="defaultOpenedDetails"
					detailed
					detail-key="id"
					:detail-transition="transitionName"
					:show-detail-icon="showDetailIcon"
					aria-next-label="Next page"
					aria-previous-label="Previous page"
					aria-page-label="Page"
					aria-current-label="Current page"
				>
					<b-table-column field="id" label="ID" centered v-slot="props">
						<span class="tag is-warning is-light">{{ props.row.id }}</span>
					</b-table-column>

					<b-table-column field="name" label="Name" centered v-slot="props">
						<span class="tag is-success is-light">
							{{ props.row.name }}
						</span>
					</b-table-column>

					<b-table-column
						field="startAt"
						label="Start at"
						centered
						v-slot="props"
					>
						<span class="tag is-danger is-light">
							{{ new Date(props.row.startAt).toLocaleString() }}
							{{ Intl.DateTimeFormat().resolvedOptions().timeZone }}
						</span>
					</b-table-column>

					<b-table-column field="endAt" label="End at" centered v-slot="props">
						<span class="tag is-danger is-light">
							{{ new Date(props.row.endAt).toLocaleString() }}
							{{ Intl.DateTimeFormat().resolvedOptions().timeZone }}
						</span>
					</b-table-column>

					<b-table-column label="Actions" centered v-slot="props">
						<b-button
							size="is-small"
							type="is-link is-danger is-light"
							@click="deleteRole(props.row.id)"
							>Delete</b-button
						>
					</b-table-column>

					<template #detail="props">
						<code>{{ props.row.value }}</code>
					</template>

					<td slot="empty" colspan="5">No records found.</td>
				</b-table>
			</div>
			<div class="column"></div>
		</div>
	</section>
</template>

<script>
export default {
	name: "RolesPage",

	data() {
		return {
			data: [],
			defaultOpenedDetails: [1],
			showDetailIcon: true,
			useTransition: false,

			// Loader
			loader: {
				isFullPage: true,
				ref: null,
			},
		};
	},
	computed: {
		transitionName() {
			if (this.useTransition) {
				return "fade";
			}
			return "";
		},
	},
	methods: {
		loading() {
			this.loader.ref = this.$buefy.loading.open({
				container: this.loader.isFullPage ? null : this.$refs.element.$el,
			});
		},
		loadInitialState() {
			this.loading();
			this.$store.dispatch("role/getRolesAction", {}).then(
				() => {
					let data = this.$store.getters["role/getRoles"];

					if (data) {
						this.data = data;
					} else {
						this.data = [];
					}

					this.loader.ref.close();
				},
				(err) => {
					this.$buefy.toast.open({
						message: err.response.data.errorMessage,
						type: "is-danger is-light",
					});
					this.loader.ref.close();
				}
			);
		},
		deleteRole(roleId) {
			this.$buefy.dialog.confirm({
				message: "Are you sure?",
				onConfirm: () => {
					this.$store
						.dispatch("role/deleteRoleAction", {
							id: roleId,
						})
						.then(
							() => {
								this.$buefy.toast.open({
									message: "Role delete successfully!",
									type: "is-success",
								});
								this.loader.ref.close();
								this.loadInitialState();
							},
							(err) => {
								if (err.response.data.errorMessage) {
									this.$buefy.toast.open({
										message: err.response.data.errorMessage,
										type: "is-danger is-light",
									});
								} else {
									this.$buefy.toast.open({
										message: "Error status code: " + err.response.status,
										type: "is-danger is-light",
									});
								}
							}
						);
				},
			});
		},
	},
	mounted() {
		this.loadInitialState();
	},
};
</script>
