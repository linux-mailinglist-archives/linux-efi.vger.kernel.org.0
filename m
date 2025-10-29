Return-Path: <linux-efi+bounces-5214-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B322C1A04A
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 12:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5645B18931B3
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7AE3314C8;
	Wed, 29 Oct 2025 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ywr0HF61"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31097330D42
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737231; cv=none; b=LWMbQgSN1eGfGmClQqN0VmqHHjk7PPJsplSvE0dUFlOpRrcqoQsc4fukVdwYk5Xo0adIUd1tKNzmdJEEj17vgAZWOUr/ZoXRaVWysmLbsQFpLOWI44W9ohQeb/rZCrbwmH4sMaJ/bG0HCqzVqwGvHbSgiv8keSca20qJ4n2PkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737231; c=relaxed/simple;
	bh=xZ3ZGRZyyesAYiVSJppgbzc/6wpmKcXOnx/IFbeBZY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1qJbuqJmZuFNtQxeGd4onrPax07cZR6a2uvA/sCffQO78/p+hpk3izNdYqqAXtvUaKZGRiVWN0ytL+nneFUzd25SiMHiKuHFKM6H3949tNglceWrBKBI7DSER3rqbMEOoct6m149n9x+mVjBdhbzNucVkCtrsphZwdoZr2mWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ywr0HF61; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3401314d845so3833645a91.1
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737228; x=1762342028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc2pmS4Yu1PyEFNeNlAsHoxFDYNywDlEMWQLdy1zt3o=;
        b=Ywr0HF61w+7bv8baKiHNwYKCyrFyzT/BlYmC4f9Y7kN09vMdlzqrxkHFnlq/2dAb+n
         iJOi0kl0zjUcl48XTxDElg4BRpi8Ww8xhwYDTEo+v2lzc6RYvhRno8jQ1D+dNHzXOZE2
         cJUMnnfdE/zJvgrWDZMkGPvbQ8o7xHfPhmccJ491Frm7j8S8QaCcKfyjm35JnUyHyxhA
         iR0r8rdBrUVpp8XfBwJJW6Q3eTRH5a8xxF6cYgYq4Idq5Ux9qUzGt+IQXthcnqRWOAwt
         8oIMZkp3HBQEunFCLttV6oPhjcS+MfpJHu+Ec7Dh6TTifWbRqi/OURpArX7xhdWwduKk
         gYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737228; x=1762342028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc2pmS4Yu1PyEFNeNlAsHoxFDYNywDlEMWQLdy1zt3o=;
        b=fNQmXRRzQQeNO1XciPDIrf/wnfRKneQkr1BS4mnvZVmAAGwOJKp/h4HVMVcEm5zghC
         3fdn1fTZEl/xDmNwq+R02w5HUp/mYwIZZ+hYYorpSjo2eqOZf+QHAGFedJYDY8IUKdqp
         7nrVEQXIOB2TMKhLxdqcxYsIv8PdQ+oDvPp2Pf0AJwKVCHifOB8/2KZ3AUTm4oY1cUGx
         hRvF5ym6ZoaKc/jjrrsV0T/C9/ghqfMu5njiKDxk6S4KPzLde6qqkTHrJLO+gelmm0G9
         ogI5WBiNPUHO6NYGSiEggVd0x+W0xcGl0Gzg0jpUMo18tb43GUO2sCehULMgCFJBJjbd
         Qgeg==
X-Forwarded-Encrypted: i=1; AJvYcCX81sdSRhsNp5Fh/YREibsse4SjLAcv8WSGlqUMDzzox1n8xtv5EmR0fBt5d0KP40Hq7EZC+mqwTk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYC8OkN0r7zWtzGyBo86Xs8caAPGLJebF7cAPKZm64fSzcKym
	0GTORKkrskhkW3tQNDdJ1pGvVDY/mAfBZDCBGgyCgXT6Wln975KAvl7fBKx7c5DMSG4=
X-Gm-Gg: ASbGncuBRsuzpYyqwefIaiMpYdqvrDXdtt2+71vNkUQzXny/euZSCddKTxoUsfEVYHU
	Eth1fe2U8Eb8aVZ4QvOihM2+NbZxOJyCySQINNeJsN1vHNAypOL8YlxnRylF0UAtqbFEDZrn75L
	BpV62YBRNwGKJgFsJrugEo4pBB9Ict4hxTQHRMXkaaSH6hwQDy5zR87nzB/31hnpWyo/FjNsr4R
	Erxp8sI1BKsTQWEZfxUvzOrKZO12lxljg09hd4eTQM5KaOgUW21i06o2jSJ5GmY4CqcKLbH5lIB
	f3DETN3GqyyDae9uzDp90NCX8OGlU30vAYeBrvpLvjEejGYwgAsvdQelFr6xXDaU4vLk6z2Iyvu
	QShNc1/PrKd6zusUdKMcX8c76A3zyuxFvVFT49xyMVLiU+SNfQk8ytZjVlB4sTT9sZD+oDUPa7m
	USuQssuSt9PrGb2DooAmghRsFVwyXM
X-Google-Smtp-Source: AGHT+IGEAqFeWf0ftjlgJx4OkwPZYhleAzhblNhIB2XsxH/EACVURZv5OiId6pITaCbKSnoGThy0lA==
X-Received: by 2002:a17:90b:2811:b0:330:6f13:53fc with SMTP id 98e67ed59e1d1-3403a290f88mr2790213a91.27.1761737228426;
        Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 01/10] riscv: Define ioremap_cache for RISC-V
Date: Wed, 29 Oct 2025 16:56:39 +0530
Message-ID: <20251029112649.3811657-2-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bert and einj drivers use ioremap_cache for mapping entries
but ioremap_cache is not defined for RISC-V.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 09bb5f57a9d3..5550b28f38db 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -142,6 +142,9 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #ifdef CONFIG_MMU
 #define arch_memremap_wb(addr, size, flags)	\
 	((__force void *)ioremap_prot((addr), (size), __pgprot(_PAGE_KERNEL)))
+
+#define ioremap_cache(addr, size)					\
+	((__force void *)ioremap_prot((addr), (size), PAGE_KERNEL))
 #endif
 
 #endif /* _ASM_RISCV_IO_H */
-- 
2.43.0


