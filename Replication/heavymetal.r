cu = terra::rast(system.file("case/cu.tif",package = "spEDM"))
cu

g1 = spEDM::gccm(cu, "ntl", "cu",
                 libsizes = matrix(rep(120,time = 2),ncol = 2),
                 E = 4, k = 4, style = 0, stack = 1,
                 pred = as.matrix(expand.grid(seq(5,130,5),
                                              seq(5,125,5))))

g2 = spEDM::gccm(cu, "ntl", "cu",
                 libsizes = matrix(rep(seq(10,120,20),time = 2),ncol = 2),
                 E = 4, k = 4, style = 0, stack = 1,
                 pred = as.matrix(expand.grid(seq(5,130,5),
                                              seq(5,125,5))))