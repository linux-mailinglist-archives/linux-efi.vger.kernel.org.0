Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9098598066
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbiHRIz7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiHRIz6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:55:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C80985AD
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8954CB8213D
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D2DC433C1;
        Thu, 18 Aug 2022 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660812955;
        bh=UUvKXR2cO27YDKET1AyG/i9gzYw04CdLto0thocEz2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZ3+lreY6dvpCx5DNQhI9brjoeeNla8/nRGqDU9UG+xKbVMdmoq7lgGU9JI1nJP3+
         YURN7Wgs+A4qn58Pi+NbJdAglfTwWEMa+0db8JEct+53GwqhuC8NeWUt6RjT+mcb0D
         jLiKePwk35+w6JPse7DYfwo3ttn24NKJ++n4XhHRWR1r/kHRP/XrRQ63uvaMpAW4uD
         P1F+/ctW4dNzV+jlv8sHlHOWEd7JKKNzP/GIgw9KGheNIXBQMAPJoWrLSaYpN+Cpk1
         SDsM/1Lg4x2asqITaqvrTQZ+6KlAZIzruuL+RaN46FHqugrb0mJCsQdia/GhPfV5GG
         Lm5u45yo1dBDg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     grub-devel@nongnu.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        grub-devel@gnu.org, Daniel Kiper <daniel.kiper@oracle.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        dann frazier <dann.frazier@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: [PATCH resend 3/9] arm64/linux: Remove magic number header field check
Date:   Thu, 18 Aug 2022 10:55:33 +0200
Message-Id: <20220818085540.2075028-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818085540.2075028-1-ardb@kernel.org>
References: <20220818085540.2075028-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2374; i=ardb@kernel.org; h=from:subject; bh=UUvKXR2cO27YDKET1AyG/i9gzYw04CdLto0thocEz2Y=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/f59S2E/1h05DNgErqGpeX5fGPw91TcV1H2M0xeP qWzAX1OJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYv3+fQAKCRDDTyI5ktmPJGuIC/ 48Idyt81w/P+gZvj7mywXsJSt2MW0nB7uxRn0sr6qZoegCyZWFJ0zejv4QIQjevXqM/tTI5byTqZUF wNPAdrsqcvDj9Ibd7tOrXuFTZZStPMdyd1ZuMSIuEEb5VtJe1Sxd9O+H9BiAhch9PR6SN99LtgdMu8 fCBFpoh5K44L0XBDDTtO0wnA1V4Lq9n0Kzb1o4r9KEL9IS1nB9RtEd02i8BLQyt3Ntbz0sqMIdmdYW kMGfNuYXjT5uC0ssvt4G331s5lB7/GRoSqjuCHEr5mtCe+DEJ1GGC66Ed06w0WTVIXizNfwDKQq9Ni 7bp0HLGpGXHGabpjfP79oJqhrqyZabjGlFHSUa3S3a/DwFxaNJkmoUL0g3/3SmjJcKP59/9IVfIxjb XH+Vun9iOXCTUhL2ELVpMWydSEdtOJEcpMhb6mnkdy/iZxe4ORB3MwFyoFIbF9mrUrWtG98rxHruma hc0n09nc5Hs0SSuDJYqO8p86KEydddWp7Fg7IwtU28HTY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The 'ARM\x64' magic number in the file header identifies an image as one
that implements the bare metal boot protocol, allowing the loader to
simply move the file to a suitably aligned address in memory, with
sufficient headroom for the trailing .bss segment (the required memory
size is described in the header as well).

Note of this matters for GRUB, as it only supports EFI boot. EFI does
not care about this magic number, and nor should GRUB: this prevents us
from booting other PE linux images, such as the generic EFI zboot
decompressor, which is a pure PE/COFF image, and does not implement the
bare metal boot protocol.

So drop the magic number check.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 grub-core/loader/arm64/linux.c | 3 ---
 include/grub/arm/linux.h       | 1 -
 include/grub/arm64/linux.h     | 1 -
 3 files changed, 5 deletions(-)

diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index aed7a200b848..b5b559c236e0 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -51,9 +51,6 @@ static grub_addr_t initrd_end;
 grub_err_t
 grub_arch_efi_linux_check_image (struct linux_arch_kernel_header * lh)
 {
-  if (lh->magic != GRUB_LINUX_ARMXX_MAGIC_SIGNATURE)
-    return grub_error(GRUB_ERR_BAD_OS, "invalid magic number");
-
   if ((lh->code0 & 0xffff) != GRUB_PE32_MAGIC)
     return grub_error (GRUB_ERR_NOT_IMPLEMENTED_YET,
 		       N_("plain image kernel not supported - rebuild with CONFIG_(U)EFI_STUB enabled"));
diff --git a/include/grub/arm/linux.h b/include/grub/arm/linux.h
index bcd5a7eb186e..bfab334dd87f 100644
--- a/include/grub/arm/linux.h
+++ b/include/grub/arm/linux.h
@@ -35,7 +35,6 @@ struct linux_arm_kernel_header {
 };
 
 #if defined(__arm__)
-# define GRUB_LINUX_ARMXX_MAGIC_SIGNATURE GRUB_LINUX_ARM_MAGIC_SIGNATURE
 # define linux_arch_kernel_header linux_arm_kernel_header
 #endif
 
diff --git a/include/grub/arm64/linux.h b/include/grub/arm64/linux.h
index 7e22b4ab6990..96f1494e05a2 100644
--- a/include/grub/arm64/linux.h
+++ b/include/grub/arm64/linux.h
@@ -39,7 +39,6 @@ struct linux_arm64_kernel_header
 };
 
 #if defined(__aarch64__)
-# define GRUB_LINUX_ARMXX_MAGIC_SIGNATURE GRUB_LINUX_ARM64_MAGIC_SIGNATURE
 # define linux_arch_kernel_header linux_arm64_kernel_header
 #endif
 
-- 
2.35.1

