from pymol import cmd

SIGMA = 4.5
FIGSIZE = (1024, 1024)
VIEW = "side"  # "top" or "side"

maps = [
    "superdark_deposit_polder.map",
    "3ps_deposit_polder.map",
    "300ps_deposit_polder.map",
    "1ns_deposit_polder.map",
    "3ns_deposit_polder.map",
    "10ns_deposit_polder.map",
    "30ns_deposit_polder.map",
    "1us_deposit_polder.map",
    "10us_deposit_polder.map",
    "30us_deposit_polder.map",
    "100us_deposit_polder.map",
]

models = [
    "../pdb-depositions/1_superdark/superdark_deposit.pdb",
    "../pdb-depositions/2_3ps/3ps_deposit.pdb",
    "../pdb-depositions/3_300ps/300ps_deposit.pdb",
    "../pdb-depositions/4_1ns/1ns_deposit.pdb",
    "../pdb-depositions/5_3ns/3ns_deposit.pdb",
    "../pdb-depositions/6_10ns/10ns_deposit.pdb",
    "../pdb-depositions/7_30ns/30ns_deposit.pdb",
    "../pdb-depositions/8_1us/1us_deposit.pdb",
    "../pdb-depositions/9_10us/10us_deposit.pdb",
    "../pdb-depositions/10_30us/30us_deposit.pdb",
    "../pdb-depositions/11_100us/100us_deposit.pdb",
]


for i, map_file in enumerate(maps):

    if VIEW == "side":
        map_file = "polders/" + map_file
    elif VIEW == "top":
        map_file = "polders_with_asn403/" + map_file

    print(i, map_file)

    cmd.load(models[i], "pl")
    cmd.color("purple", "pl")
    cmd.color("atomic", "(not elem C)")

    cmd.hide("all")
    cmd.show("sticks", "///A/FDA")
    if VIEW == "top":
        cmd.show("sticks", "///A/403")

    cmd.load(map_file, "2FoFcmap")
    cmd.map_double("2FoFcmap")
    cmd.map_double("2FoFcmap")

    cmd.isomesh("2FoFcmap_pos", "2FoFcmap", level=SIGMA, selection="///A/FDA", carve=5.2)

    cmd.color("blue", "2FoFcmap_pos")

    if VIEW == "side":
        cmd.set_view([\
            -0.197476402,    0.722830713,   -0.662173033,\
            0.846193016,   -0.215310872,   -0.487389654,\
            -0.494875133,   -0.656584084,   -0.569154680,\
            0.000000000,    0.000000000,  -56.387928009,\
            16.364500046,   13.473999977,   -4.323500156,\
            47.470001221,   65.305831909,  -20.000000000 ])

    elif VIEW == "top":
        cmd.distance("d1", "///A/FDA/N5", "///A/403/OD1")
        cmd.hide("label")
        cmd.set_view([\
            -0.132050425,    0.692924380,    0.708782971,\
            0.796741307,    0.499578238,   -0.339962572,\
            -0.589664042,    0.519843102,   -0.618061662,\
            0.000000000,    0.000000000,  -56.387928009,\
            16.364500046,   13.473999977,   -4.323500156,\
            47.470001221,   65.305831909,  -20.000000000 ])
        
    else:
        raise RuntimeError("view should be top or side")


    # cmd.ray(*FIGSIZE)

    name = map_file.split("/")[1]
    cmd.save(f"./png/{i}_{name}_{VIEW}_sigma{SIGMA}.png")
    cmd.delete("2FoFcmap_pos")
    cmd.delete("2FoFcmap")
    cmd.delete("pl")
    if VIEW == "top":
        cmd.delete("d1")
