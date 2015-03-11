@ This is my kata.
Below is the overall structure of the code.
@c
@<macro definitions@>@;
@<includes@>@;
@<routines@>@;
@<tests@>@;
@<main@>@;


@*Test harness by c.
@<macr...@>+=
void setup();
#define TEST_F(@[SUITE, NAME@]) void NAME()
#define RUN_TEST(@[SUITE, TESTNAME@]) printf(" Running %s.%s: \n", #SUITE, #TESTNAME); setup(); TESTNAME(); printf(" SUCCESS\n");
#define ASSERT_EQ(@[A, B@]) assert((A) == (B))
#define ASSERT_TRUE(@[A@]) assert((A))

@ include header file for test harness.
@<incl...@>+=
#include <assert.h>
#include <stdio.h>
#include <string.h>

@ main code.
@d  UNUSED __attribute__ (( unused ))
@<main@>+=

int main(int argc @, UNUSED, char*  argv[] @, UNUSED)
{
   @<c harness tests@>@; 
   @<roman number tests@>@;
   @<isbn tests@>@;
  
   return 0;
}

@ Test
@<c harness tests@>+= 
RUN_TEST(mytest, simple_test_harness);    

@ @<test...@>+=
TEST_F(mytest, simple_test_harness)
{
   ASSERT_TRUE(1);
   ASSERT_EQ(42, 6*7);
}


@ Roman numbers 
@<roman number tests@>+=
RUN_TEST(mytest, test_given_i_returns_1);
RUN_TEST(mytest, test_given_ii_returns_2);
RUN_TEST(mytest, test_given_iii_returns_3);
RUN_TEST(mytest, test_given_iv_returns_4);
RUN_TEST(mytest, test_given_v_returns_5);
RUN_TEST(mytest, test_given_vi_returns_6);
RUN_TEST(mytest, test_given_vii_returns_7);
RUN_TEST(mytest, test_given_viii_returns_8);
RUN_TEST(mytest, test_given_ix_returns_9);
RUN_TEST(mytest, test_given_xii_returns_12);
RUN_TEST(mytest, test_given_xviii_returns_18);
RUN_TEST(mytest, test_given_xxxix_returns_39);
RUN_TEST(mytest, test_given_liv_returns_54);
RUN_TEST(mytest, test_given_lxix_returns_69);
RUN_TEST(mytest, test_given_dxvii_returns_517);
RUN_TEST(mytest, test_given_mcmxc_returns_1990);

@ @<test...@>+=
TEST_F(mytest, test_given_i_returns_1)
{
    char* s = "i";
    int r = converter(s);
    ASSERT_EQ(1, r);
}
@ @<test...@>+=
TEST_F(mytest, test_given_ii_returns_2)
{
    char* s = "ii";
    int r = converter(s);
    ASSERT_EQ(2, r);
}
@ @<test...@>+=
TEST_F(mytest, test_given_iii_returns_3)
{
    char* s = "iii";
    int r = converter(s);
    ASSERT_EQ(3, r);
}
@ @<test...@>+=
TEST_F(mytest, test_given_iv_returns_4)
{
    char* s = "iv";
    int r = converter(s);
    ASSERT_EQ(4, r);
}
@ @<test...@>+=
TEST_F(mytest, test_given_v_returns_5)
{
    char* s = "v";
    int r = converter(s);
    ASSERT_EQ(5, r);
}

@ @<test...@>+=
TEST_F(mytest, test_given_vi_returns_6)
{
    char* s = "vi";
    int r = converter(s);
    ASSERT_EQ(6, r);
}
TEST_F(mytest, test_given_vii_returns_7)
{
    char* s = "vii";
    int r = converter(s);
    ASSERT_EQ(7, r);
}

TEST_F(mytest, test_given_viii_returns_8)
{
    char* s = "viii";
    int r = converter(s);
    ASSERT_EQ(8, r);
}

@ @<test...@>+=
TEST_F(mytest, test_given_ix_returns_9)
{
    char* s = "ix";
    int r = converter(s);
    ASSERT_EQ(9, r);
}
TEST_F(mytest, test_given_xii_returns_12)
{
    char* s = "xii";
    int r = converter(s);
    ASSERT_EQ(12, r);
}

