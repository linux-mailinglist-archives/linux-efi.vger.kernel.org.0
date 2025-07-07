Return-Path: <linux-efi+bounces-4167-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E094AFB823
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 18:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48838189E15E
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A1226CFC;
	Mon,  7 Jul 2025 16:01:15 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA7225A5B;
	Mon,  7 Jul 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904075; cv=none; b=dAcybGq9FMMg/2rKICPQAUE5EN+FHp+64mTaKJzr32u0ajjxzacubD5ercZgMA1RNzYFwGmLKmXdH+ElwnnAWj5caZZwmV7TMi92D0bfb7sdhbIjUg+6l8BqGD2D3F3hRbNFvYCzG6EDksXCRrsrhZAA4nH+8IWcfkHsQqQNF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904075; c=relaxed/simple;
	bh=x8QOGtWB+FaUXQmrwaETRfFBKmxNNBcJSQRVAv+MXUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpCuq3Ty3FX9T0qFdvu6hRAldXarR1eMaJjbHFKnRmCpa60bZvHN9bS3J3tgq+SNDVXYToxS6+fdHYbOuIvOiKTD8Zvo8+JZo/zt5YV53ZcXLD1jKa9k9r9CpDazv58Rnd40vdFZ4AjS0mHOGvbtXB2BWdKGX6/O3nHxc3b/nC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a43972dcd7so42091061cf.3;
        Mon, 07 Jul 2025 09:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904073; x=1752508873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jjHfgQa85l7Wa50vwlXdc5jSslJUPSuGPzeL+tkQOM=;
        b=LYiddVN8rcTg/uomkWc/UeqXOGCZSQJPSPIQ2pZ/xkWIjLA5zhABiA981jiickjI1f
         Wo7tMzVDE30DxbO4BK54CntFX/kmOYOyvKsOHoAaUomjizwYrmxWBtU5aZbtqHoBY2i4
         mZ1NFvq4ifa0OGxirTO3BDuv5INhQUSYdeYdjZ+BWysx+mCfQxPv02MiJPcMm4JzYYD+
         LI0p6qrdEgokjQwqDMsrCu0fkcceYY/tOTZRWMpChNnDHutZRh4S1XSWGqOAt2yudJ7d
         qnjaCNSe5wNTdH7PYHxN6XWjuv4A3bfPklDxwg8HanW1zpxDtFWuepqJtP+PpBMZOj0o
         /cNw==
X-Forwarded-Encrypted: i=1; AJvYcCVniFLhXyEjx4YFqdsowlDnuoA01Sd+8EnP8A1KHvRH91kbmJcK9541iNDfeHJM1pTe4nLrh9bkXlgOtVg8@vger.kernel.org, AJvYcCX/MOtWf94aE/lltMO63wH54w/lIxZU1pa64gWRuc/pSzJ1fTUSVV7dRNHW3w5fadRK0VNCDmlxx18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbbcEsUhdtkQVpLjI4leCsNGAstTGBWZBJFLCqqdXSdSSxqHJU
	AmAPSqmbv8cbupgrqxLTSc8OcnclBuLEUWampZdv7B08KPS1dnIBpkWE
X-Gm-Gg: ASbGncuXgXT0b+Smx+AubBblp6ivmeDTCDE+Dzd7GcTMtEDXdMf2UXcJsB54mlTHIpt
	XeIVZVn/LbuNmdS+BH4pWQ35H3gn/0eDCpjxuap0QflGZlhQoCr/u14/bsIHRf4y+EpZ0LdRAoo
	0A114VXxP/X1wn0bC79YvhNhvHjTN/1W9Se0iCPwIv3Y1sPKF36iPkI7yAH2jaGPxCYSsojSzh3
	HytfbB8usp4ZyYmkwUJzOiaLR8cgQQS39k0iNHkLmNXHw2W2jpJ+YEJ15NfqLqR4NtSVWet/0Uc
	yhjKj3yMXKzNSLGs5Ca+fWo+FcDK/+mc7WipwBnGfmU7lPBoMlhugAT7/nNiIEBb
