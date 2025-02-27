Return-Path: <linux-efi+bounces-2845-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25702A47DF3
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 13:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702703B6F2D
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 12:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DC92309B0;
	Thu, 27 Feb 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="brhJ3G17"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26EE22E405
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659816; cv=none; b=jqbmY2tJNBG7KY2aqrsLMexEPjF0P2Cz6nJvxsXXDmE+vz4qx4cldm8F/1BNGXWm5oE8f3ofJizZLgtKfP1fyaCzfTkbndPCv0TXC3w0NKL77YQZKqjwVSMRcS7MnQmKYhMYm3FvzitFTISfhoFjDUWt56o7G9puLeo48m19pa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659816; c=relaxed/simple;
	bh=67ls/POKUjWPQj872a0gGQ9pTH69yGPYjMpXWSU47vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs+n8Q+ZMFweiuLUdTXaR2UespPzLh74dIr+H+V0D3gmgx6LP+wqTuEL4zXvyfG4rUILXaANeitwHKahVnl+zl1pqwMNKVX1NYKas83lB1Qe6rXLsUa249t2stQJth7ceQxE9PtnG92nAp3iaRHLZOWwSixrc4rbZGjWlVXxVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=brhJ3G17; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220f4dd756eso16014575ad.3
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 04:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659814; x=1741264614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9tq9UU0quHGMxFhwTeHcsfn2hmcgfg1pwu61qXDOW4=;
        b=brhJ3G17yPJnnjGQzqGegbVp8BYquOSnTZC6Fvu2VbWhQfLlhaIr9k5gsN6BZfSzRC
         Rt8IyBKBeRpvhrrrNgImwQNS5WJg0qPiRxHSd+4IDNgMI6seFqJAvmp5u8RuLmXYuM9v
         jn8Dj045c+sKMNJVHYdNafDeFAQ8ebLCM969WMa4OOjpEuvYqj2xSlRsAisVSw1ndFLK
         Z9Qt5J8FLbR2DLN94wNnIDVxT/meE97dsqiN8TZIbHIabLYr65EILamnCumiB6ONGg4M
         +K6oT2aZq9ruFhFHcIuq3KkFwT9J3n9IUR2cic2X5F36R3s7lEOBtxv3EUqYSGdTnRLS
         VOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659814; x=1741264614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9tq9UU0quHGMxFhwTeHcsfn2hmcgfg1pwu61qXDOW4=;
        b=XvuFuSDrFvbLx9ONvzbHodyp0YzoU1npBVvn7lC3BX2svzoP/L7Yr7YkYdXnV4sQV8
         W6WhOxsjyS8Ujc39i1Y7gLzyfHvU7A+0dorIlgAv3QDCPJld2TGozmwl5IOGxu6jBRV/
         kJftXeqfYRX5d8zD77d09DKmyJD5uz345syZulULlRyPS8KhBfW3a1YPBBZxqUPl9K2B
         no0zPDkff8Nwsk8UuXO8xRBDYtijNreniGHdJrwyF7/w70Wp0TsWdVRlMCAVQrL6Hs9f
         5iJBIcssbhQ6A5BBEzbf5K+reIblLLomACLs/SP5ct4phY+yzoh4rVBJ6pI1AJBCcpkx
         7y3A==
X-Forwarded-Encrypted: i=1; AJvYcCXKPIug2mYwJPDXsY4J4m8N2pqEXu/2dLeFy01S27Yb0HcXBV9YWJKuP44m8g0xKCeQF/g+k5KVQ2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6+zAPeZsrE1p2XQcJX7wOBbWaiu9bFSTjB5wmDrTOepAtvl5
	175DgGbnujWBa+xDR6RcRgIq/KSFffENUPJkMOn4BqBEtLYng1i2/3MBSOjLXAI=
X-Gm-Gg: ASbGncstG+b1tYHbqF0CgmzJyFSvlmCQyte9aSl2wBE42dRw+luL80X2miBcWHPVCvm
	OVmnnY9urNfxig/wb2d7buW/rjD1/y9SXaAaL1bItn7/i1BVpbFAG8y4VwpC5c1YvbSdz6pekfW
	cjD5F7RN8sBfO4xuiU//NNkJG4dS1aZ5+y5w+KYeMurNH+HQ0HY1Xcfar8/me8u5y0fmHK6Ztls
	mxG31VQFDdcOaSRcMKURUUCDaVzw6uuUuqLmxVC7BDf8IuZs++QeyjCMOHHSjZqTSBBNSqj2eYt
	leX43btXDXHbchyn9rsStnZTPEPrcBWmtlkh
X-Google-Smtp-Source: AGHT+IHVfqxszUaYFM69ostPnakgkazkeqpkl6j+lHgInhnZ+gtwN2tclnkImUVqCbY1mWtl7iGV3Q==
X-Received: by 2002:a17:903:22c2:b0:21f:55e:ed71 with SMTP id d9443c01a7336-22307b45598mr186650025ad.5.1740659814323;
        Thu, 27 Feb 2025 04:36:54 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:54 -0800 (PST)
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
Subject: [RFC PATCH v1 03/10] acpi: Introduce SSE in HEST notification types
Date: Thu, 27 Feb 2025 18:06:21 +0530
Message-ID: <20250227123628.2931490-4-hchauhan@ventanamicro.com>
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

Introduce a new HEST notification type for RISC-V SSE events.
The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 387fc821703a..df577bf25423 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1515,7 +1515,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
+	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.43.0


