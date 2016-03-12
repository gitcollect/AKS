/*
    Implementation of AKS algorithm in Pari/GP
    Authors: Caixia LU - Vincent DALSHEIMER - Mattheiu GIRAUD
    Date: 4/28/15
*/

aks(n)={

    /* Step 1: Checks if 'n' is a perfect power */
    if(ispower(n)!=0,return(0));

    /* Step 2: Finds 'r' such that the order of n mod r is > log^2 n */
    order_n=(log(n)/log(2))^2;
    r=2;
    r=nextcoprime(r,n);
    nr=Mod(n,r);

    while(znorder(nr)<order_n,
        r+=1;
        r=nextcoprime(r,n);
        nr=Mod(n,r));

    /* Step 3: Checks if '1 < gcd(a,n) < n' for a=2 to r */
    for(a=2,r,
        d=gcd(a,n);
        if(1<d && d<n,return(0)));

    /* Step 4: Checks if 'n <= r' */
    if(n<r+1,return(1));

    /* Step 5 */
    bound_a=floor(sqrt(eulerphi(r))*log(n)/log(2));
    my(X=Mod(Mod(1,n)*x,x^r-1));

    parfor(a=1,bound_a,
        (X+a)^n-X^n-a,c,
        if(c!=0,return(0)));

    /* Step 6 */
    return(1);
}

/* Returns the next 'm' which is coprime with 'n' */
nextcoprime(m,n)={
    while(gcd(m,n)!=1,m+=1);
    return(m);
}