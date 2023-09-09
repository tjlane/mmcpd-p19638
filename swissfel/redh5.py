#!/usr/bin/env python

_description="""
Reduce a "raw" SwissFEL JF4 HDF5 file to just the hits.

Takes a list of stream files with preliminary peakfinding
results, and generates a new HDF5 file containing only
the "hit" images.

Two manually selectable parameters are available for determining
what constitutes a hit:

  * threshold on the total number of found peaks
  * threshold on the maximum peak resolution found

Notes:

  1. when multiple HDF5s with different initial pixel_masks
     are used, the masks are multiplied (AND operator)
"""

#  -- TJL <thomas.joseph.lane@gmail.com>
#     July 2022


import numpy as np
import re
import h5py
import argparse


def yield_hits(stream, min_peaks, min_res):

    for l in stream:

        if l.startswith('----- Begin chunk -----'):
            chunk_info = {}

        elif l.startswith('Image filename:'):
            chunk_info['filename'] = l.split(":")[1].strip()

        elif l.startswith('Event:'):
            chunk_info['event'] = int(l.split(":")[1].strip().strip('/').strip())

        elif l.startswith('num_peaks'):
            chunk_info['num_peaks'] = int(l.split("=")[1].strip())

        elif l.startswith('peak_resolution'):
            g = re.match('peak_resolution = \d+\.\d+ nm\^-1 or (\d+)\.(\d+) A',l)
            if g:
                res_str = g.group(1) + '.' + g.group(2)
                chunk_info['res'] = float(res_str)
            else:
                chunk_info['res'] = 1e308

        if l.startswith('----- End chunk -----') and (len(chunk_info) > 0):

            if (chunk_info['num_peaks'] >= min_peaks) and \
               (chunk_info['res'] <= min_res):

                yield chunk_info['filename'], chunk_info['event']


def copy_events(source_h5, destination_h5, events):

    fields = [
        '/data/JF06T08V02/data',
        '/data/JF06T08V02/frame_index',
        '/data/JF06T08V02/pulse_id',
    ]

    for f in fields:
       
        dest_f = destination_h5[f]
        o_size = dest_f.shape[0]
        dest_f.resize(o_size + len(events), axis = 0)

        for i,e in enumerate(events):
            print('\t{} / {}'.format(i+1, len(events)), end='\r')
            dest_f[o_size + i,...] = source_h5[f][e]

    return


def copy_singletons(source_h5, destination_h5):

    # if these dont exist at destination, make and copy
    # if they do exist, check they are the same!

    fields = [
         '/general/detector_name',
         '/data/JF06T08V02/conversion_factor',
    ]

    for f in fields:
        
        val = destination_h5.get(f, None)

        if val:
            if not destination_h5[f] == source_h5[f]:
                print('warning: {} not same in source & dest!'.format(f))
        else:
            destination_h5[f] = np.array(source_h5[f])


    # for mask, we take product
    f = '/data/JF06T08V02/pixel_mask'
    val = destination_h5.get(f, None)
    if val:
        destination_h5[f] = np.logical_and(np.array(destination_h5[f]),
                                           np.array(source_h5[f]))
    else:
        destination_h5[f] = np.array(source_h5[f])

    return


def main():


    # parse arguments
    parser = argparse.ArgumentParser(description=_description)
    parser.add_argument('streams', nargs='+',
                        help='list of stream files')
    parser.add_argument('-o', '--output', required=True,
                        help='name of the HDF5 file to be created')
    parser.add_argument('-p', '--min-peaks', default=20, type=int,
                        help='minimum number of peaks needed to be'
                             'determined a hit (default: 20)')
    parser.add_argument('-r', '--min-res', default=999.0, type=float,
                        help='minimum resolution (of the highest'
                             'resolution peak found) to be determined'
                             'a hit, in Angstroem (default: 999.0)')
    args = parser.parse_args()

    print("")
    print(" --- REDUCE DATA by HITFINDING --- ")
    print(" >> processing {} streams".format(len(args.streams)))
    print(" >> min peaks: {}".format(args.min_peaks))
    print(" >> min res:   {} A".format(args.min_res))
    print("   ---> {}".format(args.output))
    print("")


    # prepare the data fields at the destination
    destination_h5 = h5py.File(args.output, 'w')

    g_data = destination_h5.create_group('data')
    g_jf = g_data.create_group('JF06T08V02')

    img_ds = g_jf.create_dataset('data', (0, 4112, 1030), 
                                 maxshape=(None, 4112, 1030),
                                 dtype='i')
    fi_ds = g_jf.create_dataset('frame_index', (0,), maxshape=(None,),
                                dtype='L')
    pid_ds = g_jf.create_dataset('pulse_id', (0,), maxshape=(None,),
                                 dtype='L')


    # loop over stream files + add entries into new HDF5

    current_h5 = None
    source_h5s = []
    events     = []

    for stream in args.streams:

        with open(stream, 'r') as stream_f:
            for h5_path, event in yield_hits(stream_f, 
                                             args.min_peaks, 
                                             args.min_res):

                # events --> destination_h5
        
                if h5_path != current_h5: # new source hdf5

                    # because every HDF5 append operation requires
                    # resizing the HDF5 array, it's more efficient
                    # to append many events at once

                    # before beginning new source h5, append events
                    if len(events) > 0:
                        copy_events(source_h5, destination_h5, events)
                        print(current_h5)
                        events = []

                    # initialize new source h5
                    source_h5s.append(h5_path)
                    source_h5 = h5py.File(h5_path, 'r')
                    current_h5 = source_h5.filename
                    copy_singletons(source_h5, destination_h5)

                events.append(event)

            # copy events for the final h5
            if len(events) > 0:
                print(current_h5)
                copy_events(source_h5, destination_h5, events)
                events = []


    # we inject two new fields into the HDF5
    #   1. /source/hdf5
    #   2. /source/stream

    destination_h5['/source/hdf5'] = source_h5s
    destination_h5['/source/streams'] = args.streams

    print("")

    return




if __name__ == '__main__':
    main()

