Return-Path: <linux-efi+bounces-3904-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A108CAE382B
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 10:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E973A509C
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 08:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A506A1DED5F;
	Mon, 23 Jun 2025 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxEy9l+e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD24409;
	Mon, 23 Jun 2025 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666632; cv=none; b=VgANQljWwwLpwm0qA7Zd2YwS/NUzDSfin5S10aRt2y6NluMTnLmgrV6caFwJMFNQiEw6s5ir0V2hBeQx7Iqwk4Q7XmY64kOGZ5EHjp8B14ZhX/zuvj1waCbKHPpj9j0RqdCXL/m3iwGM6l7azoTP7/Lly+tl+HlxuB1CGkRBW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666632; c=relaxed/simple;
	bh=Rnhjck5HCsEhuRVAYJBZ5awJ1QZTUhi3BfHcxJlO3UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7dXP5RC3Sizx1Os+zKTSUpYoof5yA+1Zmfj8+poTvV3C27Ip1g6oPx7d3wnvrYbcub8rqA5WtDLNeEA+xrFj1jb9DSi+DVK+8pPZpt4JZsCCBCfeuNtmyI5VBw0R8lM/WNO3OeWYmoTsz6jHwBLt9U2cqw9G+XOaYRAk2vPJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxEy9l+e; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad8a8da2376so609301266b.3;
        Mon, 23 Jun 2025 01:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750666629; x=1751271429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ry3qGHx1o+/MM7PonGyb1zPHGj+XQROJebbEhmya+nk=;
        b=gxEy9l+eT6wSuNxxRlfrRu0P9vXTQIcZvfU0tzpHplRNvKz33Q0nkQLzbTjZeAMjsF
         UsNRRYW3+WG0ve0mUwxSvvKhssCqN6dx7+O+b768+hF69LwTc9JFwp3ONeEXwkayQ7DX
         OFK8ZC9dBk5jXBJwS2C8CQRZFs2HlArY30AZXVwIgvyHIs2lgHTKdYefXQkqWcL5g/xB
         rDSZ/9p2/6nmfIOc1tc83ZUzvo3qI887iDf4S0Kh97eQfSDCtikAeG72b11AuuYDse5e
         Ly+8PaqmCg5hZhUEIhRpP5qp56MnU1PXYcAUUs5rwpz79Zs48YAC1WWEUd0wQJMMtz9G
         Z9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666629; x=1751271429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ry3qGHx1o+/MM7PonGyb1zPHGj+XQROJebbEhmya+nk=;
        b=KXhlBZ3RZYC2o8SWLq3QHomxd70DVhJtvaXYe69fnZBB5zJfAvViqahNl1r14MvzZT
         9bMTG6MwE4fKAJ81oX31ddGO3ONjfZNRxMA4HEQ7aZ45A4Uc9u21MPxNHmbg8zHSpoNh
         0M9mBC1P5IUtUQ8x7EIHnfJ8hmQRzbaB5un6UqikJiPU6feOqEC5I+WXb90BhGWEzrdK
         +sz+z6t+GiNq+gC4Ns2q9j8DxEDyO057fotMfKUxgbo+kr0Si1K8HQO3b/mBht000wiN
         LIwCNhRFKvblxRuH8VADBQzE0twVuBsu/sLnr/PapawDEhkCe8IoJIQGztngsexquoDW
         3BEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSoITRUmwEBup/+ydRzVVMKkM3tyMTZerFyHw7L1TGbMA9zHCwVWv+0k0hjDX1o2lssF5lCoAQl/I=@vger.kernel.org, AJvYcCX+ZLkQpQhA6bf2+VTlDjnHGUzNaW+NrzosfffZvQOyX+5sFbiSJ1yxAQu4agOqZfmjEsqGTTcLWw0oW822@vger.kernel.org
X-Gm-Message-State: AOJu0YwpX3BrroITEy7nQOPSO397YrTX57rvOd2DCssD+3v76feDh6BD
	G/ZmzxHOm0hqF+nylsLUtChzu5IAVKFqAyo5BRUSX28XJ7Abo0DNx0fI
X-Gm-Gg: ASbGncuUTyZAvRNziHLqfGLZSZCXOROH8qjI1Qr2NA1Yq6qq55U7WziuQca0FGlWZwT
	MRoW+RwkQi1THOTu6VxUdrNPFkTnQU9GRYl3DoSZdRtSEM6r2jeU4aCmQRfhkqyWZwX9qW6LClm
	ujO4/GDjGkEIwACmlSUD5r7sCO0uakS8QqfY62e+EcxnC2fWAidVIYrEiErJvxBQu0zLctTJJeQ
	kf4u0OHS6Z6Em2meMpem47sh56o3FZWvZx4A88K8obxNJuo3fDyS0lZoPx9/sIz7V0vPyrJ/+7E
	aI9sjbSrBnHnYHPMkbFfXfPWGYKc1LGgJcfc3QFiImi08DI2bsuapGj80+/e8/1eWdYEgTch9uN
	1
X-Google-Smtp-Source: AGHT+IG15GXMsWOh4RW5DFtAdkUypKgNvRZpgsMr9ZUxR7D41K4qRzuDp12dMku5+dtniI8Kr0twvA==
X-Received: by 2002:a17:907:d2c9:b0:adb:1eee:a083 with SMTP id a640c23a62f3a-ae057c8b8aemr1029623866b.47.1750666629075;
        Mon, 23 Jun 2025 01:17:09 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0542080adsm667293566b.151.2025.06.23.01.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 01:17:08 -0700 (PDT)
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
Subject: [PATCH v1 2/3] x86/boot: the decompressor must supply boot_param from RDI
Date: Mon, 23 Jun 2025 08:16:05 +0000
Message-ID: <20250623081622.1282-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

This adjusts the decompressor to supply arguments from RDI instead RSI.

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
---
 arch/x86/boot/compressed/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d9dab940ff62..07dcc3ac5b6d 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -471,7 +471,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 /*
  * Jump to the decompressed kernel.
  */
-	movq	%r15, %rsi
+	movq	%r15, %rdi
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
-- 
2.49.0


