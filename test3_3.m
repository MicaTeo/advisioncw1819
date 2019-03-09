
%% Fuse all the points into a single 3D coordinate system

fused_transformation = {};
for i = 1: length(Tform_array)
    i
    frame_transformation = 1;
    for j = 1:i
        frame_transformation = frame_transformation * Tform_array{j}.T;
    end
    fused_transformation{end+1} = affine3d(frame_transformation);
end

gridStep = 0.01;
[~, final_pc] = clear_noise(office{1}, false);
merged_set = {};

for i = 2:length(office) % Reading the 40 point-clouds
    i
    removeBob = false;
    if i == 27
        removeBob = true;
    end
     
    [~, pc_cleared_noise] = clear_noise(office{i}, removeBob); 
    pc_transformed = pctransform(pc_cleared_noise, fused_transformation{i-1});
    final_pc = pcmerge(final_pc, pc_transformed, gridStep);
    merged_set{end+1} = final_pc;
    close all; 
    pcshow(final_pc);
end
close all;
pcshow(final_pc);


% new_xyz = office{2}.Location;
% new_pc_loc = (Rotation_array{1}*new_xyz'+Translation_array{1})' ;
% new_pc = pointCloud(new_pc_loc, 'Color', office{2}.Color);
% 
% Tform = affine3d(horzcat(horzcat(Rotation_array{1}', [0;0;0])', [Translation_array{1};1])');
% Tform = affine3d(horzcat(horzcat(Rotation_array{1}, Translation_array{1})',[0;0;0;1]));
% 
% frame_transformation = 1;
% frame_transformation = frame_transformation * Tform_array{1}.T';
% Tform_2 = affine3d(frame_transformation);
% 
% close all;
% subplot(2,2,1);
% pcshow(office{1}), hold on,
% pcshow(office{2})
% subplot(2,2,2);
% pcshow(office{1}), hold on,
% pcshow(new_pc)
% subplot(2,2,3);
% pcshow(office{1}), hold on,
% pcshow(pctransform(office{2}, Tform))
% subplot(2,2,4);
% pcshow(office{1}), hold on,
% pcshow(pctransform(office{2}, Tform_2))
% 
% pcshow(pcmerge(office{1}, pctransform(office{2}, Tform),0.001))
% 





