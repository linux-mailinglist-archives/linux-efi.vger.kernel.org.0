Return-Path: <linux-efi+bounces-2809-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34378A3EE10
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2025 09:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41196188E3E0
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2025 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCA7200136;
	Fri, 21 Feb 2025 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Bqy4R9kR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9672AEF1
	for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125584; cv=none; b=pBLAF0Lj0ZNskG5xOTPFQ4v96Ici/YK3DP2m3cJ9ahE2ZJjyLHX5+FUKZduVY3p9wtwP2HNF7C4EgDDqC849dxnPwYWf6pA+BMoSqSBcXD3RVkN3RV5kMwxNlPVyQfO8uQmm/y8hEe4Kj+pBKkQx0bEYdjzhyK68KJ5OCBydrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125584; c=relaxed/simple;
	bh=2A9LVAI/zUW2kWoYjRXarbyUvw1S+bDtLHAm+GA8gRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ao1V4LYbTS+pSMo9GM03zjRrQDbtG9SzhKB5wHLdznSSE6WmQNAF5f21pdpaf6eSvmcQearbvLVK+REJkXQfsD1OdbVgvYPg4EmpOghn91Ch6J9Gj5ef36hGD61qY2Y2js9nfs3C9N4v4sQAEZ3FJiMlaQyUtsAuNZn3YooXKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Bqy4R9kR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso2565198a12.2
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2025 00:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1740125579; x=1740730379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RlKk4Du+Rzr/cFu16R/zw4oEfN6mefn4wJkCUpov8HQ=;
        b=Bqy4R9kRe2EzoZNeon/0uPA5dv15XZbJGfeO8oMy/GxojE4k3i14tGXAtb6b1awxCG
         0I7zGuzWUGb8K5DYhsY0rOp1t37DtsA7ykARzJoE+1RNEb8yzNr4zhgLFteUjzo04Mox
         JP4b/Y3jQFbI8nCdZeBQSCZqbw1tBgMUkr1dwVvbqfUZUtzGjsc3EJ1m+qdc5n8+8RWl
         liL3q53+FwPMJpJIh1NBy2awxqLnYuJB95566S8jUlRM2ttbt6qJ7UgHGTpCrY7elgDl
         Q7r2J5MJWGBeK2t47r4OrekEVp3JPUdQ6xLE/EamRegzqmIcNsRyKRzEUjnIUo0+gZ5B
         yzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740125579; x=1740730379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlKk4Du+Rzr/cFu16R/zw4oEfN6mefn4wJkCUpov8HQ=;
        b=BeUnPSO79rl5v2/eOXOsYvKRMzbB2pM9ES75HQXs31rKDoe1ehWcOrgIrOcJwoAErl
         hB6ICOjVPfXWGT1dV8oyvZQPnMnr3qSx3b9zRrWtKnS+KtlR6L0fb6Yt3a5idpi0uFPj
         I2VCfkY/n+48IX0xX4J1XF48XgrfXpCfAo/lS3VF4hE5CdbYi1Z4MpZM/D0EWAOjT6MC
         OZUEQEkwY4l21jVCKWXgZy0qet6BMykQQ+Lt8ZDLg4ewly2YbvhzTaR+Og+PNA4TlmQJ
         0YLi/AppFvHI86IdNs2FVqfbWKQUiER0AtPXYiBHToEhhj5A7V6h0C6wK9kxhG7VO1xt
         KF0A==
X-Forwarded-Encrypted: i=1; AJvYcCXhLsgYZSS+1j/rW5o79inVtt5QcN+ABm+0mPMISiSPgGPADLFRcD3pU15gy0JzGnhASu0IdikXC6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJEHiByPs+s1wSMtvNvcWapH/TpqCLIiKozb2MR3vaUsUqdqq
	sBbEgUhbK9jIPWJNf9YeObw3BGisTvB05BatftJnXmGjlHoaom5MKWf/cJdW/Plumqk+3/NMg07
	RtCk=
X-Gm-Gg: ASbGncsyMgmsN4ZfLSidfhDyPfYdcZA/Ntn+FQDv/31VGGKUHnGEFOQkgHSbX+QfLOc
	tWYgQ9EVUe+nvJFNrdFVcHsCTcOf6cO7cBnLswuuoX8ycP6Ksimf1dy4jZcH70RX0kHwXYP1fy7
	snwlZDNLmj0h9RQsLCUD6gA+VyHxfPrS/xMewN44dvOaywt8TTFCvEVMIYsCrgcY+bc7Pq+70IY
	CnjzRMNBd3At63b+dc0q145UqP+YhXRcMsgzymIxTiwIOznGrkQD+arjLLpJvEBJCSD80HpmV5w
	c6MJEBiWixGNynKBMDZ6XxC4aoYB33p4dtZQKU71UeldhKm4yoN7lb+270nvXUyYnGodeMw1Sve
	Py89RginiyKpf8l3aZ5bKeosQ
X-Google-Smtp-Source: AGHT+IFXKYEVbsxt3ej9tqksuoiTwcM4lgX1CYwy9RrcuJ8sznNOB+o19FApSAtfdbdRT6eDQE9CyA==
X-Received: by 2002:a17:907:9494:b0:ab7:d5e3:cbac with SMTP id a640c23a62f3a-abc0de4f19emr196940766b.54.1740125579032;
        Fri, 21 Feb 2025 00:12:59 -0800 (PST)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb6f13b11esm1234299266b.71.2025.02.21.00.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 00:12:58 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/firmware/efi: Fix cper_ia_proc_ctx alignment
Date: Fri, 21 Feb 2025 09:12:42 +0100
Message-ID: <20250221081242.1411553-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the UEFI Common Platform Error Record appendix, the
IA32/X64 Processor Context Information Structure is a variable length
structure, but "is padded with zeros if the size is not a multiple
of 16 bytes".

Currently this isn't honoured, causing all but the first structure to
be garbage when printed. Thus align the size to be a multiple of 16.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/efi/cper-x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 438ed9eff6d0..3949d7b5e808 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -325,7 +325,7 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 
 	ctx_info = (struct cper_ia_proc_ctx *)err_info;
 	for (i = 0; i < VALID_PROC_CXT_INFO_NUM(proc->validation_bits); i++) {
-		int size = sizeof(*ctx_info) + ctx_info->reg_arr_size;
+		int size = ALIGN(sizeof(*ctx_info) + ctx_info->reg_arr_size, 16);
 		int groupsize = 4;
 
 		printk("%sContext Information Structure %d:\n", pfx, i);
-- 
2.48.1


