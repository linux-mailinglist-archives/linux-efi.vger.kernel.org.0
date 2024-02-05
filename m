Return-Path: <linux-efi+bounces-478-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE03849D52
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BD01F23819
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2436122;
	Mon,  5 Feb 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="HtS79BL8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CE33CF6
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144292; cv=none; b=BTtwCRqodYfsdW6nKlt79D6nGTDwJWbRqVc770fUJgLBeEihR3JJ5TZ3J7aUMhXDBC0L87r9iqOcMpN1dRM5tLD59RtcKLLXAt0DetSW5cxCyQcQIIU/GbR4aWlkPz3s/2Wa2kY3dD7fhVyl/vCnrDoLi4OdlBy78UDmysXT9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144292; c=relaxed/simple;
	bh=RaAzTD1j6njZTi7drPJQ3UKECyzc5Iqh9j0aj8NquIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAjr21KsxlfK0h8hhXZF9sH4Cg/TIZs1Cj+1vlZUFu8pDr/Gg84jzzym53Ibgu2j9wco4nfdM9r8o7w5/qN0HxodiAtc8OaEJf+HUkZHr3Wwr3l3Fb86Zx94Y1/Qok8Rgi0Zbm0fSVAU+nWMmzwmWPWdO4jDL3Xp3nnvyXyc08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=HtS79BL8; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [80.240.223.29])
	by mail.ispras.ru (Postfix) with ESMTPSA id 79E3040755DE;
	Mon,  5 Feb 2024 14:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 79E3040755DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707144288;
	bh=T/OfrlQsZKHRZkF4NQnHU8K2Q74rrNfKQBTV4x0Kb5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtS79BL8+MrwDerHLlzsG9WGCBVDPBRfxcJiKxJIzOl8XZk/IQj6/DJDIifOn8uUe
	 cLM0wKAedsYashAapL6FV7oq62zyPKF5Cvx44gqjrxVNnoY/Ino96JXhBKOeMu51QV
	 U5Wty5MGr79b5k0MmqVv9AD+Qbl7q8upW6RM4itc=
From: Evgeniy Baskov <baskov@ispras.ru>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Evgeniy Baskov <baskov@ispras.ru>,
	Mike Beaton <mjsbeaton@gmail.com>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	linux-efi@vger.kernel.org
Subject: [PATCH 1/2] x86/boot: Order sections by their RVAs
Date: Mon,  5 Feb 2024 17:44:00 +0300
Message-ID: <82e66a8c9ae70e416eb8ae5229cf5a93f17921b9.1707141974.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707141974.git.baskov@ispras.ru>
References: <cover.1707141974.git.baskov@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Image loaders which check the contiguity of executable images consider
sections adjacent in the section table to be adjacent in virtual memory.

Sort sections by their RVAs in PE section table.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/header.S | 56 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b2771710ed98..097b84ab288c 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -153,6 +153,34 @@ section_table:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
+	.ascii	".text"
+	.byte	0
+	.byte	0
+	.byte	0
+	.long	ZO__data
+	.long	setup_size
+	.long	ZO__data			# Size of initialized data
+						# on disk
+	.long	setup_size
+	.long	0				# PointerToRelocations
+	.long	0				# PointerToLineNumbers
+	.word	0				# NumberOfRelocations
+	.word	0				# NumberOfLineNumbers
+	.long	IMAGE_SCN_CNT_CODE		| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
+
+	.ascii	".data\0\0\0"
+	.long	ZO__end - ZO__data		# VirtualSize
+	.long	setup_size + ZO__data		# VirtualAddress
+	.long	ZO__edata - ZO__data		# SizeOfRawData
+	.long	setup_size + ZO__data		# PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_WRITE		# Characteristics
+
 #ifdef CONFIG_EFI_MIXED
 	.asciz	".compat"
 
@@ -185,34 +213,6 @@ pecompat_fstart:
 	.set	pecompat_vsize, 0
 	.set	pecompat_fstart, setup_size
 #endif
-	.ascii	".text"
-	.byte	0
-	.byte	0
-	.byte	0
-	.long	ZO__data
-	.long	setup_size
-	.long	ZO__data			# Size of initialized data
-						# on disk
-	.long	setup_size
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
-	.long	IMAGE_SCN_CNT_CODE		| \
-		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		# Characteristics
-
-	.ascii	".data\0\0\0"
-	.long	ZO__end - ZO__data		# VirtualSize
-	.long	setup_size + ZO__data		# VirtualAddress
-	.long	ZO__edata - ZO__data		# SizeOfRawData
-	.long	setup_size + ZO__data		# PointerToRawData
-
-	.long	0, 0, 0
-	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
-		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_WRITE		# Characteristics
-
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
 
-- 
2.43.0


