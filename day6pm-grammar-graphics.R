library(tidyverse)
library(palmerpenguins)

# all this does is declare a figure. made a white box lol
ggplot(data = penguins)

# let's set the **mappings**
ggplot(
  penguins,
  mapping = aes(
    x = flipper_length_mm,
    y = body_mass_g
  )
)

# let's add a **geometry**
ggplot(
  penguins,
  mapping = aes(
    x = flipper_length_mm,
    y = body_mass_g
  )
) +
  geom_point()

# your turn: what types of figures are created by the following **geometries**
ggplot(
  data = penguins,
  mapping = aes(x = island)
) +
  geom_bar() # count of how many penguins in each island. 3 bars

ggplot(
  data = penguins,
  mapping = aes(x = body_mass_g)
) +
  geom_histogram() # count of how many penguins in each body mass range. more like a histogram

ggplot(
  data = penguins,
  mapping = aes(
    x = species,
    y = body_mass_g
  )
) +
  geom_boxplot()


# x and y are not our only aesthetics
ggplot(
  data = penguins,
  mapping = aes(
    x = species,
    y = body_mass_g,
    fill = species
  )
) +
  geom_boxplot()


# what if fill and x refer to diff columns
ggplot(
  data = penguins,
  mapping = aes(
    x = species,
    y = body_mass_g,
    fill = island
  )
) +
  geom_boxplot() # adelie's have 3 boxplots bc 3 diff islands


# **Scales** control how mappings appear
ggplot(
  data = penguins,
  mapping = aes(
    x = species,
    y = body_mass_g,
    fill = island
  )
) +
  geom_boxplot() +
  scale_y_continuous(
    name = "Body mass (g)",
    n.breaks = 3, # edits how many breaks in y axis. only did 2. R does what it wants
  )

ggplot(
  data = penguins,
  mapping = aes(
    x = species,
    y = body_mass_g,
    fill = island
  )
) +
  geom_boxplot() +
  scale_y_continuous(
    name = "Body mass (g)",
    limits = c(2000, 7000)
  )

# the shape aesthetic works on scatters
ggplot(
  data = penguins,
  mapping = aes(
    x = body_mass_g,
    y = flipper_length_mm,
    shape = species,
    color = species # fill doesn't do shit here
  )
) +
  geom_point()


ggplot(
  data = penguins,
  mapping = aes(
    x = body_mass_g,
    y = flipper_length_mm,
    shape = species,
    color = species
  )
) +
  geom_point() +
  scale_shape_manual(
    values = c(
      Adelie = "square",
      Chinstrap = "diamond",
      Gentoo = "circle"
    )
  )
