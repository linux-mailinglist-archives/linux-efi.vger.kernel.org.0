Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201071AB3A6
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 00:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgDOWP1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 18:15:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45685 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgDOWPY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 18:15:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id 71so14820475qtc.12;
        Wed, 15 Apr 2020 15:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GU2OawWL1bidpPge0CUGIGiauoJ+t/PQ9Hui01IaJ3w=;
        b=H10HIKDZuriOM741MqEdfjzXgBnUYPecL8ICO49bhfs1Zjq+BUYxkzSqPCH1T95Ehz
         us8qX9FKnpVVTn9s5R1xxZgbdo+0VO0leLZA0UgxEU/EXeslYXGSAwWB2GRTQ4J2+OWH
         M0uhvej6zZFJHvRlElxz7gIv9hvWW/lPx3QFHtYM04dvr0MwMebGdcXMTCvKaKmxdFOn
         NgDc4eb1sfXMD9QIt7l7DjGjs8x5oXDSwUKeo+dJk7qkzoiD6u+it1LOU9pGTbCoQ9MA
         S//BQeQ87jeLNKix/zsxbuVh2AQEl4aH4u3CWe+zRZ8rnRHkAsYHfnMdf0BynWUcWYHz
         pUdQ==
X-Gm-Message-State: AGi0PuaIHYoDFT3nH0tjv4DBozkpsx9Y4rA7tCI4NpKGENVjmrI2FUOk
        2iA6PS8wCWiGPWL5+OhPPOs=
X-Google-Smtp-Source: APiQypKKO+yiB7+uIjFNaUTWvJHYnvI37H4MMGwRwlMBGopSX4oyJgU87IbKYTyH9OfqIIaavzt8zA==
X-Received: by 2002:ac8:7498:: with SMTP id v24mr22500450qtq.32.1586988923198;
        Wed, 15 Apr 2020 15:15:23 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i20sm13264340qkl.135.2020.04.15.15.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:15:22 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] efi/libstub: Factor out relocation checking
Date:   Wed, 15 Apr 2020 18:15:17 -0400
Message-Id: <20200415221520.2692512-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415221520.2692512-1-nivedita@alum.mit.edu>
References: <20200415221520.2692512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for using STUBCOPY for x86 as well, which doesn't require
relocation checking, move the checking code into its own variable so it
can be left out for x86.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/Makefile | 30 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 45ffe0822df1..e5e76677f2da 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -80,6 +80,15 @@ STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
 
+#
+# ARM discards the .data section because it disallows r/w data in the
+# decompressor. So move our .data to .data.efistub and .bss to .bss.efistub,
+# which are preserved explicitly by the decompressor linker script.
+#
+STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
+				   --rename-section .bss=.bss.efistub,load,alloc
+STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
+
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,stubcopy)
 
@@ -89,20 +98,17 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 # such relocations. If none are found, regenerate the output object, but
 # this time, use objcopy and leave all sections in place.
 #
-quiet_cmd_stubcopy = STUBCPY $@
-      cmd_stubcopy =							\
+
+cmd_stubrelocs_check-y = /bin/true
+
+cmd_stubrelocs_check-$(CONFIG_EFI_ARMSTUB) =				\
 	$(STRIP) --strip-debug -o $@ $<;				\
 	if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then		\
 		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
 		/bin/false;						\
-	fi;								\
-	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
+	fi
 
-#
-# ARM discards the .data section because it disallows r/w data in the
-# decompressor. So move our .data to .data.efistub and .bss to .bss.efistub,
-# which are preserved explicitly by the decompressor linker script.
-#
-STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
-				   --rename-section .bss=.bss.efistub,load,alloc
-STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
+quiet_cmd_stubcopy = STUBCPY $@
+      cmd_stubcopy =							\
+	$(cmd_stubrelocs_check-y);					\
+	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
-- 
2.24.1

