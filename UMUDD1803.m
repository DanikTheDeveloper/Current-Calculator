function UMUDD1803()
    %# create tabbed GUI
     hFig = figure('Menubar','none');
%     s = warning('off', 'MATLAB:uitabgroup:OldVersion');
     hTabGroup = uitabgroup('Parent',hFig);
%     warning(s);
    resArr = 0;
    volArr = 0;
    numLoops = 1;
    elementType = 'Resistance';
    numElements.resistors = 0;
    numElements.batteries = 0;
    R = 0;
    V = 0;
    numUnassigned = 2;
    hTabs(1) = uitab('Parent',hTabGroup, 'Title','Loop1');
    uicontrol('Style','pushbutton', 'String','Add loop', ...
        'Parent',hTabs(1), 'Callback',@addLoop, 'Position',[320 20 80 22]);
    uicontrol('Style','pushbutton', 'String','Delete loop', ...
        'Parent',hTabs(1), 'Callback',@deleteLoop,'Parent',hTabs(1), 'Position',[420 20 80 22]);
    c = uicontrol(hTabs(1),'Style','popupmenu');
    c.Position = [20 20 80 22];
    c.String = {'Resistance','Voltage'};
    c.Callback = @selection;
    editText = uicontrol(hTabs(1),'Style','edit');
    editText.Position = [120 20 80 22];
    uicontrol('Style','pushbutton', 'String','Add Value', ...
        'Parent',hTabs(1), 'Position',[220 20 80 22],'Callback',@addValue);
    txt = uicontrol('Parent',hTabs(1),'Style','text');
    txt.Position = [150 61 22 600];
    txt.String = sprintf(Lines());
    txt = uicontrol('Parent',hTabs(1),'Style','text');
    txt.Position = [250 61 22 600];
    txt.String = sprintf(Lines());
    
    addLoop();
    
    function selection(src,event,handles)
        if get(src,'Value') == 1
            elementType = 'Resistance';
        else
            elementType = 'Voltage';
        end
    end
    
    function addValue(src,event)
        if strcmp(elementType,'Resistance')
            numElements.resistors = numElements.resistors + 1;
            convRes = static_cast(get(editText, 'String'));
            for ii = 1:length(convRes)
                R(numElements.resistors,ii) = convRes(ii);
            end
            printRes(R(numElements.resistors,:));
        else
            numElements.batteries = numElements.batteries + 1;
            V(numElements.batteries) = static_cast(get(editText, 'String'));
            printVol(V(numElements.batteries));
        end
    end
    function printRes(Res)
        resArr = zeros(2,numElements.resistors,length(Res));
        for ii = 1:2
            if customLength(Res) == 1
                txtRes = uicontrol('Parent',hTabs(ii),'Style','text');
                txtRes.Position = [30 (20+numElements.resistors*30) 80 22];
                txtRes.String = sprintf('R%1.0i = %1.1f',...
                    int16(numElements.resistors),Res(1));
            elseif customLength(Res) == 2
                txtRes = uicontrol('Parent',hTabs(ii),'Style','text');
                txtRes.Position = [30 (20+numElements.resistors*30) 100 22];
                txtRes.String = sprintf('R%1.0i = %1.1f || %1.1f',...
                    int16(numElements.resistors),Res(1),Res(2));
            elseif customLength(Res) == 3
                txtRes = uicontrol('Parent',hTabs(ii),'Style','text');
                txtRes.Position = [30 (20+numElements.resistors*30) 130 22];
                txtRes.String = sprintf(...
                    'R%1.0i = %1.1f || %1.1f || %1.1f',int16(numElements.resistors),Res(1),Res(2),Res(3));
            else
                txtRes = uicontrol('Parent',hTabs(ii),'Style','text');
                txtRes.Position = [30 (20+numElements.resistors*30) 130 22];
                txtRes.String = sprintf(...
                    'R%1.0i = %1.1f || %1.1f || %1.1f...',int16(numElements.resistors),Res(1),Res(2),Res(3));
            end
            radioRes(numElements.resistors) = uicontrol('Parent',hTabs(ii),'Style','radiobutton');
            radioRes(numElements.resistors).Position = [20 (25+numElements.resistors*30) 22 22];
            radioRes(numElements.resistors).Callback = @(src,eventdata)radioButtonRes(...
                src,eventdata,numElements.resistors,ii);
        end
    end
    function printVol(Vol)
        volArr = zeros(2,numElements.batteries);
        for ii = 1:2
            txtVol(numElements.batteries) = uicontrol('Parent',hTabs(ii),'Style','text');
            txtVol(numElements.batteries).Position = [180 (20+numElements.batteries*30) 80 22];
            txtVol(numElements.batteries).String = sprintf('V%1.0i = %1.2f',int16(numElements.batteries),Vol);
            
            radioVol(numElements.batteries) = uicontrol('Parent',hTabs(ii),'Style','radiobutton');
            radioVol(numElements.batteries).Position = [168 (25+numElements.batteries*30) 22 22];
            radioVol(numElements.batteries).Callback = @(src,eventdata)...
                radioButtonVol(src,eventdata,numElements.batteries,ii);
        end
    end

    function radioButtonRes(src,evendata,elNum,loopNum)
        if (get(src,'Value') == get(src,'Max'))
            resArr(loopNum,elNum,:) = R(elNum,:);
        else
            resArr(loopNum,elNum,:) = 0;
        end
    end
    function radioButtonVol(src,evendata,elNum,loopNum)
        if (get(src,'Value') == get(src,'Max'))
            volArr(loopNum,elNum) = V(elNum);
        else
            volArr(loopNum,elNum) = 0;
        end
    end
    
    function addLoop(src,evt)
        numLoops = numLoops + 1;
        hTabs(numLoops) = uitab('Parent',hTabGroup, 'Title',['Loop',num2str(numLoops)]);
        uicontrol('Style','pushbutton', 'String','Add loop', ...
            'Parent',hTabs(numLoops), 'Callback',@addLoop, 'Position',[320 20 80 22]);
        uicontrol('Style','pushbutton', 'String','Delete loop', ...
            'Parent',hTabs(numLoops), 'Callback',@deleteLoop, 'Position',[420 20 80 22]);
        uicontrol('Style','pushbutton', 'String','Confirm', ...
            'Parent',hTabs(numLoops), 'Callback',@confirm, 'Position',[20 20 280 22]);
        txt = uicontrol('Parent',hTabs(numLoops),'Style','text');
        txt.Position = [150 61 22 600];
        txt.String = sprintf(Lines());
        txt = uicontrol('Parent',hTabs(numLoops),'Style','text');
        txt.Position = [250 61 22 600];
        txt.String = sprintf(Lines());
    end

    function confirm(src,evt)
        if numUnassigned + 1 > numLoops
            printCurrent();
        else
            numUnassigned = numUnassigned + 1;
            resArr = [resArr;zeros(1,numElements.resistors,length(resArr(1,1,:)))];
            volArr = [volArr;zeros(1,numElements.batteries)];
            print3();
        end
    end

    function print3()
        count = 1;
        for ii = 1:numElements.resistors
            if isZero(int16(resArr(1:numUnassigned-2,ii,:)))
                if customLength(R(ii,:)) == 1
                    txtRes = uicontrol('Parent',hTabs(numUnassigned),'Style','text');
                    txtRes.Position = [30 (20+count*30) 80 22];
                    txtRes.String = sprintf(...
                        'R%1.0i = %1.1f',int16(ii),R(ii));
                elseif customLength(R(ii,:)) == 2
                    txtRes = uicontrol('Parent',hTabs(numUnassigned),'Style','text');
                    txtRes.Position = [30 (20+count*30) 100 22];
                    txtRes.String = sprintf(...
                        'R%1.0i = %1.1f || %1.1f',int16(ii),R(ii,1),R(ii,2));
                elseif customLength(R(ii,:)) == 3
                    txtRes = uicontrol('Parent',hTabs(numUnassigned),'Style','text');
                    txtRes.Position = [30 (20+count*30) 130 22];
                    txtRes.String = sprintf(...
                        'R%1.0i = %1.1f || %1.1f || %1.1f',int16(ii),R(ii,1),R(ii,2),R(ii,3));
                else
                    txtRes = uicontrol('Parent',hTabs(numUnassigned),'Style','text');
                    txtRes.Position = [30 (20+count*30) 130 22];
                    txtRes.String = sprintf(...
                        'R%1.0i = %1.1f || %1.1f || %1.1f...',int16(ii), R(ii,1),R(ii,2),R(ii,3));
                end
                radioRes = uicontrol('Parent',hTabs(numUnassigned),'Style','radiobutton');
                radioRes.Position = [20 (25+count*30) 22 22];
                radioRes.Callback = @(src,eventdata)...
                    radioButtonRes(src,eventdata,ii,numUnassigned);
                count = count + 1;
            end
        end
        count = 1;
        for ii = 1:numElements.batteries
            if isZero(int16(volArr(1:numUnassigned-2,ii)))
                txtVol = uicontrol('Parent',hTabs(numUnassigned),'Style','text');
                txtVol.Position = [180 (20+count*30) 80 22];
                txtVol.String = sprintf('V%1.0i = %1.2f',...
                    int16(ii),V(ii));
                
                radioVol = uicontrol('Parent',hTabs(numUnassigned),'Style','radiobutton');
                radioVol.Position = [168 (25+count*30) 22 22];
                radioVol.Callback = @(src,eventdata)...
                    radioButtonVol(src,eventdata,ii,numUnassigned);
                count = count + 1;
            end
        end
    end

    function printS(subloop)
        for ii = 1:length(subloop)
            addLoop();
            count1 = 1;
            for jj = 1:numElements.resistors
                if int16(subloop(ii).resistance(jj)) ~= 0
                    if customLength(R(jj,:)) == 1
                        txtRes = uicontrol('Parent',hTabs(numLoops),'Style','text');
                        txtRes.Position = [30 (20+count1*30) 80 22];
                        txtRes.String = sprintf('R%1.0i = %1.1f',int16(jj),R(jj));
                    elseif customLength(R(jj,:)) == 2
                        txtRes = uicontrol('Parent',hTabs(numLoops),'Style','text');
                        txtRes.Position = [30 (20+count1*30) 100 22];
                        txtRes.String = sprintf(...
                            'R%1.0i = %1.1f || %1.1f',int16(jj),R(jj,1),R(jj,2));
                    elseif customLength(R(jj,:)) == 3
                        txtRes = uicontrol('Parent',hTabs(numLoops),'Style','text');
                        txtRes.Position = [30 (20+count1*30) 130 22];
                        txtRes.String = sprintf(...
                            'R%1.0i = %1.1f || %1.1f || %1.1f',int16(jj),R(jj,1),R(jj,2),R(jj,3));
                    else
                        txtRes = uicontrol('Parent',hTabs(numLoops),'Style','text');
                        txtRes.Position = [30 (20+count1*30) 130 22];
                        txtRes.String = sprintf(...
                            'R%1.0i = %1.1f || %1.1f || %1.1f...',int16(jj), R(jj,1),R(jj,2),R(jj,3));
                    end
                    count1 = count1 + 1;
                end
                count2 = 1;
                for jj = 1:numElements.batteries
                    if int16(subloop(ii).voltage(jj)) ~= 0
                        txtVol = uicontrol('Parent',hTabs(numLoops),'Style','text');
                        txtVol.Position = [165 (20+count2*30) 80 22];
                        txtVol.String = sprintf('V%1.0i = %1.2f',...
                            int16(jj),V(jj));
                        count2 = count2 + 1;
                    end
                end
            end
        end
    end

    function printCurrent()
        C = circuit(resArr,volArr);
        subloop = subLoop(C);
        printS(subloop);
        I = getCurrent(C);
        for ii = 1:numLoops
            if ii <= length(C)
                for jj = 1:length(I)
                    txtCur = uicontrol('Parent',hTabs(ii),'Style','text');
                    txtCur.Position = [265 (20+jj*30) 80 22];
                    txtCur.String = sprintf('I%1.0i = %1.4f',int16(jj),I(jj));
                end
                txtCur = uicontrol('Parent',hTabs(ii),'Style','text');
                txtCur.Position = [265 (20+(length(I)+1)*30) 200 22];
                txtCur.String = sprintf('I = %1.4f(For this loop separated)',C(ii).current);
            else
                for jj = 1:length(I)
                    txtCur = uicontrol('Parent',hTabs(ii),'Style','text');
                    txtCur.Position = [265 (20+jj*30) 80 22];
                    txtCur.String = sprintf('I%1.0i = %1.4f',int16(jj),I(jj));
                end
                txtCur = uicontrol('Parent',hTabs(ii),'Style','text');
                txtCur.Position = [265 (20+(length(I)+1)*30) 200 22];
                txtCur.String = sprintf('I = %1.4f(For this loop separated)',subloop(ii-length(C)).current);
            end
        end
    end

    function deleteLoop(src,evt)
        if(numLoops > 1)
            delete(hTabs(numLoops));
            numLoops = numLoops - 1;
            if numLoops < numUnassigned
                numUnassigned = numUnassigned - 1;
                if numUnassigned <= length(resArr(:,1,1))
                    resArr = resArr(1:numUnassigned,:,:);
                end
                if numUnassigned <= length(volArr(:,1,1))
                    volArr = volArr(1:numUnassigned,:);
                end
            end
        end
    end
end