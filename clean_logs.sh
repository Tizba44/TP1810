#!/bin/bash
# Nettoyer les journaux système de plus de 7 jours
journalctl --vacuum-time=7d
