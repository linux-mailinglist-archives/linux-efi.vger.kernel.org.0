Return-Path: <linux-efi+bounces-3903-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E51AE3827
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 10:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C235F1891162
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503FA4409;
	Mon, 23 Jun 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URBgTGvN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D671F4177;
	Mon, 23 Jun 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666599; cv=none; b=lN2dawPl5fWHtorESoLTJeYZTgqORBVCVazkZfvxsFkQ3wBZcbbdUsodDZ8ltyfYjsf8/OU4APUhaaSMIius8f1tat9hRewJhH9Z/FVXVZgIXsqYOS4BboUddVZPaejBlOEuehiT1VRUX8JiMaLzYMM/Uw7bev9BdvINSGjVunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666599; c=relaxed/simple;
	bh=lCK854TgRqv39ZVQ7Izhf1FWljjyyVyW8qjFDJ2regY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJnNdo9XTtZiIek0H/JUUXjUt3q4T1HMasiIkdUMbEfkW8QrWG7OgWcmLH/fpgUuAxnhSHdlfDftAvnoOfGGcDB7uTaoXiV+3L9fXKgHVAehAdNbGaqHVVmwNhyaeyFYSCkZtSFmsBcKLp24rXDSuOBngghxwB2c6LcMgI+OxhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URBgTGvN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad89ee255easo711848066b.3;
        Mon, 23 Jun 2025 01:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750666596; x=1751271396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwx8N1prAjZlb2ymIsmsbUe/fl2ghoNiNQjIjRYyjWA=;
        b=URBgTGvNpnROwcDg43Uo0XsmY+UY+PPS3PUoJT/+iDW/2ZdeUKzlvmaBNmCusF2qxw
         t2dkJXuGn8ATl9tDEUyk9CveTMIXJNhuXV8zUw92U/Rn9dN2sVG5zhxQNi1YBReOmyXs
         3euS8pHWSQ2XLUFEwffTTEDRB2SGYnXPXNKyt5Y7O83hQHoNFnhYio/AQr2C2kRPzrn8
         21odrSbsB8acKO6jNlOdOFEYikmloPOaMVywJsdifIAn6LOFtnAHyQpPPj0Pmb+VenxB
         Ps3Cs1PsF8P9YGLWqj2uvjnFMp3Dx07F9PZtrYIUq9ZgaMuz6O0I4U3+Ie+0GW0FxYLE
         xP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666596; x=1751271396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gwx8N1prAjZlb2ymIsmsbUe/fl2ghoNiNQjIjRYyjWA=;
        b=ELbEDf7EmWC26cQE7QP0wf+2Pb+jBnafioWWJ0g/96PkXCs5RHzDel3N0VsfMzvVhY
         8znDYFQHaNaA5PvuwgKG+dgHlHVB7HvX/qvnbgC+ZjpeElXX3paugNxYiHXJtZthhPrZ
         YVerT1gm9WSzzj6Hy1PPKBoIF2A8Jp7Gsn/LTgEu4dKYKIQlGiZaJBA6xWzXkPJWJCa5
         zOTiC/UsCdvQypt2pseOGehbcHH4p8aae2w7MMhbTjOm/C3jCG6zbL4K27sNheg3guFq
         ZMCE5xzwLNJXfqvTgyeMF3HVElFW+3BQAfew8JXTY5CfDz8Z3X0K5ERJChqfiVlwvjgF
         rjeA==
X-Forwarded-Encrypted: i=1; AJvYcCVP8tCNWt+EPFxsbD3TGlBl+7ae/hwzDEhbbprrYELAavgqzMNf4ESQPbL6Vp2S94pUuuyDMUzPXNI=@vger.kernel.org, AJvYcCWNNZNqn/bLSSNP7ziA6AZ5VVGHrIJUJyUl2gGhmuNxZATVQGTSls5A6VDK4Yj4D21EDHozsCuvTPy2O3V1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8qebpWO0RUeIxWlyUQutFnHEBNN8LZyTXNBmiFhO2gTK4Wd9
	gxkYM5jzQWQ+kcDfQwFew3I1FyulgMiLQxqyys1Uf6f+UVwZuWqNY0oVXkHKqA2N
X-Gm-Gg: ASbGncufOrlxQT/7pGNRkRmVqGVtnUZIPnkhfCNL3WENvs+AgDxWTGp95KlKLtsotuA
	1gOIzJWzK/gEGdBv50d6GPJ9LJOLiov7qDVNXpqC35T+8gfXwwjLaTuUY572gmaXWv/6CjR66gG
	MZmdbq4wXQtP4X0uVXnpZw+sRhXGA7J/FcI8NjUfi4cjTjnZt4NhgkijmA9mqphYbbpUw0QL8QZ
	30Ly3R5uMrgB/lmg9HtMOM/f7vyiodYf5Xi4Y+A2gzbiK452lhZbVwYQ+4QpXrjkt9dbE+RTMJA
	7qBXtZFuJ9GS0pXBiBDrLW6C1HHDQYWzXq6El8Zm525JTu4sUCFqZ2lFvuWlTOP4X+yHPsfzf20
	A
X-Google-Smtp-Source: AGHT+IFJiI8mbUqK5Hi/QnBg5gWqdOAemaGh54jrAyRSgjE7rvTuS6cxzBLBMZVj00OFTKDHpE2Yig==
X-Received: by 2002:a17:907:6095:b0:ade:cdec:7085 with SMTP id a640c23a62f3a-ae057d87d58mr1076811766b.26.1750666595360;
        Mon, 23 Jun 2025 01:16:35 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae08598b7a8sm238764266b.184.2025.06.23.01.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 01:16:35 -0700 (PDT)
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
Subject: [PATCH v1 1/3] Recieve boot_param from RDI Instead of RSI
Date: Mon, 23 Jun 2025 08:15:23 +0000
Message-ID: <20250623081550.1262-1-khaliidcaliy@gmail.com>
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


