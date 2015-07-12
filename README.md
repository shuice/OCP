# OCP
Objective-C Patch

**Sample code For instance method**
	-NSString.subStringFromRange(range)
	{
    	if (self.length() == 0)
    	{
        	return  "";
    	}
    	return "1";
	}

**Sample code For class method**
	+NSString.subStringFromRange(range)
	{
    	return "";
	}

**Lexical Analysis Graph**
 ![image](https://github.com/shuice/OCP/raw/master/lexicalAnalysisGraph.png)
