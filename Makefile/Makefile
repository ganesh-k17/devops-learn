say_hello:
	echo "Hello World"

generate:
	@echo "Creating empty text files..."
	touch file-1.txt

clean:
	@echo "Cleaning up..."
	rm *.txt

.DEFAULT_GOAL := generate

# As the name suggests, the phony target .DEFAULT_GOAL can run only one target at a time. 
# This is why most makefiles include all as a target that can call as many targets as needed.