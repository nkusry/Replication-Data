%formate the figures
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultlegendinterpreter','latex');
set(groot,'DefaultAxesFontName', 'Times New Roman')
set(groot,'DefaultTextFontname', 'Times New Roman')
set(groot,'DefaultLineLineWidth', 1.5)
set(groot,'DefaultAxesYGrid','on')
%plot Figure 2a
plot(Pdata,'b-');
axis([1 129 0.8 0.95]);set(gca,'ytick',0.8:0.05:0.95);
set(gca,'XTickLabel',1995:5:2020);set(gca,'YTickLabel',{'80%','85%','90%','95%'});
%plot Figure 2b
plot(UR,'b-');hold on;plot(UA,'b--');hold on;plot(UB,'b:');
axis([1 129 0 0.4]);set(gca,'ytick',0:0.1:0.4);
set(gca,'XTickLabel',1995:5:2020);set(gca,'YTickLabel',{'0%','10%','20%','30%','40%'});
legend('Overall Unemployment Rate','Unemployment Rate(Eligible)','Unemployment Rate(Non-eligible)');
%plot Figure 3
R=[0:0.0001:1]';
BC=5.08.*(0.49-1.18.*(R-0.42)).*(0.12-0.26.*(R-0.42));
WEDGE=0.4-0.4.*(TAU./UA-0.61);
epsm=0.4.*(1-UA)./(1./(0.12-0.26.*(Rdata-0.42))-1);
epsM=epsm.*(1-WEDGE);
epssp=-epsm.*WEDGE.*(1-UA)./(1-UB);
[BCX,TAUX]=ndgrid(BC,TAU);
[RX,UAX]=ndgrid(R,UA);
[RX,UBX]=ndgrid(R,UB);
[RX,epsMX]=ndgrid(R,epsM);
[RX,epsspX]=ndgrid(R,epssp);
[RX,WEDGEX]=ndgrid(R,WEDGE);
[RX,PX]=ndgrid(R,Pdata);
[RX,RdataX]=ndgrid(R,Rdata);
UAY=UAX+UAX./(1-RdataX).*epsMX.*(RX-RdataX);
UBY=UBX+UBX./(1-RdataX).*epsspX.*(RX-RdataX);
TAUY=TAUX-1.5.*TAUX.*(1+TAUX)./(1-UBX)./(1-RdataX).*epsspX.*(RX-RdataX);
EFAX=0.49-1.29.*(RX-0.42)+RX-1.5.*TAUY./UAY;
EFBX=(1./PX-1).*(1-UBX)./(1-UAX).*UBY./UAY.*(0.82-1.5.*TAUY./UBY);
[val,ind]=min(abs(BCX+WEDGEX.*EFAX+WEDGEX.*EFBX-RX));
R_new=R(ind);

TAUU0=TAU./UR;
BC0=4.6.*(0.46-1.32.*(R-0.42)).*(0.12-0.26.*(R-0.42));
[RX0,TAUUY0]=ndgrid(R,TAUU0);
[BCX0,RdataX0]=ndgrid(BC0,Rdata);
TAUUX0=TAUUY0+0.01.*(RX0-RdataX0);
WEDGEX0=0.4-0.65.*(TAUUX0-0.38);
EFFX0=0.88-0.32.*(RX0-0.42)-1.5.*TAUUX0;
[val0,ind0]=min(abs(BCX0+WEDGEX0.*EFFX0-RX0));
R_old=R(ind0);

plot(Rdata,'b-');hold on;plot(R_new,'b--');hold on;plot(R_old,'b:');
axis([1 129 0.2 0.8]);set(gca,'ytick',0.2:0.2:0.8);
set(gca,'XTickLabel',1995:5:2020);set(gca,'YTickLabel',{'20%','40%','60%','80%'});
legend('Effective Replacement Rate','Optimal Replacement Rate (proposed model)','Optimal Replacement Rate (LMS model)')

