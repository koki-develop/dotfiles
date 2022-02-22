module.exports = {
  config: {
    // font
    fontSize: 16,
    fontFamily: '"Ricty Diminished"',

    // color
    foregroundColor: "lightGray",
    cursorColor: "#ff0000",
    selectionColor: "rgba(255, 255, 255, 0.5)",
    borderColor: "#333",

    // hyperterm-summon
    summon: {
      hotkey: "Option+Space",
    },

    // hyper-statusbar
    statusbar: {
      panels: ["battery", "user", "ip", "clock"],
    },
  },

  plugins: ["hyperpower", "hyperterm-summon"],
  localPlugins: ["hyper-statusbar"],
};
