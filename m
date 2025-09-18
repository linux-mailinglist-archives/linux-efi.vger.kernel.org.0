Return-Path: <linux-efi+bounces-4851-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CA8B841C5
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 12:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20939541B70
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 10:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2982FAC06;
	Thu, 18 Sep 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1D55I4vO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591242F9980
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191438; cv=none; b=gN4QbSRe0z74oHbHqUKVesGPPyLsX+Hp7iVmVmgvdgdxHs7JKZgoer7CLemNghCI1jaYN0jhzguilKnldG46TsXJd9yE49paT71DbDwgmpTKoQs0580mUBV7zwgVNNUD5jrOzhlCPKtpXxt9+vWDuPGk2L8WTEI8asygmNKTVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191438; c=relaxed/simple;
	bh=9IGxOSD8/IQWLwc8jT7mSjBjvXiOryrCfl8S8dMZveI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aB2jhR6x04SuXMgTMYYQDgb1XzxeY49v4v+C9VRKlLATuyfHVGqtGe+JBCAHgaRoz4duZhInnwEnVeiUzyObrzIKnzKqzCoDVufj1EYg7DOh6quuAnMbiEQ7ZkUno4Qw183q0kXbRGIZ+j9sL3MSnUxXV48sIjQUTaWpmiTPNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1D55I4vO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b920a0c89so3476785e9.2
        for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191436; x=1758796236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9g+ayt4FM2fztSLOAfcyGb2gFshK+qygOJzTnKa0+m8=;
        b=1D55I4vOpZiOLe7yHvECiVpaFdSXj7kok9kCzIeR0agutFDvzg1H+IEGsxlkT45/Tz
         cEKc5dtZt+EfbUlKHeKybV+u8/G10xG4iyfEIMPeQaL74aVKNv5uxAegDkQDkeztJzTa
         MY7+t1wQn9pQOeTy+nv7yqwFVpUL3ZBkCo6ES8jYdVviCNHUo8xUla/A7zDz1Ln8reof
         c9TsGk5EHx99fifzaJdTXsbALvsvJn+LYG+0dfoA8VGgJxY5ZRS7yxxUWc1LRMd/1E/E
         eDxQIoLtzsypHI6DnI4PZATgZVBXAAL5SHOQmHx/TMlKbX/GOWo/QU24an1zMMt7xgh/
         4C2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191436; x=1758796236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9g+ayt4FM2fztSLOAfcyGb2gFshK+qygOJzTnKa0+m8=;
        b=PVbQ3XnhDZ7xrJTE9KNADHzEXCBocBqk0PN5rFXLia0URFTc71gTK1SS2/7BajoWx2
         1zM1sHFIj9nugj19uNB6s+7TzmD7mOl6/T+2H3P5AZ+BZXH17GkePewTOecKTIAAkYZ3
         JN4qiOrVzyVQQBDLxyFUvJ+96YUilLVxtofe48cozh8XKF4xu3L4efFKdE2nvGE52bpG
         +NYYUBu73bppBN4vKPHhPz/4axztM/ASnNtytn5NnSja05Rl+N5WoNceZkjassxwILPr
         9VEiZWXD2tNdtVaEOIa6XYXRzLhzdJdI5hFTlvD3Uq4Mw1tepqQhVE+BPT2LPwzHvKzr
         DSbQ==
X-Gm-Message-State: AOJu0Yx1ETOc+j5upzC/PY/KFsT7lbI/c6EWRfe81wT4bQtqJUHJZTIp
	+eRxRyF/3xoJ9uG7k0NIyHZHLwm/Fkn4ZdnPL1VZDl6W7mxWvhy/Gwk6D/2wyg8i3bhP17Y936a
	oQvCDE4P2zpSriP3hK+cKx+dgxe0Ac1gZbtFPJHDVDP+zfzsnCETGdOIEVxyebE7FqJ7aE7+7kK
	OOjLAuMmRTCMin8cLQf+xzjsXt8mgNNQ==
X-Google-Smtp-Source: AGHT+IHLme5GiJqIwrRwEMO5+ZWXnbB3UysoUpD5npyfKiKL033RbmiEockBVOaN3XQJRx9xa79Wam2T
X-Received: from wmbeq8.prod.google.com ([2002:a05:600c:8488:b0:45d:d39b:53ca])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d05:b0:459:db7b:988e
 with SMTP id 5b1f17b1804b1-46202a0e68dmr48837855e9.13.1758191435539; Thu, 18
 Sep 2025 03:30:35 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:12 +0200
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=ardb@kernel.org;
 h=from:subject; bh=6f4GfQJsdA/kppXTxBZ4Rl0+1i1W3t0MYvIV3huOmLg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0fVOTx8nmnjWPnBfWRlyx2Nust7U+6NwL8w/u6QyND
 RPLOTw7SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERqTBgZluiZM7wIMHV4y6zk
 ptEotHLrMlbGvhem5399bg39UWz4i+F/seOk8zl9+Tn7j2ns0a9iejh1HUdq+LoVum3H9upcd1b gBQA=
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-11-ardb+git@google.com>
Subject: [PATCH v3 1/8] efi: Add missing static initializer for efi_mm::cpus_allowed_lock
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
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
2.51.0.384.g4c02a37b29-goog


