Return-Path: <linux-efi+bounces-2847-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A376A47DF7
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 13:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C85A3B45B4
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71821230D35;
	Thu, 27 Feb 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N8sF/g18"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162C230D3A
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659826; cv=none; b=COm8gGipV8vDP1i4ysCcVuGdCpDWDm9SPqzn0q4I0JzWVHoQ93GjxOynVemNEgUobQYpTpbItKj7sNi6U3ZYI1cXWFt13iey/V8oLPzdKk5C/Htu6u5aAvwquIsVDFZXNPD3ivR8+CeW89A0CPTc50xcgR2cx+kHIlbdue5NClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659826; c=relaxed/simple;
	bh=Z//TrE4r/P2ORzzHAfm4GTTR/FxL7V8in1j3CWT877s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbyluQ4cIUTMpoFzsmYm4Kti5nGDu8TLOgQHE9Fn9SCXpIRiVXOM2XDKO1eLYQ9YOZ/Zb4VFZneOoCoSWKDjb1OQfmPo4N7VKv7D3uktyJYKB5t7nDEi+U/blbdpcpVb1qQx4h+rMcalTvKDpBZnXB+9ENiaFeOSmztSbQuUPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=N8sF/g18; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c8f38febso14516665ad.2
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659824; x=1741264624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtQ05xO+EnCCpS3XXknTi9mJFSuRz+8Y7aZxhDwaUdc=;
        b=N8sF/g18F4mULr2QnOeMcijsv9rbPzKDiy535tf7ppdmm6v90UZrtJ+px9jcdoKXXR
         nc2bbymnOr+QWE3R6+lNFbdCR6Dzye5GzAAMBAJZ3u3BZEBpCJ/KBhBcJKuSUwPJYaps
         wnFoL67qy8MkzA1QCI3Njl/g55O+s1PNcRCd9OW70JKtoQFwuqd0nvsWVsOd6x7ayG5O
         4uwbHPvTklIYnX1VO+UcFvY7cQ/wf+1GhZZRsS0vXrmBOJW8fJtQwS0FhVzSNtQT/rrt
         RqqKtX0SSI1b4AMgabkD/VhcU+q6dp/RbY51yghXY4GzNbElV/VTJZGatbR7r2s3ePH/
         UQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659824; x=1741264624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtQ05xO+EnCCpS3XXknTi9mJFSuRz+8Y7aZxhDwaUdc=;
        b=Gs/+QcWMJQSjgUPNdtyVENYldHVAgq3/sdPuIlkbDvlg1+BnDzIY/mvHLB3DZA3XNE
         RyUdAJusKhwEEFNrIPC5bE1dtMYeaJsZCijdCWRylmqyhOqpZiTSus02fB89kkBvfWh9
         Fxsr6mkXdySmnZs3pjlZI+9Ad74S5kmmhBae4lnM3LC4MG5YQ2PBiL2RQAHkwLOIuMWl
         cnAHHFvMyU3OP6b+QD+p8v0pa0bd4iF85w4rkeqrvrO9Uyvnj0P31isW6uFyEvibWRi2
         WUSyKAdwHCXBmVfFpb77SU8OTN8X8SuXgsB1mhIwSisKlEhJcev6wCVm9MDOG6UWb+U6
         O56Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuoV8hCg68bwoe8qzJmbMBtqFfYeNnWE4pp4eqiSl0wHp9/vgtY+XXe02srJaxuiUIJOImEFPyUt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8YkSY5aoczw9afJBLOpv9nAx99c+r7B2onwPQovyhPW2CNBX
	AXgz1CNzIcXIA4lSWV3MUEKyrH7xSqTvUCAIsfmt2iJIyzMN9XNhB2NgjO6H26I=
X-Gm-Gg: ASbGnctgfgoGXmAKlEjHvvovRcf1Cb5Lofh4Awp4PBFj3ZS2IKs/SPhoodpn9AFw86s
	mYJ6qniG/6nlDPhR7R8mmNOokM2Jaiq1LMWlkQ2Y8mFnL2zZXOG00+Y4TX4RClv7+CnFsrNA/LR
	mPt0dG+mducKYhr0Kxgc8Z2MQ/eUliGuMwCyACPRUIYiqF6wd7hHaPiAQ5i+APvY4pIWzdi+nHs
	SpvHPBojPmLvGAYyQ6pdb9kb6jwNq/RqKVbUHH9QwUyvZvS4tmQQEvV5XjnYUZPUhT0hGRZQjpI
	boreqC9/d6L/WH11L/YV0Ev53zDvG0I4hOpL
X-Google-Smtp-Source: AGHT+IFkP7CS9xqANnPn4d9Sz+3RrDXTk1H1Jji56UTUSX5o72PLQQPlMQJClQVJhKn4XxMTw6Hpiw==
X-Received: by 2002:a17:903:2288:b0:221:331:1d46 with SMTP id d9443c01a7336-2219ff8278fmr376544635ad.2.1740659824356;
        Thu, 27 Feb 2025 04:37:04 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:04 -0800 (PST)
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
Subject: [RFC PATCH v1 05/10] riscv: conditionally compile GHES NMI spool function
Date: Thu, 27 Feb 2025 18:06:23 +0530
Message-ID: <20250227123628.2931490-6-hchauhan@ventanamicro.com>
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

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b72772494655..8a1029163799 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1231,6 +1231,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1249,6 +1250,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0


