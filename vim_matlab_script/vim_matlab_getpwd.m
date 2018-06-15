function ret_pwd = vim_matlab_getpwd()
    fid = fopen('/tmp/vim_screen_pwd.tmp');
    ret_pwd = fgets(fid);
    fclose(fid);
end
