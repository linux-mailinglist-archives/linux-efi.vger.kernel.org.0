Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBB360CE8E
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiJYONs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiJYONo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:13:44 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2994A98CD;
        Tue, 25 Oct 2022 07:13:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 36DDE419E9F8;
        Tue, 25 Oct 2022 14:13:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 36DDE419E9F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707212;
        bh=4eVW1eJcsrjHfvua5xgjsd3gl1WJesFtv8uJ2bacg94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBX76ErHdSBb9NvE24qugxdvfpl7OBObs2qpDC0JnIVm51/gGJdWGo8Q/JjnoRaMX
         fE1trKCitrGKWOyf6shizWHYbhJ7wrPMXgayRDhfyckm3NgtA8pEZT3n79LeHSLeh4
         Qi8FMOclBpW78F8oMS9KJEKrSvasr2T0HQrRDr7k=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 07/23] x86/build: Check W^X of vmlinux during build
Date:   Tue, 25 Oct 2022 17:12:45 +0300
Message-Id: <84186fd75772b89be1984d6da0764a65cdef0c29.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Check if there are simultaneously writable and executable
program segments in vmlinux ELF image and fail build if there are any.

This would prevent accidental introduction of RWX segments.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3a261abb6d15..64de6c2b1740 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -112,11 +112,17 @@ vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+quiet_cmd_wx_check = WXCHK   $<
+cmd_wx_check = if $(OBJDUMP) -p $< | grep "flags .wx" > /dev/null; \
+	       then (echo >&2 "$<: Simultaneously writable and executable sections are prohibited"; \
+		     /bin/false); fi
+
 $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 $(obj)/vmlinux.bin: vmlinux FORCE
+	$(call cmd,wx_check)
 	$(call if_changed,objcopy)
 
 targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
-- 
2.37.4

