

int cmpstr (char str1[], char str2[]) {

    int i = 0;
    while (str1[i] == str2[i]) {
        if (str1[i] == '\0' || str2[i] == '\0') {
            break;
        }
        i++;
    }
    if (str1[i] > str2[i]) {
        return 1;
    }
    else if (str1[i] < str2[i]) {
        return 2;
    }
    else {
        return 0;
    }
}
