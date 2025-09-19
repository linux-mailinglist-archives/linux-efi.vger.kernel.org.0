Return-Path: <linux-efi+bounces-4869-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1912B88984
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 11:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787641C844D7
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 09:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7206E306B34;
	Fri, 19 Sep 2025 09:36:29 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274A4305055;
	Fri, 19 Sep 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274589; cv=none; b=tr+t5QpSCpV+hzCq7AgfL3x/agVcAxhL+4A4n65FDh71R8hRHYjfktubdxwJXS1lBAYfyBXZLay3Jxpl2XGV7iYLyouU4SEuv0He9UqvXnx3AEu1/OFhHjgPTPMSlwyGslNqDbOgJcX0NfEI0GqNk8cXyHuAxdz1yW4cUWsef0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274589; c=relaxed/simple;
	bh=Ccq6B67Koku2aQcukSI63wdlDqiQtEG8xW8WNmTx/3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTeQbWUcw86LSww0ct/w2LMkMYcVCcDfKYeLmbQKYsrBh5cQpv42EqvjIuFC/tbG1t/qJxO4lK0ohssMUeIdFM9HLpoiX101l+3qRzDw2Gfp0y19jC5b08/oas9Wwdj9SlANEuXOOBkUlxKlksNK+jBnEnJHVrmPpNhSdlI0NtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxudEYJM1opi0MAA--.26778S3;
	Fri, 19 Sep 2025 17:36:24 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxbMEPJM1oMmufAA--.61162S4;
	Fri, 19 Sep 2025 17:36:20 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] arm64: Only link libstub to final vmlinux
Date: Fri, 19 Sep 2025 17:36:14 +0800
Message-ID: <20250919093615.30235-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250919093615.30235-1-yangtiezhu@loongson.cn>
References: <20250919093615.30235-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxbMEPJM1oMmufAA--.61162S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrW8GryUWw17Ar45tF4fWFX_yoW8Jw4rpw
	s0kF4qkr4qgrW8Xa4rKa17Xw1Ykws8XrsIgFykZry5tw45Z3s7Wr15GFWSkF4kXr18Jayf
	Gw1ayFy8CF4DG3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==

Since the efistub functions are useless for stack unwinder, they can be
ignored by objtool. No need to link libstub to the vmlinux.o, only link
libstub to the final vmlinux. Otherwise, there may be objtool warnings
when arm64 supports objtool, this is to make consistent with the other
archs that use libstub.

Link: https://lore.kernel.org/lkml/pq4h7jgndnt6p45lj4kgubxjd5gidfetugcuf5rcxzxxanzetd@6rrlpjnjsmuy/
Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/arm64/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 73a10f65ce8b..038f37ef2143 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -156,7 +156,10 @@ KBUILD_CPPFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
 KBUILD_AFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
 
 libs-y		:= arch/arm64/lib/ $(libs-y)
-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+
+ifdef CONFIG_EFI_STUB
+KBUILD_VMLINUX_LIBS_PRELINK += $(objtree)/drivers/firmware/efi/libstub/lib.a
+endif
 
 # Default target when executing plain make
 boot		:= arch/arm64/boot
-- 
2.42.0


