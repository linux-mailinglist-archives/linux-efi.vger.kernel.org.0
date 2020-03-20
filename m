Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8AD18C520
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCTCBY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:01:24 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:43435 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCTCAd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:33 -0400
Received: by mail-qk1-f181.google.com with SMTP id x18so5376578qki.10;
        Thu, 19 Mar 2020 19:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AeGhU+XJtuOPs3cRLNFViNTkzOH17jcA/a34LgeIkSw=;
        b=aq4OHE/phBWP1IjK3aZCrnawXgjFXaWfTifotFP7BuXGd2TSc3K2gfLzel3p9rN6y8
         CHjYypIJ3s7MifasLxUVGqOdHnSV9vhzcIPaKyIQOpkPTuORtvUoMqcNanzoYzzwwflk
         fFFQd0w5w6HgRKHfclgj89U0Axu15OPh/vdrB5jtSkgui2zGmWdC+UDuwb5Bn8Z+775h
         dDRVOd1Ly8nvbh4IWoy6wOo2/RK52N+g6r+DLxPkedgFjnXToe16EIQphUMPluccd9gG
         lPrdoux7212Swb4OPiuYd1Q7RXpcoLDsos0HjhrUlaqa7XhFDTuZJpLCmoR4tjXXfOeI
         Dpqw==
X-Gm-Message-State: ANhLgQ2ry76fn9D7aFdIPoEam585NgQjHb0+1StlXmYv2LLbomA4cSdL
        P7d1z+6+pONOTWi6abLuTvs=
X-Google-Smtp-Source: ADFU+vuYAuraRM34QGCeIGQxO2X9JnyFXoVl2vLu4umGI3M8e/EYAYX6dEjzwMv0Ww/mVra5lFffwQ==
X-Received: by 2002:a37:7e82:: with SMTP id z124mr5776266qkc.360.1584669630572;
        Thu, 19 Mar 2020 19:00:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/14] efi/gop: Refactoring + mode-setting feature
Date:   Thu, 19 Mar 2020 22:00:14 -0400
Message-Id: <20200320020028.1936003-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is against tip:efi/core.

Patches 1-9 are small cleanups and refactoring of the code in
libstub/gop.c.

The rest of the patches add the ability to use a command-line option to
switch the gop's display mode.

The options supported are:
video=efifb:mode=n
        Choose a specific mode number
video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]
        Specify mode by resolution and optionally color depth
video=efifb:auto
        Let the EFI stub choose the highest resolution mode available.

The mode-setting additions increase code size of gop.o by about 3k on
x86-64 with EFI_MIXED enabled.

Changes in v2 (HT lkp@intel.com):
- Fix __efistub_global attribute to be after the variable.
  (NB: bunch of other places should ideally be fixed, those I guess
  don't matter as they are scalars?)
- Silence -Wmaybe-uninitialized warning in set_mode function.

Arvind Sankar (14):
  efi/gop: Remove redundant current_fb_base
  efi/gop: Move check for framebuffer before con_out
  efi/gop: Get mode information outside the loop
  efi/gop: Factor out locating the gop into a function
  efi/gop: Slightly re-arrange logic of find_gop
  efi/gop: Move variable declarations into loop block
  efi/gop: Use helper macros for populating lfb_base
  efi/gop: Use helper macros for find_bits
  efi/gop: Remove unreachable code from setup_pixel_info
  efi/gop: Add prototypes for query_mode and set_mode
  efi/gop: Allow specifying mode number on command line
  efi/gop: Allow specifying mode by <xres>x<yres>
  efi/gop: Allow specifying depth as well as resolution
  efi/gop: Allow automatically choosing the best mode

 Documentation/fb/efifb.rst                    |  33 +-
 arch/x86/include/asm/efi.h                    |   4 +
 .../firmware/efi/libstub/efi-stub-helper.c    |   3 +
 drivers/firmware/efi/libstub/efistub.h        |   8 +-
 drivers/firmware/efi/libstub/gop.c            | 489 ++++++++++++++----
 5 files changed, 428 insertions(+), 109 deletions(-)


base-commit: d5528d5e91041e68e8eab9792ce627705a0ed273
-- 
2.24.1

