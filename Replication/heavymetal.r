load("./data/heavymetal.RData") 

HMs = purrr::map(HMImages,terra::rast) |> 
  terra::rast()
names(HMs) = c("cu","cd","mg","pb")

Envs = purrr::map(EnviImages,terra::rast) |> 
  terra::rast()
names(Envs) = c("ntl","industry")

heavymetal = c(HMs,Envs)
terra::plot(heavymetal)

g1 = spEDM::gccm(heavymetal, "ntl", "cu",
                 libsizes = matrix(rep(120,time = 2),ncol = 2),
                 E = 4, k = 5, style = 0, stack = 1,
                 pred = as.matrix(expand.grid(seq(5,125,5), seq(5,130,5))),
                 dist.metric = "L1", dist.average = FALSE, detrend = FALSE)

g2 = spEDM::gccm(heavymetal, "industry", "cu",
                 libsizes = matrix(rep(120,time = 2),ncol = 2),
                 E = 4, k = 5, style = 0, stack = 1,
                 pred = as.matrix(expand.grid(seq(5,125,5), seq(5,130,5))),
                 dist.metric = "L1", dist.average = FALSE, detrend = FALSE)
