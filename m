Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A855C0058
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIUOyf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIUOyd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:54:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03D111C;
        Wed, 21 Sep 2022 07:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8950630C8;
        Wed, 21 Sep 2022 14:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D79C433D6;
        Wed, 21 Sep 2022 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772071;
        bh=qoG8AUDHmOU2I5I4l0QdhUgPfOVgczFVdg4duM/N0ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1KbvWqxAwksjPMHixAS6kKYquLxXXPBc43J7TpVJhEbsguJdEPVp9vtWPVINWHuc
         2XBjjCoWHYix3WRVTmKzYwk19DGGKsE7+OUM7QClUrJeYJzBDSKNtIio6f1aRtDC4B
         +RkfxHlEV92bm9/S/qAA5XAob4okLub67CNW3gdFZ+hJOmrdMExGHVX/RIkYLnJirR
         ZDEUlOXyJo20Wq0GFL0jrNMcdrw00ob5eMzaAsLRZHdP3/jYzEDQkxme1kODYq8rsG
         /1oBi8vNUJsstVe/gTQg38clY7VfNoOO8zJmtt8WK6M6STjrE3/sIFo86PNFr8lwQi
         rlj4kSllZzuAg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 01/16] x86/compressed: efi-mixed: rename efi_thunk_64.S to efi-mixed.S
Date:   Wed, 21 Sep 2022 16:54:07 +0200
Message-Id: <20220921145422.437618-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=ardb@kernel.org; h=from:subject; bh=qoG8AUDHmOU2I5I4l0QdhUgPfOVgczFVdg4duM/N0ck=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWELtrdLtAR/KkA68TrBETYomSqf5o5QE0faqqd /ugXebaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslhAAKCRDDTyI5ktmPJCwQDA CozSGlv+5tNXgtL7BiYeb/foFMHqbRay+0Lrn3ezbrxsGqqQd9BnZ9Mhu2OvCMLS6Dft5HZDCHrTa/ uVDfEDz0X3dIXpE/o44GwwAM8gt/4DgvgUDYuIwpAz6w5lSpUvx7dZEAxy3Pa2cQIBHWczD2goKC/6 fectwWEcxmy1uE+C8XQO2w5IS/cJGdR+h9TpQJ+31ciUQHCrgiuBoNlLB8MnqUi1Ecd4hYwgAupqZe Z2CdWsUJYL1iiSXCqhjOaf7b6TxVQ9FJlO6yMBZ/dEGjR3TY/6L41/Yyhwv80HYi9Zc5rSR8q0v1f2 b7A4QqE/50IhtcUzm9KH1x7C1kw3E+ogRg93lEje6DzyY3eazAaGNPCkTq8Qi+x0wAcTrC/T1DwU2v +KViOYEudnxvVOoJVOlo2ZuN6yWbi1OmuObPVUce+iy2TZ7zo6dz2vtjkwtKw+IiAj1XpCr9W6JXqo Wy7Wknuf0lxaPc3ZM5sw7Fn4koe/Xm5q5e7NcEddi/I60=
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
index 35ce1a64068b..d6dbb46696a2 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,11 +107,11 @@ endif
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

