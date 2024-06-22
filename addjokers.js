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
      "Earn {C:gold}$3{} at the end of the round"
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
      "When {C:important}Blind{} is selected, create one {C:common}common {C:red}Phantom Thieves {C:important}Joker",
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
      "Copies the ability of {C:important}Joker{} to the left"
    ],
    image_url: "img/j_joker.png",
    rarity: "Rare"
  },
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
    EDITION: "#4ca893"
  };
  
  let regex = /{([^}]+)}/g;
  
  function add_cards_to_div(cards, div_class) {
    const container = document.querySelector(`.${div_class}`);
    if (!container) return;
  
    cards.forEach(card => {
      let cardDiv = document.createElement('div');
      cardDiv.className = 'card';
  
      let cardHTML = `<h3>${card.name}</h3><p>`;
      cardHTML += card.text.map(line => {
        line = line + "{}";
        line = line.replaceAll("{}", "</span>");
        return line.replace(regex, (match, p1) => {
          let styles = "";
          let attributes = p1.split(",");
          attributes.forEach(attr => {
            let [key, value] = attr.split(":");
            if (key === "C") styles += `color: ${cols[value.toUpperCase()]};`;
            if (key === "X") styles += `background-color: ${cols[value.toUpperCase()]}; border-radius: 5px; padding: 0 5px;`;
          });
          return `</span><span style="${styles}">`;
        });
      }).join("<br/>");
  
      cardHTML += "</p>";
      cardDiv.innerHTML = cardHTML;
      container.appendChild(cardDiv);
    });
  }
  
  document.addEventListener('DOMContentLoaded', () => {
    add_cards_to_div(jokers, 'jokers');
    // Call add_cards_to_div for other card types
  });
  