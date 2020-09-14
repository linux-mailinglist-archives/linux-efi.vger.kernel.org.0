Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67ED02688DE
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 11:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgINJ5m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 05:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgINJ5g (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 05:57:36 -0400
Received: from e123331-lin.nice.arm.com (unknown [37.6.197.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 779CC20732;
        Mon, 14 Sep 2020 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600077456;
        bh=12+uyxP3sbyITu/xtGVVeDeSUYX4EFBO8MDh0CpvfFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAFDHRJ5A8Ztx/KYtZir9ffaY6tEATTiWku+yOOBJnQNQdK6BRE2YIC0cY6U1d7VX
         WvRsL44kCy2HHZ+OerbafI25Kpe/xwcl4sh58eU9rpSX8Cg4FM62t/qHHXPvePrDcA
         IJizx7WGp3R8Vm8LBsmq+79FkgXuGAkBIz00be/E=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 03/12] ARM: module: add support for place relative relocations
Date:   Mon, 14 Sep 2020 12:56:57 +0300
Message-Id: <20200914095706.3985-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
References: <20200914095706.3985-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When using the new adr_l/ldr_l/str_l macros to refer to external symbols
from modules, the linker may emit place relative ELF relocations that
need to be fixed up by the module loader. So add support for these.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/elf.h |  5 +++++
 arch/arm/kernel/module.c   | 20 ++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index b078d992414b..0ac62a54b73c 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -51,6 +51,7 @@ typedef struct user_fp elf_fpregset_t;
 #define R_ARM_NONE		0
 #define R_ARM_PC24		1
 #define R_ARM_ABS32		2
+#define R_ARM_REL32		3
 #define R_ARM_CALL		28
 #define R_ARM_JUMP24		29
 #define R_ARM_TARGET1		38
@@ -58,11 +59,15 @@ typedef struct user_fp elf_fpregset_t;
 #define R_ARM_PREL31		42
 #define R_ARM_MOVW_ABS_NC	43
 #define R_ARM_MOVT_ABS		44
+#define R_ARM_MOVW_PREL_NC	45
+#define R_ARM_MOVT_PREL		46
 
 #define R_ARM_THM_CALL		10
 #define R_ARM_THM_JUMP24	30
 #define R_ARM_THM_MOVW_ABS_NC	47
 #define R_ARM_THM_MOVT_ABS	48
+#define R_ARM_THM_MOVW_PREL_NC	49
+#define R_ARM_THM_MOVT_PREL	50
 
 /*
  * These are used to set parameters in the core dumps.
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index e15444b25ca0..beac45e89ba6 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -185,14 +185,24 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			*(u32 *)loc |= offset & 0x7fffffff;
 			break;
 
+		case R_ARM_REL32:
+			*(u32 *)loc += sym->st_value - loc;
+			break;
+
 		case R_ARM_MOVW_ABS_NC:
 		case R_ARM_MOVT_ABS:
+		case R_ARM_MOVW_PREL_NC:
+		case R_ARM_MOVT_PREL:
 			offset = tmp = __mem_to_opcode_arm(*(u32 *)loc);
 			offset = ((offset & 0xf0000) >> 4) | (offset & 0xfff);
 			offset = (offset ^ 0x8000) - 0x8000;
 
 			offset += sym->st_value;
-			if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_ABS)
+			if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_PREL ||
+			    ELF32_R_TYPE(rel->r_info) == R_ARM_MOVW_PREL_NC)
+				offset -= loc;
+			if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_ABS ||
+			    ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_PREL)
 				offset >>= 16;
 
 			tmp &= 0xfff0f000;
@@ -283,6 +293,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 
 		case R_ARM_THM_MOVW_ABS_NC:
 		case R_ARM_THM_MOVT_ABS:
+		case R_ARM_THM_MOVW_PREL_NC:
+		case R_ARM_THM_MOVT_PREL:
 			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
 			lower = __mem_to_opcode_thumb16(*(u16 *)(loc + 2));
 
@@ -302,7 +314,11 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			offset = (offset ^ 0x8000) - 0x8000;
 			offset += sym->st_value;
 
-			if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_ABS)
+			if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_PREL ||
+			    ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVW_PREL_NC)
+				offset -= loc;
+			if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_ABS ||
+			    ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_PREL)
 				offset >>= 16;
 
 			upper = (u16)((upper & 0xfbf0) |
-- 
2.17.1

