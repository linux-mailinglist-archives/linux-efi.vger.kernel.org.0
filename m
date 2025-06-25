Return-Path: <linux-efi+bounces-3991-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF6CAE836E
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6616EDAF
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68253262FF6;
	Wed, 25 Jun 2025 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWE2qnaB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C862620C4;
	Wed, 25 Jun 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856181; cv=none; b=k2QxGzC0g07i/PSZBonIZmMZtBqrfB4TaaoZrh7++0fztkQc1eGB+V45BXpA6LS2SqxS9nCXJERwlN+ETA70AXjfC0mYj85QtDNoCGdE0WRjHY9gVSvKIVBSgdhgS3bH2IN5AsmJID6axdMk2W+Y1ApMm8PeAqiCPZ8xYaacFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856181; c=relaxed/simple;
	bh=Dz5Oh6ZQApBF4VZkqH2TbMEO+1URjB0qZPeXpOaSAyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aikb9tHP83WdksYBr2eDwkO2Xol7pd15HmbL+ug4mFn9g6ibP/DSWLJDl0IoYX6+jEnquejersneXslOHu3NkFOhFrrcnfhUIEvUTRatBUH3zJhnKbtGeBVFliLwpMILNFyvVlZk1bekRRMcNSVGAnFFi+faTuP4P0fgMuGD0Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWE2qnaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A8EC4CEEA;
	Wed, 25 Jun 2025 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750856180;
	bh=Dz5Oh6ZQApBF4VZkqH2TbMEO+1URjB0qZPeXpOaSAyM=;
	h=From:To:Cc:Subject:Date:From;
	b=qWE2qnaB6AEFnYieEk5vJ+/s0gLddEoVYyPp9W6NmjrIKr/i1PiqNv/EhEdoyy/kq
	 8GHpQsDUspx3bxFYvs5Hk3AlqEFmRV6g7FqmBpGHqA1oYVdn66vnxrDWDFD9H8ER+O
	 HmndyumTt2kdePikwRvQOBbItSTHZzDLvSENDTgy3n5qL0J4X+V3wCfJV8OSx9iB3a
	 ZT+zlhoIWBfCUOzV7MdCVR+vhAxxVO+ppng7Od5zaIIUlB/IrdXLHAO25qok0mgZBN
	 UspZvgH1d67IYcnY1RxxXEBHknoQvebrYG3CgG9nKvSx9vBlL3OhO7dH00GpZ5zJeg
	 zAH+oRAaoFtBw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: fix unnecessary rebuilding when CONFIG_DEBUG_EFI=y
Date: Wed, 25 Jun 2025 21:55:20 +0900
Message-ID: <20250625125555.2504734-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_DEBUG_EFI is enabled, some objects are needlessly rebuilt.

[Steps to reproduce]

  Enable CONFIG_DEBUG_EFI and run 'make' twice in a clean source tree.
  On the second run, arch/arm64/kernel/head.o is rebuilt even though
  no files have changed.

  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- clean
  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
     [ snip ]
  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
    CALL    scripts/checksyscalls.sh
    AS      arch/arm64/kernel/head.o
    AR      arch/arm64/kernel/built-in.a
    AR      arch/arm64/built-in.a
    AR      built-in.a
     [ snip ]

The issue is caused by the use of the $(realpath ...) function.

At the time arch/arm64/kernel/Makefile is parsed on the first run,
$(objtree)/vmlinux does not exist. As a result,
$(realpath $(objtree)/vmlinux) expands to an empty string.

On the second run of Make, $(objtree)/vmlinux already exists, so
$(realpath $(objtree)/vmlinux) expands to the absolute path of vmlinux.
However, this change in the command line causes arch/arm64/kernel/head.o
to be rebuilt.

To address this issue, use $(abspath ...) instead, which does not require
the file to exist. While $(abspath ...) does not resolve symlinks, this
should be fine from a debugging perspective.

The GNU Make manual [1] clearly explains the difference between the two:

  $(realpath names...)
    For each file name in names return the canonical absolute name.
    A canonical name does not contain any . or .. components, nor any
    repeated path separators (/) or symlinks. In case of a failure the
    empty string is returned. Consult the realpath(3) documentation for
    a list of possible failure causes.

  $(abspath namees...)
    For each file name in names return an absolute name that does not
    contain any . or .. components, nor any repeated path separators (/).
    Note that, in contrast to realpath function, abspath does not resolve
    symlinks and does not require the file names to refer to an existing
    file or directory. Use the wildcard function to test for existence.

The same problem exists in drivers/firmware/efi/libstub/Makefile.zboot.
On the first run of Make, $(obj)/vmlinuz.efi.elf does not exist when the
Makefile is parsed, so -DZBOOT_EFI_PATH is set to an empty string.
Replace $(realpath ...) with $(abspath ...) there as well.

[1]: https://www.gnu.org/software/make/manual/make.html#File-Name-Functions

Fixes: 757b435aaabe ("efi: arm64: Add vmlinux debug link to the Image binary")
Fixes: a050910972bb ("efi/libstub: implement generic EFI zboot")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/kernel/Makefile                  | 2 +-
 drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2920b0a51403..a2604c33f35c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -81,7 +81,7 @@ obj-y					+= head.o
 always-$(KBUILD_BUILTIN)		+= vmlinux.lds
 
 ifeq ($(CONFIG_DEBUG_EFI),y)
-AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
+AFLAGS_head.o += -DVMLINUX_PATH="\"$(abspath vmlinux)\""
 endif
 
 # for cleaning
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 92e3c73502ba..832deee36e48 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -36,7 +36,7 @@ aflags-zboot-header-$(EFI_ZBOOT_FORWARD_CFI) := \
 		-DPE_DLL_CHAR_EX=IMAGE_DLLCHARACTERISTICS_EX_FORWARD_CFI_COMPAT
 
 AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE) \
-			 -DZBOOT_EFI_PATH="\"$(realpath $(obj)/vmlinuz.efi.elf)\"" \
+			 -DZBOOT_EFI_PATH="\"$(abspath $(obj)/vmlinuz.efi.elf)\"" \
 			 -DZBOOT_SIZE_LEN=$(zboot-size-len-y) \
 			 -DCOMP_TYPE="\"$(comp-type-y)\"" \
 			 $(aflags-zboot-header-y)
-- 
2.43.0


