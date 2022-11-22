
clear all
data_folder='D:\Brown_Data';
fs_raw=30000;
subsamp_factor=120;

ID_monkey='SPK';
ID_session='121001';
SPK_subsamp(data_folder, ID_monkey,ID_session,subsamp_factor);

ID_monkey='SPK';
ID_session='121003';
SPK_subsamp(data_folder, ID_monkey,ID_session,subsamp_factor);

ID_monkey='SPK';
ID_session='121004';
SPK_subsamp(data_folder, ID_monkey,ID_session,subsamp_factor);

ID_monkey='SPK';
ID_session='121005';
SPK_subsamp(data_folder, ID_monkey,ID_session,subsamp_factor);

ID_monkey='SPK';
ID_session='121107';
SPK_subsamp(data_folder, ID_monkey,ID_session,subsamp_factor);

ID_monkey='RUS';
ID_session='120618';
RUS_subsamp(data_folder, ID_monkey,ID_session,subsamp_factor);

ID_monkey='RUS';
ID_session='120619';
RUS_subsamp(data_folder, ID_monkey,ID_session,subsamp_factor);

ID_monkey='RUS';
ID_session='120622';
RUS_subsamp(data_folder, ID_monkey,ID_session,subsamp_factor);

ID_monkey='RUS';
ID_session='120627';
RUS_subsamp(data_folder, ID_monkey,ID_session,subsamp_factor);

ID_monkey='RUS';
ID_session='120702';
RUS_subsamp(data_folder, ID_monkey,ID_session,subsamp_factor);
