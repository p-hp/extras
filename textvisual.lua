local TextProcessor = {};

TextProcessor.Patterns = {
	tagPattern = {"<(.-)>", "</(!)>"};
};

TextProcessor.Features = {
	["hl"] = {"b", "font color='rgb(218,165,32)'"};
	[<tag>] = <replacementTags[]>;
	]]
};

function TextProcessor.specialConcat(tab, joinStr: string)
	local str = "";
	for i, addText in pairs(reverseTab(tab)) do
		str ..= addText:split(" ")[1] .. (i < #tab and joinStr or "");
	end;
	return str;
end;

function TextProcessor:Make(text: string, index: number): string
	local isTag;

	if index and index > 0 then
		text, isTag = self:SimpleSlice(text, index);
	end;

	for used, template in pairs(self.Features) do
		local feature = "<" .. table.concat(template, "><") .. ">";
		text = text:gsub("<" .. used .. ">", feature);
		local featureCloser = "</" .. self.specialConcat(template, "></") .. ">";
		text = text:gsub("</" .. used .. ">", featureCloser);
	end;

	return text, isTag;
end;

function reverseTab(tab)
	local rev = {};
	for i=#tab, 1, -1 do
		rev[#rev+1] = tab[i];
	end;
	return rev;
end;

function TextProcessor.firstWord(text)
	return text:split(" ")[1];
end;

function TextProcessor:SimpleSlice(text, index)
	local unclosedTags = {};
	local chars = text:sub(1, index):split("");
	local tagIsOpening = false;
	local tagIsClosing = false;
	local unclosedTag = "";
	local closedTag = "";

	local str = "";

	for p, char in pairs(chars) do
		if char == "<" and chars[p + 1] ~= "/" then
			tagIsOpening = true;
		elseif char == ">" and tagIsOpening then
			tagIsOpening = false;
			table.insert(unclosedTags, unclosedTag);
			unclosedTag = "";
		elseif tagIsOpening then
			unclosedTag ..= char;
		elseif char == "<" and chars[p + 1] == "/"
			tagIsClosing = true;
		elseif char == ">" and tagIsClosing then
			tagIsClosing = false;
			table.remove(unclosedTags, table.find(unclosedTags, closedTag));
		elseif tagIsClosing then
			closedTag ..= char;
		end;

		str ..= char;
	end;


	if tagIsOpening then
		table.insert(unclosedTags, unclosedTag ~= "" and unclosedTag or "unfinished");

		local unclosedDifference = #unclosedTag - #self.firstWord(unclosedTag);

		if unclosedTag == "" then
			str ..= "unfinished";
		elseif unclosedDifference > 0 then
			str = str:sub(1, #str - unclosedDifference);
		end
		str ..= ">";
	end;

	if tagIsClosing then
		str = str:sub(1, #str - #closedTag - 1);
	end;
	
	local toClose = reverseTab(unclosedTags);
	for i, v in pairs(toClose) do
		local firstWord = self.firstWord(v);
		str ..= "</" .. firstWord .. ">";
	end;
	
	return str, tagIsOpening or tagIsClosing;
end;

function TextProcessor:Typewriter(object, text: string, config: {prop: string?; length: number?})
	config = config or {};
	for i = 1, #text do
		local sliced, inTag = self:Make(text, i);
		
		object[config.prop or "Text"] = sliced;
		if not inTag then
			wait(config.length or .04);
		end;
	end;
end;

return TextProcessor;
