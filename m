Return-Path: <linux-efi+bounces-5222-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F7EC1A0EA
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 12:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0335F4216B3
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1463B337BB1;
	Wed, 29 Oct 2025 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pe54++yt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A03376AA
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737276; cv=none; b=Ad+uXXQ+IxBw6muBaOxXcMDXYglSH6+ta8v6FoyKKrzqwRbdGHb6ZcR4Ihw3QgypmfpZRjySEHJ0vWBlPii2IJluIfRTpFaN2Jc2VYvyGu09Fh0MVPuomn1E6yrj3sGr3HVR06T7qH2aXmFueYc/58VgE5S9cYkkiuPlVhLf48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737276; c=relaxed/simple;
	bh=TilcVfmqeN4S9SQk/86dbqTu5JigqINDawfpL8vf2DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr4LKZQ+yxOX4Q0gKIXz0d3KgtRR6YbjhNsaFYvuuIE8TLzoGB64525FqGjDimlnsCkJjhiWWdxiQ8DtWTkrn+daOUynFB7E2hClQ6H9kh2ndsy87SMBcAzIAFtrlGeVWH6BDanoGoChc6XMSpdOL3taKl50dJpdvf01XShG/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pe54++yt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso7266839a91.0
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737270; x=1762342070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd49FUCFXP7v439aOYgrBhlMaMpFr/VqGWFeAvQumyw=;
        b=pe54++ytCggU8LUi7x8xTGTKHGjO3vSbxsgPKrzECz5/xwulrRYqwC6Mm4exFUbA2C
         1Y9D3DQ5+XMTdzLSseE5XbFvdarBmLYhdycKL57E7u6ftnJISGXvT+U06JCaXWeGFAKv
         FxT+FXDjmoIkdoQCEbhpbFLP5tf3+fDfnjNjOxMNyY8kPGcAKsnGCNqar3BOPmEZ60CU
         cCYOez+eeRb5zoHlmRIxuhwvLpb8b0s9hJAn1frBZ3+ias5YV4lk2P5ia3sA48glunZ7
         kx3blCT5+wamtPadOIjlscqVSCE2kjwK9ai24wB9ecdycIxNBFDv3H9QqwCrKWpp3qQ+
         EOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737270; x=1762342070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wd49FUCFXP7v439aOYgrBhlMaMpFr/VqGWFeAvQumyw=;
        b=XwuSkHuu1wrtS3C3fnLP+BzpJtsyP8j2iDZHTk8WongHKjCf4AfjSq5YNUaQDJVrO/
         dIbC+VNE47Q23onOT4xo3XcyAwUUdUgQjTP3uAjrl+0BjJJlD8J0+Q8f31pWyP48oHI5
         vA/xMZr7zFOA90P2vwEihf0I+slSqHfJxh/2YFmhGsDNViEjL1YbsTj2HKtPtiUwbL7v
         36uyrAGkKHI3jBVfn5H9LFG4bnuMkbXLZ2L3hXEX2dPBPzABQAOZvRU7xn/Jv4nECv2f
         dbW9mnd/qBvs2idc6K1DzCcTss782SUVKyFC4b30PaaqYY/+eg9JJx+UjmFdKF7F5eCs
         gnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYVC4wzAhpSkA/+F+IwcoKgZFVVIOjbeJcUTMw32QoQGhBBucvvEOVPZBILYfG/m2QsyzZ1j955LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNB59z7LutrL66uluSvMxdOCQBwI0xlqNSGQVTfISYF69te8zS
	oayycumtVg9aaltKlDqQ8nHIidgpnb/qtfMx5WLJWp+Uu4PKXHMaHLhGstx5pZjxYZY=
X-Gm-Gg: ASbGncu68FmfDEMJkKXmJe/AVG9Dwg9uzcVYMunQUHkem//ItvlGWZlu6qm6LlODtuT
	WuhW7+7hUVoFJvNbRVt8SMuxk+od6VPiK3h0n/qfH3h61aGcN26J7IQpq3LERcWm9eSxQMy4iqY
	tI1YcRiFsbNHkkSXwiWsq9VnbBF8BF8cw42Q4+TbQ0FOiJKNiDoM2yBimPH1CJNvJa0ZJ+KI68O
	d3O1D1eCJx01fet8QBjjpKX6tpsFAbOinbjmF11Kee38qbJLFcnG7Kb3RB3X2FZlxe18qr1t0C3
	96t8mvtpNNpF92XOK2e5tkoDPvEuW4bYC00+HfeEZrHf4wGSqhg5ucGjlRIKZi4EL6Q2SXOlJ0D
	wTncQtZKIPxlDJGlpPJmwG15Vsdp6IfMFsz84P/WHnENxGN0mwicwV+n+zijN3BlvdJ8UzCg6Bp
	VjhcVmIoQ/zeqOv15hxpLwp3XeHiDF
X-Google-Smtp-Source: AGHT+IEwpD5L2Hn2Oj9/1NiPPKl78u4FeofUgufEwNswN516sCORZuI1gux4yna6NQqFE96u6vitOQ==
X-Received: by 2002:a17:90b:1f8a:b0:33f:eca0:47c6 with SMTP id 98e67ed59e1d1-3403a2f179cmr2624640a91.30.1761737269909;
        Wed, 29 Oct 2025 04:27:49 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:49 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Wed, 29 Oct 2025 16:56:47 +0530
Message-ID: <20251029112649.3811657-10-hchauhan@ventanamicro.com>
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

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 22cda9c452d2..97aa3726e9f6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -185,6 +185,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0


