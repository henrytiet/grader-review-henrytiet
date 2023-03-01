CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning.'

cd student-submission 
if [[ -f ListExamples.java ]]
then
    echo "ListExamples found!"
else
    echo "ListExamples NOT FOUND."
    exit 1
fi

cp ../TestListExamples.java ./
if [[ -f TestListExamples.java ]]
then
    echo "TestListExamples.java copied."
else
    echo "TestListExamples.java NOT FOUND."
    exit 2
fi

javac -cp $CPATH *.java 2> compile.txt
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt

if grep -q "error" compile.txt
then
    echo COMPILER ERROR
    exit 3
fi

if grep -q "timed out" output.txt
then 
    echo TIMED OUT 
    exit 4
fi

if grep -q "OK" output.txt 
then
    echo Success!
    exit 0
fi