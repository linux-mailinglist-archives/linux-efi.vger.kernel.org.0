Return-Path: <linux-efi+bounces-2763-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB35A2A9AA
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 14:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FD93AAB87
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC472500DC;
	Thu,  6 Feb 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OTShSsiU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BE624634C
	for <linux-efi@vger.kernel.org>; Thu,  6 Feb 2025 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848027; cv=none; b=mfrglEue8Fq+Enex4kZmTVSVR8IbPJuY8qH36KCd7/GjkwEsOr1l0Hk7rgK0rXKVyaf4PweIsv9L1V4jx5GG5e8sXCWDqhPbPoJ58ZkU1sZOJCBClKLphi+SKLNJKJ9LCjuRKWjxgAOGDtVq1kAO7WvVPgMPjulYbLKD8ectAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848027; c=relaxed/simple;
	bh=/8yDtOhiTSdR/J3JnQgABqnDOPtJ5A90copPotre4SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drKKAU3rqOGpDA4tf8nNGR0tJzRQQHCT7LBZVk48y/FPfGABMLbceDFL3Yos7JY/r2Wa+R4Hs0pTJZqqDszC/orXMnkypxf7EPupBTrhmYUvFciSioXnzVvF6YU6cMI6qg8mZE4INTLT5kfOmwwtzlsueVs+73IT1kr/+PP12K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OTShSsiU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f49bd087cso766045ad.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2025 05:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738848025; x=1739452825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xce49/BY9vfXB35z8CeRZ6MSP3HJqpKyFsN4Gqyc7dc=;
        b=OTShSsiUIG0spRMll8phJSoMy2YnBIKT52PySrZSXQGBfSBizhbax4N8RZTyX0WWRE
         P3bjyjwtpdrpP5tIo3oD8sCh1vROHPd2nh0gEVOxUy8F8MtnBo2MEbefIff5KuyJWNyx
         itUNEYwym67Lx6hwo4YINDES0RftGwJJLcZCGnLC6qT3dz1ThwMyJNPRA5NSysEYIoxi
         RC1mFRSK2rqAwgs0TXXYx8VUZqzRdUYXUV262J0+64TxeocBhEUOPxOXwglSKf37ZXpb
         VyZ5ILFLB3LtvMqsu5q2GTanJOMVtQFt+eaEq9Kpfm08NJnvDkP21vjWEm1HoQi1adY5
         5xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738848025; x=1739452825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xce49/BY9vfXB35z8CeRZ6MSP3HJqpKyFsN4Gqyc7dc=;
        b=Yehq00EupCdxVt8LtOKWWvad/3ow0NvDlhhVNE/oLR+ZvQtSZdUB3Z/nOkZS9MzoPT
         oMvCnn0jbMj6IKizvFvOkLJ3B6CnOKPGSh30/TZ+GhJCtDl8SqCEpROiHc6+iLV97fDj
         8dckKtDzNAXP5yn7mAcL50b33dBCHlLd1KrdquUJ6j07LV2o0AvWRxDRorKh1dcoxfXL
         jPvTqAA1Pkl3TBC0tWv7Wm/2qgkrMttYBmdPI4svmTPqii6ixrr75qUXtjXPVxvk6lR8
         cVtYL71+Y4oJvxiNk+AbqgZm2Ooo6UHpSC899unnXu+cKjZyWF2slRrBJ3QhWboR6nBx
         AtFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCR4wjmMbs2CY+4Uvf5UZqFZrm2QTYP3i1GrfPFjbtOw/cB6pYepBunWLp79azC8U8ovbv3j+shNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwevewavT18R4uwsTU6tb2BT1rfRxq8+z2brNTC1fbWi0Z/mjBU
	M0DsnxCsMLyJZ/6CAWKQuMCq9LBfhvXNyxnibUuh8wYSwjAziiDkJasUlQyLWbE=
X-Gm-Gg: ASbGncsRG9r2FdrzN3vuZT+O+e0KU9aq8eDZgfIM0OXSMP2CkCwL2kmQTxpvsMffkcs
	BV5b9wJ4MACLObcB4pp69FsXGxy5c495q4fp4bmuOkFfLODJ8xO9LFBxHQXsueX031sBdQvMxQl
	YjmOcW8cdYbQp8e57QWJl65VsENqOkKsl/29iu6UCkzxVEHgh+0wk2MoUaGs/IOhoMyTpja0+Xg
	P8scixO0HsSXa9Jf7DULVyDktMRr/iaLarutc0nr03qgdTWFZbLzaIYjYleYdGogdFk9fQt4Oln
	ntgcSBco0kgPjEkWqA==
X-Google-Smtp-Source: AGHT+IFcNT/rNgI2uCAPNRIwNCrMXf037u5qAVa3V5iSa1fu7wy92g99/HkKLyrbAq4szqQ1+3GzCQ==
X-Received: by 2002:a17:902:eccc:b0:21f:1af3:b318 with SMTP id d9443c01a7336-21f1af3b387mr108852145ad.53.1738848025272;
        Thu, 06 Feb 2025 05:20:25 -0800 (PST)
Received: from L4CR4519N7.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d987sm12170775ad.120.2025.02.06.05.20.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Feb 2025 05:20:25 -0800 (PST)
From: Rui Qi <qirui.001@bytedance.com>
X-Google-Original-From: Rui Qi
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	haibo1.xu@intel.com,
	guohanjun@huawei.com,
	sunilvl@ventanamicro.com,
	samuel.holland@sifive.com,
	parri.andrea@gmail.com,
	ericchancf@google.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [RFC 5/5] RISC-V: define ioremap_cache
Date: Thu,  6 Feb 2025 21:19:26 +0800
Message-Id: <20250206131926.91289-6-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250206131926.91289-1-qirui.001@bytedance.com>
References: <20250206131926.91289-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

Define ioremap_cache for riscv, otherwise it will
cause compile errors for bert.c and einj.c

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/riscv/include/asm/io.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 1c5c641075d2..c81d2de007bc 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -134,6 +134,11 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #endif
 
 #include <asm-generic/io.h>
+#define ioremap_cache ioremap_cache
+static inline void __iomem *ioremap_cache(phys_addr_t addr, size_t size)
+{
+	return (__force void *)ioremap_prot(addr, size, _PAGE_KERNEL);
+}
 
 #ifdef CONFIG_MMU
 #define arch_memremap_wb(addr, size)	\
-- 
2.20.1


