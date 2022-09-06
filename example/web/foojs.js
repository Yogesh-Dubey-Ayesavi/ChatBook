function foo(count) {
    let result =  0;
    for(let i = 1; i <= count; i++) {
        result +=  i;
        console.log(i);
    }
    return result;
}