const MUR = END_STONE_BRICKS;
const DACH = DARK_PRISMARINE;
const PODLOGA = COBBLESTONE;
const DREWNO = PLANKS_SPRUCE;
const POWIETRZE = AIR;
const OKNO = GLASS;
const PLOTEK = SPRUCE_FENCE;

function budujFoseIMost(bx: number, by: number, bz: number) {
    blocks.fill(POWIETRZE, world(bx - 4, by - 3, bz - 4), world(bx + 44, by - 1, bz + 44));
    blocks.fill(WATER, world(bx - 10, by - 3, bz - 10), world(bx + 50, by - 2, bz + 50));
    blocks.fill(MUR, world(bx, by - 3, bz), world(bx + 40, by - 1, bz + 40));
    blocks.fill(DREWNO, world(bx + 18, by -1, bz - 7), world(bx + 22, by - 1, bz));
    blocks.fill(PLOTEK, world(bx + 18, by, bz - 7), world(bx + 18, by, bz - 1)); 
    blocks.fill(PLOTEK, world(bx + 22, by, bz - 7), world(bx + 22, by, bz - 1));
}

function budujMury(bx: number, by: number, bz: number) {
    blocks.fill(MUR, world(bx, by, bz), world(bx + 40, by + 12, bz + 40));
    blocks.fill(POWIETRZE, world(bx + 3, by, bz + 3), world(bx + 37, by + 12, bz + 37));
    blocks.fill(PODLOGA, world(bx + 3, by - 1, bz + 3), world(bx + 37, by - 1, bz + 37));

    blocks.fill(MUR, world(bx + 14, by + 12, bz), world(bx + 26, by + 17, bz + 2));
    blocks.fill(DACH, world(bx + 15, by + 17, bz), world(bx + 25, by + 18, bz + 2));
    blocks.fill(DACH, world(bx + 18, by + 19, bz), world(bx + 22, by + 21, bz + 2));

    //Przód
    blocks.fill(OKNO, world(bx + 7, by + 4, bz), world(bx + 11, by + 8, bz + 2));
    blocks.fill(OKNO, world(bx + 29, by + 4, bz), world(bx + 33, by + 8, bz + 2));
    //Tył
    blocks.fill(OKNO, world(bx + 7, by + 4, bz + 38), world(bx + 11, by + 8, bz + 40));
    blocks.fill(OKNO, world(bx + 29, by + 4, bz + 38), world(bx + 33, by + 8, bz + 40));
    //Lewa ściana
    blocks.fill(OKNO, world(bx, by + 4, bz + 10), world(bx + 2, by + 8, bz + 15));
    blocks.fill(OKNO, world(bx, by + 4, bz + 25), world(bx + 2, by + 8, bz + 30));
    //Prawa ściana
    blocks.fill(OKNO, world(bx + 38, by + 4, bz + 10), world(bx + 40, by + 8, bz + 15));
    blocks.fill(OKNO, world(bx + 38, by + 4, bz + 25), world(bx + 40, by + 8, bz + 30));

    blocks.fill(DACH, world(bx, by + 12, bz), world(bx + 40, by + 13, bz + 40));
    blocks.fill(POWIETRZE, world(bx + 4, by + 12, bz + 4), world(bx + 36, by + 13, bz + 36));
}

function budujDonzon(cx: number, cy: number, cz: number) {
    let wysPietra = 10;
    blocks.fill(MUR, world(cx - 8, cy, cz - 8), world(cx + 8, cy + 26, cz + 8));
    blocks.fill(POWIETRZE, world(cx - 7, cy, cz - 7), world(cx + 7, cy + 25, cz + 7));
    blocks.fill(POWIETRZE, world(cx - 2, cy + 1, cz - 8), world(cx + 2, cy + 4, cz + 7));

    blocks.fill(DREWNO, world(cx - 7, cy + wysPietra, cz - 7), world(cx + 7, cy + wysPietra, cz + 7));

    blocks.fill(DACH, world(cx - 9, cy + 24, cz - 9), world(cx + 9, cy + 25, cz + 9));
    blocks.fill(DACH, world(cx - 7, cy + 26, cz - 7), world(cx + 7, cy + 27, cz + 7));
    blocks.fill(DACH, world(cx - 5, cy + 28, cz - 5), world(cx + 5, cy + 30, cz + 5));
    blocks.fill(DACH, world(cx - 3, cy + 31, cz - 3), world(cx + 3, cy + 33, cz + 3));
    blocks.place(GOLD_BLOCK, world(cx, cy + 34, cz));
}

player.onChat("zamek", function () {
    player.say("Nie ruszaj sie!");

    let bx = Math.round(player.position().getValue(Axis.X));
    let by = Math.round(player.position().getValue(Axis.Y));
    let bz = Math.round(player.position().getValue(Axis.Z)) + 15;

    budujFoseIMost(bx, by, bz);
    budujMury(bx, by, bz);
    budujDonzon(bx + 20, by, bz + 20);

    player.say("Gotowe!");
});