<?php

// D.ROSSI - seminartex Seminar:
// v2.6 - Apr 2017 - include place after date in summary
// v2.4 - 2.5 small bugfixes
// v2.3  Oct 24th 2011;  //DATE-FIX:  $date =   substr($key,6,2) . "/"  . substr($key,4,2) .  "/" . substr($key,0$
// v2.2  Thu Jul  7 14:16:07 CEST 2011
// v1: Wed Apr 21 18:56:23 CEST 2010
// v0: Mon Feb 23 14:08:53 CET 2009  (my seminartexref package)
//
// usage:
// 
// !!Seminar
// seminarquery:[seminar.seminar][2008] 
// seminarquery:[seminar.seminar][PREV] 
// seminarquery:[seminar.seminar][NEXT]  
// seminarquery:[seminar.seminar][TODO]  
//v2.2  
// seminarquery:[seminar.seminar][ALL]   

// $PdfLink
// $SeminarLink
// $UrlLink


$BibtexPdfLink = "(PDF)";
$BibtexUrlLink = "(URL)";
$BibtexSeminarLink = "paper/";

//use "*" for bulleted environment, 
//    "#" for enumerated items
//    ""  for custom stuff
$SeminarBullet_or_Counter = ""; 

$BibtexGenerateDefaultUrlField = false;

#$log_str = "";

$BibtexLang = array();


// nonsns -- for PmWiki and the like
Markup("seminarquery","fulltext","/\\bseminarquery:\\[(.*?)\\]\\[(.*?)\\]/e","SeminarQuery('$1', '$2')");

SDV($HandleActions['seminarentry'],'HandleSeminarEntry');

$SeminarEntries = array();

class BaseBibtexEntry {
  var $values = array();
  var $seminarfile;
  var $entryname;
  var $entrytype;

  function BibtexEntry($seminarfile, $entryname)
  {
    $this->seminarfile = $seminarfile;
    $this->entryname = $entryname;
  }

  function getList() 
  {
   	return "";
  }

  function evalGet($get)
  {
     $get = str_replace("\\\"", "\"", $get);
     eval('$res = ' . $get . ';');
    return $res;
  }

  function get($field)
  {
    return $this->values[$field];
  }

  function getSummary()
  {
    $ret = "";
    while (list($key, $value)=each($this->values))
    {
       $ret .= "$key = $value\n";
    }   
    return $ret;
  }

}


class SeminarEntry extends BaseBibtexEntry {
  function SeminarEntry($seminarfile, $entryname)
  {
    parent::BibtexEntry($seminarfile, $entryname);
    $this->entrytype = "SEMINAR";
    $this->values['KEY'] = $entryname;
    if (substr($this->values['KEY'],0,1)=="?") {
    	$this->values['KEY'] = substr($entryname,1);
    }
  }

  function getList($dourl = true) {
    $key    =trim(parent::get("KEY"));
    $title  =trim(parent::get("TITLE"));
    $author =trim(parent::get("AUTHOR"));   
    $author_url=trim(parent::get("AUTHOR_URL"));  
    $conf    =trim(parent::get("CONF"));         
    $conf_url=trim(parent::get("CONF_URL"));   

    //2.6:
    $where     =trim(parent::get("WHERE"));
    $when      =trim(parent::get("WHEN"));

    if ( $to_be_confirmed =trim(parent::get("TBC")) ) {
	 $color = "%gray%";
    } else {
	 $color = "";
    }	    

    // $date = substr($key,0,4) . "/" . substr($key,4,2) . "/" . substr($key,6,2);
    $date =  substr($key,6,2) . "/"  . substr($key,4,2) .  "/" . substr($key,0,4);


    if ( $author ) {
       if ( $author_url ) {
            $speaker  = "[[ $author_url | $author ]]";
       } else {
            $speaker  = $author;         
       } 
    } else {   
       if ( $conf_url ) {
            $speaker  = "[[ $conf_url | $conf ]]";
       } else {
            $speaker  = $conf;         
       } 
    }   
 
    //2.6:
    return  "||[[#LIST$key]]$color$date ($when@$where) ||$color$speaker ||'''[[#KEY$key|$color$title]]'''\n";
  }



