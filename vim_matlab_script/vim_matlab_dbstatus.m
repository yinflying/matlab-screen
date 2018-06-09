function vim_matlab_dbstatus()
    fid = fopen([tempdir 'vim_screen_matlab.tmp'],'w');
    s = dbstatus;
    for i = 1:size(s,1);
        fprintf(fid,'dbstatus %s',s(i).file);
        for j = 1:size(s(i).line,2)
            fprintf(fid,' %.0f',s(i).line(j));
        end
        fprintf(fid,'\n');
    end
    fclose(fid);
end
