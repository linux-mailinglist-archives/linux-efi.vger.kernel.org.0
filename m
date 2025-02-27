Return-Path: <linux-efi+bounces-2852-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05E3A47DFD
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 13:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1330A1894F3D
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BF22FDF9;
	Thu, 27 Feb 2025 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IYpz8ai6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071722FACE
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659852; cv=none; b=SYa1B0m4FdCvVKHrav4F8Y4ZDPDWk1RbkePCxP2fc01ibsgxfxJVCg18PAz/iPEHibRMBtCoWNWGYvdFuM9YrA/OtzXG50oVOMcjTnmEgLt3naEwnbw16o0Pv8sgEiQYr4TBbmf9MOHPkXAohHqUxo5cLDO22kh+fPQCZqevKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659852; c=relaxed/simple;
	bh=VXd0R443A2CSpN6/WQb26SvFq5CeBSdmv/3wp2DtRPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9+WMNyWJncH0gTOUaHJlJoAXFg1VGt3ZtcDDIunFin3vSFBmdOXuIX0vCGqiPzJZypuYRFa/leKJEWT+9C0rE2xz//Ds+IvoPqV7QvV9zkNb2breTOjX9mGgz/lkTidXTbGbEj5S8WeBrFywxEt54udPukoBG0pxrxuUr8AWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IYpz8ai6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223378e2b0dso12827895ad.0
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 04:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659850; x=1741264650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+mNjfrfC3KQpEysy41mS2Tv5FPl9byidBfQ8gAxtKE=;
        b=IYpz8ai6jUfZrW6JOesC2KeuqEZFq65PXtDxF5pjRRe+74aywVgCYQMxkfrO6sAi+b
         WoOmFQbBThkjkqWthkhnQdjFSGFyfZS0PPSeEvs5KoA4cD1f62t/x47ImxHxq44JQ0l+
         yemtizH7DWZji+yz0P45m/rxFk7Gd41G3cnzB9EXE0VlWHVq/GYKsdMUCzugCe7EE6r+
         2ClSzlQSGJwdZYZeIRJeqZ2eEMx+Ewyv2zFUMf0feT5SCaniga7uAT33G3cs8AagiUj3
         ID0w4nKnyNDptgMQjnKbfOAZpPkKpzHN8NfTqTs5AWnldKI1FDLgeYwXWG0C9Unv9h7w
         Mwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659850; x=1741264650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+mNjfrfC3KQpEysy41mS2Tv5FPl9byidBfQ8gAxtKE=;
        b=ObR+WRjKhJd2wLV7mXOrZy2FHRAuVQ8Y8DKQoEM1JMmqYdbuDpSXeV4lRhtoGZhd8H
         TUd8IslkNRfSX3U2JvuHDn0+gOoY7+O3ENNCAbm2HxTzmWgaIEV3afc37p2DvgiY74Bl
         oge6Xez51y2XviOdf8oqCi5dQRAAnmk5D8THoEBXGa9f1PkIj4UPfWVbIEvJXoFQMvno
         l1KA5BCVtr9mA5X9eXOdHoIkhXesEbGgkWdXNqfK5jH75XY0xmklAsKxuEeBiBI9Ajld
         E7AmGV0BRjiAsqR7BzXIQjpzb7y5p00JdIcBjHIWF/QlkRsnvaga9j1G06OKQVqBAnpF
         vDWw==
X-Forwarded-Encrypted: i=1; AJvYcCXUCcuBw9/y0aZoDAwSOMBsFqDFIbmYLGiftK/8CXxxgUKBAWRqEn7GQv+HeRZDNVcRMUjHisEEfE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfeTeEMQXn/RwL3Ct0/CjpXMndv1aP6a/CUZ6bn2mC7Ud6J7co
	AjsM31VDO6J55sxXbK3YcMPQpVMTzdpFsUk0cRsyGavd97ZUvz8YGo/aC/LigoQ=
X-Gm-Gg: ASbGncthxSEPvwMTxtjlhHdnrXruGWWKM6nCncaPTxYrvI6ef+IFGWm7JEse5dNPQSA
	m8PBW0sMTLBulAe4MM5l3WOd8yNYMpDr2KwU2jYA/aZ8f/7I46xXT7g1vkEuL6FKKBaThAnLN4q
	nl5YYFHgXrnWFjHSbZ1gxavM8+vm7kkoOUAkLGyOhc54XmYIwkyotLPkZzeXPSeHvm512anPiX7
	aj8K0YvdX/qIUoPz8y5C1zaSnIWL6WcW1yK7KsMTX3sHOW1Ll0J7yADouAYYLaexMHxlMEEGVH1
	GjfzNsGlvOGBH/5jFnysFH4i3jKDWB4gc+/9
X-Google-Smtp-Source: AGHT+IE9Vof5DljJTx2QIG7oo7zj0JMnbJZ2cxvFEIVb6E+KmXCrNVvzk23nCPfXj+pXqJcPAINyhg==
X-Received: by 2002:a17:902:e847:b0:223:4b8d:32f7 with SMTP id d9443c01a7336-2234b8d349dmr54186705ad.19.1740659850577;
        Thu, 27 Feb 2025 04:37:30 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:30 -0800 (PST)
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
Subject: [RFC PATCH v1 10/10] riscv: Enable APEI and NMI safe cmpxchg options required for RAS
Date: Thu, 27 Feb 2025 18:06:28 +0530
Message-ID: <20250227123628.2931490-11-hchauhan@ventanamicro.com>
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

Enable the APEI option so that APEI GHES options are visible.
Enable SAFE_CMPXCHG option required for GHES error handling.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..baf97a4f6830 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -54,6 +54,7 @@ config RISCV
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_TIME_DATA
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -175,6 +176,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0