  function getSummary($dourl = true)
  {
    $this->entryId+=1;
    
    $where     =trim(parent::get("WHERE"));   #Amphi Saphir 
    $when      =trim(parent::get("WHEN"));    #14h - 15h  
    $author    =trim(parent::get("AUTHOR"));         
    $author_url=trim(parent::get("AUTHOR_URL"));   
    $conf    =trim(parent::get("CONF"));         
    $conf_url=trim(parent::get("CONF_URL"));   
    $howpublish=trim(parent::get("HOWPUBLISHED")); # link to SLIDES / paper  
    $title     =trim(parent::get("TITLE"));
    $year      =trim(parent::get("YEAR"));
    $abstract  =trim(parent::get("ABSTRACT"));
    $abstract_html =trim(parent::get("ABSTRACT_HTML")); #preformatted
    $biography =trim(parent::get("BIOGRAPHY"));
    $keyword   =trim(parent::get("KEYWORD"));
    $note      =trim(parent::get("NOTE"));
    $key       =trim(parent::get("KEY"));   # @misc{KEY,
    

    
    if ( $where == "" ) {
	 $where = "Amphi Saphir";
    }
    if ( $when == "" ) {
	 $when = "14h - 15h";
    }

    
    $date = "";
    // $date =  substr($key,0,4) . "/" . substr($key,4,2) . "/" . substr($key,6,2);
    $date =   substr($key,6,2) . "/"  . substr($key,4,2) .  "/" . substr($key,0,4);
    $date .= ",  " . $when;


    
    $ret = "\n----\n[[#KEY$key]]\n\t ";

    if ( $to_be_confirmed =trim(parent::get("TBC")) ) {
	 $color = "%gray%";
	 $ret .= "\n|| 	 ||%red%''to be confirmed''\n";
    } else {
	 $color = "";
    }	    
    
    if ($date) {
      	$ret .= "\n||'''Date:''' ||$color$date";
    } else {
      	$ret .= "\n||'''Date:''' ||$colorTBD";
    }

    if ($where) {
      	$ret .= "\n||'''Room:''' ||$color$where";
    } else {
      	$ret .= "\n||'''Room:''' ||TBD";
    }


    if ( $author ) {
        $is_talk=1;
	$is_conf=0;
      	$ret .= "\n||'''Speaker:''' ||$color" . $author;
    } else if ($conf) {   
        $is_talk=0;
	$is_conf=1;
	$ret .= "\n||'''Conference:''' ||$color" . $conf;
    } else {
      	$ret .= "\n||'''Speaker:''' ||TBD";
    }
    
    if (  $author_url ) {  
       	$ret .= "\n||'''Web:''' ||$color" . $auth_url;
    } else if ($conf_url) {   
	$ret .= "\n||'''Web:''' ||$color" . $conf_url;
    }   

    if ($title) {
	if ($howpublished) {
      	    $ret .= "\n||'''Talk:''' ||[" . $howpublished ."|$color" . $title . "]'''";
	} else if ($to_be_confirmed) {
      	    $ret .= "\n||'''Talk:''' ||$color'''" . $title ."'''" ;
	} else {
            # no link... yet!
      	    $ret .= "\n||'''Talk:''' ||%navy%'''" . $title ."'''" ;
	}
    } else {
      	$ret .= "\n||'''Talk:''' ||TBD";
    }
    
    if ($abstract) {
      	$ret .= "\n||'''Abstract:''' ||$color" . $abstract . "";
    } else if ($abstract_html) {
      	$ret .= "\n||'''Abstract:''' ||[=" . $abstract_html . "=]";
    }
    
    
    if ($biography) {
	      $ret .= "\n||'''Biography:''' ||$color" . $biography;
    } 
    if ($note) {
	      $ret .= "\n||'''Note:''' ||$color"  	. $note;
    } 
    if ($keyword) {
	      $ret .= "\n||'''Keyword:''' ||$color" 	. $keyword;
    } 
    

    #     # General form for futher fields
    #     if ($x) {
    #       	$ret .= "(" . $x .")" 
    #     } else {
    #       	$ret .= "(x TBD)"
    #     }
    $ret .= "\n||'''Links:''' ||''back to the [[#LIST$key|list item]], [[#LISTTOP| list top]] or [[#SUMMARYTOP| summary top]]''\n";

    return $ret ;

  }

}



#===============================================
#  Query and PMWiki stuff
#-----------------------------------------------


function SeminarSortByDate($a, $b)
{
  # due to KEY format, sort by DATE = sort by KEY!!!
  
  $f1 = substr( $a->get("KEY"), 0, 8 ); # YYYYMMDD
  $f2 = substr( $b->get("KEY"), 0, 8 );

  if ($f1 == $f2) { 
    $f1 = substr( $a->get("WHEN"), 0, 2 );
    $f2 = substr( $b->get("WHEN"), 0, 2 );
    # look for time in WHEN ... e.g, 16h > 12h

    if ($f1 == $f2) return 0;
    return ($f1 < $f2) ? -1 : 1;  
  } 
  return ($f1 < $f2) ? -1 : 1;
}


