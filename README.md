#UNFINISHED PROJECT

# OCP
Objective-C Patch

**Sample code For instance method**

```Objective-C++
-NSString.subStringFromRange(range)
{
	if (self.length() == 0)
	{
		return  "";
	}
	return "1";
}
```	

**Sample code For class method**

```Objective-C++
+NSString.subStringFromRange(range)
{
	return "";
}
```

**Lexical Analysis Graph**
 ![image](https://github.com/shuice/OCP/raw/master/lexicalAnalysisGraph.png)
 
**Lexical Analysis Status Change Table**
 ![image](https://github.com/shuice/OCP/raw/master/lexical_status_change_table.png)