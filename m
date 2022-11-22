Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B56340F4
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiKVQKn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiKVQKi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:10:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9AD73421;
        Tue, 22 Nov 2022 08:10:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E2B1B81C12;
        Tue, 22 Nov 2022 16:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF16C433C1;
        Tue, 22 Nov 2022 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133435;
        bh=wDRs75zTAHjH3XwxSS7HuA7vyVpCwR1hlLp7hTGnUFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Haz5xahkdshlBU/tRr1O4ZnSpYOxX3bxkfza8v1TsQcZ4lMCI9qJ1KM8Lb3FAGcJQ
         o0RkclgkoVbumV79RLi3iVyHmRbhfQHailej8zQhhfrdqFm1FTmB3o5+kZ51nayvu8
         n2aqgIzHAtrDbSEOvSAvmBDa369Ctdd9h9inzeP46OsDo3cZYJxiICuXm7uciseWlB
         /TLgPGpfJdaifs0CXoGJSzaLzIE9UGda4T4dP1+O9DkO9Yk+q60zWOXWrxV6sw8uUg
         oNz7Nu4bp8Uanr83MiA7vUjNzQe03ZpY6/pDJvzf1SqR0z997M3rPB4KeXaMUfViIm
         xOBxti+UdhdTQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 01/17] x86/compressed: efi-mixed: rename efi_thunk_64.S to efi-mixed.S
Date:   Tue, 22 Nov 2022 17:10:01 +0100
Message-Id: <20221122161017.2426828-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=ardb@kernel.org; h=from:subject; bh=wDRs75zTAHjH3XwxSS7HuA7vyVpCwR1hlLp7hTGnUFQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRP2cVMH4lvpZYQzGmsO4SCnQ5TYAbG9swSZYuk aYpQndyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0TwAKCRDDTyI5ktmPJF6UC/ 9BDabprUrkL/8MHA1NYfeEFcxm0F80tRYJR18ArKn7XZL1lIaI7H8gIjlDpkkMwVhnLz6l0H+1cGkl RjuLYE0Mw1g4+mqc+vfhiFxwcR4NxL8KH62C1+MjiF1oe7LoTnDWwB1dB01FA4pwJVfLGbwQ+pm4Rt /XJVU/Y1xczQvY6SjM2B1ZkOA8z8b9G3pwSFiqgKXAdfyX6MJ5A6bdfkhnjJafN74SlbIIYu/DS5LL lIO6xlfBUuz6vmdKgak9m2bN/Z2caFUj2+RtaZepIAEeFbmKgEsEeGfAPpA3J8Gjho+YpmF2Pswyhk i0HlZD9bYErdUa3BP3gbBG0iaDLFq/j1q4zX041vJdzt6eT8OYIlRcYRufTmdzHgNefkNEgV0aT/u4 1vcuyzeh5e5yGxB0h7To97JEJferfJwy1bM54Kh3Vypin+jRc3uqVOaYvLIkuzKPeHjyyJ7TKJhpgO ZXwKwZRWiktn+JJbmig4mlt6PuSmJf5rfEnoWzTo69tU0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for moving the mixed mode specific code out of head_64.S,
rename the existing file to clarify that it contains more than just the
mixed mode thunk.

While at it, clean up the Makefile rules that add it to the build.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile                        | 6 +++---
 arch/x86/boot/compressed/{efi_thunk_64.S => efi_mixed.S} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3a261abb6d158d62..cd1a6295b957ea1d 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -108,11 +108,11 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
 
-vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
-efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
+vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_mixed.S
similarity index 100%
rename from arch/x86/boot/compressed/efi_thunk_64.S
rename to arch/x86/boot/compressed/efi_mixed.S
-- 
2.35.1

