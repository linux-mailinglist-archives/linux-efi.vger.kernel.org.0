Return-Path: <linux-efi+bounces-2846-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90787A47DEA
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 13:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCC61893229
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 12:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8D230D0F;
	Thu, 27 Feb 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TqbrQbZB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5292309A3
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659821; cv=none; b=uqiz/L3aLr2JnrYHnnQQ+7Dxh/vu9wJ0TlwdbrMVPWiO7sXrXoLJ4r7IpDZeFH2ImT1DDwx3fYsn1TeLVs/SezyWYJDNwlU1V+VwZlCX85JgiC1zBof00635NMF/NONRSkuYUkXsSADi1Abxrme2uuSeZg5TLCNhlJ4lxM6diV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659821; c=relaxed/simple;
	bh=rGWTzIIeViWhGlD8y9psao/8+qBiPCPjAKNTSslE/48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqd0QGras6wXqNl/Ivcx/CJPr+kR+oL4mb9LbxBurXjLcLQPVv1dmax3GzlBM4RP5hyLqoyOiZYkr1bfhgSHq3IkaLO4nMihN/FCPueEzBkiRl9R90hSiMyBOM0vo8EG21KWx6l2H9VPA2prRFcqd1kLygqdgwHzctGc2Ik9OrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TqbrQbZB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223480ea43aso19851225ad.1
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 04:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659819; x=1741264619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvAemUtNRi9tUzWy4d/eui/dPAc9laFlbuC1eHj4jHs=;
        b=TqbrQbZBaYvY5y2YdGx3D0sg+gCI3UW5XBphTHTYm5Cgh5IaLoFi1b6kmPZtkK9ott
         oFBlbok9irak0WiJ7CBLZdtotOAHfKN66/9y2wmUuyKF4TzfdrgmNLIpwcjW2Lskdsbj
         xRJAFeyMCsQ5NQYuj8x8G2me+OuBQHyzIwd4Jqn5TWUA/axkd3ipYiM/5T/jXRuod28s
         M40yFH5ryMwAuFHv2GiiZSGEindR4F6jOXsWRoL101D/+Ce5OwBqhME6rKmt8XUj51Tp
         S3nCzkxEtNCmkFjYEClVZqZlOs1mTk7MPLpnDk8xdn/kW3NKaYwxZ+CAkkCzx4qV0R5A
         q8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659819; x=1741264619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvAemUtNRi9tUzWy4d/eui/dPAc9laFlbuC1eHj4jHs=;
        b=YG8YYGEWyIeSABXH6CrNZcBNKpQr61ui+V5xkVgLNItp3sFSsA7Nrcs7NCLmrnYmom
         W+W78XOa6A/a5WsIfi6jMK87yEGaPsMMzyGtsYJR1hsE8KB2eRlyeEk/xUBDtKwftGK9
         n4s5J4RD+1iXU2mEhiuul8tr0Bf6bQyFvJBMBOn3oCXGhHLhSI0EzsL/4g+zk3+/UKJM
         d5Ko6AQDef5YXzngdm1ewVK1dx0D70WdGUcLK3Al7NYM4Gx0A9iv4xUA/ZXPJ/JTf0xx
         48PxKOhOUWmRXjJOThLQOcBPoOrTbyoXz/XwpHNUdBLX/eToINmPC9iYmQxa9MVbD+04
         CoJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvloNC3bINGWqxCwUHtOL09vPXviO1hrz26nFUJudJITsukkzRN/1MqePjsHQsIGCADdBVcDS8xgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1GrJX4uEmiPTxsr0VGKsFVptf+MowXKmJeL5iakHLSkEXM56h
	VVD/7Dq8HoK5pzLSH56ejf+B/N4bOSh+ePQ54MHtERzslQdl+hP37BflqRQ7HYs=
X-Gm-Gg: ASbGncvS3QIpV612fRsWSfcmnsOPRHTfcl0M9qHJAl4wBwo3dCUaeDNjO+L6bkjd4vH
	4XkXmfqetM8da2B4m8i3dr2ofo3J+mRtvI+piHI5A84P2PL0iRRzX/t6ykvOjfdmpr+nyR44gBU
	EhSm+J/cNa+tXuihw/Y5CKDygJn6vCeNrLS4f9fXkhAHzH0liQ+lA86zipCHY2c5sCSbE6Cyem1
	rb+6CS2pRBtzn6GkcIitI8Rd6z+LO7bytZ++tWVlcXR8L7XiJS6Rk+UF6egFg1OZhX2nxYT/Euc
	McWMFFKhTEPPoFqNIQSyeF/NOCbMReoM6xqB
X-Google-Smtp-Source: AGHT+IFYVtprbH9evLqNClf+RfnxGHGySs3bbzOLOoRiAZRk+G2rF8ng8rvkLS2SHiGq2QScEJQDTw==
X-Received: by 2002:a17:903:228d:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-221a0ed7e4cmr423165445ad.19.1740659819428;
        Thu, 27 Feb 2025 04:36:59 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:59 -0800 (PST)
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
Subject: [RFC PATCH v1 04/10] riscv: Add fixmap indices for GHES IRQ and SSE contexts
Date: Thu, 27 Feb 2025 18:06:22 +0530
Message-ID: <20250227123628.2931490-5-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GHES error handling requires fixmap entries for IRQ notifications.
Add fixmap indices for IRQ, SSE Low and High priority notifications.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/fixmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..fa3a0ec0c55c 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -38,6 +38,14 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 
+#ifdef CONFIG_ACPI_APEI_GHES
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+#ifdef CONFIG_RISCV_SSE
+	FIX_APEI_GHES_SSE_LOW_PRIORITY,
+	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
+#endif /* CONFIG_RISCV_SSE */
+#endif /* CONFIG_ACPI_APEI_GHES */
 	__end_of_permanent_fixed_addresses,
 	/*
 	 * Temporary boot-time mappings, used by early_ioremap(),
-- 
2.43.0


