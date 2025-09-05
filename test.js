import bcrypt from "bcrypt";

const password = "123"; // password yang mau di-hash
const saltRounds = 10; // sesuai dengan $2b$10$

async function generateHash() {
  const hash = await bcrypt.hash(password, saltRounds);
  console.log("Hash bcrypt:", hash);
}

generateHash();