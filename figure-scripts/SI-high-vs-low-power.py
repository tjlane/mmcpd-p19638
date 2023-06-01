from pymol import cmd

maps = [
    "10ns_HP_light-dark_mkFoFo.map",
    "10ns_LP_light-dark_mkFoFo.map",
    "10ns_LP-trunc_light-dark_mkFoFo.map",
    "10ns_HP-LP_truncated_light-light_mkFoFo.map",
]
map_names = ["hp-dark", "lp-dark", "lp_trunc-dark", "hp-lp_trunc"]
sigmas = [3.5, 3.5, 3.5, 2.5]
figsize = (1024, 1024)

for i, map_file in enumerate(maps):

    cmd.load(map_file, "FoFomap")
    cmd.map_double("FoFomap")
    cmd.map_double("FoFomap")

    sigma = sigmas[i]

    cmd.isomesh("FoFomap_pos", "FoFomap", level=sigma)
    cmd.isomesh("FoFomap_neg", "FoFomap", level=-sigma)
    cmd.color("teal", "FoFomap_pos")
    cmd.color("orange", "FoFomap_neg")

    cmd.set_view([\
        -0.147726595,    0.706028700,   -0.692566812,\
        0.849637151,   -0.267813772,   -0.454238236,\
        -0.506187141,   -0.655552089,   -0.560312212,\
        -0.000755738,   -0.000517276,  -51.140655518,\
        16.833612442,   14.409214020,   -2.746963501,\
        45.223979950,   57.661785126,  -20.000000000])

    cmd.ray(*figsize)
    cmd.save(f"./pngs/fad/fad_{map_names[i]}_sigma{sigma}.png")


    cmd.set_view([\
            0.823080957,   -0.523740172,   -0.219496548,\
            0.479296654,    0.433438808,    0.763114929,\
        -0.304546565,   -0.733313620,    0.607798934,\
        -0.001531212,    0.000697166,  -32.788993835,\
        24.531145096,   10.582251549,    2.564769745,\
        26.537899017,   38.975711823,  -20.000000000])

    cmd.ray(*figsize)
    cmd.save(f"./pngs/ttd/ttd_{map_names[i]}_sigma{sigma}.png")


    cmd.set_view([\
        -0.514932692,   -0.260631859,    0.816615045,\
            0.050195895,    0.941828191,    0.332233459,\
        -0.855710208,    0.212080300,   -0.471908659,\
            0.001370723,   -0.000914710,  -30.631669998,\
        20.368503571,   16.328887939,    8.819749832,\
        24.135972977,   36.573795319,  -20.000000000])

    cmd.ray(*figsize)
    cmd.save(f"./pngs/arg/arg_{map_names[i]}_sigma{sigma}.png")

    cmd.delete("FoFomap_pos")
    cmd.delete("FoFomap_neg")
    cmd.delete("FoFomap")
