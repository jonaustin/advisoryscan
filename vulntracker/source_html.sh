#!/bin/sh

# WARNING: rm -rf will be called on this dir, check twice!!
# use absolute paths
source_html_dir='/home/jon/projects/code/vulntracker/python/vulntracker/source_html/'

source_dir='/home/jon/projects/code/vulntracker/python/vulntracker/'

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
for n in `find . -iname "*py"`; do python /usr/local/bin/lpy.py $n; done

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
    # apparently apache is set up on dreamhost to process .py files even if they have .html extension
    # only mv if *py.html, otherwise cp (template file)
    myfile=`basename $html_file`;
    if test `echo $myfile|grep "\.py\.html"`;
    then
        myfile=`echo $myfile | sed 's#\.py#_py#'`;
        mv $html_file ${mynewdir}/$myfile;
    else
        cp $html_file $mynewdir;
    fi
done

cp source_html.sh ${source_html_dir}/source_html.sh.html
sed -i ${source_html_dir}/source_html.sh.html -e 's#$#<br />#'
