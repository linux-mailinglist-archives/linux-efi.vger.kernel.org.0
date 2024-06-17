Return-Path: <linux-efi+bounces-1226-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B6990AF31
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 15:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45341F2154A
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2F819CD0E;
	Mon, 17 Jun 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLbrJBfC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088D19CD08;
	Mon, 17 Jun 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630459; cv=none; b=ek6qmOGlRV0imk4NOQliZ/ifmHVqyIlVUeluUDNZVXhUN3SugOsU1TQQ05zlbBWXmjVBffu/OHavNx1L7vqKOKDjFFcXLSOCbwquYEX+AhsgajtB3JyOYdd5anfwHoKLXFlqKVDbOZ8i0IlnmO1zvuR9lMq2kSWJPv4r6w3U0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630459; c=relaxed/simple;
	bh=kaqaszhQnjB6MNLzi7ZVRYXuc9INOeh8YqNngcloKc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+fFuwd9u8UjcnQnBrG7ZkWUqEadad/4syRxAqznWJtTP1B3suQLrtXbpKZbRLHZtNa20M+AjwmHJYxuqxev0+wn1BO9f58xeedRJgJGN4W9MePZMlbFfmJsc08syk7kMPnIza/FRQPd0bF25yio7Lj27RZxfUaHzausl4pBMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLbrJBfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F87C2BD10;
	Mon, 17 Jun 2024 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630459;
	bh=kaqaszhQnjB6MNLzi7ZVRYXuc9INOeh8YqNngcloKc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLbrJBfCixCHPUSvgD2TXt64lc7sMc2x0RE6iUDtR/IsOUUeU7pCbJ1efPK7snQNp
	 g+fZBd+ueUk77CgXHRydKp7HD3TK2F9aoClrNmVa4msiX8QD/0jGwreH0ekRlrMwr4
	 S7SS7dvqRLnjFstEHhMx68skaT+e1cd+89Ntkrb16hBHiGE2UPlvdaNvQr7TmyzWmL
	 AxygjDXl4l6sN2Zbfn9D3djQUOHtFarrHbRG48exH4W9kZP1Dbzi00rfwWbCzRGpas
	 WxPOK/Lcs234oDHrV1owveV1x40fLU7I6ODpgaG9o7aBO/TzDYFQHkftN/9NTOVo23
	 XwJl6YFb+YOkg==
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
Date: Mon, 17 Jun 2024 09:19:19 -0400
Message-ID: <20240617132046.2587008-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
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


