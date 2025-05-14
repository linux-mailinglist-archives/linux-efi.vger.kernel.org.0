Return-Path: <linux-efi+bounces-3701-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E2AB7314
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 19:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB8E3BAF80
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A572820C9;
	Wed, 14 May 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAEIc3MA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7F280CD9
	for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244640; cv=none; b=NqCp2C9kPAKMqwWE3X7nGuqe4uk8UPIk6ie5OH0UIAl2vpEFqks/X1bRyKLxx6Vrf0oOsDWA4hMIhuvmuhZOUSYDCl9TonXo55xbBqkYoXsW8ebcobJFlJ6seH+zDOUAQLiqkKqjL8PIabf9GJDFudA5BkeRqWFW6yV27Gsiz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244640; c=relaxed/simple;
	bh=wNSwSHaQL768bwuARb+U+ClbCVRY8y/M7G0l8xnwMes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=My72A9YP+fQ7AqqV7U1xCfU800ef8ew+lZRGK/NchBuCD43gFFU/M0Jp6lkley3tcu16t90S3IBDh7tz9L9CGdWX2pFB1b20m1BLdDY8LOyR+PI2yEx/Ejxy5x3CkeM/xch3ZqRVCzvtBWjUa9TWoYe/sbD1C5PExstgaze9Qu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAEIc3MA; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5fbe340b709so57684a12.3
        for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747244637; x=1747849437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3HyzwFpqI96MKN6rPIIRpRYJw2Hi2fE7csbcA6ZBUg=;
        b=AAEIc3MAESsX+Wa2luqGcJJff4QP3meX9pAvOAS1ih4c+m7dmICw0DsA722C1iQJtD
         l1qgFVDCoq8Wz0E+dCNH3/QqlvhhMNt5waypuDrXQE4uzbqijBucU/LTVu9Wk09HYyDg
         EgHBkHgYmrccbLnezdVBKqzlr4jyCqS/Ogi8q8OAGP0eEz84EdBPbIGhHDTt1F+6o9ii
         VPimE6Z0Uc5OaVKO1/IUQP8rwbIjIDEtG7NNJZxqV6rRhVNO1/a7IX/zNX+jzR1CHJMO
         2iVjGRu80kmvMMPZpscjcIGj8r9G6u9NX7TcbgjSRAIBhVbLsDlVspXQgTUSN6TwshCG
         oqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244637; x=1747849437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3HyzwFpqI96MKN6rPIIRpRYJw2Hi2fE7csbcA6ZBUg=;
        b=nn/yQLM3Xj2joK5EGry4sSqA+3eCDZkEQbi8AWFmp4wrlWUdCO5CjYSIoqFLzoEOy+
         AX5uNnv4hOD70CxcVPI8JTAeu7XpNrrbnoLEXcAHf87MAJSsON/7NG6au+jsu8DOnNpm
         LQ/4GaQWVHb/xNJcE9COoXO7Zjw4GVnAL5Cjv4S8QY55sK0Scl3BwtSa1YByoH1RJIwN
         40T5JQJfCp5vj2w+Gq29RNI/Nm6Lhs7aDsKKJJJdA6lKDYtzA7WTAX+eI4O648Td50Ct
         g1gXEQf5xFReZQR3/ZI/jtHnJ3pst3IlernwubcGM+WXR0rS7sKkYvKBoYE7xe9+1muQ
         wqDQ==
X-Gm-Message-State: AOJu0Yw6TfinE8oS2OxYFygmOa3NhWikopT2JjW4i+c8e9tian4+pL+a
	8L1LDaFoYdhYPMnQGMbXP65EvLq623nculiYNT4HgUGTfRVA/x6+seBL64X0TgCmWgb0vseORCB
	5Q5fx874BEs+oYqGtumCiVDJLjJin+UjBGs64Gme1u3AxN22/PIEPGa0VDq3LTl3JH9gURrIdxO
	uk9Nq62YDx6Psi32hq71Ox2PUSng==
X-Google-Smtp-Source: AGHT+IFMiOIHcOTbuiXUZt5aRX5V8FD38VCujID8sYnl6g5WCQk844aGLumnl4jvPnBScsY9NLpomgSv
X-Received: from edr22.prod.google.com ([2002:a05:6402:44d6:b0:5fc:8eaa:6880])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1eca:b0:5fa:f7ed:f19c
 with SMTP id 4fb4d7f45d1cf-5ff9889159cmr3446782a12.4.1747244637109; Wed, 14
 May 2025 10:43:57 -0700 (PDT)
Date: Wed, 14 May 2025 19:43:41 +0200
In-Reply-To: <20250514174339.1834871-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=ardb@kernel.org;
 h=from:subject; bh=Uiag6eY4kkyJQ9LOjYS9SFHapP2JX/63rkWG9Swk9rg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPlWsB25Y3CTRL3p7X+7vm8bf2FpxlxIpNnHp0k0Pe+9
 z1PjvKpjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARuWWMDB9TrRZWXE++3T1d
 bb8st+a0ub6btS/EH4x80K4aeOHV7UmMDAdPP5o2qVGqVFrj3exdWYfn329vd/XQllvXP/OacVb TT0YA
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250514174339.1834871-10-ardb+git@google.com>
Subject: [RFC PATCH 1/7] efi: Add missing static initializer for efi_mm::cpus_allowed_lock
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Initialize the cpus_allowed_lock struct member of efi_mm.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7309394b8fc9..59a56661937c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -73,6 +73,9 @@ struct mm_struct efi_mm = {
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
+#ifdef CONFIG_SCHED_MM_CID
+	.cpus_allowed_lock	= __RAW_SPIN_LOCK_UNLOCKED(efi_mm.cpus_allowed_lock),
+#endif
 };
 
 struct workqueue_struct *efi_rts_wq;
-- 
2.49.0.1101.gccaa498523-goog


