window.log = function(msg) {
	console.log(msg);
};

var griddb = {
	"griddb":	{
		1: [
			[
				"CREATE TABLE queue(						\
					id INTEGER NOT NULL PRIMARY KEY,			\
					func_id INTEGER NOT NULL REFERENCES function(id),	\
					args TEXT NOT NULL DEFAULT '[]',			\
					done BOOL DEFAULT false,				\
					answer TEXT						\
				)"
			],
			[
				"CREATE TABLE function(						\
					id INTEGER NOT NULL PRIMARY KEY,			\
					name VARCHAR(255) NOT NULL,				\
					code TEXT NOT NULL,					\
					unique(name)						\
				)"
			],
		],
	},
};

function VersionableDBs(rules) {
	this.rules	= rules;
	this.dbs	= {};
}

VersionableDBs.prototype = {
	versionableDB: {
		version:	1,
		size:		2 * 1024 * 1024,
		dbName:		"versionableDB",
		versionTable: 	"version",
		dbTable:	"db",
		dbNameMaxSize:	255,
		creationScript:	[
					"CREATE TABLE {{dbTable}}(							\
						id INTEGER NOT NULL PRIMARY KEY,					\
						name VARCHAR({{dbNameMaxSize}}) NOT NULL UNIQUE,			\
						created TIMESTAMP NOT NULL DEFAULT (datetime('now','localtime')),	\
						version REAL NOT NULL,							\
						actual BOOL NOT NULL DEFAULT TRUE					\
					)",
					"CREATE TABLE {{versionTable}}(							\
						id INTEGER NOT NULL PRIMARY KEY,					\
						db INTEGER NOT NULL REFERENCES {{dbTable}}(id),				\
						changed TIMESTAMP NOT NULL DEFAULT (datetime('now','localtime')),	\
						version REAL NOT NULL,							\
						actual BOOL NOT NULL DEFAULT TRUE					\
					)"
				],
		getCreationScript:	function() {
			var _this = this;
			var script = [];
			for(var i = 0; i < this.creationScript.length; i++)
				script.push(this.creationScript[i].replace(/\{\{(\w+)}}/g, function(str, name){
					return _this[name];
				}).replace(/\s+/g, " "));
			return script;
		},
		create:	function(trans) {
			var script = thos.getCreationScript();
			for(var i = 0; i < script.length; i++)
				trans,executeSql(script[i]);
		}
	},
	migrate: function(name) {
		var _this 	= this;
		var db 		= this.dbs[name];
		var rule 	= this.rules[name];
		if(!db || !rule) return;
		var actual_version = db.version;
		if(actual_version == "undefined")
			actual_version = 0;
		log("DB version: " + actual_version)
		var versions = this.getRulesVersionsFor(rule, actual_version);
		log("applying versions: " + JSON.stringify(versions));
		var new_version = versions[versions.length - 1];
		log("to new version: " + new_version);
		db.transaction(function(trans){
			log("changeVersion()");
			_this.applyRules(trans, rule, versions);
		});
		//db.changeVersion(actual_version, new_version, function(trans){
		//	//log("changeVersion()");
		//	//_this.applyRules(trans, rule, versions);
		//}, function(){
		//	alert("Deu ruim");
		//}, function(){
		//	alert("Funfou!!!");
		//});
	},
	applyRules: function(trans, rules, versions) {
		log("applyRules()");
		for(var i = 0; i < versions.length; i++) {
			var version_rule = rules[versions[i]];
			for(var j = 0; j < version_rule.length; j++) {
				var rule = version_rule[j];
				var sql = rule[0];
				var bind = [];
				for(var k = 1; k < rule.length; k++)
					bind.push(rule[k]);
				console.log("Executing: '" + sql.replace(/\s+/g, " ") + "': " + JSON.stringify(bind));
				trans.executeSql(sql, bind);
			}
		}
	},
	getDB: function(name, text, size) {
		log("getDB('" + name + "', '" + text + "', " + size + ")");
		if(!this.dbs[name]) {
			log("DB '" + name + "' does not exists, creating...");
			log("openDatabase('" + name + "', \"\", '" + text + "', '" + size + "'");
			this.dbs[name] = openDatabase(name, "", text, size);
		} else {
			log("DB '" + name + "' already exists.");
		}
		this.migrate(name);
		return this.dbs[name];
	},
	getRulesVersionsFor: function(rules, actual) {
		var versions = [];
		for(var ver in rules) {
			if(ver - actual > 0) versions.push(ver);
		}
		return versions.sort(function(a, b){return a - b})
	},
};

function GridDB() {
	this.db = openDatabase("GridDB", "", "JSGrid Database", 200000);
}
