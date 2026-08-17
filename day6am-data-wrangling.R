# packages contain functions and data. load them with the `library()` function
library(tidyverse)
library(palmerpenguins)

# palmerpenguins contains the penguins data fram
penguins

# glimpse() rotates the printing of a data frame so you can see every column
glimpse(penguins)
# will be hundreds of columns so this is helpful for that

# Rows -------------------------------------------------------------------
# ^ command k. then h

## Filter
# keeps rows that satisfy one or more conditions

filter(penguins, sex == "female") # 2 arguments
# only prints female penguins

filter(penguins, species == "Chinstrap")
# only prints chinstrap penguins

# what about this?
filter(penguins, species == "female") # df with 0 rows bc doesn't exist

filter(penguins, body_mass_g < 3000)

filter(penguins, sex == "female" | flipper_length_mm > 190)
# |, & are the vectorized versions of ||, &&
# save the doubles for if(), use the singles in data frames

## Arange
# arrange() sorts rows by one or more columns
arrange(penguins, bill_depth_mm)
# bill depth in increasing order

arrange(penguins, island)
# biscoe's first (bc alphabetical ig?)
# can sort by multiple columns (order matters!)

arrange(penguins, island, bill_depth_mm)
# sorted by island, then bill_depth is in order of each island

# what if i want descending order?
arrange(penguins, desc(body_mass_g))


## Distinct and Count
distinct(penguins, island)
# prints each different island: 1 column of Torgersen, Biscoe, Dream

count(penguins, island)
# count of each distinct island --> Biscoe is 168, dream: 124, torgersen: 52

# works on multiple columns, too
count(penguins, species, island)
# counts of each unique species & island combo

# Columns ----------------------------------------------------------------

## Mutate
# adds (or replaces) columns

mutate(penguins, body_mass_kg = body_mass_g / 1000)
# makes a new col: body mass kg

penguins_kg_g <- mutate(penguins, body_mass_kg = body_mass_g / 1000)
select(penguins_kg_g, body_mass_kg, body_mass_g)

# mutate can create more than one column at a time
mutate(
  penguins,
  body_mass_kg = body_mass_g / 1000,
  bill_length_cm = bill_length_mm / 10
)

# relocate columns using .before
mutate(
  penguins,
  body_mass_kg = body_mass_g / 1000,
  bill_length_cm = bill_length_mm / 10,
  .before = 1
) # puts new columns at the front (1)


## Select
# chooses cols to retain (or exclude)
select(penguins, body_mass_g)
# only prints body mass g

# helpers for select
# : selects ranges of cols
select(penguins, species:island)
select(penguins, species:bill_depth_mm)
# ! excludes cols
select(penguins, !species) # gets rid of species col
select(penguins, !island:bill_length_mm) # gets rid of range of cols

# select() family of helper functions
select(penguins, starts_with("bill"))
select(penguins, ends_with("mm"))
select(penguins, contains("length"))


# Pipe -------------------------------------------------------------------

# chaining together multiple functions is ugly
filter(mutate(penguins, body_mass_kg = body_mass_g / 1000), body_mass_kg < 2.8)
filter(
  mutate(
    penguins,
    body_mass_kg = body_mass_g / 1000
  ),
  body_mass_kg < 2.8
) # same thing but still messy

# notice they're in different orders

# pipe to the rescue
penguins |>
  mutate(body_mass_kg = body_mass_g / 1000) |>
  filter(body_mass_kg < 2.8)


# your turn
# flip this into the correct order using pipes
select(arrange(penguins, species, bill_length_mm), species:bill_length_mm)

penguins |>
  arrange(species, bill_length_mm) |>
  select(species:bill_length_mm)


# Summarize --------------------------------------------------------------

penguins |>
  summarize(avg_size = mean(body_mass_g))
# NA is R's way of representing missing data

penguins |>
  summarize(avg_size = mean(body_mass_g, na.rm = TRUE))
# 4202. gets rid of NA's

# by default, summaries happen across the entire data frame
# use .by to group

penguins |>
  summarize(
    avg_size = mean(body_mass_g, na.rm = TRUE),
    .by = species
  ) # can group species tgt and then take mean of body weight


# grouping by multiple columns
penguins |>
  summarize(
    avg_size = mean(body_mass_g, na.rm = TRUE),
    .by = c(species, island)
  ) # avg size based off species and island


# creating multiple summaries
penguins |>
  summarize(
    avg_size = mean(body_mass_g, na.rm = TRUE),
    n_penguins = n(),
    .by = c(species, island)
  ) # same thing as above but shows how many penguins are in each category. gentoo has most