function SeminarQuery($files,$action)
{
  
  global $SeminarEntries, $SortField, $SeminarBullet_or_Counter;

  $files = trim($files);
  $cond = trim($cond);
  $sort = trim($sort);

  #if ($sort[0] == '!') { $reverse = true; $sort = substr($sort, 1); }
  #else $reverse = false;


  if (!$SeminarEntries[$files]) ParseSeminarFile($files);

  $now = 0 + substr(date('Ymd'),0,8); #like the entry name!
  $res = array();
  $seminarselectedentries = $SeminarEntries[$files];
  while (list($key, $value)=each($seminarselectedentries))
    {
    	$entryname = $value->get('KEY');
	if (substr($entryname,1)=="?") {
           $date = 0 + substr($entryname,1,8);
        } else {
      	   $date = 0 + substr($entryname,0,8);
	}   

 	if ( $action == "ALL" ) {
	   $res[] = $value;
	} else if ( $action == "PREV" ) {
	   if ( $date < $now )  {
	   	$res[] = $value;
	   }	
	} else if ( $action == "NEXT" ) {
	   if ( $date >= $now )  {
	   	$res[] = $value;
	   }	
	} else if ( substr($action,0,2) == "20" ) { #by year
           if ( $action == substr( $date,0,4) ) {
                $res[] = $value; 
           }    
        }   
	   
    }

  usort($res, "SeminarSortByDate");
  #most recent first:
  if ( $action == "PREV" ) { 
 	 $res = array_reverse($res);
  }	 
  if ( $action == "ALL" ) { 
 	 $res = array_reverse($res);
  }	 
  if ( substr($action,0,2) == "20" ) { 
         $res = array_reverse($res);
  }      

  
   $retS = "[[#SUMMARYTOP]]\n"; 
   $retL = "[[#LISTTOP]]\n";
   $oldyr = -1;
    while (list($key, $value)=each($res))
    {
       ##v2.4 -- split "ALL by YEAR"
       if ( $action == "ALL" ) {
       $entryname = $value->get('KEY');
       if (substr($entryname,1)=="?") {
           $year = 0 + substr($entryname,1,4);
        } else {
      	   $year = 0 + substr($entryname,0,4);
       }   
       if ($year != $oldyr) {
	 if ($oldyr > 0) {
	 	$retL .= "----\n" ;
	 }	
         $retL .= "!!" . $year . "\n";
	 $oldyr = $year;
       }
      }

      $unwanted = array("{", "}", "\\");

      $list = $value->getList();
      $list = str_replace($unwanted, "",  $list);
      $retL .= $SeminarBullet_or_Counter . $list . "\n";
      
      $summary = $value->getSummary();
      $summary = str_replace($unwanted, "",  $summary);

      $retS .= $SeminarBullet_or_Counter . $summary . "\n";
    }

  return $retL . $retS;
}


#===============================================
#  Parse Seminar files
#-----------------------------------------------



function HandleSeminarEntry($pagename)
{
  global $HTTP_GET_VARS, $PageStartFmt, $PageEndFmt, $PageHeaderFmt, $ScriptUrl, $seminarentry, $seminarfile, $seminarref;
  $seminarfile = $HTTP_GET_VARS['seminarfile'];
  $seminarref = $HTTP_GET_VARS['seminarref'];
  SDV($ScriptUrl, FmtPageName('$PageUrl', $pagename));

  $seminarentry = GetSeminarEntry($seminarfile, $seminarref);

  $page = array('timefmt'=>@$GLOBALS['CurrentTime'],
		'author'=>@$GLOBALS['Author']);
//  SetPageVars($pagename,$page, (seminarentry != false ? $seminarentry->getTitle() : ""));

  $PageHeaderFmt = "";
  SDV($HandleBibtexFmt,array(&$PageStartFmt,
    'function:PrintSeminarEntry',&$PageEndFmt));
  PrintFmt($pagename,$HandleBibtexFmt);
}


function PrintSeminarEntry()
{
  global $seminarentry, $seminarfile, $seminarref, $pagename;
  if ($seminarentry == false) echo MarkupToHTML($pagename, "%red%(PrintSeminarEntry)Invalid SeminarTex Entry: [" . $seminarfile . ", " . $seminarref . "]!");
  else
    {
      echo MarkupToHTML($pagename, $seminarentry->getSolePageEntry());
    }
}