TEST_F(mytest, test_given_xviii_returns_18)
{
    char* s = "xviii";
    int r = converter(s);
    ASSERT_EQ(18, r);
}


TEST_F(mytest, test_given_xxxix_returns_39)
{
    char* s = "xxxix";
    int r = converter(s);
    ASSERT_EQ(39, r);
}

@ Test of L.
@<test...@>+=
TEST_F(mytest, test_given_liv_returns_54)
{
    char* s = "liv";
    int r = converter(s);
    ASSERT_EQ(54, r);
}

TEST_F(mytest, test_given_lxix_returns_69)
{
    char* s = "lxix";
    int r = converter(s);
    ASSERT_EQ(69, r);
}


@ Test to 'D', 'C', 'M'.

@<test...@>+=
TEST_F(mytest, test_given_dxvii_returns_517)
{
    char* s = "dxvii";
    int r = converter(s);
    ASSERT_EQ(517, r);
}


TEST_F(mytest, test_given_mcmxc_returns_1990)
{
    char* s = "mcmxc";
    int r = converter(s);
    ASSERT_EQ(1990, r);
}




@ Converter.
@<rout...@>+=
int get(char ch);
int comp(char ch, char ch2);

int converter(char* str_in)
{
    int r = 0;
    int r1 = 0;
    int pos = 0;
    char ch = 0;
    char ch2 = 0;
    int sub = 0;     
    for(;;) 
    { 
        @<get current charactor |ch| and it's next |ch2|@>@;

        @<convert to number |r1| and compare for a sign |sub|@>@; 

        @<calculate the result |r| with sign |sub| @>@;
       
        if(ch2 == 0) break; /* end if no more*/
    } 

    return r;
}

@ @<get current charactor |ch| and it's next |ch2|@>=
ch = str_in[pos++];
ch2 = str_in[pos];

@ @<convert to number |r1| and compare for a sign |sub|@>= 
r1 = get(ch); 
sub = comp(ch, ch2);

@ @<calculate the result |r| with sign |sub| @>=
if(sub > 0) 
    r = r - r1;
else 
    r = r + r1;


@ The two key functions.
@<rout...@>+=
int comp(char ch, char ch2)
{
    int j;
    int k;
    j = get(ch);
    k = get(ch2);
   
    if(k > j ) return 1;
    return 0; 
}

int get(char ch)
{
    char pattern_c[] = {'i', 'v', 'x', 'l', 'c', 'd',  'm'};
    int  pattern_n[] = { 1,   5,   10,  50, 100, 500, 1000};
    int j = -1;
    int i;
    for(i=0;i<7;i++) {
        if(ch == pattern_c[i]){
            j = pattern_n[i];
            break;
        }
    }
    return j;
}

@ ISBN-13.
@<isbn tests@>+=
RUN_TEST(mytest, test_given_9780470059029_returns_1);
RUN_TEST(mytest, test_given_9780471486480_with_spaces_returns_1);
RUN_TEST(mytest, test_given_9780262134729_with_hyphens_returns_1);
RUN_TEST(mytest, test_given_9780470059029x_returns_0);
RUN_TEST(mytest, test_given_9788889527190_returns_0);


@ @<test...@>+=
TEST_F(mytest, test_given_9780470059029_returns_1)
{
    char* s = "9780470059029";
    int r = isbn13_check(s);
    ASSERT_EQ(1, r);
}
TEST_F(mytest, test_given_9780471486480_with_spaces_returns_1)
{
    char* s = "978 0 471 48648 0";
    int r = isbn13_check(s);
    ASSERT_EQ(1, r);
}
TEST_F(mytest, test_given_9780262134729_with_hyphens_returns_1)
{
    char* s = "978-0-262-13472-9";
    int r = isbn13_check(s);
    ASSERT_EQ(1, r);
}


@ Error checking.
@<test...@>+=
TEST_F(mytest, test_given_9780470059029x_returns_0)
{
    char* s = "9780470059029x";
    int r = isbn13_check(s);
    ASSERT_EQ(0, r);
}

