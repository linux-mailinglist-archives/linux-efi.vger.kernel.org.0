Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9D1D681C
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgEQM6y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 May 2020 08:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgEQM6y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 17 May 2020 08:58:54 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE478207D4;
        Sun, 17 May 2020 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589720332;
        bh=6E68aEPOceXY2JUM2lcRV5fat0r6tb4MJlYatfkYf+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laqU9gqtBPCstQAPd6rlju5HVorbAE8W/dqgIdLM2JS5SeH9YIH8o9HlceqtZwo5u
         JYs/MMdlkgD7hZEaC4N0M9/DtJ3XYeFyPhec9A285n3jJUK0kPkULQ11ImNQUkpRDG
         mmAs2RG3zWCFq7g7hTPWOYdm58sUkzrWe2J3tpRc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        linux-acpi@vger.kernel.org, Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH 5/7] x86/boot: Mark global variables as static
Date:   Sun, 17 May 2020 14:57:52 +0200
Message-Id: <20200517125754.8934-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517125754.8934-1-ardb@kernel.org>
References: <20200517125754.8934-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Mike Lothian reports that after commit
  964124a97b97 ("efi/x86: Remove extra headroom for setup block")
gcc 10.1.0 fails with

  HOSTCC  arch/x86/boot/tools/build
  /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld:
  error: linker defined: multiple definition of '_end'
  /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld:
  /tmp/ccEkW0jM.o: previous definition here
  collect2: error: ld returned 1 exit status
  make[1]: *** [scripts/Makefile.host:103: arch/x86/boot/tools/build] Error 1
  make: *** [arch/x86/Makefile:303: bzImage] Error 2

The issue is with the _end variable that was added, to hold the end of
the compressed kernel from zoffsets.h (ZO__end). The name clashes with
the linker-defined _end symbol that indicates the end of the build
program itself.

Even when there is no compile-time error, this causes build to use
memory past the end of its .bss section.

To solve this, mark _end as static, and for symmetry, mark the rest of
the variables that keep track of symbols from the compressed kernel as
static as well.

Fixes: 964124a97b97 ("efi/x86: Remove extra headroom for setup block")
Reported-by: Mike Lothian <mike@fireburn.co.uk>
Tested-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200511225849.1311869-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/tools/build.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 8f8c8e386cea..c8b8c1a8d1fc 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,14 +59,14 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_COMPAT_RESERVE 0x0
 #endif
 
-unsigned long efi32_stub_entry;
-unsigned long efi64_stub_entry;
-unsigned long efi_pe_entry;
-unsigned long efi32_pe_entry;
-unsigned long kernel_info;
-unsigned long startup_64;
-unsigned long _ehead;
-unsigned long _end;
+static unsigned long efi32_stub_entry;
+static unsigned long efi64_stub_entry;
+static unsigned long efi_pe_entry;
+static unsigned long efi32_pe_entry;
+static unsigned long kernel_info;
+static unsigned long startup_64;
+static unsigned long _ehead;
+static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
 
-- 
2.17.1

