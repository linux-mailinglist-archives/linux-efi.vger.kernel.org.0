Return-Path: <linux-efi+bounces-5220-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65FC1A07E
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9EA1AA08D1
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372BA3375CB;
	Wed, 29 Oct 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N5v2ul5D"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB672337111
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737262; cv=none; b=fEGlKQ6tnrCgVWN9cao0tsG7nKHHDVn0y0NqOKja81CQ8iJO1rSgEGxnZn5K4arHPYngQI/29wrZ9NcnAG+iyZ/8NkxBNIs8Rc+kVZz/u7ijssr0nB9OiKjdQ07NF+KqibXyntpvBScV47M8l1xX4SxGgItveu4qUjsq//tgF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737262; c=relaxed/simple;
	bh=I4TEHisHhy81GfBk4tNwlY19gPH1ru3ik8bcWj4YLHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAOy4A0sAnZysRGD2nrKoVb2gYQk7dOB3uc15Nv73hBRescRWYY6aTSfTnjszMvV+lr6lIfhdAMgQg97VPAeCX0DyuoKNWOmQ8JHB5rkbxSqMDyAPdICRjE1KeTzBrZxoZYIBFaVD6G/3ZXUPmNqcwhwd0ObKT3Xmx7VIfkY8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=N5v2ul5D; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f5d497692so8638595b3a.1
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737259; x=1762342059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu9PVTm9hjUdHoFQcU8g3rsnUfjy9F8yp+wWZYUCJFc=;
        b=N5v2ul5DYuPP6BS+JMG++hnvL8J8HGcOkejRFmUkaA5x/QCOPH52WwkH/89wzElRaT
         V4NArUDZwut/qZtnXm1M3vRUoj59DljRh7kRX/EChV2DImg27ScHSzeYjamP0vmvmg/D
         U122zUUCcI7TaTKcUwAZg9ZTZuIeenmAU3DR8t5siol1Pa9SeuTpp6jw/mBKZ4RVxmFm
         4OwS/1BF1UrFYkmNwDYUb+YFUpHBIQ3DFEIzVn2NNow5i2mhA9rAa6FlRdo8eYOqtCqi
         0ArmAuYyqiBShSXPj5Cvkb66/AKISaJ86J9FCOi3DJtrCF7vlDvUusECmRLgKM3S/cnD
         c3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737259; x=1762342059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu9PVTm9hjUdHoFQcU8g3rsnUfjy9F8yp+wWZYUCJFc=;
        b=whwTfjKnlFG+XoEnx2RPHWMtnefTHAUDBTHcFzkdNTTjr4G+dEvQvRYCHpQA+a1/zu
         /xuhuv1XMbcmKuzRAMv6Yoh0uIKMxn6F7GBcUMeZkpGQRgzXa2Ge+xiagjst46HHS9m7
         cM3WAh2bEMF1b4e8LViGvgB/qgzhf4RMM2ZNMhdUbHBXw8BGD5QABG5V6UuV8COUoUJC
         AGS9wXqGhtAmKT1jlKw2w6Ts2AskEutVDkLyorUBngDRemBICAwOViE9t9fOqNgoWAbG
         jtSNdhPFhdwku+vGOXjcNfO71Wn/HO6TTx7qu2jTcytbyseXmegsPtHnbrsob5AXlHN0
         3iEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFVrXM73zu7asCDf18j04FTcgn/GjRxSm+u71roWLvyJGCp6SXLVAYka17XZAmhxTEdocOeVutr/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtfUdXQZH/WkG6+txIcYeDwTPx6MiCN1FDjsIw+RwRzxj0fp+
	CzpEki3v7O62cD0UloqU8vciy+st4otm1qDnCbittHMQJFz1JVAjjGFnxnVv7AQmfvM=
X-Gm-Gg: ASbGnct5w6idtfji3R4xp1Y9vXCPfbAcCI4yYvcN4Q/xpWqpwQ5EP+x68Zk/W1QdCo3
	AQ/D5CVhVyWQ8AdnI6aWNs6C58GeyVmEV7BGHpFnpj1W8K5AENN6ScRayxX0Pwl8m7M5meAN5dU
	uvuS+0Pcz9krJGgfZpnDB0eRGSAo654gSHiiP7GjrsSzsYotwirWIO3biQTOLYZP+qd62LEnRK3
	ejy6ZsmqfaGFyVSM28aAw29ct2HUhiV5OUGquSuTGwqhd9F6tq3WC1C46lq0IMwrKB1Kw7RXhXB
	Xs2iUMgCcFC7z5ICZ2nnSLta4liwb9ExIKuFs5Kc1FfYXlrlbshWA4fjTkKNBP5dQjwJsg5PECD
	Pkn1zdfij6Njwhr2ES66b4qcdM0kuRZGE3crdEjM9pRIfVOcoXdoWFwR9WlLsd2Oad8NlKtiDW5
	AtnQZAONemIdB/jPtywsXV1OU5gFHb08WGkp5PzAw=
X-Google-Smtp-Source: AGHT+IEwNLyhot5qPJEYgE8ajY5jbwtZPlrijo+bkOA+9e521cPY2uChToY5FLnyugwQKON/wAVvRw==
X-Received: by 2002:a17:903:32c6:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-294dee20a01mr33897975ad.18.1761737259146;
        Wed, 29 Oct 2025 04:27:39 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:38 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Wed, 29 Oct 2025 16:56:45 +0530
Message-ID: <20251029112649.3811657-8-hchauhan@ventanamicro.com>
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

Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
respectively. These are defined for cper records.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 928409199a1a..ebdd92ba1e15 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -110,6 +110,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISCV",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -118,6 +119,8 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RISCV32",
+	"RISCV64",
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.43.0