X-Google-Smtp-Source: AGHT+IE5H4TbOWXiMtctRzGpVMXWMN9EKKkuzuG65fneNh4UquF4oGHK/oRc691OefT6XfNku9H7Ag==
X-Received: by 2002:a05:622a:1a85:b0:4a4:30e7:782 with SMTP id d75a77b69052e-4a99868ee60mr169101571cf.18.1751904072585;
        Mon, 07 Jul 2025 09:01:12 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:70::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4ca4sm64253881cf.6.2025.07.07.09.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:01:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Jul 2025 09:01:04 -0700
Subject: [PATCH 4/8] arm64: remove CONFIG_VMAP_STACK conditionals from irq
 stack setup
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm64_vmap-v1-4-8de98ca0f91c@debian.org>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 leo.yan@arm.com, kernel-team@meta.com, mark.rutland@arm.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=leitao@debian.org;
 h=from:subject:message-id; bh=x8QOGtWB+FaUXQmrwaETRfFBKmxNNBcJSQRVAv+MXUM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoa+9DSBRMI8Y7WDeHlaRNjWDgkbdHTVhzsSsvE
 KRxvRSyGF+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGvvQwAKCRA1o5Of/Hh3
 bVKED/9r+4+juSqRb8Mc4iBHI9xw8ErDqMCrI12SJuUy7IbUOWXvJslgGnAt1e10WTa6qR76JVx
 iSB9b/Yrz4mg83zDv/8Z0t+YZvKRbB+jhnIYMVE+MjYqTJo3EuJ+Zy6VW2jxtrrp/h650qCN+hj
 o1mxdHmMHP1zRooSOi0xkjJpSL+rBc5si5G6l7lwe4NWzo5enJg2qHhmw2WDpgPa0ZsRuqMz65O
 K1cJRDCPwsYUKioooZJZbSe9lp4sSAj0Qfz6iqE2Vx2SmiWTMKJdGWT30lM8U8aTka9YoVh1peX
 uqAWQUegb+45HGHW9zRqGBPZeaIBrWwcDI0cR4Qdv+f9fYqgbfTGC7UHimmG8RGbdC52rN5TY8b
 A/prszx8n/q0m01cL2elWUmWTTe5N1fHbTTuDWn1hpgwMx0kQhbwoQssJNG++g10yIsS6GiYbnZ
 6Xz2ADX+bL+8GsWsd/UDv/X4Nl1Gyaze6myHfKKVtbxnpdoESx5M/PVd/5WPgQVQ1apqRgbVE4d
 kAFjNZ1tIgr39Az5O1q12sXbf1IIRCCbz+rpTUQJv2m9JgNJ2Pkng3OW/lzYH0GATE/rmHT1YPf
 e59OeqXrDonSvnEp8Ubx9UEM3bgcUNt/YFIif/MsXq1xPCZ21vW+P7YK2DRgdJwLzppREiJAURr
 TXjI9Mg28CTMZCg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

With VMAP_STACK always enabled on arm64, drop the CONFIG_VMAP_STACK
checks and legacy irq stack allocation from arch/arm64/kernel/irq.c. The
code now unconditionally uses the VMAP_STACK path for irq stack
initialization, simplifying the logic.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/kernel/irq.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 85087e2df564..c0065a1d77cf 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -51,7 +51,6 @@ static void init_irq_scs(void)
 			scs_alloc(early_cpu_to_node(cpu));
 }
 
-#ifdef CONFIG_VMAP_STACK
 static void __init init_irq_stacks(void)
 {
 	int cpu;
@@ -62,18 +61,6 @@ static void __init init_irq_stacks(void)
 		per_cpu(irq_stack_ptr, cpu) = p;
 	}
 }
-#else
-/* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned. */
-DEFINE_PER_CPU_ALIGNED(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
-
-static void init_irq_stacks(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		per_cpu(irq_stack_ptr, cpu) = per_cpu(irq_stack, cpu);
-}
-#endif
 
 #ifndef CONFIG_PREEMPT_RT
 static void ____do_softirq(struct pt_regs *regs)

-- 
2.47.1


