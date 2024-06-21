let jokers = [
  {
    name: "The Contract",
    text: [
      "{C:important}+1{} hand size, each {C:red}Phantom Thieves{} Joker you own gives {C:xmult}X1.3{} Mult"
    ],
    image_url: "img/j_joker.png",
    rarity: "Legendary"
  },
  {
    name: "Zorro",
    text: [
      "Creates a random {C:planet}Planet{} card at the end of the round",
      "{C:inactive}(Must have room)"
    ],
    image_url: "img/j_joker.png",
    rarity: "Uncommon"
  },
  {
    name: "Johanna",
    text: [
      "Retriggers the {C:important}first{} scoring card"
    ],
    image_url: "img/j_joker.png",
    rarity: "Uncommon"
  },
  {
    name: "Milady",
    text: [
      "Earn {C:important}$3{} at the end of the round"
    ],
    image_url: "img/j_joker.png",
    rarity: "Uncommon"
  },
  {
    name: "Goemon",
    text: [
      "{C:green}1 in 3{} chance to duplicate {C:important}first hand{} of round if it has only {C:important}1{} card"
    ],
    image_url: "img/j_joker.png",
    rarity: "Uncommon"
  },
  {
    name: "Chief",
    text: [
      "{C:chips}+20{} Chips for every other {C:red}Phantom Thieves{} Joker you own"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Carmen",
    text: [
      "When {C:important}Blind{} is selected, create one {C:common}common {C:red}Phantom Thieves {C:joker}Joker",
      "{C:inactive}(Must have room)"
    ],
    image_url: "img/j_joker.png",
    rarity: "Rare"
  },
  {
    name: "Captain Kidd",
    text: [
      "{C:green}1 in 2{} chance to upgrade level of played {C:important}poker hand"
    ],
    image_url: "img/j_joker.png",
    rarity: "Rare"
  },
  {
    name: "Robin Hood",
    text: [
      "Create your most used {C:purple}Tarot{} at the end of the round"
    ],
    image_url: "img/j_joker.png",
    rarity: "Uncommon"
  },
  {
    name: "Necronomicon",
    text: [
      "Create a random {C:purple}Tarot{} card at the end of the round"
    ],
    image_url: "img/j_joker.png",
    rarity: "Uncommon"
  },
  {
    name: "Prophetess",
    text: [
      "{C:green}1 in 4{} chance to see the next card to draw"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Twins",
    text: [
      "{C:inactive}Does nothing..."
    ],
    image_url: "img/j_joker.png",
    rarity: "Rare"
  },
  {
    name: "Weapons Dealer",
    text: [
      "{C:green}1 in 5{} chance of adding a random enhancement to scoring cards"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Back Alley Doctor",
    text: [
      "{C:Chips}+20{} Chips per {C:purple}Tarot{} card used this run"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Teacher",
    text: [
      "Played cards give {C:chips}+20{} Chips when scored"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Paparazza",
    text: [
      "Reduce required chip score of {C:important}Blinds{} by 10%"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Skilled Gamer",
    text: [
      "{C:green}1 in 2{} chance of {C:blue}+1{} hand each round"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Shogi Player",
    text: [
      "{C:green}1 in 2{} chance of {C:red}+1{} discard each round"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Admin",
    text: [
      "{C:green}1 in 5{} chance of adding a random seal to scoring cards"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Man of the People",
    text: [
      "All cards and packs in shop cost {C:gold}$1{} less",
      "{C:inactive}(Minimum {C:gold}$1{C:inactive})"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Prosecutor",
    text: [
      "{C:green}1 in 5{} chance of adding a random edition to scoring cards"
    ],
    image_url: "img/j_joker.png",
    rarity: "Common"
  },
  {
    name: "Arsène",
    text: [
      "Copies the ability of {C:joker}Joker{} to the left"
    ],
    image_url: "img/j_joker.png",
    rarity: "Rare"
  },
]

// works the same. 
let consumables = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Tarot"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Planet"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Spectral"
  // },
]

let card_modifications = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Enhancement"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Edition"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/sticker_example.png",
  //   rarity: "Seal"
  // },
]

let decks = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Deck"
  // },
]

let stickers = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/sticker_example.png",
  //   rarity: "Sticker"
  // },
]

let blinds = [
  // {
  //   name: "The Wall",
  //   text: [
  //     "Extra large blind",
  //     "{C:inactive}({C:red}4x{C:inactive} Base for {C:attention}$$$$${C:inactive})",
  //     "{C:inactive}(Appears from Ante 2)"
  //   ],
  //   image_url: "img/the_wall.png",
  //   rarity: "Boss Blind"
  // },
  // {
  //   name: "Violet Vessel",
  //   text: [
  //     "Very large blind",
  //     "{C:inactive}({C:red}6x{C:inactive} Base for {C:attention}$$$$$$$${C:inactive})",
  //     "{C:inactive}(Appears from Ante 8)"
  //   ],
  //   image_url: "img/violet_vessel.png",
  //   rarity: "Showdown"
  // },
]

let shop_items = [
]

let cols = {
  
  MULT: "#FE5F55",
  CHIPS: "#009dff",
  MONEY: "#f3b958",
  XMULT: "#FE5F55",
  FILTER: "#ff9a00",
  ATTENTION: "#ff9a00",
  BLUE: "#009dff",
  RED: "#FE5F55",
  GREEN: "#4BC292",
  PALE_GREEN: "#56a887",
  ORANGE: "#fda200",
  IMPORTANT: "#ff9a00",
  GOLD: "#eac058",
  YELLOW: "#ffff00",
  CLEAR: "#00000000", 
  WHITE: "#ffffff",
  PURPLE: "#8867a5",
  BLACK: "#374244",
  L_BLACK: "#4f6367",
  GREY: "#5f7377",
  CHANCE: "#4BC292",
  JOKER_GREY: "#bfc7d5",
  VOUCHER: "#cb724c",
  BOOSTER: "#646eb7",
  EDITION: "#ffffff",
  DARK_EDITION: "#5d5dff",
  ETERNAL: "#c75985",
  INACTIVE: "#ffffff99",
  HEARTS: "#f03464",
  DIAMONDS: "#f06b3f",
  SPADES: "#403995",
  CLUBS: "#235955",
  ENHANCED: "#8389DD",
  JOKER: "#708b91",
  TAROT: "#a782d1",
  PLANET: "#13afce",
  SPECTRAL: "#4584fa",
  VOUCHER: "#fd682b",
  EDITION: "#4ca893",
}

let rarities = {
  "Common": "#009dff", 
  "Uncommon": "#4BC292",
  "Rare": "#fe5f55",
  "Legendary": "#b26cbb",
  "Joker": "#708b91",
  "Tarot": "#a782d1",
  "Planet": "#13afce",
  "Spectral": "#4584fa",
  "Voucher": "#fd682b",
  "Pack": "#9bb6bd",
  "Enhancement": "#8389DD",
  "Edition": "#4ca893",
  "Seal": "#4584fa",
  "Deck": "#9bb6bd",
  "Sticker": "#5d5dff",
  "Boss Blind": "#5d5dff",
  "Showdown": "#4584fa",
}

regex = /{([^}]+)}/g;

let add_cards_to_div = (jokers, jokers_div) => {
  for (let joker of jokers) {
    console.log("adding joker", joker.name);
  
    joker.text = joker.text.map((line) => { return line + "{}"});
  
    joker.text = joker.text.join("<br/>");
    joker.text = joker.text.replaceAll("{}", "</span>");
    joker.text = joker.text.replace(regex, function replacer(match, p1, offset, string, groups) {
      let classes = p1.split(",");
  
      let css_styling = "";
  
      for (let i = 0; i < classes.length; i++) {
        let parts = classes[i].split(":");
        if (parts[0] === "C") {
          css_styling += `color: ${cols[parts[1].toUpperCase()]};`;
        } else if (parts[0] === "X") {
          css_styling += `background-color: ${cols[parts[1].toUpperCase()]}; border-radius: 5px; padding: 0 5px;`;
        }
      }
  
      return `</span><span style='${css_styling}'>`;
    });
  
    let joker_div = document.createElement("div");
    joker_div.classList.add("joker");
    if (joker.rarity === "Sticker" || joker.rarity == "Seal") {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" class="hasback" />
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    } else if (joker.soul) {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <span class="soulholder">
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-bg" />
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-top" />
        </span>
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    } else {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" />
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    }
  
    jokers_div.appendChild(joker_div);
  }
}

if (jokers.length === 0) {
  document.querySelector(".jokersfull").style.display = "none"
} else {
  let jokers_div = document.querySelector(".jokers");
  add_cards_to_div(jokers, jokers_div);
}

if (consumables.length === 0) {
  document.querySelector(".consumablesfull").style.display = "none"
} else {
  let consumables_div = document.querySelector(".consumables");
  add_cards_to_div(consumables, consumables_div);
}

if (card_modifications.length === 0) {
  document.querySelector(".cardmodsfull").style.display = "none"
} else {
  let cardmods_div = document.querySelector(".cardmods");
  add_cards_to_div(card_modifications, cardmods_div);
}

if (decks.length === 0) {
  document.querySelector(".decksfull").style.display = "none"
} else {
  let decks_div = document.querySelector(".decks");
  add_cards_to_div(decks, decks_div);
}

if (stickers.length === 0) {
  document.querySelector(".stickersfull").style.display = "none"
} else {
  let stickers_div = document.querySelector(".stickers");
  add_cards_to_div(stickers, stickers_div);
}

if (blinds.length === 0) {
  document.querySelector(".blindsfull").style.display = "none"
} else {
  let blinds_div = document.querySelector(".blinds");
  add_cards_to_div(blinds, blinds_div);
}

if (shop_items.length === 0) {
  document.querySelector(".shopitemsfull").style.display = "none"
} else {
  let shopitems_div = document.querySelector(".shopitems");
  add_cards_to_div(shop_items, shopitems_div);
}