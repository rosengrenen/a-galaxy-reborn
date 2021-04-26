const fs = require("fs");
const { parse, print } = require("./shared");

let data = fs.readFileSync("users.ldif", { encoding: "utf8" });

const users = parse(data);

users.forEach((user) => {
	user.cn[0] = user.cn[0].replace("%{nickname}", user.nickname[0]);
	user.cn[0] = user.cn[0].replace("%{firstname}", user.givenname[0]);
	user.cn[0] = user.cn[0].replace("%{lastname}", user.sn[0]);
});

let newUsers = [];

users.forEach((user) => {
	newUsers.push({
		dn: user.dn[0],
		cn: user.givenname[0],
		gidnumber: 3000 + newUsers.length,
		homedirectory: "/home/chalmersit/" + user.uid[0],
		loginshell: "/bin/bash",
		objectclass: [
			"organizationalPerson",
			"posixAccount",
			"top",
			...(user.sshpublickey !== undefined ? ["ldapPublicKey"] : []),
		],
		userpassword: user.userpassword[0],
		sn: user.sn[0],
		uidnumber: 3000 + newUsers.length,
		uid: user.uid[0],
		...(user.sshpublickey !== undefined
			? { sshpublickey: user.sshpublickey[0] }
			: {}),
	});
});

print(newUsers, "new-users.ldif");
