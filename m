Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4045A17980B
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 19:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgCDShC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 13:37:02 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41627 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgCDShB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 13:37:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so2142137qtr.8;
        Wed, 04 Mar 2020 10:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t72VC5FU9skZvPoRXT4JDlpkMHlun4zsQXYH+X7/xVY=;
        b=UC5KPX1gkAlUUPc2kuYqJ0+ltoF1px5EcNyw3DMaGx8n+BcTrVlCa3LG8V4y7sZzOd
         c2FsojccE2PuGcxgJ/1TBLWcoD+HfX+CC8AZftjDkN3WW1pze0DHVZXcSkhYGMtjgjSE
         5dmvkQAl6C1mOf2AQM3CslGr4AoIPzJPTq8L9gxbFcWnhW96sJGQXjGOZZHdybnoJL/x
         wSzczQq6SUHVmPlaIC5YQriShuTFhKIGLUTLMnJ4dbhaRirV+A2euJcOxWWILhcvbqKm
         vJ8GSA5exkg6KLsCat9nspe13+y1gPlhOb5gsMPM+f6qtcg3z3HL/uk5hwWjotTFd/7P
         hS7g==
X-Gm-Message-State: ANhLgQ3bm+fpC84Lf28pnMw+l//Iiy9ADxqa6CZDXJjoTi9qX5RA4W+A
        KoPlKcUepAMvXrIol93Fl2g=
X-Google-Smtp-Source: ADFU+vtG2/eGWH/ozxp6G3g7sKoqbi4VumUirf3Q9c83tQ/1/xaaXQiZ/cKgv2yL/wCM/5lU0YSa7Q==
X-Received: by 2002:ac8:7a9a:: with SMTP id x26mr3721562qtr.137.1583347020632;
        Wed, 04 Mar 2020 10:37:00 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g2sm14156230qkb.27.2020.03.04.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:37:00 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] efi/x86: Move mixed-mode thunk to efi/libstub
Date:   Wed,  4 Mar 2020 13:36:59 -0500
Message-Id: <20200304183659.257828-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit c2d0b470154c ("efi/libstub/x86: Incorporate eboot.c into
libstub") moved all the callers of the mixed-mode thunk into
efi/libstub, so move the thunk itself as well for completeness.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/Makefile                                | 1 -
 drivers/firmware/efi/libstub/Makefile                            | 1 +
 .../firmware/efi/libstub/x86_64-thunk.S                          | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/x86/boot/compressed/efi_thunk_64.S => drivers/firmware/efi/libstub/x86_64-thunk.S (100%)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e51879bdc51c..047004d39a55 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -88,7 +88,6 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
-vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 4d6246c6f651..85b66e5e5d1f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -55,6 +55,7 @@ lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o \
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
 lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_EFI_MIXED)		+= x86_64-thunk.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/drivers/firmware/efi/libstub/x86_64-thunk.S
similarity index 100%
rename from arch/x86/boot/compressed/efi_thunk_64.S
rename to drivers/firmware/efi/libstub/x86_64-thunk.S
-- 
2.24.1