@ Below the test will fail if we check the last digit.
@<test...@>+=
TEST_F(mytest, test_given_9788889527190_returns_0)
{
    char* s = "9788889527190";
    int r = isbn13_check(s);
    ASSERT_EQ(0, r);
}



@
@d ISBN_DATA_LEN 12
@d ISBN_CHECK_LEN 1
@d ISBN_LEN (ISBN_DATA_LEN +ISBN_CHECK_LEN)

 @<rout...@>+=
int isbn13_check(char* s)
{
    int ret = 0;
    int i;
    int sum = 0;
    int n = strlen(s);
    int counter = 0;
    int x;
    if(n < ISBN_LEN) return 0;
    for(i=0;i<n;i++) {
        if(s[i] == ' ' || s[i] == '-')continue;
        
        if(s[i] >= '0' && s[i] <='9') {
            
            x = s[i] - '0';

            if(counter < ISBN_DATA_LEN) {
                @<handle isbn13 data digit@>@;
                continue;
            }
        }
        if(counter == ISBN_LEN -1) {
            @<handle isbn13 check digit@>@;
            continue;
        }
        return 0; /* invalid charactors or exceed length return false */
    }

    return ret;
}
@ @<handle isbn13 data digit@>=
sum = sum +(s[i] - '0') * ((counter%2 == 0) ? 1:3) ;
counter++;

@ @<handle isbn13 check digit@>=
sum = sum%10;
sum = (10 - sum)%10;
if(x == sum) {
    ret = 1;
}
counter ++;
       
@ ISBN 10.
@<isbn tests@>+=
RUN_TEST(mytest, test_given_0471958697_returns_1);
RUN_TEST(mytest, test_given_0471606952_with_spaces_returns_1);
RUN_TEST(mytest, test_given_184146208x_returns_1);
RUN_TEST(mytest, test_given_184146208x0_returns_0);
RUN_TEST(mytest, test_given_04719586972_returns_0)

@ @<test...@>+=
TEST_F(mytest, test_given_0471958697_returns_1)
{
    char* s = "0471958697";
    int r = isbn10_check(s);
    ASSERT_EQ(1, r);
}

TEST_F(mytest, test_given_0471606952_with_spaces_returns_1)
{
    char* s = "0 471 60695 2";
    int r = isbn10_check(s);
    ASSERT_EQ(1, r);
}

TEST_F(mytest, test_given_184146208x_returns_1)
{
    char* s = "184146208x";
    int r = isbn10_check(s);
    ASSERT_EQ(1, r);
}
TEST_F(mytest, test_given_184146208x0_returns_0)
{
    char* s = "184146208x0";
    int r = isbn10_check(s);
    ASSERT_EQ(0, r);
}
TEST_F(mytest, test_given_04719586972_returns_0)
{
    char* s = "04719586972";
    int r = isbn10_check(s);
    ASSERT_EQ(0, r);
}

@ 
@d ISBN10_DATA_LEN 9
@<rout...@>+=
int isbn10_check(char* s)
{
    int r = 0;
    int i;
    int n = strlen(s);
    int counter = 0;
    int sum = 0;
    for(i=0;i<n;i++) {
        if(s[i] == ' ' || s[i] == '-')continue;
        if(s[i] >= '0' && s[i] <='9') {

            if(counter < ISBN10_DATA_LEN) {
                @<handle isbn10 data digit@>@;
                continue;
            }
        } 

        if(counter == ISBN10_DATA_LEN) {
            @<handle isbn10 check digit@>@;
        }   

        return 0; /* invalid charactors or exceed length return false */
    }

    return r;
}

@ @<handle isbn10 data digit@>=
sum += (counter+1)*(s[i] - '0');
counter++;
@ @<handle isbn10 check digit@>=
sum = sum % 11;

if((s[i]-'0' == sum)||
    (s[i] == 'x' && sum == 10)) {
   r = 1;
   continue;
}

@ Harness setup.
@<rout...@>+= 
void setup()
{
}

@* Index.
