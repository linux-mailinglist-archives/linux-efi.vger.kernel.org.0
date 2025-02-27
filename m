Return-Path: <linux-efi+bounces-2851-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94606A47E02
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 13:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CAB163579
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F1E22FE05;
	Thu, 27 Feb 2025 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lJ0OCCkY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17667233D7B
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659847; cv=none; b=DUNvbYf7c71sxvVfnehG+GsP4kOM1/QTNjz6cT/TnBtmNvI16xZC2n70fMdfYosx0/uNMSfRHuoFlfysjhrhUliMLdn1bSBMfru+UwaKr3vISk1KgdRW71NkLSy0ry8eAPQiEg4e+7nKLqjyg8Tm21PbR9PjAXkLzl9tZPoybt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659847; c=relaxed/simple;
	bh=Of9PqcRio9hOrtrXaK3C+7d5d06uoPfQDo/STc3oCQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkCyInq0kvnh0AT5oFn46fdvLYd5+5wBquGoBeTWh7s+YPECjKvknxYSGJJlVjMdKrw8jBFJsqGeVuGGXC5MEFYky1U8pYlbZTD8blDZ6+xzL1HO01eYYir0SHxYYuS0pzch22i8+uKs95nwGhYPH12Zeas/PtYXSxlxIVhyr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lJ0OCCkY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223378e2b0dso12826705ad.0
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 04:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659845; x=1741264645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcOi1q1j+KD4L6iG3zLb6+WxKLL1t6DJV3NbpeiJXTU=;
        b=lJ0OCCkYqSPgtJ4dZ5CW1e4TJpEUkvQ8TruxrJkxp+sYc4S39EiAnZNewqSQbILB63
         forlY5KP6QqdDUb2i/QCV018Kf6KZDc/9RmNfZL/xnF1qeyjPRsuQntu7K4iaXuYSiWi
         /rgckz/qfXN8oAOVC3D4sTS+u0wkLMrUEyrQELnMvSqclFHk8aPKkBe33fUaSy6d8LdY
         NxctfU3nxHEAcCa+GnEoMChDPAO+omjxcXTTDegi8hEZ6AVchmfwBetA6R1ESy7x9TRR
         AuyT7nVDMfN8y6RwWEdGWQi3EUQtS9guYWx6uPBuM0gJnITHIY0VidW50RM5rXrobUun
         Mf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659845; x=1741264645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcOi1q1j+KD4L6iG3zLb6+WxKLL1t6DJV3NbpeiJXTU=;
        b=GpU4EfKb0fo1BNM8gZb9wanZHv5RaMUj5+Mzx1hcKO8ZeQ4wSSCfXd8TkwoRIZo9oF
         YB8J2+7Rjh92/y0UZYz3HI20JsI5EMklq0Uz+Ag9xEOW7yy0vjmE6NIuKJSIQ7j88ozI
         lZupl5nEGOgkJJe/Ma9R/O8Kn8NBn1ilijqErlW5bYr+KTgv2dq2O3ISXay1E0rLfaL8
         pdrnSEWHHwstg4G10Go9y+kdC/sxyFURpYta9iohihZSRCTcyh1q8DyGBvULCQg4xHxj
         igbJYv1iy9LF54m2ppnb7p7dOcM9TwVaQ9LSaOEEe7I+iacUoEfLaxuAK02dKrjxmB8r
         0E/w==
X-Forwarded-Encrypted: i=1; AJvYcCWMIP5gOYxVe0jrnsxSg3NCV4udkb3zhu36YhPryoQqNE5Acfd7konbXLQO3SBTG8gHdTgYoh2EZI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/XcXITyq0MLAHzsRNFTYWJWuk84+uYMP0OVUshxl0TE0gCaQo
	ChSFq5P04WgdAr64Z6ewJayQ1GVyLz99J9aZmZw7QkMKOszb+H6libg8CFevNn0=
X-Gm-Gg: ASbGnctCpyt5vni1RqNcG3awlM7weTGkdNKMo88fHRROrhCjt58WLjat/hj4Zv3w5cu
	U/QSLoVG1xU3bB5/Fly572OBffWVt63N1d96LP3aSsK9Tu56AUGiX/dbJwytJEs5McKLyNHEYcE
	o2Z6xK7FW7zxz948hVQ4Fteg6eB3M6ya+MQ/kfOQYkLnY5GH1DFfgnOnHOZDskS62wQ0LlQvl8j
	OIiapukFgMPQhdnFwTVEDCOULv/qJ2aYDgoNB8kx5Bw7c9+GAgOL2fHL1W3oLMl3QNbLVepZCOA
	QNhovdQD8atzEUUjiZ9adUtZZX3KQbTwcc6n
X-Google-Smtp-Source: AGHT+IFpHziUTuaJEINi+EgHoRKrGPAz4AsnUhhSqo24MLZ7IPH1ipJJRVjiescHNO1qawzm+Z45XQ==
X-Received: by 2002:a17:903:1c6:b0:223:4a10:311b with SMTP id d9443c01a7336-2234a1033camr48544315ad.1.1740659845617;
        Thu, 27 Feb 2025 04:37:25 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:24 -0800 (PST)
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
Subject: [RFC PATCH v1 09/10] riscv: Add config option to enable APEI SSE handler
Date: Thu, 27 Feb 2025 18:06:27 +0530
Message-ID: <20250227123628.2931490-10-hchauhan@ventanamicro.com>
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

APEI SSE handlers can be enabled/disabled with this config
option. When enabled, the SSE registration is done for GHES
entries having notification type set to SSE. When disabled,
registration function return not supported error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 3cfe7e7475f2..be1eaba9b093 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -45,6 +45,11 @@ config ACPI_APEI_SEA
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
 
+config ACPI_APEI_SSE
+	bool
+	depends on RISCV && RISCV_SSE && ACPI_APEI_GHES
+	default y
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
-- 
2.43.0