%plot figure 4a
plot(R_new-R_old)
axis([1 129 0 0.1]);set(gca,'ytick',0:0.02:0.1);
set(gca,'XTickLabel',1995:5:2020);
%plot figure 4b
BC_new=5.08.*(0.49-1.18.*(R_new-0.42)).*(0.12-0.26.*(R_new-0.42));
UA_new=UA+UA./(1-Rdata).*epsM.*(R_new-Rdata);
UB_new=UB+UB./(1-Rdata).*epssp.*(R_new-Rdata);
TAU_new=TAU-1.5.*TAU.*(1+TAU)./(1-UB)./(1-Rdata).*epssp.*(R_new-Rdata);
ratio=(1./Pdata-1).*UB_new./UA_new;
net=0.82-1.5.*TAU_new./UB_new;
ela=(R_new-R_old)./ratio./net;
plot(ela,'b-');hold on;plot(net,'b--');hold on;plot(ratio,'b:');
axis([1 129 0 2.5]);set(gca,'ytick',0:0.5:2.5);
set(gca,'XTickLabel',1995:5:2020);
legend('labour-market spillover elasticity','marginal net cost of unemployment',' relative unemployment-stock weight of non-eligible workers')

%plot figure 5
scatter(Rdata,UR);
hold on;plot(fit(Rdata,UR,'poly1'));
xlabel('$R$');ylabel('$u$');
axis([0.2 0.8 0.03 0.1]);
legend('off');

%plot figure 6
duadR=epsM.*UA./(1-Rdata);
dubdR=epssp.*UB./(1-Rdata);
dudR_new=Pdata.*duadR+(1-Pdata).*dubdR;
plot(dudR_new,'b-');hold on;plot(duadR,'b--');hold on;plot(dubdR,'b:');
axis([1 129 -0.02 0.02]);set(gca,'ytick',-0.02:0.01:0.02);
set(gca,'XTickLabel',1995:5:2020);
legend('$du/dR$','$du_i/dR$','$du_n/dR$');

%plot Figure 7
scatter(Pdata,UR);
hold on;plot(fit(Pdata,UR,'poly1'));
xlabel('Coverage Rate');ylabel('Unemployment Rate');
legend('off');

%plot Figure 8a
Roptimal=RP(Pdata);
Roptimal1=RP(Pdata-0.05);
Roptimal2=RP(Pdata+0.05);
plot(Roptimal,'b-');hold on;plot(Roptimal1,'b--');hold on;plot(Roptimal2,'b:');
axis([1 129 0.3 0.7]);set(gca,'ytick',0.3:0.1:0.7);
set(gca,'XTickLabel',1995:5:2020);set(gca,'YTickLabel',{'30%','40%','50%','60%','70%'});
legend('Optimal R (p)','Optimal R (p-0.05)','Optimal R (p+0.05)');

%plot Figure 8b
dRdp1=(RP(Pdata+0.01)-RP(Pdata))./0.01;
dRdp2=(RP(Pdata)-RP(Pdata-0.01))./0.01;
dRdp=(dRdp1+dRdp2)./2;
dudp=UA-UB+dudR_new.*dRdp;
UR1=UR+0.05.*dudp;UR2=UR-0.05.*dudp;
plot(UR,'b-');hold on;plot(UR1,'b--');hold on;plot(UR2,'b:');
axis([1 129 0 0.15]);set(gca,'ytick',0:0.03:0.15);
set(gca,'XTickLabel',1995:5:2020);set(gca,'YTickLabel',{'0%','3%','6%','9%','12%','15%'});
legend('unemployment rate (observed)','unemployment rate (lower optimal R \& higher p)','unemployment rate (higher optimal R \& lower p)');


%plot Figure 9a
plot(TAU,'b-');
axis([1 129 0.01 0.05]);set(gca,'ytick',0.01:0.01:0.05);
set(gca,'XTickLabel',1995:5:2020);set(gca,'YTickLabel',{'1%','2%','3%','4%','5%'});

%plot Figure 9b
plot(Rdata,'b-');
axis([1 129 0.2 0.8]);set(gca,'ytick',0.2:0.2:0.8);
set(gca,'XTickLabel',1995:5:2020);set(gca,'YTickLabel',{'20%','40%','60%','80%'});

%plot Figure 10a
Recipiency=xlsread('statistics.xlsx','I2:I130');
plot(Recipiency,'b-');
axis([1 129 0 1]);set(gca,'ytick',0:0.2:1);
set(gca,'XTickLabel',1995:5:2020);set(gca,'YTickLabel',{'0%','20%','40%','60%','80%','100%'});

%plot Figure 10b
LongUnemRatio=xlsread('statistics_m.xlsx','F2:F388');
plot(quarter(LongUnemRatio),'b-');
axis([1 129 0 0.5]);set(gca,'ytick',0:0.1:0.5);
set(gca,'XTickLabel',1995:5:2020);set(gca,'YTickLabel',{'0%','10%','20%','30%','40%','50%'});
