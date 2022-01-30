<!-- @format -->

<template>
	<div class="home">
		<br /><br /><br />
		<img alt="logo" src="../assets/logo.png" width="200" />
		<div class="hello">
			<br /><br />
			<strong>Welcome to Pard</strong>
			<p>
				If you have any suggestions, bug reports, or annoyances
				<br />please report them to our
				<a
					href="https://github.com/Clivern/Pard/issues"
					target="_blank"
					rel="noopener"
					>issue tracker</a
				>.
			</p>
			<br />
			<small>
				Made with
				<span class="icon has-text-danger"><i class="fas fa-heart"></i></span>
				by
				<a href="https://github.com/Clivern" target="_blank" rel="noopener"
					>Clivern</a
				><br />
			</small>
		</div>
	</div>
</template>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
a {
	color: #42b983;
}
</style>

<script>
export default {
	name: "HomePage",

	data() {
		return {
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
	},

	mounted() {
		this.$emit("refresh-state");

		this.loading();

		this.$store.dispatch("health/fetchReadiness").then(
			() => {
				this.backend_status = this.$store.getters["health/getReadiness"].status;

				this.loader.ref.close();
			},
			(err) => {
				this.$buefy.toast.open({
					message: err,
					type: "is-danger is-light",
				});

				this.loader.ref.close();
			}
		);
	},
};
</script>
