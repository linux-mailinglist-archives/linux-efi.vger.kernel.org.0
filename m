Return-Path: <linux-efi+bounces-3574-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28AFAA85C8
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A78189B46C
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0471F4184;
	Sun,  4 May 2025 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnHGt8mq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891B1F3B8D
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352435; cv=none; b=r8aqbvvKBWjQgWn7KkEm/H0AAZwZintSbzX1WbkInbc6kYh1Z6oy5I1CVuKAhuHOOSx2LB0Uw1ydmcFamF5HlLY+CSAHiLcRF+16z4MRSstAmAd9zoSVLaw1LMDVZSKlQoziOQcnfLe/xYuTn6XSx65gqveSFzCiAtKK6SKdAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352435; c=relaxed/simple;
	bh=C6gzvknBtFypmZWra6mOhD5B9I5YTmOiy1ngK8W8VIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e1IbWD+kpT2aEmvEBK43AIkgYsPmkbVmKc3BMvgyk6GHsU7rBZPM9aoBCA6RkVg3UIqC9kSCM8yGcuHD8wKIUpq6ceiwcu80/Pc3s8RzLnQlPDaxl6ideHOtSy7RzY2YH/kgzJN+4BiTou3RBB6oe44Zq5Zo/xto/O6ygDUk7YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnHGt8mq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43f251dc364so19247655e9.2
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352432; x=1746957232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lC4kTjWNtYVJtNr/R34O8MumjOtUSCO/boDQXdKZavw=;
        b=pnHGt8mqiuF+GMqLCoQhhPgIaOlJo3iwzdQ3DI+jOcmt9vFeK+wL4nmgq4B28DqPqL
         dfzu3epn+rmr++Xzp1iYGnZWO2A1KN4bvWB5GeuGE0VsQJZD+jN0hPZWJHhzSg922k+Q
         nhKgVwiLBBnEv+WBCyvCDD/1eTJJetUyHOI7UjW7XhxiLu3MIA5T4TeOIZsa9CC+MeIZ
         462zrWDY06o8XspYTwbA/iiqjbvZ94faR2L++BsFHDDlPCO6VoFdm5V/l+1ReNUG9MnL
         k9y39SItd74ylX2A8aqF+hiDr8Pa61m+7vxe/CZgb52TwuB7f2qi+kXa+jO78WbV0B5f
         XS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352432; x=1746957232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lC4kTjWNtYVJtNr/R34O8MumjOtUSCO/boDQXdKZavw=;
        b=F3PNg3t335Zqe106no+5QdAcm7kmnZg+1EVVfM4dI+gswYvt4TkvPj/Ww/KDt1d48q
         Amg3sr/VdBHwiiE1RII1w0bhgvqfleLaeI+s51pEIp1GE21ZIdwN2jgkm2FUtFSZ2oVB
         LxanC9yyWIcOALot721koQvm6OXDdvhQH11UhKU3mNx7jlVc2rn6L96fG3LbtbIderrg
         r2V5QoprxXQiOUyadM87JqvwlqEPVOglLAm6PB9OouNRBFEyuk0D7lLIR2XT3MJ8r/Ev
         qWWosxFaUOMGQYokIrlQBEo8g+Ii1ur9hQHjplEB2zVNW1VDqDUADEi7K6OQwKEnvlpo
         BMPw==
X-Gm-Message-State: AOJu0YytrtbG2hIK96Pi9CMiNnzournUaCyT56Fna4ZOkXWICj1Q69oH
	zLsmjKe5MlL+UR9mUl5jodzODEBNOgzJEmPqnddGIbHpJF3yAa9lPHu0+sbejxG4OvWrPQ==
X-Google-Smtp-Source: AGHT+IEmLbsKySGDhi+UwQYPdC4xgeVngLAICWAnBPmQkT2h+F73uzVvKde7aylFSfpCInOSZFE5iYR3
X-Received: from wmbjh5.prod.google.com ([2002:a05:600c:a085:b0:43b:c450:ea70])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8711:b0:43d:47b7:b32d
 with SMTP id 5b1f17b1804b1-441c4919fb3mr23588375e9.25.1746352432075; Sun, 04
 May 2025 02:53:52 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:53 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=ardb@kernel.org;
 h=from:subject; bh=zbymTFtFVf98uj8Itu8GL+XtbjDBIM1MUB1YpDi01GQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4o9J9pr5v31sQhY7Xrs6r2nfuyWPri+dwcCjtsW5b
 kmdOndMRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjItumMDP23rh9evG3K30dz
 u2Qy193e2NR6a3/IR5mGV76N//dd8W9gZGg4XCoufDDz/3Wmlbzbni2s0n4rcPeOgw/3n5hfdV+ WbGQHAA==
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-48-ardb+git@google.com>
Subject: [RFT PATCH v2 23/23] x86/boot: Get rid of the .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section is now empty, so it can be dropped from the
linker script.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4aaa1693b262..af8bc4a6f6c3 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -160,11 +160,6 @@ SECTIONS
 
 	} :text = 0xcccccccc
 
-	/* bootstrapping code */
-	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
-		HEAD_TEXT
-	} :text = 0xcccccccc
-
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
-- 
2.49.0.906.g1f30a19c02-goog


