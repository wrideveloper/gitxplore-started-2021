const identity = [
  { name: "Galur Arasy Lumintang" },
  { class: "1A" },
  { presenceNumber: "13" },
  { studyProgram: "Manajemen Informatika" },
];

identity.forEach((item) => {
  const prop = Object.keys(item)[0];
  const val = Object.values(item)[0];
  console.log(`${prop}: ${val}`);
});
