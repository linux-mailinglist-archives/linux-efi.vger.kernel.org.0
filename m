Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4F601489
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJQRRh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJQRRf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:17:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89206E89D
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AACFDB816B3
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABA0C43470;
        Mon, 17 Oct 2022 17:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027051;
        bh=MOK53C8vtg8643VO6pTj8ZYvjFm+Js3aEDe/DEn5gnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFPslyIv2RiRTkc9+z4P3Htvys5kxgx+VKixQ3rt0GLsme1Io+l0jgg2rEUQKJUxi
         jEEW8wXZ25bNiFHwoIv9wgBcOWMa/HRRstH0V447LFDRILe1iVhTOwnOWpER87o/dv
         jL68cwQrTGbdDll0xaBabfnLE3HNpagrhoTWxIHhpGGGIqUXnQLbtwffC4WOK7qXca
         yHa7oDpfuMxQBRxFu4+dVYldxUXYI7siw05aMhnzq9D4cCSSG0JgaTZjDLwRQTPjSD
         4KpfcVMj/JIgP9SsU+OSBsY9HoylDYTgio5saUd2cayvJm5pJMjNrPrtjinpPp8091
         6r3Sdlnjgs8yg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 04/21] efi: libstub: Remove zboot signing from build options
Date:   Mon, 17 Oct 2022 19:16:43 +0200
Message-Id: <20221017171700.3736890-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4308; i=ardb@kernel.org; h=from:subject; bh=MOK53C8vtg8643VO6pTj8ZYvjFm+Js3aEDe/DEn5gnY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY3vFAL2phWjlNHu0m1O5v2uBq2d/vqZy9b3knvf W2fst3iJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N7wAKCRDDTyI5ktmPJHDaC/ 0UzlEisuhW9ApzE10jCKDshmpEeuzsEwjKOIxJJUFJm2zt9DNEu2JbMlsLx5nL4tzWlk6wfblvRaJY 8IRNXs1gww8ZLUdCbu5JDk17mk1hyG4vTD0+zEZPmgWybxQOggPiU80IX+BHSbc3obbZW+YNhRxsQ3 i/UskpU1+6L9ddf31s7hfqjZL95xe427S5s8hYujc8xIlNpUpnKikvNQOVcY0p+lq/v98xIAJD+6bs j0ifirGVW2RInjI5mEb9bDC4chJDz6PGN3POMQHNYt0liI6JOaIEd28otjZaS8zw1rDnt/3cCnz+xB O3ScnKTEnHZSo8ojf/mBtBUp0/ekheB3VDYpo2zVzXbqxfy/MfABALWzKRdqGDlKQACTE1fqBknS3c pThAtaZ/LsnfxMBEMXCUpluGDNtbUm/AG91R5PmgiU4pAtlMKGu0OPmw/FLeyppQy6l3+nqG7tokpI /tI3mVuX7W/zh6fJxut6ho0A18KcGuV8lo9SWr3HGbJFg=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The zboot decompressor series introduced a feature to sign the PE/COFF
kernel image for secure boot as part of the kernel build. This was
necessary because there are actually two images that need to be signed:
the kernel with the EFI stub attached, and the decompressor application.

This is a bit of a burden, because it means that the images must be
signed on the the same system that performs the build, and this is not
realistic for distros.

During the next cycle, we will introduce changes to the zboot code so
that the inner image no longer needs to be signed. This means that the
outer PE/COFF image can be handled as usual, and be signed later in the
release process.

Let's remove the associated Kconfig options now so that they don't end
up in a LTS release while already being deprecated.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig                | 22 ---------------
 drivers/firmware/efi/libstub/Makefile.zboot | 29 +++-----------------
 2 files changed, 4 insertions(+), 47 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index fceeea74522e..0d5201e49841 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -102,28 +102,6 @@ config EFI_ZBOOT
 	  is supported by the encapsulated image. (The compression algorithm
 	  used is described in the zboot image header)
 
