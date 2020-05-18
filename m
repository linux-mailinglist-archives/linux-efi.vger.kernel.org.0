Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD5D1D87D1
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgERTHT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:19 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33286 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgERTHT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:19 -0400
Received: by mail-qv1-f67.google.com with SMTP id er16so4752910qvb.0
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5gmfhBy4ZQi73aV4VUxL+02Na527LTWFeRnHN1oNEH0=;
        b=qQlovKc2D9FpnGWyB9vu4Mnxw6t3vLuEtRMtdwO98324TtVHvgJk7XIcDsDdudLJ5V
         IUKjsXlxDpel2A/Z63gDmhUsxXSdjHOn6FSoRVs4OED6umcUiSaGGo4BTd+dabbifUx4
         wWQyW7BSEHrXdrN5sJ9oXVv74lYckKckn04jaZNK/rlMcZI1g4k6FRRykcxnjY6I+r3F
         mDBf5R6VTpKfDWx9meUoPuP3QYlDCLbe+fUnAX0z0//nFXVt1f53SNUrl3o5L2bo8Ov6
         UrdrFzg850f+ITbbE3p4ExjCgrMNEZtrZRep+rBMWyNy7VPNzTCe4v9o2SvGzQFvjZ8w
         qIxw==
X-Gm-Message-State: AOAM532MGFZc/oJRihuNpz+iGMibqUL0KQzuWkYdoWKG4X/WfONCCM3C
        jdT9VBnYtc2fZEYup8VeAMBYK/r9SHI=
X-Google-Smtp-Source: ABdhPJxjpOdeuNsGJ1i6gL8DMTmlLbfRhA1+FFF1TnMYkyyenkbyHrMU+s/v5WZmwNR0L+yGN+aEUw==
X-Received: by 2002:ad4:57a2:: with SMTP id g2mr7159916qvx.137.1589828837514;
        Mon, 18 May 2020 12:07:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:16 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 00/24] efi/libstub: Add printf implementation
Date:   Mon, 18 May 2020 15:06:52 -0400
Message-Id: <20200518190716.751506-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series (on top of efi/next) adds a basic printf implementation for
the EFI stub to use.

Patches 1-2 are minor cleanup.

Patch 3 adds an on-stack buffer for efi_puts to do the char to UTF-16
conversion, to avoid calling into the firmware for each character.

Patches 4-16 copy the simple printf implementation from
arch/x86/boot/printf.c and spruce it up. The main enhancements are
support for 64-bit integers and conversion to vsnprintf. There are small
fixes to correct the behavior for edge cases (detailed in the individual
patches).

Patch 17 changes efi_info/efi_err to actually use efi_printk, and
introduces a loglevel into the EFI stub instead of just quiet/non-quiet.
The loglevels are reused from the main kernel. An efi_debug macro is
also added, but is currently unused. As an aside, we chose efi_info over
efi_pr_info, but I'm wondering whether we should make it efi_pr_info
after all: there is already an efi_info symbol (structure type and field
name) so it might lead to some confusion.

Patch 18-19 add an option to list the available modes from the GOP,
which should make using the new video=efifb parameters easier.

Patches 20-24 incorporate UTF-16 support into the new printf function
and use it in a couple of places.

Arvind Sankar (24):
  efi/libstub: Include dependencies of efistub.h
  efi/libstub: Rename efi_[char16_]printk to efi_[char16_]puts
  efi/libstub: Buffer output of efi_puts
  efi/libstub: Add a basic printf implementation
  efi/libstub: Optimize for size instead of speed
  efi/printf: Drop %n format and L qualifier
  efi/printf: Add 64-bit and 8-bit integer support
  efi/printf: Factor out flags parsing and handle '%' earlier
  efi/printf: Fix minor bug in precision handling
  efi/printf: Merge 'p' with the integer formats
  efi/printf: Factor out width/precision parsing
  efi/printf: Factor out integer argument retrieval
  efi/printf: Handle null string input
  efi/printf: Refactor code to consolidate padding and output
  efi/printf: Abort on invalid format
  efi/printf: Turn vsprintf into vsnprintf
  efi/libstub: Implement printk-style logging
  efi/libstub: Add definitions for console input and events
  efi/gop: Add an option to list out the available GOP modes
  efi/printf: Add support for wchar_t (UTF-16)
  efi/libstub: Add UTF-8 decoding to efi_puts
  efi/libstub: Use %ls for filename
  efi/libstub: Get the exact UTF-8 length
  efi/libstub: Use snprintf with %ls to convert the command line

 Documentation/fb/efifb.rst                    |   5 +
 arch/x86/include/asm/efi.h                    |  10 +
 arch/x86/xen/efi.c                            |   2 +-
 drivers/firmware/efi/libstub/Makefile         |   6 +-
 .../firmware/efi/libstub/efi-stub-helper.c    | 275 ++++++---
 drivers/firmware/efi/libstub/efistub.h        | 107 +++-
 drivers/firmware/efi/libstub/file.c           |   4 +-
 drivers/firmware/efi/libstub/gop.c            |  97 ++-
 drivers/firmware/efi/libstub/vsprintf.c       | 563 ++++++++++++++++++
 include/linux/efi.h                           |   4 +-
 10 files changed, 968 insertions(+), 105 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/vsprintf.c

-- 
2.26.2

