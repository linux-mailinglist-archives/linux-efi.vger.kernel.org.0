Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF21AB3A3
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 00:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgDOWPY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 18:15:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41306 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgDOWPW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 18:15:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id y3so19286298qky.8;
        Wed, 15 Apr 2020 15:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LncCRWwsHSyHm2+Q1R5MkVDJxDhecE7946LHPNlHWxE=;
        b=YiOpi0E4CyKRbRehnzXPgjrX9vshvvDZUBPufwHYeY7uR/gzNciq+szY11K4hNQ1zH
         dQHgNIm0CPPmVkJyC7/Zmrr6twaJ/enGMtUE8sNNIFLwzo7umJOTV+gORCI2AhhPKMT9
         uqsLYyOuPI9rgl83eYeADiG2KlvVMgosjT7XVTY+V8HbmypF4XJoSC9T6CtaUAQugFqF
         yeejp4QreqeDakkhi+JGSklnhLtky/o+9Ai8At/Px3g5D7CrkX5GyjkkUkIt7azqrAxU
         ozI1WXwn4QpLKuChma6GysElkoX9s/ElG3BvNCQaw67f3lBG1CainFIp7Ewrvrl1k4HQ
         lkwA==
X-Gm-Message-State: AGi0PuYskHn8EHLDBX2VGv8Fu0wGBxx1NiejR1p09Y3DduUXxExQq81x
        uQrKF/Mmvx+pRC1fCQGr1rk=
X-Google-Smtp-Source: APiQypJsDv1bXLDEpxnZEb5zwIkObKu8f3Si7Aa/hJPgAYvnQd+75LxKQmr2QYWRZnG+xey3DQMsfw==
X-Received: by 2002:a05:620a:4f2:: with SMTP id b18mr28120143qkh.433.1586988921329;
        Wed, 15 Apr 2020 15:15:21 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i20sm13264340qkl.135.2020.04.15.15.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:15:20 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] efi: Remove __efistub_global annotation
Date:   Wed, 15 Apr 2020 18:15:15 -0400
Message-Id: <20200415221520.2692512-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch series removes the need for annotating global data in the EFI
stub with __efistub_global for ARM32 and X86.

This is done by renaming the .data and .bss sections in the object files
linked into the EFI stub to .data.efistub and .bss.efistub respectively,
and including those sections into the compressed kernel's .data section
using its linker script.

The series is based on efi/next, rebased onto v5.7-rc1, plus two earlier
fixes for x86 EFI that are queued for v5.7.

Patches on top of v5.7-rc1:
In efi/next:

Ard Biesheuvel (2):
      efi: clean up config table description arrays
      efi: move arch_tables check to caller

Arvind Sankar (19):
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

Additional:
Arvind Sankar (2):
      efi/x86: Move efi stub globals from .bss to .data
      efi/x86: Always relocate the kernel for EFI handover entry

Arvind Sankar (5):
  efi/arm: Remove __efistub_global annotation
  efi/libstub: Factor out relocation checking
  efi/x86: Remove __efistub_global annotation
  efi: Kill __efistub_global
  efi/x86: Check for bad relocations

 arch/arm/boot/compressed/vmlinux.lds.S        |  2 +-
 arch/x86/boot/compressed/vmlinux.lds.S        |  1 +
 drivers/firmware/efi/libstub/Makefile         | 43 +++++++++++++------
 drivers/firmware/efi/libstub/arm-stub.c       |  4 +-
 .../firmware/efi/libstub/efi-stub-helper.c    | 15 +++----
 drivers/firmware/efi/libstub/efistub.h        |  6 ---
 drivers/firmware/efi/libstub/gop.c            |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c       |  2 +-
 8 files changed, 42 insertions(+), 33 deletions(-)

-- 
2.24.1

