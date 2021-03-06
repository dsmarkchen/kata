@ This is my kata.
Below is the overall structure of the code.
@c
@<macro definitions@>@;
@<includes@>@;
@<type definitions@>@;
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
   @<yatzy tests@>@;
   @<prime number tests@>@;
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

@* Yatzy.
@<type...@>+=
typedef enum {
    chance, yatzy,                          @/
    ones, twos, threes,fours,fives, sixes,  @/
    pair, two_pairs,                        @/
    three_of_kind, four_of_kind,            @/ 
    small_straight, large_straight,
    full_house
} yatzy_category_t;

int yatzy_score(yatzy_category_t cat, int* data);

@ @<yatzy tests@>=
RUN_TEST(mytest, test_chance_1_1_3_3_6_returns_14);

RUN_TEST(mytest, test_yatzy_1_1_1_1_1_returns_50);
RUN_TEST(mytest, test_yatzy_1_1_1_2_1_returns_0);

RUN_TEST(mytest, test_fours_1_1_2_4_4_returns_8);
RUN_TEST(mytest, test_ones_3_3_3_4_5_returns_0);

RUN_TEST(mytest, test_pair_3_3_3_4_4_returns_8);
RUN_TEST(mytest, test_pair_1_1_6_2_6_returns_12);
RUN_TEST(mytest, test_pair_3_3_3_4_1_returns_0);


RUN_TEST(mytest, test_twopairs_1_1_2_3_3_returns_8);
RUN_TEST(mytest, test_twopairs_1_1_2_2_2_returns_0);


@ @<test...@>=

