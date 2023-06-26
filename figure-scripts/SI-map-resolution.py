from pymol import cmd

SIGMA = 1.5

maps = [
    '3ns-paired-ref-res2.2/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res2.3/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res2.4/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res2.5/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res2.6/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res2.7/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res2.8/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res2.9/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res3.0/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res3.1/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res3.2/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res3.3/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res3.4/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res3.5/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res3.6/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res3.7/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res3.8/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res3.9/3ns_deposit_refine_001_filled.map',
    '3ns-paired-ref-res4.0/3ns_deposit_refine_001_filled.map',
]
figsize = (1024, 1024)

for i, map_file in enumerate(maps):

    cmd.load(map_file, "2FoFomap")

    cmd.isomesh("2FoFomap_pos", "2FoFomap", level=SIGMA)
    cmd.color("blue", "2FoFomap_pos")

    cmd.set_view([\
        0.123201139,    0.933493197,   -0.336691886,\
        0.689663291,   -0.324499726,   -0.647302687,\
        -0.713519812,   -0.152468815,   -0.683788061,\
        -0.001419090,   -0.000370961,  -55.086540222,\
        13.213901520,   18.439935684,   -7.525491238,\
        51.427639008,   59.495639801,  -20.000000000 ])

    # cmd.ray(*figsize)

    name = map_file.split("/")[0]
    cmd.save(f"./png/{name}_sigma{SIGMA}.png")
    cmd.delete("2FoFomap_pos")
    cmd.delete("2FoFomap")
