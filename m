Return-Path: <linux-efi+bounces-1235-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461B090CBD5
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 14:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF151F238AC
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 12:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5813A259;
	Tue, 18 Jun 2024 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcPY3zCg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD2142E9E;
	Tue, 18 Jun 2024 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714185; cv=none; b=t3oE14rweyvH9mJWAUEE7N8QNephi56WNfgC3wdF5G+48RF2SKKIeABryv/2x6yLqsBXUqBCRbIpvgNtKXB+Iy9iZs/qjWAKcP85/mp889ezfiGVDb4uuT11mGHo/JgSL4WPYK5gqHRxveLGX0bgzbDqmzBVt0+whpaTXo4U08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714185; c=relaxed/simple;
	bh=kaqaszhQnjB6MNLzi7ZVRYXuc9INOeh8YqNngcloKc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0P3OOkecGxWfogoXQ5uDwJqK2bTAWEyeGREHg17Kf/gdbYpOQQ5PBSi6fyTFWGrlba2Cgtod/OuBxDKJxnuNVZSMi9lPj5i0/5+6lWnWLRV7zy7rpDgPhePosXbqFEsZEkDY3gJbbHGS+Mnsz0/vdWunLILrB7ECWwY5wuDCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcPY3zCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62696C3277B;
	Tue, 18 Jun 2024 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714184;
	bh=kaqaszhQnjB6MNLzi7ZVRYXuc9INOeh8YqNngcloKc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcPY3zCgiicvBAPEXv+PeuFtrqbGdxfgeDt+RdFX7DPLDiKEor3mldxzaupgyXIV3
	 ZRQrYMD9FQEmbmaVDLmUesYbfYVoCZbM+vAmvbXxzArzVbkz5cRi5q1KbNQgVKbacv
	 nf/5KOJ6421EKCwhyK4Z0Ta6q5DspR2lJjqo6XVQydFGAtLVGbS1anVfZS0HxkmXMG
	 jp/gBdapCGqau1JOPqmI8afHH2QNlHYcH7hVJIL2zc03UjdEEyqvcye5emHF8DIMgu
	 IWIpAMhQ7dxLljKTGKJ/JuhEVqUCI1lPKCLJO4jnngTp5KVbvxNXQTlhchIOO1Gx0s
	 AqDsP9HY33foQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	linux-efi@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.9 06/44] efi/libstub: zboot.lds: Discard .discard sections
Date: Tue, 18 Jun 2024 08:34:47 -0400
Message-ID: <20240618123611.3301370-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 5134acb15d9ef27aa2b90aad46d4e89fcef79fdc ]

When building ARCH=loongarch defconfig + CONFIG_UNWINDER_ORC=y using
LLVM, there is a warning from ld.lld when linking the EFI zboot image
due to the use of unreachable() in number() in vsprintf.c:

  ld.lld: warning: drivers/firmware/efi/libstub/lib.a(vsprintf.stub.o):(.discard.unreachable+0x0): has non-ABS relocation R_LARCH_32_PCREL against symbol ''

If the compiler cannot eliminate the default case for any reason, the
.discard.unreachable section will remain in the final binary but the
entire point of any section prefixed with .discard is that it is only
used at compile time, so it can be discarded via /DISCARD/ in a linker
script. The asm-generic vmlinux.lds.h includes .discard and .discard.*
in the COMMON_DISCARDS macro but that is not used for zboot.lds, as it
is not a kernel image linker script.

Add .discard and .discard.* to /DISCARD/ in zboot.lds, so that any
sections meant to be discarded at link time are not included in the
final zboot image. This issue is not specific to LoongArch, it is just
the first architecture to select CONFIG_OBJTOOL, which defines
annotate_unreachable() as an asm statement to add the
.discard.unreachable section, and use the EFI stub.

Closes: https://github.com/ClangBuiltLinux/linux/issues/2023
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/zboot.lds | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index ac8c0ef851581..af2c82f7bd902 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -41,6 +41,7 @@ SECTIONS
 	}
 
 	/DISCARD/ : {
+		*(.discard .discard.*)
 		*(.modinfo .init.modinfo)
 	}
 }
-- 
2.43.0


