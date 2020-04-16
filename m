Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2411D1AC8AC
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 17:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395082AbgDPPMd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 11:12:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43328 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395079AbgDPPMa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Apr 2020 11:12:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id 20so13555963qkl.10;
        Thu, 16 Apr 2020 08:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z50ZsQ8IUFKM+b5Biw9UtKMzIva0+uiY3DIJESbMIYI=;
        b=b3AvZJdB+XYSInOhwiqHoL54WbIpkjelfc/zxOKcDkELhhrh6/iJPR+Hv1B67DRe/k
         s8Z9GatXTDh3tu0sppjh2cWoBe6BOt65w1ggHYRC42aleTJSn6VVae7hhs0V7SjkfvtC
         fnDgTkiCoE19/aVbIVS8Ma7lccntWq8VFlCzEYQ+VwrduM/12Xd1E3JjpxTuuP1EBuR2
         Pq/Tv3VdPBqF23Wcie1Kyho/1wHUQ82vkvodZ32VimH6BeDUVtXmPSt348/Sor9wV/Oz
         pkkEF4pZRfJcrUHGYF+n18u2nIFOowxakQFK61i+OtPErT7/KNF14Fc7sWA+NIt7CyLW
         mhUQ==
X-Gm-Message-State: AGi0PuaDmYZRx2YAB1yUYmL/lTJy+iVId4sJkc5+Jtq7mFzhdjDy3R6W
        CWl/NFkmJzjOGgMGDO+46Rk=
X-Google-Smtp-Source: APiQypL6nC7+eoW1r8jlGp0Pbr9X6TqFhXKgLwxJWfl9Gn6UCRZwndkSTjZyZCGBOb2DmniWXBxoFQ==
X-Received: by 2002:a37:7242:: with SMTP id n63mr30880327qkc.111.1587049949214;
        Thu, 16 Apr 2020 08:12:29 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c207sm15252197qkb.7.2020.04.16.08.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:12:28 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] efi: Remove __efistub_global annotation
Date:   Thu, 16 Apr 2020 11:12:24 -0400
Message-Id: <20200416151227.3360778-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200415221520.2692512-1-nivedita@alum.mit.edu>
References: <20200415221520.2692512-1-nivedita@alum.mit.edu>
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

Changes from v1:
- drop patch 2 and squash patches 3 and 5 for x86
- fix R_X86 -> R_386
- only check native relocation size (32-bit for R386 and 64-bit for
  RX86_64)

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

Arvind Sankar (3):
  efi/arm: Remove __efistub_global annotation
  efi/x86: Remove __efistub_global and add relocation check
  efi: Kill __efistub_global

 arch/arm/boot/compressed/vmlinux.lds.S        |  2 +-
 arch/x86/boot/compressed/vmlinux.lds.S        |  1 +
 drivers/firmware/efi/libstub/Makefile         | 31 +++++++++++++------
 drivers/firmware/efi/libstub/arm-stub.c       |  4 +--
 .../firmware/efi/libstub/efi-stub-helper.c    | 15 +++++----
 drivers/firmware/efi/libstub/efistub.h        |  6 ----
 drivers/firmware/efi/libstub/gop.c            |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c       |  2 +-
 8 files changed, 34 insertions(+), 29 deletions(-)

-- 
2.25.3