TEST_F(mytest, test_chance_1_1_3_3_6_returns_14)
{
    int expected_i = 14;
    int d[5] = {1,1,3,3,6};
    int r = yatzy_score(chance, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_yatzy_1_1_1_1_1_returns_50)
{
    int expected_i = 50;
    int d[5] = {1,1,1,1,1};
    int r = yatzy_score(yatzy, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_yatzy_1_1_1_2_1_returns_0)
{
    int expected_i = 0;
    int d[5] = {1,1,1,2,1};
    int r = yatzy_score(yatzy, d);
    ASSERT_EQ(expected_i, r);
}

TEST_F(mytest, test_fours_1_1_2_4_4_returns_8)
{
    int expected_i = 8;
    int d[5] = {1,1,2,4,4};
    int r = yatzy_score(fours, d);
    ASSERT_EQ(expected_i, r);
}

TEST_F(mytest, test_ones_3_3_3_4_5_returns_0)
{
    int expected_i = 0;
    int d[5] = {3,3,3,4,5};
    int r = yatzy_score(ones, d);
    ASSERT_EQ(expected_i, r);
}

TEST_F(mytest, test_pair_3_3_3_4_4_returns_8)
{

    int expected_i = 8;
    int d[5] = {3,3,3,4,4};
    int r = yatzy_score(pair, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_pair_1_1_6_2_6_returns_12)
{

    int expected_i = 12;
    int d[5] = {1,1,6,2,6};
    int r = yatzy_score(pair, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_pair_3_3_3_4_1_returns_0)
{

    int expected_i = 0;
    int d[5] = {3,3,3,4,1};
    int r = yatzy_score(pair, d);
    ASSERT_EQ(expected_i, r);
}

TEST_F(mytest, test_twopairs_1_1_2_3_3_returns_8)
{

    int expected_i = 8;
    int d[5] = {1,1,2,3,3};
    int r = yatzy_score(two_pairs, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_twopairs_1_1_2_2_2_returns_0)
{

    int expected_i = 0;
    int d[5] = {1,1,2,2,2};
    int r = yatzy_score(two_pairs, d);
    ASSERT_EQ(expected_i, r);
}

@ @<yatzy tests@>+=
RUN_TEST(mytest, test_threekind_3_3_3_4_5_returns_9);
RUN_TEST(mytest, test_threekind_3_3_4_5_6_returns_0);
RUN_TEST(mytest, test_threekind_3_3_3_3_1_returns_0);
@ @<test...@>+=
TEST_F(mytest, test_threekind_3_3_3_4_5_returns_9)
{

    int expected_i = 9;
    int d[5] = {3,3,3,4,5};
    int r = yatzy_score(three_of_kind, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_threekind_3_3_4_5_6_returns_0)
{

    int expected_i = 0;
    int d[5] = {3,3,4,5,6};
    int r = yatzy_score(three_of_kind, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_threekind_3_3_3_3_1_returns_0)
{

    int expected_i = 0;
    int d[5] = {3,3,3,3,1};
    int r = yatzy_score(three_of_kind, d);
    ASSERT_EQ(expected_i, r);
}



@ @<rout...@>+=
int yatzy_score(yatzy_category_t cat, int* data)
{
    int i;
    int r = 0;
    int p1 = 0; /*pair of 1*/
    int p2 = 0; /*pair of 2*/
    int p3 = 0; /*pair of 3*/
    int p4 = 0;
    int p5 = 0;
    int p6 = 0; /*pair of 6*/
    int pair_count = 0;
    @<declare three kind variables@>@;
    @<declare four kind variables@>@;
    if(data == 0) return 0;
    if(cat == chance) {
        for(i =0 ;i<5;i++) {
            r = r + data[i];
        }
    }
    if (cat == yatzy) {
        if(data[0] == data[1] &&
                data[1] == data[2] &&
                data[2] == data[3] &&
                data[3] == data[4])
            r = 50; 
    }
    @<scrore on ones,twos,threes, to sixes@>@;
    @<score on pair@>@;
    @<score on two pairs@>@;
    @<score on three of a kind@>@;
    @<score on four of a kind@>@;
    if (cat == small_straight) {
        if(data[0] == 1 &&
                data[1] == 2 &&
                data[2] == 3 &&
                data[3] == 4 &&
                data[4] == 5) r = 15;
    }
    if (cat == large_straight) {
        if(data[0] == 2 &&
                data[1] == 3 &&
                data[2] == 4 &&
                data[3] == 5 &&
                data[4] == 6) r = 20;
    }
    if (cat == full_house) {
        r = score_full_house(data);
    }

    return r;
}
@ @<rout...@>+=
int find_pair(int r0, int* data)
{
    int i;
    int count = 0; 
    for(i=0; i< 5;i++) {
       if(r0 == data[i]) {
            count ++;
        } 
    }
    if(count == 2) return 1;
    return 0;
  
}
@ @<type...@>+=
int find_pair(int r0, int* data);


@ @<scrore on ones,twos,threes, to sixes@>=
if (cat == ones) {
    for(i = 0; i< 5;i++) {
        if(data[i] == 1) r  = r +1;
    }
}
if (cat == twos) {
    for(i = 0; i< 5;i++) {
        if(data[i] == 2) r  = r +2;
    }
}

if (cat == threes) {
    for(i = 0; i< 5;i++) {
        if(data[i] == 3) r  = r +3;
    }
}

if (cat == fours) {
    for(i = 0; i< 5;i++) {
        if(data[i] == 4) r  = r +4;
    }
}

if (cat == fives) {
    for(i = 0; i< 5;i++) {
        if(data[i] == 5) r  = r +5;
    }
}


if (cat == sixes) {
    for(i = 0; i< 5;i++) {
        if(data[i] == 6) r  = r +6;
    }
}

@ @<score on pair@>=
if (cat == pair) {
    p1 = find_pair(1, data);      
    p2 = find_pair(2, data);      
    p3 = find_pair(3, data);      
    p4 = find_pair(4, data);      
    p5 = find_pair(5, data);      
    p6 = find_pair(6, data);      
    if (p1 > 0) r = 2;
    if (p2 > 0) r = 4;
    if (p3 > 0) r = 6;
    if (p4 > 0) r = 8;
    if (p5 > 0) r = 10;
    if (p6 > 0) r = 12;
}
 
@ @<score on two pairs@>=
if (cat == two_pairs) {
    p1 = find_pair(1, data);      
    p2 = find_pair(2, data);      
    p3 = find_pair(3, data);      
    p4 = find_pair(4, data);      
    p5 = find_pair(5, data);      
    p6 = find_pair(6, data);      
    if (p1 > 0) {r = 2; pair_count++;}
    if (p2 > 0) {r += 4;pair_count++;}
    if (p3 > 0) {r += 6;pair_count++;}
    if (p4 > 0) {r += 8;pair_count++;}
    if (p5 > 0) {r += 10;pair_count++;}
    if (p6 > 0) {r += 12;pair_count++;}
    if(pair_count != 2) r = 0;
}
  
@ @<score on three of a kind@>=
if (cat == three_of_kind) {
   t1= find_three(1, data);
   t2= find_three(2, data);
   t3= find_three(3, data);
   t4= find_three(4, data);
   t5= find_three(5, data);
   t6= find_three(6, data);
    if (t1 > 0) r = 3;
    if (t2 > 0) r = 6;
    if (t3 > 0) r = 9;
    if (t4 > 0) r = 12;
    if (t5 > 0) r = 15;
    if (t6 > 0) r = 18;
}


@ @<declare three kind variables@>=
int t1,t2,t3,t4,t5,t6;
@ @<type...@>+=
int find_three(int r0, int* data);

@ @<rout...@>+=
int find_three(int r0, int* data)
{
    int i;
    int count = 0; 
    for(i=0; i< 5;i++) {
       if(r0 == data[i]) {
            count ++;
        } 
    }
    if(count == 3) return 1;
    return 0;

}
@ @<score on four of a kind@>=
if (cat == four_of_kind) {
   f1= find_four(1, data);
   f2= find_four(2, data);
   f3= find_four(3, data);
   f4= find_four(4, data);
   f5= find_four(5, data);
   f6= find_four(6, data);
    if (f1 > 0) r = 4;
    if (f2 > 0) r = 8;
    if (f3 > 0) r = 12;
    if (f4 > 0) r = 16;
    if (f5 > 0) r = 20;
    if (f6 > 0) r = 24;
}

@ @<declare four kind variables@>=
int f1,f2,f3,f4,f5,f6;

@ @<type...@>+=
int find_four(int r0, int* data);

@ @<rout...@>+=
int find_four(int r0, int* data)
{
    int i;
    int count = 0; 
    for(i=0; i< 5;i++) {
       if(r0 == data[i]) {
            count ++;
        } 
    }
    if(count == 4) return 1;
    return 0;

}
@ @<yatzy tests@>+=
RUN_TEST(mytest, test_fourkind_2_2_2_2_5_returns_8);
RUN_TEST(mytest, test_fourkind_2_2_2_5_5_returns_0);
RUN_TEST(mytest, test_fourkind_2_2_2_2_2_returns_0);
@ @<test...@>+=
TEST_F(mytest, test_fourkind_2_2_2_2_5_returns_8)
{

    int expected_i = 8;
    int d[5] = {2,2,2,2,5};
    int r = yatzy_score(four_of_kind, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_fourkind_2_2_2_5_5_returns_0)
{

    int expected_i = 0;
    int d[5] = {2,2,2,5,5};
    int r = yatzy_score(four_of_kind, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_fourkind_2_2_2_2_2_returns_0)
{

    int expected_i = 0;
    int d[5] = {2,2,2,2,2};
    int r = yatzy_score(four_of_kind, d);
    ASSERT_EQ(expected_i, r);
}


@ @<rout...@>+=
int score_full_house(int* data)
{
    int i;
    int fh1, fh2;  /* the two number of full house*/
    int fh1_c, fh2_c; /* the counter of full house */
    fh1_c = fh2_c = 0;
    fh2 =0;
    fh1 = data[0]; fh1_c = 1;
    for(i=1; i< 5;i++) {
        if((fh2 == 0) && (data[i] != fh1)) {
            fh2 = data[i];
            fh2_c ++;
            continue;
        }
        if(data[i] == fh1) {
            fh1_c ++;
            continue;
        }
        if(data[i] == fh2) {
            fh2_c ++;
            continue;
        }
    }
    if((fh1_c == 2 && fh2_c==3) ||
       (fh1_c == 3 && fh2_c==2 )) {
        return data[0] + data[1] + data[2] + data[3]+data[4];
    }
    return 0;
}

@ @<type...@>+=
int score_full_house(int* data);

@ @<yatzy tests@>+=
RUN_TEST(mytest, test_fullhouse_1_1_2_2_2_returns_8);
RUN_TEST(mytest, test_fullhouse_2_2_3_3_4_returns_0);
RUN_TEST(mytest, test_fullhouse_4_4_4_4_4_returns_0);

@ @<test...@>+=
TEST_F(mytest, test_fullhouse_1_1_2_2_2_returns_8)
{

    int expected_i = 8;
    int d[5] = {1,1,2,2,2};
    int r = yatzy_score(full_house, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_fullhouse_2_2_3_3_4_returns_0)
{

    int expected_i = 0;
    int d[5] = {2,2,3,3,4};
    int r = yatzy_score(full_house, d);
    ASSERT_EQ(expected_i, r);
}
TEST_F(mytest, test_fullhouse_4_4_4_4_4_returns_0)
{

    int expected_i = 0;
    int d[5] = {4,4,4,4,4};
    int r = yatzy_score(full_house, d);
    ASSERT_EQ(expected_i, r);
}



@* Prime number. Factorize a positive number
@<prime number tests@>=
RUN_TEST(mytest, test_given_2_returns_2);
RUN_TEST(mytest, test_given_3_returns_3);
RUN_TEST(mytest, test_given_4_returns_2_2);
RUN_TEST(mytest, test_given_6_returns_2_3);
RUN_TEST(mytest, test_given_12_returns_2_2_3);
RUN_TEST(mytest, test_given_15_returns_3_5);

RUN_TEST(mytest, test_given_21_returns_3_7);
RUN_TEST(mytest, test_given_35_returns_5_7);

RUN_TEST(mytest, test_given_147_returns_3_7_7);

@ 
@d MAX_PRIME_NUM 100
@<test...@>+=
TEST_F(mytest, test_given_2_returns_2)
{
    int d = 2;
    int d_out[MAX_PRIME_NUM];
    int c = fact_prime(d, d_out);
    ASSERT_EQ(1, c);
    ASSERT_EQ(2, d_out[0]);

}
TEST_F(mytest, test_given_3_returns_3)
{
    int d = 3;
    int d_out[MAX_PRIME_NUM];
    int c = fact_prime(d, d_out);
    ASSERT_EQ(1, c);
    ASSERT_EQ(3, d_out[0]);

}
TEST_F(mytest, test_given_4_returns_2_2)
{
    int d = 4;
    int d_out[MAX_PRIME_NUM];
    int c = fact_prime(d, d_out);
    ASSERT_EQ(2, c);
    ASSERT_EQ(2, d_out[0]);
    ASSERT_EQ(2, d_out[1]);

}
TEST_F(mytest, test_given_6_returns_2_3)
{
    int d = 6;
    int d_out[MAX_PRIME_NUM];
    int c = fact_prime(d, d_out);
    ASSERT_EQ(2, c);
    ASSERT_EQ(2, d_out[0]);
    ASSERT_EQ(3, d_out[1]);

}

TEST_F(mytest, test_given_12_returns_2_2_3)
{
    int d = 12;
    int d_out[MAX_PRIME_NUM];
    int c = fact_prime(d, d_out);
    ASSERT_EQ(3, c);
    ASSERT_EQ(2, d_out[0]);
    ASSERT_EQ(2, d_out[1]);
    ASSERT_EQ(3, d_out[2]);

}

TEST_F(mytest, test_given_15_returns_3_5)
{
    int d = 15;
    int d_out[MAX_PRIME_NUM];
    int c = fact_prime(d, d_out);
    ASSERT_EQ(2, c);
    ASSERT_EQ(3, d_out[0]);
    ASSERT_EQ(5, d_out[1]);

}

@
@<test...@>+=
TEST_F(mytest, test_given_21_returns_3_7)
{
    int d = 21;
    int d_out[MAX_PRIME_NUM];
    int c = fact_prime(d, d_out);
    ASSERT_EQ(2, c);
    ASSERT_EQ(3, d_out[0]);
    ASSERT_EQ(7, d_out[1]);
}
TEST_F(mytest, test_given_35_returns_5_7)
{
    int c = 0;
    int d = 35;
    int d_out[MAX_PRIME_NUM];
   
    int x2 = is_prime(2);
    int x3 = is_prime(3);
    int x5 = is_prime(5);
    int x7 = is_prime(7);
    int x9 = is_prime(9);
    int x35 = is_prime(35);

    ASSERT_EQ(1, x2);
    ASSERT_EQ(1, x3);
    ASSERT_EQ(1, x5);
    ASSERT_EQ(1, x7);
    ASSERT_EQ(0, x9);
    ASSERT_EQ(0, x35);

    c = fact_prime(d, d_out);
    ASSERT_EQ(2, c);
    ASSERT_EQ(5, d_out[0]);
    ASSERT_EQ(7, d_out[1]);
}

TEST_F(mytest, test_given_147_returns_3_7_7)
{
    int d = 147;
    int d_out[MAX_PRIME_NUM];
    int c = fact_prime(d, d_out);
    ASSERT_EQ(3, c);
    ASSERT_EQ(3, d_out[0]);
    ASSERT_EQ(7, d_out[1]);
    ASSERT_EQ(7, d_out[2]);

}



@ 
@<rout...@>+=
int is_prime(int d);
int fact_prime(int d, int* d_out)
{
    int pos = 0;
    int dd = d/2+1; /* the maximum of prime numbers it could be */

    int t = 2;
    int r[MAX_PRIME_NUM];
    int tpos=0;
    int j =0;
    if (dd < 3) dd = 3;
    /* get all prime numbers */
    for(t=2;t<=dd;t++) {
        if(is_prime(t)) r[tpos++] = t;
    }

    for(j=0;j<tpos;) {
        if(d % r[j] == 0) {
            d_out[pos++] = r[j];
            d = d/r[j];
            continue;
        }
        j++;
    }
  
    return pos;
}
int is_prime(int d)
{
    int dd = d/2+1; /* the maximum of prime numbers it could be */
    int i;
    for(i = 2; i< dd; i++) {
        if(d % i == 0) return 0;
    }
    return 1;
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
