function vim_matlab_dbstack(s)
    fid = fopen([tempdir 'vim_screen_matlab.tmp'],'w');
    if(size(s,1) > 0)
        fprintf(fid,'dbstack %s %.0f\n',s(1).file,s(1).line);
    end
    fclose(fid);
end
