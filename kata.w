@ This is my kata.

@*Test harness by c.
@c
void setup();
#define TEST_F(SUITE, NAME) void NAME()
#define RUN_TEST(SUITE, TESTNAME) printf(" Running %s.%s: \n", #SUITE, #TESTNAME); setup(); TESTNAME(); printf(" SUCCESS\n");
#define ASSERT_EQ(A, B) assert((A) == (B))
#define ASSERT_TRUE(A) assert((A))

@ include header file for test harness.
@c
#include <assert.h>
#include <stdio.h>
#include <string.h>

@ main code.
@c
TEST_F(mytest, simple_test)
{
   ASSERT_TRUE(0);
}

int main(int argc, char* argv[])
{
   ASSERT_EQ(42, 6*7);

   RUN_TEST(mytest, simple_test);
   return 0;
}

void setup()
{}

