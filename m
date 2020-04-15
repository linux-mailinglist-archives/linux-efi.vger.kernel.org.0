Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9621AB3A9
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 00:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgDOWPd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 18:15:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44191 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731293AbgDOWP2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 18:15:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id w24so14816101qts.11;
        Wed, 15 Apr 2020 15:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rOrczQkTIxOcY6UFnnC40rT9zyAvKX1Bi6yBMzeK9G0=;
        b=R3YrZgITU3hxn/wx6wEqa+HsWygMsyqSGlz3K3xiaxZCkI21FpTsNMYfE3bz2zo2dA
         rPxWSeIZgbg84L/wBVX4JmyKEyuXsFMHUoHcjI1/P0I/HIbx27FtpzTIZOV8P4Jw10Ta
         zjKTmS4yzpRybNM3HBYRgAdZhrzO6scSscMeK8SabJL5gy8aZrL24S6bkM6HR4JaimLz
         DKUbtcZB1bTVN4bRAAv94iGPx4MzN3Do8ix7lKTwBln5t7xyGUH7JnVQqBOUKcX0hF3c
         2CDMhEFAmI6Q6Dr1bpw9Dgxwb3H/MMGX/TBiuMfv/ErjxJkhfCr4bUsda6cbZC6BOnKx
         pp8w==
X-Gm-Message-State: AGi0PubV6xmcjt7stxRfzq1jQHiXgPTK9/CvQfAR8mhzElAHo7ybK6PA
        /NWhoTcQH/LX9oAfk8n+dek=
X-Google-Smtp-Source: APiQypL+3Bxma6w8vttK2a2cMb2AyT1VBao4IUEBYSF9XsXFaqUg93j4LKjmJf0fyJxTOhIxxv+jTg==
X-Received: by 2002:ac8:2afc:: with SMTP id c57mr17402778qta.324.1586988926023;
        Wed, 15 Apr 2020 15:15:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i20sm13264340qkl.135.2020.04.15.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:15:25 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] efi/x86: Check for bad relocations
Date:   Wed, 15 Apr 2020 18:15:20 -0400
Message-Id: <20200415221520.2692512-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415221520.2692512-1-nivedita@alum.mit.edu>
References: <20200415221520.2692512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add relocation checking for x86 as well to catch non-PC-relative
relocations that require runtime processing, since the EFI stub does not
do any runtime relocation processing.

This will catch, for example, data relocations created by static
initializers of pointers.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0bb2916eb12b..2aff59812a54 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -96,6 +96,8 @@ STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
 # .bss section here so it's easy to pick out in the linker script.
 #
 STUBCOPY_FLAGS-$(CONFIG_X86)	+= --rename-section .bss=.bss.efistub,load,alloc
+STUBCOPY_RELOC-$(CONFIG_X86_32) := 'R_X86_32_(8|16|32)'
+STUBCOPY_RELOC-$(CONFIG_X86_64) := 'R_X86_64_(8|16|32|32S|64)'
 
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,stubcopy)
@@ -107,16 +109,14 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 # this time, use objcopy and leave all sections in place.
 #
 
-cmd_stubrelocs_check-y = /bin/true
-
-cmd_stubrelocs_check-$(CONFIG_EFI_ARMSTUB) =				\
+cmd_stubrelocs_check =							\
 	$(STRIP) --strip-debug -o $@ $<;				\
-	if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then		\
+	if $(OBJDUMP) -r $@ | grep -E $(STUBCOPY_RELOC-y); then		\
 		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
 		/bin/false;						\
 	fi
 
 quiet_cmd_stubcopy = STUBCPY $@
       cmd_stubcopy =							\
-	$(cmd_stubrelocs_check-y);					\
+	$(cmd_stubrelocs_check);					\
 	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
-- 
2.24.1

