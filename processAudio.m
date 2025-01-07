function formattedAudio = processAudio(inputAudio, fs)
    % Process and format mixed audio signal
    %
    % Parameters:
    %   inputAudio: Matrix representing the mixed audio signal
    %   fs: Sampling frequency of the audio signal
    %
    % Returns:
    %   formattedAudio: Formatted and truncated audio matrix (stereo, max 15 seconds)
    
    % Constants
    MAX_DURATION = 30; % Maximum duration in seconds
    MAX_SAMPLES = MAX_DURATION * fs; % Maximum samples for the given duration
    
    % Check if input audio is valid
    if isempty(inputAudio)
        error('Input audio is empty.');
    end
    
    % Determine audio dimensions
    [numSamples, numChannels] = size(inputAudio);
    
    % Truncate audio if it exceeds the maximum duration
    if numSamples > MAX_SAMPLES
        inputAudio = inputAudio(1:MAX_SAMPLES, :);
    end
    
    % Handle mono audio by duplicating the channel
    if numChannels == 1
        inputAudio = [inputAudio, inputAudio]; % Convert to stereo
    elseif numChannels > 2
        % Handle multi-channel audio by reducing to stereo
        monoAudio = mean(inputAudio, 2); % Convert to mono
        inputAudio = [monoAudio, monoAudio]; % Convert mono to stereo
    end
    
    % Normalize audio to avoid clipping
    maxAmplitude = max(abs(inputAudio(:)));
    if maxAmplitude > 1
        inputAudio = inputAudio / maxAmplitude;
    end
    
    % Output the formatted audio
    formattedAudio = inputAudio;
end
