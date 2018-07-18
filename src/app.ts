import { StartingCells } from './startingCells';
import { GameOfLife } from './gameOfLife';
import { Grid } from './grid';

export class App {

	public readonly Grid: Grid;

	constructor(window: Window) {

		const windowHeight = Math.max(window.document.documentElement.clientHeight, window.innerHeight);
		const windowWidth = Math.max(window.document.documentElement.clientWidth, window.innerWidth);
		this.Grid = new Grid(new StartingCells(windowHeight, windowWidth), new GameOfLife(), window.document);
	}
}