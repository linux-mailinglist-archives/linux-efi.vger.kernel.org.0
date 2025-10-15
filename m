Return-Path: <linux-efi+bounces-5054-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0CBE0BC1
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 23:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818AF18818A6
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0E52C3242;
	Wed, 15 Oct 2025 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hafDm8Wm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA619F48D
	for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562066; cv=none; b=ii/XBcYJvH8ALGHPcb46v2HZ46Ifvn0P8WK0jeXPY/KGUICZqRiYrCREqiBD9wmtI+dnRuatDtnLiOu/fh7fR4uzTHUHhfxmPeiriFdt1V9+WfL/s3glGCRkns9uxcnnKI3sGZ6fWLSY2LtliXcY0QCdY7c7v2XTBAEymliUTvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562066; c=relaxed/simple;
	bh=bNZ5nGNUpC8e2pvYUVL99aPY0d8SHeaESMtukQB/3XU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZPBuf+wbMI0kFJctE6ZDbTcwy3NS/tExBy3gEQCNb0vrxWmEYALEZMhatuRdJKQ/P3PmTnSN+oSdtAi0wv9Ya1fZnB6L11OYPjcC1oamldMl7BPf+RtTVbMmLiBIvfTAn91RK1UdrpHOFg5owHxl1KYDk/P7UVlWb14Kp4x7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hafDm8Wm; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso577897f8f.0
        for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562063; x=1761166863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ka9acDfWYNVlXTADikeAWQzZKPfls3YVu38LVwS+Ync=;
        b=hafDm8Wm9R1j2wleWPCIBHHpvUR0ANn9ufO+biLcxPUXEAux2L9IOtrX3Vhp19rFPZ
         qjQPNVq5bfe3HGSYVSLwwoS829dFnddsNDbDWSd0TPUjLbFmNbUY30DJyFitUpDBYHG0
         x8APgU618N9ghMX7ffE6Iu+STeMOKFvW2SrT7wwaNTYXWcQhRnaURbFe3hNht/pFtXeb
         5Q3u/0hMxSjInTuFvHv0Fgoyylx91QgabimnMxrWRZEpStRoRnU0hVAMjv4eC/oz2tJ4
         VEra1YLB0BzLrCTwK3hhQjL0DiW4cx5DkmqN+POgi7HMNhpFGCZOrmaWu0HDX3kXZpZC
         z+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562063; x=1761166863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ka9acDfWYNVlXTADikeAWQzZKPfls3YVu38LVwS+Ync=;
        b=ci0h3aYwA3GkKe0Xydn0GXUXDAMNNkwQKhlEdYMUmqwy/FGjzh4zbi3pu59EIPyeKE
         aitPDBpQX5VlDauaUTobHRoCCSJDLKUadq1xtV1ZUUeH7zyJ6O1Zp0+jYLiVIZvUTng7
         G/PeT+/AWx44N/XAD7gNn90kQsE118KiPSkoMSCYd+PItOCtSSLjIzXz6Y+W0F71E2O+
         7aSBEE8QcxvrTFAMfx3ecIjV8YYstxVCOshQr+sYfXny7K+VCauV9oawKN4PDP2LIQNb
         4Se5NFhvaT4oHNa7nEJxk2qWTF9btuuUHOw7S6IyMqfVRaik52x//OMNwzj1VIUXWjHr
         jOdw==
X-Gm-Message-State: AOJu0YyxSGz7pzzekPYUlSz1LQFFOtEFeqX7uI2HOpXPbaOp/3YVGKBU
	FiohqTlFU7kBPjnUcXNFUPIxkcineN1ikCF5jZf1b4aKo6+x2X+wrDiuUgUROsFmZNxnPSZvYVC
	BoEZrdQDm1k0ARxaNRkDYH12qC51oHxjOB134edQJDtyWzWQ5BEs4XFRfDLBu5NDIMcpzwWmYjT
	QPfIQ1YA6XjPJCuYI5HqDkdevfRDHs8A==
X-Google-Smtp-Source: AGHT+IFKTW/66VSsBVsAUER/FDq7sYd1YbEd3eoZpeBB4yPvhP9MMDUr1WYotgBpEovQntSXolk5aG9w
X-Received: from wrbbs13.prod.google.com ([2002:a05:6000:70d:b0:425:f04a:4d86])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4608:b0:426:fc52:cca6
 with SMTP id ffacd0b85a97d-426fc52ce1amr745223f8f.7.1760562062643; Wed, 15
 Oct 2025 14:01:02 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:36 +0200
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=ardb@kernel.org;
 h=from:subject; bh=JyRr6WrjNMazb438tuZ9KzQEKZXISsNH26aHqvF27Qc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDV2tC1n7FDTPeV2T5Cns9OHybTyotoSC/MG9h28E9c
 6e9XhzRUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbibs7IcOb7w1WO7Qs+rOkM
 ELf0rhGcYyJ5Y9+Kya9PRiVKqrEftmf4Zx95zqD/wkvN1ftm2b2fulPT5faOaY7fu9K+9XRNYPV R5QIA
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-10-ardb+git@google.com>
Subject: [PATCH v4 resend 1/7] efi: Add missing static initializer for efi_mm::cpus_allowed_lock
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Initialize the cpus_allowed_lock struct member of efi_mm.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1ce428e2ac8a..fc407d891348 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -74,6 +74,9 @@ struct mm_struct efi_mm = {
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
+#ifdef CONFIG_SCHED_MM_CID
+	.cpus_allowed_lock	= __RAW_SPIN_LOCK_UNLOCKED(efi_mm.cpus_allowed_lock),
+#endif
 };
 
 struct workqueue_struct *efi_rts_wq;
-- 
2.51.0.869.ge66316f041-goog


