module.exports = {
	globDirectory: './',
	globPatterns: [
		'**/*.{wasm,html,png,svg,ico,json,js}'
	],
	swDest: 'sw.js',
	ignoreURLParametersMatching: [
		/^utm_/,
		/^fbclid$/
	],
	navigateFallback: '/ucblogo-code/ucblogo.html'
};