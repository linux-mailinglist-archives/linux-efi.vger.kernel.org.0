Return-Path: <linux-efi+bounces-412-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D682EB2B
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 09:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2C51F240C6
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82D4125A3;
	Tue, 16 Jan 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RUhQ1yYx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0011CBB
	for <linux-efi@vger.kernel.org>; Tue, 16 Jan 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40e8609c35dso845385e9.1
        for <linux-efi@vger.kernel.org>; Tue, 16 Jan 2024 00:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705395239; x=1706000039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C4eYXKJysFX8VE3KSiDq93HZ7LreswMaox/Ot0fnYCM=;
        b=RUhQ1yYx8UOnBqXcLd2pSQFTGejEmtUAr+sCLkU6i1tGNXrQwNtU/jYz30efdMlIuj
         BbhWE/FkTr/b+qpkZsjlcNddVMtOYlneuOf0wmKbVjXefPWoJ4W8y5hHE6ECEQJCfHCL
         iqSZZAjiPLypy0ynxeaJOkkuo1Zz0RoYm0JAA6q337VAt1/0hyFiQYH5eNip6AjAF0FN
         8EBny0PlOZs/LOSERZ9BH3PybQke0USvU4UIvEIGdIF7l8dRXfW4PNVyHiLWjtbokQOA
         XV9qXzpry76dBsLnh5yIQSpL3zdrl6tft4RyFccCewY9XOG1fFjWc/D+0oFlKgNuYRxq
         biFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705395239; x=1706000039;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4eYXKJysFX8VE3KSiDq93HZ7LreswMaox/Ot0fnYCM=;
        b=mfeCSaxMdmqYfUhoVQNzvBy6NjH9ZNs7Grt7m0VYF5GMEQj80bZCKP3pEfdQG1LWZy
         5cDO+uF6DA9MHbef2A3DsORai5nAL8bkZIxXy51XnxNvWw2/X3zlLguhOBld4fJ4+Q5T
         OVGvtzoUzc2H0hzhoNEpsikQxSPbXlV/knY4RvCd1JY/pP8S8yOHZnsF0LMu6pNrCrEI
         jjr3qAXIYsk23HTeUk1aast6aRJjxwVJ22kPuJUAFhj6E6vvopopn3fPCOmRp1hTB0Wv
         YVN9IiG2VS77+vLtA/6022udcRA5w5aFBrY3XfQ6glRR6qOz5RR+/LdkCoF7eAaoTumE
         4A0A==
X-Gm-Message-State: AOJu0YxWmym82km1IBJ2WWYIfgfP3ADaCSfsXtPFwcLAKZgYo3b/d5AX
	p2YOhPI4QN+Qpty4kxrGw5g7i6Hogb6HLRddfZd57Gmaz1G1jb1bf+1nhEyCEj9+GXbRvcAWieN
	PF2OlJ1x+D3X/Al2snbbW8nmmk4Pfweo0wjSVfoTiUOgst5L2OXn3DqgUtPTsun4eQo4=
X-Google-Smtp-Source: AGHT+IH054hnmbpxDsqYZUNPPXFfvJw0cg8yCg6w07PvRNm/hXu9sRWH9tPiLoazlfNZ6lmFROrcbe1d
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3b82:b0:40e:46bc:f782 with SMTP id
 n2-20020a05600c3b8200b0040e46bcf782mr123735wms.4.1705395239241; Tue, 16 Jan
 2024 00:53:59 -0800 (PST)
Date: Tue, 16 Jan 2024 09:53:48 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=ardb@kernel.org;
 h=from:subject; bh=JjeLxdoT4xbPV5jCAVM9yKRNNcWl1LDQgnee20GLWIg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWZi8zTWZ+32XLuCuncnuymXdfxTPSbCd/E5+srLY9q2
 jlbish3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIk88Wdk2L/Q67z2aZeM0pMP
 1A7HXc65ELRk8oruJe6uBt8Sw75JhTL8s/bbFRccnflf5d+h7zOdgzuqE/n0PKWUom+vmNxUf/w nJwA=
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240116085347.2193966-2-ardb+git@google.com>
Subject: [PATCH] efi/x86: Set the PE/COFF header's NX compat flag unconditionally
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: pjones@redhat.com, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that we use the proper section and file alignment, and invoke the
EFI memory attributes protocol to manage executable permissions where
needed, we can set the NX compat flag unconditionally.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b2771710ed98..34963501a2c5 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -112,11 +112,7 @@ extra_header_fields:
 	.long	salign				# SizeOfHeaders
 	.long	0				# CheckSum
 	.word	IMAGE_SUBSYSTEM_EFI_APPLICATION	# Subsystem (EFI application)
-#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
 	.word	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	# DllCharacteristics
-#else
-	.word	0				# DllCharacteristics
-#endif
 #ifdef CONFIG_X86_32
 	.long	0				# SizeOfStackReserve
 	.long	0				# SizeOfStackCommit
-- 
2.43.0.275.g3460e3d667-goog


