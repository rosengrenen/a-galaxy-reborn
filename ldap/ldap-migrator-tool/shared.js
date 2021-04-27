const fs = require("fs");

module.exports.parse = function (input) {
	input = input.replaceAll(/\n /g, "");

	const entries = [];

	let i = -1;
	for (const line of input.split("\n")) {
		if (line.startsWith("#")) {
			i++;
			entries.push({});
			continue;
		}

		if (line.length === 0) {
			continue;
		}

		const splitIndex = line.indexOf(":");
		const key = line.substring(0, splitIndex).trim();
		let value;
		if (line.includes("::")) {
			value = Buffer.from(line.substring(splitIndex + 2).trim(), "base64")
				.toString("utf8")
				.replaceAll("\r\n", "")
				.replaceAll("\n", "");
		} else {
			value = line.substring(splitIndex + 1).trim();
		}

		if (entries[i][key] === undefined) {
			entries[i][key] = [value];
		} else {
			entries[i][key] = [...entries[i][key], value];
		}
	}

	return entries;
};

module.exports.print = function (entries, filename) {
	let string = "";
	entries.forEach((entry) => {
		Object.entries(entry).forEach(([key, value]) => {
			if (Array.isArray(value)) {
				value.forEach((val) => {
					string += `${key}: ${val}\n`;
				});
			} else {
				string += `${key}: ${value}\n`;
			}
		});
		string += "\n";
	});

	fs.writeFileSync(filename, string);
};
