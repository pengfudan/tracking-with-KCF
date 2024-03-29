function update_visualization_func = show_video(img_files, video_path, resize_image)
%SHOW_VIDEO
%   Visualizes a tracker in an interactive figure, given a cell array of
%   image file names, their path, and whether to resize the images to
%   half size or not.

	%store one instance per frame
	num_frames = numel(img_files);
	boxes = cell(num_frames,1);

	%create window
	[fig_h, axes_h, unused, scroll] = videofig(num_frames, @redraw, [], [], @on_key_press);  %#ok, unused outputs
	set(fig_h, 'NumberTitle','off', 'Name', ['Tracker - ' video_path])%'Number','off', 'Name',
	axis off;
	
	%image and rectangle handles start empty, they are initialized later
	im_h = [];
	rect_h = [];
	
	update_visualization_func = @update_visualization;
	stop_tracker = false;
	

	function stop = update_visualization(frame, box)
		%store the tracker instance for one frame, and show it. returns
		%true if processing should stop (user pressed 'Esc').
		boxes{frame} = box;
		scroll(frame);
		stop = stop_tracker;
	end

	function redraw(frame)
		%render main image
		im = imread([video_path img_files{frame}]);
		if size(im,3) > 1,
			im = rgb2gray(im);
		end
		if resize_image,
			im = imresize(im, 0.5);
		end
		
		if isempty(im_h),  %create image
			im_h = imshow(im, 'Border','tight', 'InitialMag',200, 'Parent',axes_h);
		else  %just update it
			set(im_h, 'CData', im)
		end
		
		%render target bounding box for this frame
		if isempty(rect_h),  %create it for the first time
			rect_h = rectangle('Position',[0,0,1,1], 'EdgeColor','g', 'Parent',axes_h);
		end
		if ~isempty(boxes{frame}),
			set(rect_h, 'Visible', 'on', 'Position', boxes{frame});
		else
			set(rect_h, 'Visible', 'off');
		end
	end

	function on_key_press(key)
		if strcmp(key, 'escape'),  %stop on 'Esc'
			stop_tracker = true;
		end
	end

end

