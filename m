Return-Path: <linux-efi+bounces-1061-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5EC8CC590
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 19:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5561F2251F
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6FB1422B4;
	Wed, 22 May 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y47fhWjY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715A76048;
	Wed, 22 May 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399170; cv=none; b=q7ozyMAJqO5X3IzwcvN3gD4HChQQagR9/FfOzIsGYE9J9aDiu5cHbENwJYPU8tMoSyMMbEBhWEuEL9GdXux1llUWawv8BZfIWYGDkOXHDaZi2Jd+0XuTDz3lxWAlJur3jdSzeBA1HYTTkSkG9351svK+M2Pp01PU+yGCnLk1Kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399170; c=relaxed/simple;
	bh=/PN55//MytV2k126282ue9+p5v4Xkeov6iPQTSuOE0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DJfhIvb6JcJ59leuTgR6ebcrW0fWdKtNvd5+pixDQkJvsAmfClh0BMftQDsOqj5aNCO+lQkipq5RCDFJVnJZKvMw15JUu1cmmqBKDfAtQWr93GOSChaYXaz3F2nY6W8PPomX0bNE3vjFZcLsbyK6sfYfOkebhmLg+WbsaDxvDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y47fhWjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7FBC2BBFC;
	Wed, 22 May 2024 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716399170;
	bh=/PN55//MytV2k126282ue9+p5v4Xkeov6iPQTSuOE0I=;
	h=From:Date:Subject:To:Cc:From;
	b=Y47fhWjYcGcX+hOXTvI/thAGXgpXSJkTNj/raoRIYCzHfYHB0cm8nftecIKyahIjl
	 Q4aZMLVXBy+W/wAXMACXGJcNlJE9tnqGrnX9CEn3+FsT3RfYR7lHA7DeSRc+QCFKY6
	 qPEeOvszF4EwoIto7zwVqmRwaKRVcIGVW+Bk8BgD36RD892XLlH/uHaSp6g/5GCJUI
	 2hBukG52w9lh3MSvOIBjqjCBN9KU1qz9i5se9iqFs8SPvPKDxvQlg6675DysWrBDYV
	 WvBUkze66kt6+i0jHAo78VPkSOyPGn/i7t0TESMlrvksdlaZRAvkefo1+PkBxvFHej
	 hFvTTnR93Ap3A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 22 May 2024 10:32:43 -0700
Subject: [PATCH] efi/libstub: zboot.lds: Discard .discard sections
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-efi-zboot-lds-add-discard-sections-to-discard-v1-1-6b415efa0f85@kernel.org>
X-B4-Tracking: v=1; b=H4sIADosTmYC/z2NQQqDQAxFryJZN2CDFuxVShfjJFMDxSmToYji3
 Q0uXL4P7/0NTIqKwbPZoMhfTfPscL81EKcwfwSVnYFa6tqeCCUprmPOFb9sGJiR1WIojCaxum1
 Y87X1SWgYU0f8CODNX3F/Of9e730/AL0j0wl/AAAA
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 linux-efi@vger.kernel.org, loongarch@lists.linux.dev, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=nathan@kernel.org;
 h=from:subject:message-id; bh=/PN55//MytV2k126282ue9+p5v4Xkeov6iPQTSuOE0I=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGl+Oo4Oxd7SElMMTAu1Lm6fLL6M/+cp31+Llh65fP3Gy
 4u7j+0W6ShlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATeXKT4Q9H3JdL7xP8nLr+
 bQ+r07/4Idp7zpSFZ3rXaNZs35OXKnCf4X/2GW+e06zO+rcVgn482DjpxNxVRy0/aKXkvJPQWyq
 sKMEOAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

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
---
 drivers/firmware/efi/libstub/zboot.lds | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index ac8c0ef85158..af2c82f7bd90 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -41,6 +41,7 @@ SECTIONS
 	}
 
 	/DISCARD/ : {
+		*(.discard .discard.*)
 		*(.modinfo .init.modinfo)
 	}
 }

---
base-commit: 15aa8fb852f995dd234a57f12dfb989044968bb6
change-id: 20240522-efi-zboot-lds-add-discard-sections-to-discard-5fe29bf42d6a

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


