<!-- @format -->

<template>
	<div class="columns is-desktop is-centered">
		<div class="column is-4">
			<br /><br />
			<section>
				<b-field label="Name">
					<b-input
						v-model="form.name"
						placeholder="Packets Drop By 10%"
					></b-input>
				</b-field>
				<b-field label="Mode Type">
					<b-select
						placeholder="Select a mode type"
						expanded
						v-model="form.mode"
						@input="onModeChange()"
					>
						<option value="sys_load">System Load Increase</option>
						<option value="network_delay">Network Delay</option>
						<option value="packet_loss">Packet Loss</option>
						<option value="packet_corruption">Packet Corruption</option>
						<option value="packet_duplication">Packet Duplication</option>
						<option value="random_reboots">Random Reboots</option>
					</b-select>
				</b-field>
				<template
					v-if="
						form.mode == 'network_delay' ||
						form.mode == 'packet_loss' ||
						form.mode == 'packet_corruption' ||
						form.mode == 'packet_duplication'
					"
				>
					<b-field label="Network Interface">
						<b-select
							placeholder="Select a network net_interface"
							expanded
							v-model="form.net_interface"
						>
							<option
								v-for="net_interface in form.net_interfaces"
								v-bind:key="net_interface"
							>
								{{ net_interface }}
							</option>
						</b-select>
					</b-field>
				</template>

				<template v-if="form.mode == 'packet_duplication'">
					<b-field label="Packet Duplication in Percent">
						<b-input
							v-model="form.packet_duplication.percent"
							placeholder="2%"
						></b-input>
					</b-field>
				</template>

				<template v-if="form.mode == 'packet_corruption'">
					<b-field label="Packet Corruption in Percent">
						<b-input
							v-model="form.packet_corruption.percent"
							placeholder="5%"
						></b-input>
					</b-field>
				</template>

				<template v-if="form.mode == 'packet_loss'">
					<b-field label="Packet Loss in Percent">
						<b-input
							v-model="form.packet_loss.percent"
							placeholder="10%"
						></b-input>
					</b-field>
				</template>

				<template v-if="form.mode == 'network_delay'">
					<b-field label="Delay in ms">
						<b-input
							v-model="form.network_delay.delay"
							placeholder="100ms"
						></b-input>
					</b-field>
					<b-field label="Random uniform distribution in ms">
						<b-input
							v-model="form.network_delay.distribution"
							placeholder="10ms"
						></b-input>
					</b-field>
				</template>

				<template v-if="form.mode == 'sys_load'">
					<b-field label="Worker threads to stress the CPU">
						<b-input v-model="form.sys_load.cpu" placeholder="8"></b-input>
					</b-field>
					<b-field label="I/O operations to stress the I/O">
						<b-input v-model="form.sys_load.io" placeholder="4"></b-input>
					</b-field>
					<b-field label="Workers to allocate memory">
						<b-input v-model="form.sys_load.vm" placeholder="2"></b-input>
					</b-field>
					<b-field label="Temporary files to created to perform read/write">
						<b-input v-model="form.sys_load.hdd" placeholder="3"></b-input>
					</b-field>
				</template>

				<b-field label="Select local start time">
					<b-datetimepicker
						v-model="form.startAt"
						placeholder="Click to select..."
					>
					</b-datetimepicker>
				</b-field>
				<b-field label="Select local end time">
					<b-datetimepicker
						v-model="form.endAt"
						placeholder="Click to select..."
					>
					</b-datetimepicker>
				</b-field>
				<br />
				<div class="field">
					<p class="control">
						<b-button
							type="is-danger is-light"
							v-bind:disabled="form.button_disabled"
							@click="storeEvent"
							>Submit</b-button
						>
					</p>
				</div>
			</section>
		</div>
	</div>
</template>

<script>
export default {
	name: "NewPage",
	data() {
		return {
			form: {
				button_disabled: false,
				name: "",
				mode: "",
				net_interface: "",
				startAt: "",
				endAt: "",
				net_interfaces: [],

				packet_duplication: { percent: "2%" },
				packet_corruption: { percent: "5%" },
				packet_loss: { percent: "10%" },
				network_delay: { delay: "100ms", distribution: "10ms" },
				sys_load: { cpu: "8", io: "4", vm: "2", hdd: "3" },
			},
			// Loader
			loader: {
				isFullPage: true,
				ref: null,
			},
		};
	},
	methods: {
		loading() {
			this.loader.ref = this.$buefy.loading.open({
				container: this.loader.isFullPage ? null : this.$refs.element.$el,
			});
		},

		onModeChange() {},

		loadInterfaces() {
			this.loading();

			this.$store.dispatch("role/getInterfacesAction", {}).then(
				() => {
					let data = this.$store.getters["role/getInterfaces"];

					if (data) {
						this.form.net_interfaces = data;
					} else {
						this.form.net_interfaces = [];
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

		storeEvent() {
			this.loading();
			this.form.button_disabled = true;

			this.$store
				.dispatch("role/createRoleAction", {
					name: this.form.name,
					startAt: this.form.startAt,
					endAt: this.form.endAt,
					value: {
						mode: this.form.mode,
						net_interface: this.form.net_interface,

						packet_duplication_percent: this.form.packet_duplication.percent,
						packet_corruption_percent: this.form.packet_corruption.percent,
						packet_loss_percent: this.form.packet_loss.percent,

						network_delay_delay: this.form.network_delay.delay,
						network_delay_distribution: this.form.network_delay.distribution,

						sys_load_cpu: this.form.sys_load.cpu,
						sys_load_io: this.form.sys_load.io,
						sys_load_vm: this.form.sys_load.vm,
						sys_load_hdd: this.form.sys_load.hdd,
					},
				})
				.then(
					() => {
						this.$buefy.toast.open({
							message: "Role created successfully!",
							type: "is-success",
						});

						this.form.button_disabled = false;
						this.loader.ref.close();
						this.$router.push("/roles");
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
						this.form.button_disabled = false;
						this.loader.ref.close();
					}
				);
		},
	},
	mounted() {
		this.loadInterfaces();
	},
};
</script>