function GetSeminarEntry($seminar, $ref)
{
    global $SeminarEntries;
    $ref = trim($ref);
    $seminar = trim($seminar);
    $seminartable = $SeminarEntries[$seminar];
    if ($seminartable == false)
    {
      ParseSeminarFile($seminar);
      $seminartable = $SeminarEntries[$seminar];
    }
    $seminarref = $seminartable[$ref];
    if ($seminarref == false)
      return false;
    return $seminarref;
}


function CompleteSeminarEntry($seminar, $ref)
{
  $entry = GetSeminarEntry($seminar, $ref);
  if ($entry == false) return "%red%(CompleteSeminarEntry)Invalid SeminarTex Entry!";
  return $entry->getCompleteEntry();
}

function SeminarSummary($seminar, $ref)
{
  $entry = GetSeminarEntry($seminar, $ref);
  if ($entry == false) return "%red%(SeminarSummary)Invalid SeminarTex Entry!" . $seminar . "," . $ref;
  return $entry->getSummary();
}

function ParseSeminarEntries($fname, $entries)
{
   global $SeminarEntries;
   // entries is a array with already splitted seminar file
   // $entries[0] -> not interessting
   // $entries[1] -> array filled with entries type
   // $entries[2] -> array filled with entries key
   // $entries[3] -> array filled with the key = value....
   $nb_entries = count($entries[0]);

   $seminarfileentry = array();
   for ($i = 0 ; $i < $nb_entries ; ++$i)
   {
      $entrytype = strtoupper($entries[1][$i]);
      $entryname = $entries[2][$i];

      if ($entrytype == "MISC") $entry = new SeminarEntry($fname, $entryname);
      else  $entry = new BaseBibtexEntry($fname, $entryname);

      // match all keys
      preg_match_all("/(\w+)\s*=\s*([^¶]+)¶?/", $entries[3][$i], $all_keys);

      // for seminar sort
      $entry->value['KEY'] = $entryname;
      for ($j = 0 ; $j < count($all_keys[0]) ; $j++)
      {
	$key = strtoupper($all_keys[1][$j]);
	$value = $all_keys[2][$j];
	// Remove the leading and ending braces or quotes if they exist.
	$value = preg_replace('/^\s*{(.*)}\s*$/', '\1', $value);
	// TODO: only run this regexp if the former didn't match
	$value = preg_replace('/^\s*"(.*)"\s*$/', '\1', $value);

	$entry->values[$key] = $value;
         // $all_keys[0] -> not interessting
         // $all_keys[1] -> array filled with keys
         // $all_keys[2] -> array filled with values
      }
      $seminarfileentry[$entryname] = $entry;
   }

   $SeminarEntries[$fname] = $seminarfileentry;
}


function ParseSeminar($seminar_file, $seminar_file_string)
{
// first split the seminar file into several part
// first let's do an ugly trick to replace the first { and the last } of each seminar entry by another special char (to help with regexp)

   $count=0;
   for ($i = 0 ; $i < strlen($seminar_file_string) ; $i++)
   {
      if ($seminar_file_string[$i] == '{')
      {
         if ($count==0)
            $seminar_file_string[$i] = '?';
         $count++;
      }
      else if ($seminar_file_string[$i] == '}')
      {
         $count--;
         if ($count==0)
            $seminar_file_string[$i] = '?';
      }
      else if ($seminar_file_string[$i] == ',' && $count == 1)
	 $seminar_file_string[$i] = '¶';
   }

   $nb_seminarentry = preg_match_all("/@(\w+)\s*?\s*([^¶]+)¶([^?]*)?/", $seminar_file_string, $matches);
   ParseSeminarEntries($seminar_file, $matches);
}

function ParseSeminarFile($seminar_file)
{
   global $BibtexSeminarDir, $pagename;

   $seminar_file_string = "";
   
   foreach (glob($BibtexSeminarDir . "/" . $seminar_file) as $filename) 
   {         
   
       if ( $f = fopen($filename, "r") ) 
       {
	  while (!feof($f))
	  {
             $seminar_file_string = $seminar_file_string . fgets($f);
	  }

       } else {
           print "<font color=#FF0000>Can't open file $filename</font><br>\n";
       }	   
   }
   $seminar_file_string = preg_replace("/\n/", "", $seminar_file_string);

   # READs the file Ok;
   #	print "$seminar_file_string";
   ParseSeminar($seminar_file, $seminar_file_string);
   
   return true;
   return false;
}

?>
