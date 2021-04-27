const fs = require("fs");
const { parse, print } = require("./shared");

let data = fs.readFileSync("groups.ldif", { encoding: "utf8" });

let groups = parse(data);

groups = groups.filter((group) => !group.objectclass.includes("itPosition"));

groups = groups.map((group) => {
	if (group.objectclass.includes("itGroup")) {
		return {
			dn: group.dn[0],
			cn: group.cn[0],
			gidnumber: group.gidnumber[0],
			member: group.member,
			objectclass: ["groupOfNames", "customPosixGroup", "top"],
		};
	}

	return group;
});

print(groups, "new-groups.ldif");
