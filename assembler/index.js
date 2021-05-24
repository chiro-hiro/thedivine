const fs = require("fs");
const opcode = require("./opcode");

// Map OPCODE string -> Binary value
const asmMap = new Map(opcode.map((v, i) => [v, i]));

function compile(fileName) {
  const inputContent = fs.readFileSync(fileName).toString();
  const fileContent = inputContent
    .split("\n")
    // Trim input
    .map((i) => i.trim())
    // Remove comment and empty lines
    .filter((i) => i.length > 0 && !/^(;|#)/.test(i));
  const buf = [];
  for (let i = 0; i < fileContent.length; i += 1) {
    const [opc, param] = fileContent[i].split(" ").filter((i) => i.length > 0);
    const op = opc.toUpperCase();
    if (asmMap.has(op)) {
      buf.push(asmMap.get(op));
      console.log(
        `${asmMap.get(op).toString(16).padStart(2, "0")}    ${op}${
          param ? ` ${param}` : ""
        }`
      );
      if (param) {
        if (/^0x[a-f0-9]+$/gi.test(param) && param.length % 2 == 0) {
          const hexString = param.replace(/^0x/gi, "");
          for (let i = 0; i < hexString.length; i += 2) {
            buf.push(parseInt(hexString.substr(i, 2), 16));
          }
        } else {
          console.log(`Invalid param ${param}`);
          process.exit(0);
        }
      }
    } else {
      console.log(`Invalid opcode ${op}`);
      process.exit(0);
    }
  }
  return Buffer.from(buf).toString("hex");
}

const bytecode = compile(`${__dirname}/../contracts/TheDivine.asm`);
const len = bytecode.length / 2;

console.log("\nOutput:\t\t", bytecode);
console.log("Tx deploy data:\t", `60${len.toString(16)}803d90600a8239f3${bytecode}`);
