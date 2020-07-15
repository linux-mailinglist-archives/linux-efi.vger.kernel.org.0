Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15DA2202E5
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jul 2020 05:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgGOD0e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jul 2020 23:26:34 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44981 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgGOD0e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jul 2020 23:26:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id b4so542243qkn.11;
        Tue, 14 Jul 2020 20:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x02PSZ/ln73kH7sNoYBWCtnZv6JMMSwwMLMAhMgzHFw=;
        b=oB5fTh1Ruv4+IXDIiB/4KddIc+Bw45HUoNf3HKjt9ZHX4nLhes40WA/paDwK8P27At
         Bl+H4zzAv6N1TQJZwkvFRSUnkke0my5Qyjag7bG1UXuMgsn2YmLzC/0GJEqERlTqXw4v
         TGNQNYV4dJQKXr3pgbLYtNVCL07K1W0Ua+d2CwhDKiWzk1WhozKImARepvAfh/S9xhDI
         CJB4W1Zt58M2RHI8lCG+B1R2satc0Fl7fE+QADJh3fZ4OrD4FJeDmJS0omB1yJGhcgtd
         Keh+VMr4wcerOXPeHNBxWdiDtMPd0MWEgQebte0kytVQDDM0OMN1KjozOLtky95ZWRPV
         Edwg==
X-Gm-Message-State: AOAM5331ssa5Q3lZ7AIyeNVTw513I4e0PVdqnhGMtrJwvwig3BrkQ07m
        CDNZTNDEiY3ucSme4E5H+QE=
X-Google-Smtp-Source: ABdhPJyDVid+brrmtZb5Ifc3sfFV/6rCk4qRYru0r78cYTkiQXtL3W+Z6drnA9x1nieS2mBIhqZGoA==
X-Received: by 2002:a37:27c2:: with SMTP id n185mr7301100qkn.459.1594783593197;
        Tue, 14 Jul 2020 20:26:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f15sm838709qka.120.2020.07.14.20.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 20:26:32 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch/x86/boot: Don't add the EFI stub to targets
Date:   Tue, 14 Jul 2020 23:26:31 -0400
Message-Id: <20200715032631.1562882-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

vmlinux-objs-y is added to targets, which currently means that the EFI
stub gets added to the targets as well. It shouldn't be added since it
is built elsewhere.

This confuses Makefile.build which interprets the EFI stub as a target
	$(obj)/$(objtree)/drivers/firmware/efi/libstub/lib.a
and will create drivers/firmware/efi/libstub/ underneath
arch/x86/boot/compressed, to hold this supposed target, if building
out-of-tree. [0]

Fix this by pulling the stub out of vmlinux-objs-y into efi-obj-y.

[0] See scripts/Makefile.build near the end:
    # Create directories for object files if they do not exist

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 7619742f91c9..5a828fde7a42 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -90,8 +90,8 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
-vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
+efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
@@ -115,7 +115,7 @@ endef
 quiet_cmd_check-and-link-vmlinux = LD      $@
       cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
 
-$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 	$(call if_changed,check-and-link-vmlinux)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
-- 
2.26.2

