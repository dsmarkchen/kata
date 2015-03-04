@ This is my kata.
Below is the overall structure of the code.
@c
@<macro definitions@>
@<includes@>@;
@<tests@>@;
@<routines@>@;
@<main@>@;


@*Test harness by c.
@<macr...@>+=
void setup();
#define TEST_F(SUITE, NAME) void NAME()
#define RUN_TEST(SUITE, TESTNAME) printf(" Running %s.%s: \n", #SUITE, #TESTNAME); setup(); TESTNAME(); printf(" SUCCESS\n");
#define ASSERT_EQ(A, B) assert((A) == (B))
#define ASSERT_TRUE(A) assert((A))

@ include header file for test harness.
@<incl...@>+=
#include <assert.h>
#include <stdio.h>
#include <string.h>

@ main code.
@<main@>+=
int main(int argc, char* argv[])
{
   RUN_TEST(mytest, simple_test_harness);
   RUN_TEST(mytest, test_given_i_returns_1);
   RUN_TEST(mytest, test_given_ii_returns_2);
   RUN_TEST(mytest, test_given_iii_returns_3);
   RUN_TEST(mytest, test_given_iv_returns_4);
   RUN_TEST(mytest, test_given_v_returns_5);
   RUN_TEST(mytest, test_given_vi_returns_6);
   RUN_TEST(mytest, test_given_vii_returns_7);
   RUN_TEST(mytest, test_given_viii_returns_8);
   RUN_TEST(mytest, test_given_ix_returns_9);
   RUN_TEST(mytest, test_given_xii_returns_12)
   RUN_TEST(mytest, test_given_xviii_returns_18)
   RUN_TEST(mytest, test_given_xxxix_returns_39)


   return 0;
}

@ Test.
@<test...@>+=
TEST_F(mytest, simple_test_harness)
{
   ASSERT_TRUE(1);
   ASSERT_EQ(42, 6*7);
}

@ Roman numbers
@<test...@>+=
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




@ @<rout...@>+=
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
        ch = str_in[pos++];
        ch2 = str_in[pos];
        if(ch == 'i') {
            r1 = r1+1;
            sub = 1;
        }
        if(ch == 'v') {
            if(sub) {
                r = r+ 5-r1;
                r1 = 0;
            }
            else 
                r = r+5;
            sub = 0;
        }
        if(ch == 'x') {
            if(sub) {
               r = r + 10 - r1;
               r1 = 0;
            }
            else 
               r = 10+r;
            sub = 0;
        }
        if(ch2 == 0) { 
           // printf ("### %d__%d\n",r,r1);
            return r+r1;
        }
        
    } 
   
   
    return 0;
    

 }

@ Harness setup.
@<rout...@>+= 
void setup()
{
}

