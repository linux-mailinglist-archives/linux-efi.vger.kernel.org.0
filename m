Return-Path: <linux-efi+bounces-234-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF218167D2
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 09:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB58B20FB4
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371CF9C1;
	Mon, 18 Dec 2023 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3yU54TF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67210780;
	Mon, 18 Dec 2023 08:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A421C433C8;
	Mon, 18 Dec 2023 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702886504;
	bh=TvhXLKajBdXbCsQQLg4hu2vsZVvrLjECtEuBXZ7kJy4=;
	h=From:To:Cc:Subject:Date:From;
	b=a3yU54TF+HZHPuRqFso6ODttKWlDRU1vur6KFo+az6ovsTHZECNg4XcXZH9TMd5uR
	 MRxLaD50O2a/YTNm/EJHMv6R9z8fgMT8Tn+FCfYY/y/TtHti7HlRuYXPDLkqEUogxi
	 5KmdH3rR9NVbvOW1gEl93UluxpdurxNBoBuUQ/+fCD3tlik4jHNZd+/ck1xDmIV7OL
	 wr6gTim0iHBuQU3a9JEUoYS7ORGKFiOC2hjHEoesO7Hl22pM9+ZtnRArPpc6y8C0x9
	 cFmpRJNERHRCi4RXw1q5/Ys2mcpYHHjLWAkxDeYkwUCNTD8ZliwLM/+LH3vUA6t8H9
	 OCMQKkULZH4vw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi/libstub: zboot: do not use $(shell ...) in cmd_copy_and_pad
Date: Mon, 18 Dec 2023 17:01:27 +0900
Message-Id: <20231218080127.907460-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You do not need to use $(shell ...) in recipe lines, as they are already
executed in a shell. An alternative solution is $$(...), which is an
escaped sequence of the shell's command substituion, $(...).

For this case, there is a reason to avoid $(shell ...).

Kbuild detects command changes by using the if_changed macro, which
compares the previous command recorded in .*.cmd with the current
command from Makefile. If they differ, Kbuild re-runs the build rule.

To diff the commands, Make must expand $(shell ...) first. It means that
hexdump is executed every time, even when nothing needs rebuilding. If
Kbuild determines that vmlinux.bin needs rebuilding, hexdump will be
executed again to evaluate the 'cmd' macro, one more time to really
build vmlinux.bin, and finally yet again to record the expanded command
into .*.cmd.

Replace $(shell ...) with $$(...) to avoid multiple, unnecessay shell
evaluations. Since Make is agnostic about the shell code, $(...), the
if_changed macro compares the string "$(hexdump -s16 -n4 ...)" verbatim,
so hexdump is run only for building vmlinux.bin.

For the same reason, $(shell ...) in EFI_ZBOOT_OBJCOPY_FLAGS should be
eliminated.

While I was here, I replaced '&&' with ';' because a command for
if_changed is executed with 'set -e'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/boot/Makefile                    | 2 +-
 drivers/firmware/efi/libstub/Makefile.zboot | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index 1761f5972443..a5a787371117 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -44,7 +44,7 @@ EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
 EFI_ZBOOT_MACH_TYPE	:= ARM64
 EFI_ZBOOT_FORWARD_CFI	:= $(CONFIG_ARM64_BTI_KERNEL)
 
-EFI_ZBOOT_OBJCOPY_FLAGS	= --add-symbol zboot_code_size=0x$(shell \
+EFI_ZBOOT_OBJCOPY_FLAGS	= --add-symbol zboot_code_size=0x$$( \
 				$(NM) vmlinux|grep _kernel_codesize|cut -d' ' -f1)
 
 include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 2c489627a807..65ffd0b760b2 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -5,8 +5,8 @@
 # EFI_ZBOOT_FORWARD_CFI
 
 quiet_cmd_copy_and_pad = PAD     $@
-      cmd_copy_and_pad = cp $< $@ && \
-			 truncate -s $(shell hexdump -s16 -n4 -e '"%u"' $<) $@
+      cmd_copy_and_pad = cp $< $@; \
+			 truncate -s $$(hexdump -s16 -n4 -e '"%u"' $<) $@
 
 # Pad the file to the size of the uncompressed image in memory, including BSS
 $(obj)/vmlinux.bin: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
-- 
2.40.1


