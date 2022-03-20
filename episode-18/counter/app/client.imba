global css body
	min-height: 100vh
	d: flex
	justify-content: center
	align-items: center
	text-align: center

tag app
	prop count = 0

	<self>
		<header>
			<button @click=count++> "Click me"
			<p> "Clicked {count} times"

imba.mount <app>
