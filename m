Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D10F1FBF61
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 21:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgFPTsG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Jun 2020 15:48:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42033 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbgFPTsF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Jun 2020 15:48:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id q14so16488329qtr.9
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 12:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NH/TuqtXr+w9Q/kPHLpFEpBaSZJtZ3hL6C8nNtDhevI=;
        b=Yc/q42T/8XgaiPcrmhGulXI9FMemvcewW/xFv7qx2kYDp3rCTiwtBb9hUyT+U5lHeS
         vm5j/6CgupIUztsBXj6IwxPKKQqmz6uGKwf+G2XSwzIRgH/1zOtefSLupaFvmvlj5kji
         iBgwgmx1FV2dFSHABcpCCtitI6D+1aQrVcFzPBkktfLrtl+1MNTHk/uQ5mNoWBG4gugo
         4M/DsR4iBFpD6Q6Kkm40GIloLDCDaZYPIHDml7Xx9D/dXPrxl5Pgy8f9Iw1kT37Kyp0c
         giEDxStIamMv4cEtQxV2FSy92oRNNBmUW7bg5QHQNDA5eDOxnqD3vlXZ7m9Tij94fKgL
         cfUg==
X-Gm-Message-State: AOAM530Yk4X1or7Bv0TBzHKlpHdJwaGoM30fmKaugoZy0eiLECM9yOXD
        mRieHNxetIb0I96mK3vgXdvpOSCJ
X-Google-Smtp-Source: ABdhPJwdh/m8dO1iwRxon3IE9aqX32L90sQH1onNROLjtBW9GLgryDxQHj5jerCOkUUNR3adsB/lYQ==
X-Received: by 2002:aed:24db:: with SMTP id u27mr22546628qtc.256.1592336883511;
        Tue, 16 Jun 2020 12:48:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 10sm14959481qkv.136.2020.06.16.12.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:48:03 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org
Subject: [PATCH] efi/x86: Setup stack correctly for efi_pe_entry
Date:   Tue, 16 Jun 2020 15:48:02 -0400
Message-Id: <20200616194802.1718902-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAMj1kXELi+siUDH6g+_B3t77x3exobj2b1qQ-W4RMVY_DK1dhA@mail.gmail.com>
References: <CAMj1kXELi+siUDH6g+_B3t77x3exobj2b1qQ-W4RMVY_DK1dhA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit
  17054f492dfd ("efi/x86: Implement mixed mode boot without the handover protocol")
introduced a new entry point for the EFI stub to be booted in mixed mode
on 32-bit firmware.

When entered via efi32_pe_entry, control is first transferred to
startup_32 to setup for the switch to long mode, and then the EFI stub
proper is entered via efi_pe_entry. efi_pe_entry is an MS ABI function,
and the ABI requires 32 bytes of shadow stack space to be allocated by
the caller, as well as the stack being aligned to 8 mod 16 on entry.

Allocate 40 bytes on the stack before switching to 64-bit mode when
calling efi_pe_entry to account for this.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e821a7d7d5c4..d073e3c919dd 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -213,7 +213,6 @@ SYM_FUNC_START(startup_32)
 	 * We place all of the values on our mini stack so lret can
 	 * used to perform that far jump.
 	 */
-	pushl	$__KERNEL_CS
 	leal	startup_64(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
 	movl	efi32_boot_args(%ebp), %edi
@@ -224,11 +223,20 @@ SYM_FUNC_START(startup_32)
 	movl	efi32_boot_args+8(%ebp), %edx	// saved bootparams pointer
 	cmpl	$0, %edx
 	jnz	1f
+	/*
+	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
+	 * shadow space on the stack even if all arguments are passed in
+	 * registers. We also need an additional 8 bytes for the space that
+	 * would be occupied by the return address, and this also results in
+	 * the correct stack alignment for entry.
+	 */
+	subl	$40, %esp
 	leal	efi_pe_entry(%ebp), %eax
 	movl	%edi, %ecx			// MS calling convention
 	movl	%esi, %edx
 1:
 #endif
+	pushl	$__KERNEL_CS
 	pushl	%eax
 
 	/* Enter paged protected Mode, activating Long Mode */
-- 
2.26.2

