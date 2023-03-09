classdef nutmeg < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        nutmegfig                     matlab.ui.Figure
        nut_file_menu                 matlab.ui.container.Menu
        nut_opensession_menu          matlab.ui.container.Menu
        nut_savesession_menu          matlab.ui.container.Menu
        nut_quit_menu                 matlab.ui.container.Menu
        nut_special_menu              matlab.ui.container.Menu
        nut_import_markerfile         matlab.ui.container.Menu
        nut_plotsensors_menu          matlab.ui.container.Menu
        nut_field_viewer_menu         matlab.ui.container.Menu
        nut_stripVoxels_menu          matlab.ui.container.Menu
        nut_stripVoxels_vol_menu      matlab.ui.container.Menu
        nut_stripVoxels_cs_menu       matlab.ui.container.Menu
        nut_stripgreymatter_menu      matlab.ui.container.Menu
        nut_simulate_menu             matlab.ui.container.Menu
        nut_cuisinart_menu            matlab.ui.container.Menu
        Untitled_1                    matlab.ui.container.Menu
        nut_loadVOI_menu              matlab.ui.container.Menu
        nut_selectVOI_menu            matlab.ui.container.Menu
        nuteeg                        matlab.ui.container.Menu
        nut_surfaces_menu             matlab.ui.container.Menu
        nut_import_dfs_menu           matlab.ui.container.Menu
        nut_import_dfs_vol_menu       matlab.ui.container.Menu
        nut_import_dfs_cs_menu        matlab.ui.container.Menu
        nut_displaysurfaces_menu      matlab.ui.container.Menu
        nut_displaysurfaces_vol_menu  matlab.ui.container.Menu
        nut_displaysurfaces_cs_menu   matlab.ui.container.Menu
        nut_surfaces_voxori_menu      matlab.ui.container.Menu
        nut_import_eeg_coords_menu    matlab.ui.container.Menu
        nut_import_neuroscan_menu     matlab.ui.container.Menu
        nut_import_stdeegcoord_menu   matlab.ui.container.Menu
        nut_import_prealigned_menu    matlab.ui.container.Menu
        nut_export_eeg_coords_menu    matlab.ui.container.Menu
        nut_eegmralign_menu           matlab.ui.container.Menu
        nut_localspheres_menu         matlab.ui.container.Menu
        nut_eeg_multisphere_menu      matlab.ui.container.Menu
        nut_importLsc_menu            matlab.ui.container.Menu
        nut_exportLsc_menu            matlab.ui.container.Menu
        Untitled_2                    matlab.ui.container.Menu
        nut_importLp_menu             matlab.ui.container.Menu
        nut_exportLp_menu             matlab.ui.container.Menu
        nut_import_smac               matlab.ui.container.Menu
        nut_import_cartool            matlab.ui.container.Menu
        nut_FCM_button                matlab.ui.control.Button
        pushbutton57                  matlab.ui.control.Button
        nut_timefstats_button         matlab.ui.control.Button
        nut_tfbf_button               matlab.ui.control.Button
        pushbutton54                  matlab.ui.control.Button
        nut_leadfield_button          matlab.ui.control.Button
        text14                        matlab.ui.control.Label
        nut_voxelsize_text            matlab.ui.control.EditField
        nut_megfile                   matlab.ui.control.Label
        nut_beamforming_button        matlab.ui.control.Button
        nut_displayMEG_button         matlab.ui.control.Button
        nut_importmeg_button          matlab.ui.control.Button
        nut_sbeam_button              matlab.ui.control.Button
        nut_opensession_button        matlab.ui.control.Button
        nut_reset_button              matlab.ui.control.Button
        nut_refresh_image_button      matlab.ui.control.Button
        nut_savesession_button        matlab.ui.control.Button
        nut_CoregistrationButton      matlab.ui.control.Button
        nut_logo_axes                 matlab.ui.control.UIAxes
    end

    
    methods (Access = private)
        % Update components that require runtime configuration
        function addRuntimeConfigurations(app)
            
            % Set component properties that require runtime configuration
            app.nutmegfig.CloseRequestFcn = 'nut_close';
            app.nut_CoregistrationButton.ButtonPushedFcn = 'nut_CoregistrationTool; nut_enabler;';
            app.nut_savesession_button.ButtonPushedFcn = 'nut_savesession';
            app.nut_refresh_image_button.ButtonPushedFcn = 'nut_refresh_image';
            app.nut_reset_button.ButtonPushedFcn = 'nut_reset';
            app.nut_opensession_button.ButtonPushedFcn = 'nut_opensession';
            app.nut_sbeam_button.ButtonPushedFcn = 'nut_results_viewer';
            app.nut_importmeg_button.ButtonPushedFcn = 'nut_importmeg;';
            app.nut_opensession_menu.MenuSelectedFcn = 'nut_opensession';
            app.nut_savesession_menu.MenuSelectedFcn = 'nut_savesession';
            app.nut_quit_menu.MenuSelectedFcn = 'nut_close';
            app.nut_import_markerfile.MenuSelectedFcn = 'nut_import_markerfile';
            app.nut_plotsensors_menu.MenuSelectedFcn = 'nut_plotSensors';
            app.nut_field_viewer_menu.MenuSelectedFcn = 'nut_field_viewer';
            app.nut_stripVoxels_vol_menu.MenuSelectedFcn = 'nut_stripVoxels';
            app.nut_stripVoxels_cs_menu.MenuSelectedFcn = 'nut_stripcsvoxels';
            app.nut_stripgreymatter_menu.MenuSelectedFcn = 'nut_stripgreyvoxels';
            app.nut_simulate_menu.MenuSelectedFcn = 'nut_Simulate_Callback';
            app.nut_cuisinart_menu.MenuSelectedFcn = 'nut_view_slice_in_head';
            app.nut_displayMEG_button.ButtonPushedFcn = 'nut_beamforming_gui';
            app.nut_beamforming_button.ButtonPushedFcn = 'nut_beamforming_gui';
            app.nut_loadVOI_menu.MenuSelectedFcn = 'nut_loadVOI_Callback';
            app.nut_selectVOI_menu.MenuSelectedFcn = 'global nuts; nuts.VOIvoxels=nut_select_VOI;nut_enabler';
            app.nut_leadfield_button.ButtonPushedFcn = 'global nuts ndefaults; [nuts, nuts.Lp,nuts.voxels]=nut_obtain_lead_field(nuts,str2num(get(findobj(''Tag'',''nut_voxelsize_text''),''Text'')),ndefaults.lf.numcomp); nut_enabler;';
            app.pushbutton54.ButtonPushedFcn = 'global nuts; [nuts.Lp,nuts.voxels]=nut_compute_lead_field(str2num(get(findobj(''Tag'',''nut_voxelsize_text''),''Text''))); nut_enabler;';
            app.nut_import_dfs_vol_menu.MenuSelectedFcn = 'nut_iso2surf';
            app.nut_import_dfs_cs_menu.MenuSelectedFcn = 'nut_import_corticalsurface_dfs';
            app.nut_displaysurfaces_vol_menu.MenuSelectedFcn = 'nut_trimesh';
            app.nut_displaysurfaces_cs_menu.MenuSelectedFcn = 'nut_plot_csprojection';
            app.nut_surfaces_voxori_menu.MenuSelectedFcn = 'nut_findvoxelorientations';
            app.nut_import_neuroscan_menu.MenuSelectedFcn = 'nut_import_eeg_coords(1); nut_enabler';
            app.nut_import_stdeegcoord_menu.MenuSelectedFcn = 'nut_import_eeg_coords(2); nut_enabler';
            app.nut_import_prealigned_menu.MenuSelectedFcn = 'nut_import_eeg_coords(3); nut_enabler';
            app.nut_export_eeg_coords_menu.MenuSelectedFcn = 'nut_export_eeg_coords';
            app.nut_eegmralign_menu.MenuSelectedFcn = 'nut_show_eegmralign';
            app.nut_eeg_multisphere_menu.MenuSelectedFcn = 'nut_eeg_multisphere';
            app.nut_importLsc_menu.MenuSelectedFcn = 'nut_importLsc';
            app.nut_exportLsc_menu.MenuSelectedFcn = 'nut_exportLsc';
            app.nut_importLp_menu.MenuSelectedFcn = 'nut_importLp';
            app.nut_exportLp_menu.MenuSelectedFcn = 'nut_exportLp';
            app.nut_import_smac.MenuSelectedFcn = 'nut_smac2nuts';
            app.nut_import_cartool.MenuSelectedFcn = 'nut_cartoollf2nuts';
            app.nut_tfbf_button.ButtonPushedFcn = 'nut_tfbf_gui';
            app.nut_timefstats_button.ButtonPushedFcn = 'nut_timef_stats';
            app.pushbutton57.ButtonPushedFcn = 'global nuts ndefaults; [nuts.Lp,nuts.voxels]=nut_compute_lead_field(str2num(get(findobj(''Tag'',''nut_voxelsize_text''),''String'')),ndefaults.lf.numcomp); nut_enabler;';
            app.nut_FCM_button.ButtonPushedFcn = 'fcm_gui';
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function nutmeg_OpeningFcn(app, varargin)
            %%---------------------------------------------------
            
            % Add runtime required configuration - Added by Migration Tool
            addRuntimeConfigurations(app);
            
            % Ensure that the app appears on screen when run
            movegui(app.nutmegfig, 'onscreen');
            
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app); %#ok<ASGLU>
            
            % --- Executes just before nutmeg is made visible.
            handles.output = hObject;
            guidata(hObject, handles);
            set(handles.nut_logo_axes, 'Units', 'pixels');
            banner = imread(['nutmeg.png']); % Read the image file banner.jpg
            info = imfinfo(['nutmeg.png']); % Determine the size of the image file
            position = get(handles.nut_logo_axes, 'Position');
            axes(handles.nut_logo_axes);
            bannerhandle=image(banner);
            set(handles.nut_logo_axes, ...
                'Visible', 'off', ...
                'Units', 'pixels');
            set(bannerhandle,'ButtonDownFcn','nut_about');
            
            watchon;
            
            % compatibility checks -----------------------
            if(~exist('spm','file'))
                errordlg('NUTMEG requires SPM2 or SPM8 in your MATLAB path. They may be downloaded from http://www.fil.ion.ucl.ac.uk/spm')
                return
            end
            
            if(strcmp(spm('ver'),'SPM8b') || strcmp(spm('ver'),'SPM8') || strcmp(spm('ver'),'SPM12'))
                disp('Be patient, don''t click anything yet, SPM8 takes a moment to open its MRI viewer.')
            elseif(strcmp(spm('ver'),'SPM5'))
                errordlg(['NUTMEG is not compatible with SPM5. SPM2 or SPM8 may be downloaded from http://www.fil.ion.ucl.ac.uk/spm'])
                return
            elseif(strcmp(spm('ver'),'SPM2'))
                % anything special to say?
            else
                errordlg(['NUTMEG is not compatible with ' spm('ver') '. Please place SPM2 or SPM8 in your path, which may be downloaded from http://www.fil.ion.ucl.ac.uk/spm'])
                return
            end
            
            whichcell2mat = which('cell2mat');
            if(strfind(whichcell2mat,'eeglab'))
                errordlg(['There is a conflict with EEGLAB''s version of cell2mat. Please remove ' whichcell2mat ' from your path.']);
                return
            end
            
            % hack to get mcc to recognize certain important functions exist
            if(0)
                nut_select_VOI;
                nut_Default_Beamformer;
            end
            % end compatibility checks -------------------
            
            % set up paths
            nut_setpath
            
            % nutmegpath = fileparts(which('nutmeg'));
            % beamformerpath = fullfile(nutmegpath,'beamformers'); % path to nutmeg/beamformers
            % externalpath = fullfile(nutmegpath,'external'); % path to nutmeg/external
            % denoiserpath = fullfile(nutmegpath,'denoisers'); % path to nutmeg/denoisers
            % dataimporterpath = fullfile(nutmegpath,'data_importers');
            % lfpath = fullfile(nutmegpath,'leadfield_obtainers');
            % templatespath = fullfile(nutmegpath,'templates');
            % nuteegpath = fullfile(nutmegpath,'nuteeg');
            % nuteegutilpath = fullfile(nuteegpath,'util');
            % nuteegutilsphpath = fullfile(nuteegutilpath,'Sphere_Tessellation');
            % addpath(beamformerpath,externalpath,denoiserpath,dataimporterpath,...
            %     lfpath,templatespath,nuteegpath,nuteegutilpath,nuteegutilsphpath);
            
            nut_defaults;
            
            if ( ~isempty(varargin) && isstruct(varargin{1}) )  % if nuts structure given as input
                global nuts screws st defaults
                nuts = varargin{1};
                spm('Defaults','fMRI');
                set(handles.nut_megfile,'String','(none loaded)');
                nut_enabler(handles);
                nut_refresh_image;
            else
                nut_reset;   % flush everything and set up proper globals, etc.
                global nuts
            end
            
            nuts.fig = hObject;
            
            nut_spmfig_setup;
            
            monpos = get(0,'MonitorPositions');
            figpos = get(nuts.fig,'Position');
            set(nuts.fig,'Position',[figpos(1) figpos(1)+monpos(1,2) figpos(3) figpos(4)]);
            
            watchoff;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create nutmegfig and hide until all components are created
            app.nutmegfig = uifigure('Visible', 'off');
            app.nutmegfig.IntegerHandle = 'on';
            app.nutmegfig.Color = [1 1 1];
            colormap(app.nutmegfig, 'parula');
            app.nutmegfig.Position = [61 121 662 225];
            app.nutmegfig.Name = 'NUTMEG: Neurodynamic Utility Toolbox for MEG';
            app.nutmegfig.Resize = 'off';
            app.nutmegfig.HandleVisibility = 'on';
            app.nutmegfig.Tag = 'nutmegfig';

            % Create nut_file_menu
            app.nut_file_menu = uimenu(app.nutmegfig);
            app.nut_file_menu.Text = 'File';
            app.nut_file_menu.Tag = 'nut_file_menu';

            % Create nut_opensession_menu
            app.nut_opensession_menu = uimenu(app.nut_file_menu);
            app.nut_opensession_menu.Text = 'Open Session...';
            app.nut_opensession_menu.Tag = 'nut_opensession_menu';

            % Create nut_savesession_menu
            app.nut_savesession_menu = uimenu(app.nut_file_menu);
            app.nut_savesession_menu.Text = 'Save Session...';
            app.nut_savesession_menu.Tag = 'nut_savesession_menu';

            % Create nut_quit_menu
            app.nut_quit_menu = uimenu(app.nut_file_menu);
            app.nut_quit_menu.Separator = 'on';
            app.nut_quit_menu.Text = 'Quit';
            app.nut_quit_menu.Tag = 'nut_quit_menu';

            % Create nut_special_menu
            app.nut_special_menu = uimenu(app.nutmegfig);
            app.nut_special_menu.Text = 'Special';
            app.nut_special_menu.Tag = 'nut_special_menu';

            % Create nut_import_markerfile
            app.nut_import_markerfile = uimenu(app.nut_special_menu);
            app.nut_import_markerfile.Text = 'Import CTF Markerfile...';
            app.nut_import_markerfile.Tag = 'nut_import_markerfile';

            % Create nut_plotsensors_menu
            app.nut_plotsensors_menu = uimenu(app.nut_special_menu);
            app.nut_plotsensors_menu.Enable = 'off';
            app.nut_plotsensors_menu.Separator = 'on';
            app.nut_plotsensors_menu.Text = 'Plot Sensor Locations';
            app.nut_plotsensors_menu.Tag = 'nut_plotsensors_menu';

            % Create nut_field_viewer_menu
            app.nut_field_viewer_menu = uimenu(app.nut_special_menu);
            app.nut_field_viewer_menu.Enable = 'off';
            app.nut_field_viewer_menu.Text = 'View Lead Field Distribution';
            app.nut_field_viewer_menu.Tag = 'nut_field_viewer_menu';

            % Create nut_stripVoxels_menu
            app.nut_stripVoxels_menu = uimenu(app.nut_special_menu);
            app.nut_stripVoxels_menu.Enable = 'off';
            app.nut_stripVoxels_menu.Text = 'Strip Voxels';
            app.nut_stripVoxels_menu.Tag = 'nut_stripVoxels_menu';

            % Create nut_stripVoxels_vol_menu
            app.nut_stripVoxels_vol_menu = uimenu(app.nut_stripVoxels_menu);
            app.nut_stripVoxels_vol_menu.Enable = 'off';
            app.nut_stripVoxels_vol_menu.Text = 'Inner Volume';
            app.nut_stripVoxels_vol_menu.Tag = 'nut_stripVoxels_vol_menu';

            % Create nut_stripVoxels_cs_menu
            app.nut_stripVoxels_cs_menu = uimenu(app.nut_stripVoxels_menu);
            app.nut_stripVoxels_cs_menu.Enable = 'off';
            app.nut_stripVoxels_cs_menu.Text = 'Cortical Surface';
            app.nut_stripVoxels_cs_menu.Tag = 'nut_stripVoxels_cs_menu';

            % Create nut_stripgreymatter_menu
            app.nut_stripgreymatter_menu = uimenu(app.nut_stripVoxels_menu);
            app.nut_stripgreymatter_menu.Text = 'Grey Matter';
            app.nut_stripgreymatter_menu.Tag = 'nut_stripgreymatter_menu';

            % Create nut_simulate_menu
            app.nut_simulate_menu = uimenu(app.nut_special_menu);
            app.nut_simulate_menu.Text = 'Simulate MEG data...';
            app.nut_simulate_menu.Tag = 'nut_simulate_menu';

            % Create nut_cuisinart_menu
            app.nut_cuisinart_menu = uimenu(app.nut_special_menu);
            app.nut_cuisinart_menu.Separator = 'on';
            app.nut_cuisinart_menu.Text = 'Brain Cuisinart(r)';
            app.nut_cuisinart_menu.Tag = 'nut_cuisinart_menu';

            % Create Untitled_1
            app.Untitled_1 = uimenu(app.nutmegfig);
            app.Untitled_1.Text = 'Manual VOI';
            app.Untitled_1.Tag = 'Untitled_1';

            % Create nut_loadVOI_menu
            app.nut_loadVOI_menu = uimenu(app.Untitled_1);
            app.nut_loadVOI_menu.Text = 'Load/View VOI...';
            app.nut_loadVOI_menu.Tag = 'nut_loadVOI_menu';

            % Create nut_selectVOI_menu
            app.nut_selectVOI_menu = uimenu(app.Untitled_1);
            app.nut_selectVOI_menu.Text = 'Select VOI';
            app.nut_selectVOI_menu.Tag = 'nut_selectVOI_menu';

            % Create nuteeg
            app.nuteeg = uimenu(app.nutmegfig);
            app.nuteeg.Text = 'NUTEEG';
            app.nuteeg.Tag = 'nuteeg';

            % Create nut_surfaces_menu
            app.nut_surfaces_menu = uimenu(app.nuteeg);
            app.nut_surfaces_menu.Text = 'Surfaces';
            app.nut_surfaces_menu.Tag = 'nut_surfaces_menu';

            % Create nut_import_dfs_menu
            app.nut_import_dfs_menu = uimenu(app.nut_surfaces_menu);
            app.nut_import_dfs_menu.Enable = 'off';
            app.nut_import_dfs_menu.Text = 'Import BrainSuite DFS';
            app.nut_import_dfs_menu.Tag = 'nut_import_dfs_menu';

            % Create nut_import_dfs_vol_menu
            app.nut_import_dfs_vol_menu = uimenu(app.nut_import_dfs_menu);
            app.nut_import_dfs_vol_menu.Enable = 'off';
            app.nut_import_dfs_vol_menu.Text = 'Volume';
            app.nut_import_dfs_vol_menu.Tag = 'nut_import_dfs_vol_menu';

            % Create nut_import_dfs_cs_menu
            app.nut_import_dfs_cs_menu = uimenu(app.nut_import_dfs_menu);
            app.nut_import_dfs_cs_menu.Enable = 'off';
            app.nut_import_dfs_cs_menu.Text = 'Cortical Surface';
            app.nut_import_dfs_cs_menu.Tag = 'nut_import_dfs_cs_menu';

            % Create nut_displaysurfaces_menu
            app.nut_displaysurfaces_menu = uimenu(app.nut_surfaces_menu);
            app.nut_displaysurfaces_menu.Enable = 'off';
            app.nut_displaysurfaces_menu.Text = 'Display Surfaces';
            app.nut_displaysurfaces_menu.Tag = 'nut_displaysurfaces_menu';

            % Create nut_displaysurfaces_vol_menu
            app.nut_displaysurfaces_vol_menu = uimenu(app.nut_displaysurfaces_menu);
            app.nut_displaysurfaces_vol_menu.Enable = 'off';
            app.nut_displaysurfaces_vol_menu.Text = 'Volume';
            app.nut_displaysurfaces_vol_menu.Tag = 'nut_displaysurfaces_vol_menu';

            % Create nut_displaysurfaces_cs_menu
            app.nut_displaysurfaces_cs_menu = uimenu(app.nut_displaysurfaces_menu);
            app.nut_displaysurfaces_cs_menu.Enable = 'off';
            app.nut_displaysurfaces_cs_menu.Text = 'Cortical Surface';
            app.nut_displaysurfaces_cs_menu.Tag = 'nut_displaysurfaces_cs_menu';

            % Create nut_surfaces_voxori_menu
            app.nut_surfaces_voxori_menu = uimenu(app.nut_surfaces_menu);
            app.nut_surfaces_voxori_menu.Enable = 'off';
            app.nut_surfaces_voxori_menu.Text = 'Compute Voxel Orientations From CS';
            app.nut_surfaces_voxori_menu.Tag = 'nut_surfaces_voxori_menu';

            % Create nut_import_eeg_coords_menu
            app.nut_import_eeg_coords_menu = uimenu(app.nuteeg);
            app.nut_import_eeg_coords_menu.Enable = 'off';
            app.nut_import_eeg_coords_menu.Separator = 'on';
            app.nut_import_eeg_coords_menu.Text = 'Import Electrode Coordinates';
            app.nut_import_eeg_coords_menu.Tag = 'nut_import_eeg_coords_menu';

            % Create nut_import_neuroscan_menu
            app.nut_import_neuroscan_menu = uimenu(app.nut_import_eeg_coords_menu);
            app.nut_import_neuroscan_menu.Text = 'Digitized Coordinates';
            app.nut_import_neuroscan_menu.Tag = 'nut_import_neuroscan_menu';

            % Create nut_import_stdeegcoord_menu
            app.nut_import_stdeegcoord_menu = uimenu(app.nut_import_eeg_coords_menu);
            app.nut_import_stdeegcoord_menu.Text = 'Coordinates Aligned to MNI Template';
            app.nut_import_stdeegcoord_menu.Tag = 'nut_import_stdeegcoord_menu';

            % Create nut_import_prealigned_menu
            app.nut_import_prealigned_menu = uimenu(app.nut_import_eeg_coords_menu);
            app.nut_import_prealigned_menu.Text = 'Coordinates Aligned to Individual MRI';
            app.nut_import_prealigned_menu.Tag = 'nut_import_prealigned_menu';

            % Create nut_export_eeg_coords_menu
            app.nut_export_eeg_coords_menu = uimenu(app.nuteeg);
            app.nut_export_eeg_coords_menu.Enable = 'off';
            app.nut_export_eeg_coords_menu.Text = 'Export Electrode Coordinates';
            app.nut_export_eeg_coords_menu.Tag = 'nut_export_eeg_coords_menu';

            % Create nut_eegmralign_menu
            app.nut_eegmralign_menu = uimenu(app.nuteeg);
            app.nut_eegmralign_menu.Enable = 'off';
            app.nut_eegmralign_menu.Text = 'MR/Sensor Fitting';
            app.nut_eegmralign_menu.Tag = 'nut_eegmralign_menu';

            % Create nut_localspheres_menu
            app.nut_localspheres_menu = uimenu(app.nuteeg);
            app.nut_localspheres_menu.Text = 'Localspheres';
            app.nut_localspheres_menu.Tag = 'nut_localspheres_menu';

            % Create nut_eeg_multisphere_menu
            app.nut_eeg_multisphere_menu = uimenu(app.nut_localspheres_menu);
            app.nut_eeg_multisphere_menu.Enable = 'off';
            app.nut_eeg_multisphere_menu.Text = 'Generate';
            app.nut_eeg_multisphere_menu.Tag = 'nut_eeg_multisphere_menu';

            % Create nut_importLsc_menu
            app.nut_importLsc_menu = uimenu(app.nut_localspheres_menu);
            app.nut_importLsc_menu.Enable = 'off';
            app.nut_importLsc_menu.Text = 'Load';
            app.nut_importLsc_menu.Tag = 'nut_importLsc_menu';

            % Create nut_exportLsc_menu
            app.nut_exportLsc_menu = uimenu(app.nut_localspheres_menu);
            app.nut_exportLsc_menu.Enable = 'off';
            app.nut_exportLsc_menu.Text = 'Save';
            app.nut_exportLsc_menu.Tag = 'nut_exportLsc_menu';

            % Create Untitled_2
            app.Untitled_2 = uimenu(app.nuteeg);
            app.Untitled_2.Separator = 'on';
            app.Untitled_2.Text = 'Lead Potential';
            app.Untitled_2.Tag = 'Untitled_2';

            % Create nut_importLp_menu
            app.nut_importLp_menu = uimenu(app.Untitled_2);
            app.nut_importLp_menu.Enable = 'off';
            app.nut_importLp_menu.Text = 'Load';
            app.nut_importLp_menu.Tag = 'nut_importLp_menu';

            % Create nut_exportLp_menu
            app.nut_exportLp_menu = uimenu(app.Untitled_2);
            app.nut_exportLp_menu.Enable = 'off';
            app.nut_exportLp_menu.Text = 'Save';
            app.nut_exportLp_menu.Tag = 'nut_exportLp_menu';

            % Create nut_import_smac
            app.nut_import_smac = uimenu(app.Untitled_2);
            app.nut_import_smac.Text = 'Import SMAC Lead Field and Solution Points';
            app.nut_import_smac.Tag = 'nut_import_smac';

            % Create nut_import_cartool
            app.nut_import_cartool = uimenu(app.Untitled_2);
            app.nut_import_cartool.Text = 'Import Cartool Lead Field and Solution Points';
            app.nut_import_cartool.Tag = 'nut_import_cartool';

            % Create nut_logo_axes
            app.nut_logo_axes = uiaxes(app.nutmegfig);
            app.nut_logo_axes.CameraPosition = [0.5 0.5 9.16025403784439];
            app.nut_logo_axes.CameraTarget = [0.5 0.5 0.5];
            app.nut_logo_axes.CameraUpVector = [0 1 0];
            app.nut_logo_axes.CameraViewAngle = 6.60861036031192;
            app.nut_logo_axes.DataAspectRatio = [1 1 1];
            app.nut_logo_axes.PlotBoxAspectRatio = [1 1 1];
            app.nut_logo_axes.FontName = 'helvetica';
            app.nut_logo_axes.XLim = [0 1];
            app.nut_logo_axes.YLim = [0 1];
            app.nut_logo_axes.ZLim = [0 1];
            app.nut_logo_axes.CLim = [0 1];
            app.nut_logo_axes.ALim = [0 1];
            app.nut_logo_axes.Layer = 'top';
            app.nut_logo_axes.XTick = [0 0.2 0.4 0.6 0.8 1];
            app.nut_logo_axes.XTickLabel = {'0  '; '0.2'; '0.4'; '0.6'; '0.8'; '1  '};
            app.nut_logo_axes.YTick = [0 0.5 1];
            app.nut_logo_axes.YTickLabel = {'0  '; '0.5'; '1  '};
            app.nut_logo_axes.ZTick = [0 0.5 1];
            app.nut_logo_axes.ZTickLabel = '';
            app.nut_logo_axes.FontSize = 12;
            app.nut_logo_axes.TickDir = 'in';
            app.nut_logo_axes.NextPlot = 'replace';
            app.nut_logo_axes.Tag = 'nut_logo_axes';
            app.nut_logo_axes.Visible = 'off';
            app.nut_logo_axes.Position = [449 45 208 126];

            % Create nut_CoregistrationButton
            app.nut_CoregistrationButton = uibutton(app.nutmegfig, 'push');
            app.nut_CoregistrationButton.Tag = 'nut_CoregistrationButton';
            app.nut_CoregistrationButton.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_CoregistrationButton.FontName = 'helvetica';
            app.nut_CoregistrationButton.Tooltip = 'optional';
            app.nut_CoregistrationButton.Position = [42 109 108 24];
            app.nut_CoregistrationButton.Text = 'Coregister MRI...';

            % Create nut_savesession_button
            app.nut_savesession_button = uibutton(app.nutmegfig, 'push');
            app.nut_savesession_button.Tag = 'nut_savesession_button';
            app.nut_savesession_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_savesession_button.FontName = 'helvetica';
            app.nut_savesession_button.Position = [42 149 108 24];
            app.nut_savesession_button.Text = 'Save Session...';

            % Create nut_refresh_image_button
            app.nut_refresh_image_button = uibutton(app.nutmegfig, 'push');
            app.nut_refresh_image_button.Tag = 'nut_refresh_image_button';
            app.nut_refresh_image_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_refresh_image_button.FontName = 'helvetica';
            app.nut_refresh_image_button.Position = [42 82 108 24];
            app.nut_refresh_image_button.Text = 'Refresh MRI';

            % Create nut_reset_button
            app.nut_reset_button = uibutton(app.nutmegfig, 'push');
            app.nut_reset_button.Tag = 'nut_reset_button';
            app.nut_reset_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_reset_button.FontName = 'helvetica';
            app.nut_reset_button.Position = [41 36 108 24];
            app.nut_reset_button.Text = 'New Subject';

            % Create nut_opensession_button
            app.nut_opensession_button = uibutton(app.nutmegfig, 'push');
            app.nut_opensession_button.Tag = 'nut_opensession_button';
            app.nut_opensession_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_opensession_button.FontName = 'helvetica';
            app.nut_opensession_button.Position = [42 176 108 24];
            app.nut_opensession_button.Text = 'Open Session...';

            % Create nut_sbeam_button
            app.nut_sbeam_button = uibutton(app.nutmegfig, 'push');
            app.nut_sbeam_button.Tag = 'nut_sbeam_button';
            app.nut_sbeam_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_sbeam_button.FontName = 'helvetica';
            app.nut_sbeam_button.Position = [186 15 150 24];
            app.nut_sbeam_button.Text = 'Display Results';

            % Create nut_importmeg_button
            app.nut_importmeg_button = uibutton(app.nutmegfig, 'push');
            app.nut_importmeg_button.Tag = 'nut_importmeg_button';
            app.nut_importmeg_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_importmeg_button.FontName = 'helvetica';
            app.nut_importmeg_button.Position = [186 176 150 24];
            app.nut_importmeg_button.Text = 'Load MEG/EEG Data...';

            % Create nut_displayMEG_button
            app.nut_displayMEG_button = uibutton(app.nutmegfig, 'push');
            app.nut_displayMEG_button.Tag = 'nut_displayMEG_button';
            app.nut_displayMEG_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_displayMEG_button.FontName = 'helvetica';
            app.nut_displayMEG_button.FontSize = 10.6666666666667;
            app.nut_displayMEG_button.Enable = 'off';
            app.nut_displayMEG_button.Position = [186 143 150 24];
            app.nut_displayMEG_button.Text = 'View/Select MEG Channels';

            % Create nut_beamforming_button
            app.nut_beamforming_button = uibutton(app.nutmegfig, 'push');
            app.nut_beamforming_button.Tag = 'nut_beamforming_button';
            app.nut_beamforming_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_beamforming_button.FontName = 'helvetica';
            app.nut_beamforming_button.FontSize = 10.6666666666667;
            app.nut_beamforming_button.Enable = 'off';
            app.nut_beamforming_button.Position = [186 82 155 24];
            app.nut_beamforming_button.Text = 'Source Analysis: Time Series';

            % Create nut_megfile
            app.nut_megfile = uilabel(app.nutmegfig);
            app.nut_megfile.Tag = 'nut_megfile';
            app.nut_megfile.BackgroundColor = [0.996108949416342 0.867200732433051 0.675791561760891];
            app.nut_megfile.VerticalAlignment = 'top';
            app.nut_megfile.WordWrap = 'on';
            app.nut_megfile.FontName = 'helvetica';
            app.nut_megfile.Position = [342 178 300 18];
            app.nut_megfile.Text = '(none loaded)';

            % Create nut_voxelsize_text
            app.nut_voxelsize_text = uieditfield(app.nutmegfig, 'text');
            app.nut_voxelsize_text.Tag = 'nut_voxelsize_text';
            app.nut_voxelsize_text.HorizontalAlignment = 'right';
            app.nut_voxelsize_text.FontName = 'Sans Serif';
            app.nut_voxelsize_text.FontSize = 10.6666666666667;
            app.nut_voxelsize_text.Position = [343 116 24 18];
            app.nut_voxelsize_text.Value = '5';

            % Create text14
            app.text14 = uilabel(app.nutmegfig);
            app.text14.Tag = 'text14';
            app.text14.BackgroundColor = [0.800793469138628 0.699229419394217 0.542977035172045];
            app.text14.VerticalAlignment = 'top';
            app.text14.WordWrap = 'on';
            app.text14.FontName = 'Sans Serif';
            app.text14.FontSize = 10.6666666666667;
            app.text14.Position = [369 113 68 18];
            app.text14.Text = 'mm voxels';

            % Create nut_leadfield_button
            app.nut_leadfield_button = uibutton(app.nutmegfig, 'push');
            app.nut_leadfield_button.Tag = 'nut_leadfield_button';
            app.nut_leadfield_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_leadfield_button.FontName = 'helvetica';
            app.nut_leadfield_button.Enable = 'off';
            app.nut_leadfield_button.Position = [186 113 150 24];
            app.nut_leadfield_button.Text = 'Obtain Lead Field';

            % Create pushbutton54
            app.pushbutton54 = uibutton(app.nutmegfig, 'push');
            app.pushbutton54.Tag = 'pushbutton54';
            app.pushbutton54.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.pushbutton54.FontName = 'helvetica';
            app.pushbutton54.Enable = 'off';
            app.pushbutton54.Visible = 'off';
            app.pushbutton54.Position = [360 74 172 22];
            app.pushbutton54.Text = 'Compute Lead Field (old)';

            % Create nut_tfbf_button
            app.nut_tfbf_button = uibutton(app.nutmegfig, 'push');
            app.nut_tfbf_button.Tag = 'nut_tfbf_button';
            app.nut_tfbf_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_tfbf_button.FontName = 'helvetica';
            app.nut_tfbf_button.FontSize = 10.6666666666667;
            app.nut_tfbf_button.Position = [186 53 155 24];
            app.nut_tfbf_button.Text = 'Source Analysis: Time-Freq';

            % Create nut_timefstats_button
            app.nut_timefstats_button = uibutton(app.nutmegfig, 'push');
            app.nut_timefstats_button.Tag = 'nut_timefstats_button';
            app.nut_timefstats_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_timefstats_button.FontName = 'helvetica';
            app.nut_timefstats_button.Position = [351 15 84 24];
            app.nut_timefstats_button.Text = 'Statistics';

            % Create pushbutton57
            app.pushbutton57 = uibutton(app.nutmegfig, 'push');
            app.pushbutton57.Tag = 'pushbutton57';
            app.pushbutton57.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.pushbutton57.FontName = 'helvetica';
            app.pushbutton57.Enable = 'off';
            app.pushbutton57.Visible = 'off';
            app.pushbutton57.Position = [410 92 150 24];
            app.pushbutton57.Text = 'Compute Lead Field (old_8Jun09)';

            % Create nut_FCM_button
            app.nut_FCM_button = uibutton(app.nutmegfig, 'push');
            app.nut_FCM_button.Tag = 'nut_FCM_button';
            app.nut_FCM_button.BackgroundColor = [0.92970168612192 0.808606088349737 0.62891584649424];
            app.nut_FCM_button.FontName = 'helvetica';
            app.nut_FCM_button.Position = [452 15 84 24];
            app.nut_FCM_button.Text = 'FCM';

            % Show the figure after all components are created
            app.nutmegfig.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = nutmeg(varargin)

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.nutmegfig)

                % Execute the startup function
                runStartupFcn(app, @(app)nutmeg_OpeningFcn(app, varargin{:}))
            else

                % Focus the running singleton app
                figure(runningApp.nutmegfig)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.nutmegfig)
        end
    end
end