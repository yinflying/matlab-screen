function vim_matlab_edit()
    fid = fopen('/tmp/vim_screen_pwd.tmp');
    C = textscan(fid,'%s');
    for i = 1:size(C,1)
        edit(C{i,1}{:});
    end
    fclose(fid);
end
