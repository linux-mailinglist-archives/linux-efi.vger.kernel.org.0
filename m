Return-Path: <linux-efi+bounces-3907-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DE6AE3839
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 10:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCA03A514D
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E31A8F60;
	Mon, 23 Jun 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDfO1x/A"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4FF211F;
	Mon, 23 Jun 2025 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666732; cv=none; b=Y7BDjN8GBf9sZhVgOk5KtM5LflRxhp6hG+otYyPLk2ENVWM+1sDHKdXmx8hioWTyQgDzs/RW3Jf7RyQqCPl8b26oDdfFDrG+zJqC5qIvapbULNKIu18cjlZPJgoGniSKmYl451xoz0HjTyKVkkZbQ5mEQfN4pFoNG9gpmU9gipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666732; c=relaxed/simple;
	bh=lCK854TgRqv39ZVQ7Izhf1FWljjyyVyW8qjFDJ2regY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbjOG/OwE4x7hE3rIYUI3c15lTIQN5atPUFB/Su+wf6SKfDh7eUrWcZwj3+m4Cs+IaDcWO2NKcUnYFEnq8cDJvwowVyKy5AQut8uksVFK6M6yh6K7eWH/FDXi/WTmtT9NsONeWQZiHA06TH3GwVXhXEbBrGda45c7tXgId/oris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDfO1x/A; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad8a8da2376so609596066b.3;
        Mon, 23 Jun 2025 01:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750666729; x=1751271529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwx8N1prAjZlb2ymIsmsbUe/fl2ghoNiNQjIjRYyjWA=;
        b=RDfO1x/AEljEzhgDjHWFG9lPS2VhewfdT+Y69CQ+blJqxCKO9Sfg1xD5mDeutY1uzJ
         asu1EpriX3x4PRt+AQOyE4OAPl4CEn/Lmf2/BNT6AEwlB4CqR5XpU6nLAr25bvd0Yfsl
         ZA+vxFh/2xlLj/YeWAQLsWIxnzClrAbHLQbTs8qsshLik7YTk1i8e3/1K/vl3imp6SpA
         1uk24m9NtgOVVLbBQ5Y2hWcdUmtliurkr+YXl1QVTc6rN5ptDWZjGMII9k8S1H3pCYJ8
         nZTjnfNMSTK642QEkXv4nnqz/YaE0Xod+n04t+mkzPO5yCYfxyWpjzwpUtqPllh/2Asj
         yVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666729; x=1751271529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gwx8N1prAjZlb2ymIsmsbUe/fl2ghoNiNQjIjRYyjWA=;
        b=s+5bLJ5pphjNeN4kVehMlkMtysopwhMS4AUn4rxe9MVjUOCwtPI5BDVHD0OF8Luh2F
         t2BoNFOYfML/N0tAtQJvD/A2QhDSUUxhDSWcNOFraYSA/bz2gKNjE3VTz2PCUcty1WBl
         2lSvJe2IthXTgc3dwp7EKpNVodqWs3aSt8vyF7y951PSNSx9Re5HhDXsDheIzl/6ozq6
         E2DJdiEGG76diNjKQOF646I2q7NJ6X1X3vRqETX11AOiS7Rt4w3ON3iYJSBRyaHsav2p
         OlbeZXMJ0zpEymXS0NDtPUNb2h3atSvsZ6rMtn5/XlOfW/sWvOmZtqHBuqbP1dKvnvvl
         g2dw==
X-Forwarded-Encrypted: i=1; AJvYcCUb8xAQrCiA3Scu7ItspCPnNfu4jP1r5PpdnulQd9DCSUCyV/NhzLbdk7r7wMtQQ7zD/sGQjqEQfEQ=@vger.kernel.org, AJvYcCVX61tr6qJ4853OVHE4GA329hWT0mLNUbpfPySV7kMXl4FeNJSDXVnqbs6S9diXfngq1MpA5G5KHZXuxFYd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9DBqtlFYtAPTmylAi8hsNMVNTVZPgp+1rOHA2QrDdr86pxr1s
	w9XID5CxcP00A/Azb2yrb/mJy+PccO43kjvKSP4hgT8xeYnPRcs3UIYo
X-Gm-Gg: ASbGncuA86QxuU9O1LmJniJNOZrQxYlG2hQhPyR9FlEoIuzALmQcUb33vCS3LhO5iNb
	w/snRD1Q9I1TBTs7gszTBDm8jK1CJPbAKVXWNgU5wp0MR4BhZT9iw6lnK5DqAy6aHhm84TZAfm1
	SyIN/wzJEqERvFLNH4WCVKyUzZ2WtbUGEtcy6bRSwn2x2BeumZwQG276XC85iasCiuPlGD2t7DI
	mJFKF+YzA/k395LihyqFrAZ1dA1UAeK/Xeip6uUlTP+khHNyuCJ1JdIb0kquIHRW2rSa1cmRqdE
	Vd92RfkioqFPHfpklCQhcVyiu3oPJDxl3mGu08t9zOlwLBfyOZX4uIxTZ4+pDDSkQP54qLBSPzx
	0
X-Google-Smtp-Source: AGHT+IGnko2iUfz77f98BBimqLt0TFCYQBHgyYvKFbjRTMvtzWLPW4CMLACqj3r7KnSwqczuloUYVw==
X-Received: by 2002:a17:907:3f8b:b0:ad8:a515:767f with SMTP id a640c23a62f3a-ae057ca667amr995584766b.51.1750666728427;
        Mon, 23 Jun 2025 01:18:48 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7f2cesm680467166b.10.2025.06.23.01.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 01:18:48 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ubizjak@gmail.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH v1 1/3] x86/boot: Recieve boot_param from RDI Instead of RSI
Date: Mon, 23 Jun 2025 08:17:50 +0000
Message-ID: <20250623081803.1340-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

Adjust the kernel entry point to recieve arguments from RDI instead of
RSI.

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
---
 arch/x86/kernel/head_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index dfb5390e5c9a..d24fea15b6a6 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -43,7 +43,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * for us.  These identity mapped page tables map all of the
 	 * kernel pages and possibly all of memory.
 	 *
-	 * %RSI holds the physical address of the boot_params structure
+	 * %RDI holds the physical address of the boot_params structure
 	 * provided by the bootloader. Preserve it in %R15 so C function calls
 	 * will not clobber it.
 	 *
@@ -56,7 +56,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * compiled to run at we first fixup the physical addresses in our page
 	 * tables and then reload them.
 	 */
-	mov	%rsi, %r15
+	mov	%rdi, %r15
 
 	/* Set up the stack for verify_cpu() */
 	leaq	__top_init_kernel_stack(%rip), %rsp
-- 
2.49.0


