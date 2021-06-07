const fs = require("fs");
const { parse, print } = require("./shared");

let data = fs.readFileSync("groups.ldif", { encoding: "utf8" });

let groups = parse(data);

groups = groups.filter((group) => !group.objectclass.includes("itPosition"));

let newGroups = [];
let currentIdOffset = 0;

groups.forEach((group) => {
	if (
		group.objectclass.includes("itGroup") ||
		group.objectclass.includes("posixGroup")
	) {
		newGroups.push({
			dn: group.dn[0],
			cn: group.cn[0],
			gidnumber: 5000 + currentIdOffset,
			member: group.member,
			objectclass: ["groupOfNames", "customPosixGroup", "top"],
		});

		currentIdOffset++;
	} else {
		newGroups.push(group);
	}

	return group;
});

print(newGroups, "new-groups.ldif");