-config EFI_ZBOOT_SIGNED
-	def_bool y
-	depends on EFI_ZBOOT_SIGNING_CERT != ""
-	depends on EFI_ZBOOT_SIGNING_KEY != ""
-
-config EFI_ZBOOT_SIGNING
-	bool "Sign the EFI decompressor for UEFI secure boot"
-	depends on EFI_ZBOOT
-	help
-	  Use the 'sbsign' command line tool (which must exist on the host
-	  path) to sign both the EFI decompressor PE/COFF image, as well as the
-	  encapsulated PE/COFF image, which is subsequently compressed and
-	  wrapped by the former image.
-
-config EFI_ZBOOT_SIGNING_CERT
-	string "Certificate to use for signing the compressed EFI boot image"
-	depends on EFI_ZBOOT_SIGNING
-
-config EFI_ZBOOT_SIGNING_KEY
-	string "Private key to use for signing the compressed EFI boot image"
-	depends on EFI_ZBOOT_SIGNING
-
 config EFI_ARMSTUB_DTB_LOADER
 	bool "Enable the DTB loader"
 	depends on EFI_GENERIC_STUB && !RISCV && !LOONGARCH
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 35f234ad8738..3340b385a05b 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -20,22 +20,11 @@ zboot-size-len-y			:= 4
 zboot-method-$(CONFIG_KERNEL_GZIP)	:= gzip
 zboot-size-len-$(CONFIG_KERNEL_GZIP)	:= 0
 
-quiet_cmd_sbsign = SBSIGN  $@
-      cmd_sbsign = sbsign --out $@ $< \
-		   --key $(CONFIG_EFI_ZBOOT_SIGNING_KEY) \
-		   --cert $(CONFIG_EFI_ZBOOT_SIGNING_CERT)
-
-$(obj)/$(EFI_ZBOOT_PAYLOAD).signed: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
-	$(call if_changed,sbsign)
-
-ZBOOT_PAYLOAD-y				 := $(EFI_ZBOOT_PAYLOAD)
-ZBOOT_PAYLOAD-$(CONFIG_EFI_ZBOOT_SIGNED) := $(EFI_ZBOOT_PAYLOAD).signed
-
-$(obj)/vmlinuz: $(obj)/$(ZBOOT_PAYLOAD-y) FORCE
+$(obj)/vmlinuz: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
 	$(call if_changed,$(zboot-method-y))
 
 OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
-			 --rename-section .data=.gzdata,load,alloc,readonly,contents
+			  --rename-section .data=.gzdata,load,alloc,readonly,contents
 $(obj)/vmlinuz.o: $(obj)/vmlinuz FORCE
 	$(call if_changed,objcopy)
 
@@ -53,18 +42,8 @@ LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
 $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
 	$(call if_changed,ld)
 
-ZBOOT_EFI-y				:= vmlinuz.efi
-ZBOOT_EFI-$(CONFIG_EFI_ZBOOT_SIGNED)	:= vmlinuz.efi.unsigned
-
-OBJCOPYFLAGS_$(ZBOOT_EFI-y) := -O binary
-$(obj)/$(ZBOOT_EFI-y): $(obj)/vmlinuz.efi.elf FORCE
+OBJCOPYFLAGS_vmlinuz.efi := -O binary
+$(obj)/vmlinuz.efi: $(obj)/vmlinuz.efi.elf FORCE
 	$(call if_changed,objcopy)
 
 targets += zboot-header.o vmlinuz vmlinuz.o vmlinuz.efi.elf vmlinuz.efi
-
-ifneq ($(CONFIG_EFI_ZBOOT_SIGNED),)
-$(obj)/vmlinuz.efi: $(obj)/vmlinuz.efi.unsigned FORCE
-	$(call if_changed,sbsign)
-endif
-
-targets += $(EFI_ZBOOT_PAYLOAD).signed vmlinuz.efi.unsigned
-- 
2.35.1

