module.exports = {
  config: {
    // font
    fontSize: 16,
    fontFamily: '"Ricty Diminished"',

    // color
    foregroundColor: "lightGray",
    cursorColor: "#ff0000",
    selectionColor: "rgba(255, 255, 255, 0.5)",

    // hyperterm-summon
    summon: {
      hotkey: "Option+Space",
    },
  },

  plugins: ["hyperpower", "hyperterm-summon"],
};
