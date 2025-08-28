Return-Path: <linux-efi+bounces-4647-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1393EB399C5
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37961C80B04
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D934D3112A3;
	Thu, 28 Aug 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgiKLSru"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EB3101C7
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376584; cv=none; b=nl0M+rgMu/EQH0ON1vUyvO1MeQpqtTgxfc7YbVMujEPhQjPY8plWrnzV1lW9QLHzISBcrtSz4bxShpx/KCDdW82Cax4wjWW4EFvRnvwu4V7KrI9s+k6Rie5hQ+GQtSk1RsL9MEs8IgVDURYY/sujky5hN31KxdO+oDF6NGV4ZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376584; c=relaxed/simple;
	bh=ATa5Ur6QwnSv625zc1IS75BRih4YDr/zqVuLMWsD/FU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nfu5VGLlx3x4RqnvOPgkWj26M7MOEzqMX3EBD1CLLlMszgIiFWcpJstGb5+b1zvoROD8qpZAhwxpkcR6mLg1DbQXCzjVZrxYBVAmS01blieTgS4shZEJTJip/JxIwio95LdEDWrSS3RIiAr6/EvHyGF9BqYjp+OAmJ5cPuIwyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BgiKLSru; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1ad21752so4344345e9.1
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376581; x=1756981381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXWw7Y+UJdSBQLh/fhRl4MOI8sJec2OYFK+QWdBoYgg=;
        b=BgiKLSrucTu4sxEbKsFVIphskwesSQ52hUh+lszzIjwH9pp5Q++aCJ6mThHZe4QDD/
         GMOhNyl/dRbvf0qXT/ZCLI2bAKUg4ru4eqeu14Y3Fjg4gTpO3Gh6JHA6fw1eFrQ1Nm6F
         QIC11hE5xS0wZU23glbZKo+Z1hDabIbVScJgqj2YWieuYA+dePx3G5mBt6H/FbAW7OOK
         aJ3b/TY2ZDZ+EMCk+W2vcEl9hbArKi8osCaxrIAsOThAqRBvjk9vIxo/vqk0o1x2COph
         pRJVe6GWYkAWNbaDlz1i5paXAWb59NgWNcY54q+9ZTxUHv7vPLYAFykptkGtudUPAlx6
         rZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376581; x=1756981381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXWw7Y+UJdSBQLh/fhRl4MOI8sJec2OYFK+QWdBoYgg=;
        b=Gd+d/oB4VLauWX7E39OfcMRFZNqnVLdY3J9GoPUzXSNVrX3a8Uh3sMyFwHOJoEa+DZ
         cYItLe5dZJrjr8a8R775WtZMiiqKAHjsIqn6kY0NNJbdAC943WJmWkOeVZol4B4UdUpD
         S+8zdLyzfPHpFLzDD5GIEOpO+LizNZ5F5qXRyIuua39Wj3fEoCrzz7hfbYvP6LwYW0nR
         MbOOUKLLeeNZ138pyt4mTUK/NOot2spM19h2vX2FSByOiioy8PaSrPbYvaueta9kNG/T
         yLDvCPngSxgvoScZLD9BO1YbpbGRjNpdzYFe/t6c4OLItC+oEHK/2mPPwZYQv/0HY8nu
         TbAw==
X-Gm-Message-State: AOJu0YxxSA0kBxIU9T6WLxOts5Qs/+flZkRjdVjPExdzZpgN52c137Js
	9f90PFO+5xLLReuuWqWy8k9uKQr4hFEzEAP3TfPvWxu5lfkUFBVYHJ62mU9/YKN9AjNMQMomdA=
	=
X-Google-Smtp-Source: AGHT+IHbmcTa9uXOzfLKVnm4w8QZ3oOsJ/lxXH29qLLzB/tlHHWIOyMrZTudC5l76tIEXZKxSGIjjFAr
X-Received: from wmsd11.prod.google.com ([2002:a05:600c:3acb:b0:45b:5f83:6ae4])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1387:b0:458:b8b0:6338
 with SMTP id 5b1f17b1804b1-45b6870e70bmr89819895e9.6.1756376580490; Thu, 28
 Aug 2025 03:23:00 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:25 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=ardb@kernel.org;
 h=from:subject; bh=/jCcOYfML0JH2E5FHnI0zJ4gY10zGaxYfVZWNXUzEkw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7tMH2RyFtySk5UujLB6vfVR4hjsk57HGk6q6T+8be
 cuay552lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIm0VDP8T/fqbUpg7ot4cIX3
 Ls8hm2nrXuXcn3/fZgJr+SozrVytVob/4d7xE0xtPa//CrC89Pte1+V9fs46W1SVBT87CFztezC LDQA=
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-46-ardb+git@google.com>
Subject: [PATCH v7 22/22] x86/boot: Get rid of the .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section is now empty, so it can be dropped from the
linker script.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4277efb26358..d7af4a64c211 100644
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
2.51.0.268.g9569e192d0-goog


