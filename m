Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A336F1750C3
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCAXEm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:04:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38935 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgCAXEl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:04:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id e13so2679591qts.6;
        Sun, 01 Mar 2020 15:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmV5IqscjIZivuAGdRTQkJJYXa88r33702K1Dz7eG0U=;
        b=HE/+8tYwyaWyJPL3sje7YiYjE3E4TzuRDcMAqonSuz+aMEGucgWoByNQOp9qElYaLL
         UnFYaG3kq1s+RtF81i+6ikmbA5lotLw/GyyLcO+EqYnMtSbi0k0Jxzb65kPiuy76MA+g
         bMS8DHBFRcPXBzEWT9dR7PbX7h1ZVhgtSlIj5AAdXOAjTimDKwTYf9mwNbqQvLswuuGV
         Mj0nV9Ih4SZ2Dzby7pdb12HBRs3C6tuMNane29AysdnEpzR1c86oK3GRvJ2TUW4kZYC6
         i+xS0vHtkF1Hwkyqig1sxlcRdkl9j+k+xWEPeGOGSBwKcRKBaDRGZcJRSGH896JYTs1A
         YbxQ==
X-Gm-Message-State: APjAAAUQQvf5kIiI3ZcdmBe4aWNQtOEVV2+BXKorL+lNqT/egVFMMl4I
        +C3vXO84Jgj8iGYF52MlHfgOh3yBeBc=
X-Google-Smtp-Source: APXvYqwrOTQTq4Ldfu4ycs185PMTamy4EcVtEkfdUsQOwCAPB6QuwGrqtdvCKbFpZijKIpFhFc4ZlQ==
X-Received: by 2002:ac8:7090:: with SMTP id y16mr12998941qto.356.1583103880601;
        Sun, 01 Mar 2020 15:04:40 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n138sm9065082qkn.33.2020.03.01.15.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:04:40 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] efi/x86: Avoid using code32_start
Date:   Sun,  1 Mar 2020 18:04:35 -0500
Message-Id: <20200301230436.2246909-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301230436.2246909-1-nivedita@alum.mit.edu>
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

code32_start is meant for 16-bit real-mode bootloaders to inform the
kernel where the 32-bit protected mode code starts. Nothing in the
protected mode kernel except the EFI stub uses it.

efi_main currently returns boot_params, with code32_start set inside it
to tell efi_stub_entry where startup_32 is located. Since it was invoked
by efi_stub_entry in the first place, boot_params is already known.
Return the address of startup_32 instead.

This will allow a 64-bit kernel to live above 4Gb, for example, and it's
cleaner.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_32.S      |  3 +--
 arch/x86/boot/compressed/head_64.S      |  4 ++--
 arch/x86/kernel/asm-offsets.c           |  1 -
 drivers/firmware/efi/libstub/x86-stub.c | 10 +++++-----
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 2f8138b71ea9..e013bdc1237b 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -156,9 +156,8 @@ SYM_FUNC_END(startup_32)
 SYM_FUNC_START(efi32_stub_entry)
 SYM_FUNC_START_ALIAS(efi_stub_entry)
 	add	$0x4, %esp
+	movl	8(%esp), %esi	/* save boot_params pointer */
 	call	efi_main
-	movl	%eax, %esi
-	movl	BP_code32_start(%esi), %eax
 	leal	startup_32(%eax), %eax
 	jmp	*%eax
 SYM_FUNC_END(efi32_stub_entry)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fabbd4c2e9f2..6a4ff919008c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -472,9 +472,9 @@ SYM_CODE_END(startup_64)
 SYM_FUNC_START(efi64_stub_entry)
 SYM_FUNC_START_ALIAS(efi_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
+	movq	%rdx, %rbx			/* save boot_params pointer */
 	call	efi_main
-	movq	%rax,%rsi
-	movl	BP_code32_start(%esi), %eax
+	movq	%rbx,%rsi
 	leaq	startup_64(%rax), %rax
 	jmp	*%rax
 SYM_FUNC_END(efi64_stub_entry)
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 5c7ee3df4d0b..3ca07ad552ae 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -88,7 +88,6 @@ static void __used common(void)
 	OFFSET(BP_kernel_alignment, boot_params, hdr.kernel_alignment);
 	OFFSET(BP_init_size, boot_params, hdr.init_size);
 	OFFSET(BP_pref_address, boot_params, hdr.pref_address);
-	OFFSET(BP_code32_start, boot_params, hdr.code32_start);
 
 	BLANK();
 	DEFINE(PTREGS_SIZE, sizeof(struct pt_regs));
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 9db98839d7b4..7f3e97c2aad3 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -703,10 +703,11 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 }
 
 /*
- * On success we return a pointer to a boot_params structure, and NULL
- * on failure.
+ * On success, we return the address of startup_32, which has potentially been
+ * relocated by efi_relocate_kernel.
+ * On failure, we exit to the firmware via efi_exit instead of returning.
  */
-struct boot_params *efi_main(efi_handle_t handle,
+unsigned long efi_main(efi_handle_t handle,
 			     efi_system_table_t *sys_table_arg,
 			     struct boot_params *boot_params)
 {
@@ -736,7 +737,6 @@ struct boot_params *efi_main(efi_handle_t handle,
 			goto fail;
 		}
 	}
-	hdr->code32_start = (u32)bzimage_addr;
 
 	/*
 	 * efi_pe_entry() may have been called before efi_main(), in which
@@ -799,7 +799,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 		goto fail;
 	}
 
-	return boot_params;
+	return bzimage_addr;
 fail:
 	efi_printk("efi_main() failed!\n");
 
-- 
2.24.1

