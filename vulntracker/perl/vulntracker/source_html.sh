#!/bin/sh

# WARNING: rm -rf will be called on this dir, check twice!!
# use absolute paths
source_html_dir='/home/jon/projects/code/vulntracker/perl/vulntracker/source_html/'

source_dir='/home/jon/projects/code/vulntracker/perl/vulntracker/'

# remove current html files
#find . -iname "*html"|xargs rm
if [ ! $source_html_dir ];
then
    echo "Please define source_html_dir\n";
else
    rm -rf ${source_html_dir}/*;
fi

if [ ! -d $source_html_dir ]; 
then 
    mkdir $source_html_dir; 
fi; 

# create new html files
for n in `find . -iname "*pm"`; do perltidy --html -nnn $n; done
for n in `find . -iname "*pl"`; do perltidy --html -nnn $n; done

# create correct dir structure in source_html_dir and move files
for html_file in `find . -iname "*.html"`; 
do 
    mydir=`dirname $html_file`; 
    if [ $mydir == '.' ];
    then
        mydir='';
    else
        mydir=`echo $mydir | sed 's#\./##'`;
    fi
    mynewdir=${source_html_dir}/$mydir;
    if [ ! -d $mynewdir ];
    then
        mkdir -p $mynewdir;
    fi
    # apparently apache is set up on dreamhost to process .pl files even if they have .html extension
    myfile=`basename $html_file`;
    if test `echo $myfile|grep "\.pl"`;
    then
        myfile=`echo $myfile | sed 's#\.pl#_pl#'`;
        mv $html_file ${mynewdir}/$myfile;
    else
        mv $html_file $mynewdir;
    fi
done

cp source_html.sh ${source_html_dir}/source_html.sh.html
sed -i ${source_html_dir}/source_html.sh.html -e 's#$#<br />#'
