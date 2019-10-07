#!/bin/bash

function tunnel(){
  if [[ -z $1 ]]; then
      echo "Takes an ssh config host name and starts an SSH tunnel"
      echo "$1 required: name of an ssh tunnel host"
      echo "$2 optional: run the tunnel as a background job if defined"
      return -1
  fi

  if [[ -z $2 ]]; then
    sudo ssh -f -N $1
  else
    sudo ssh -f -N $1 &
  fi
}

function pubkey(){
  if [[ -z $1 ]]; then
    echo "Takes a path to a private key and prints a compatible public key to stdout"
    echo "$1 required: path to a private key"
    return -1
  fi


  ssh-keygen -y -f $1
}
