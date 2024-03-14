function love.draw()
	love.graphics.clear(0, 0.15, 0.5);
	love.graphics.print("Hello World", 400, 300);
	height = 100;
	width = 100;
	love.graphics.polygon("fill", 0, 0, width, 0, width, height * 0.5, 0, height * 0.25);
end;
