Return-Path: <linux-efi+bounces-5223-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414BBC1A129
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 12:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A1B424C75
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFD53385A1;
	Wed, 29 Oct 2025 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ioLAtW16"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B23346B1
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737277; cv=none; b=O5Th00mFtZ3hRm6dmhBN9bjLRSblVbQqVO0b8XcllMx9cC77W9rnfQFicXvrJ3rzEOO0mt7x7rSIHmoPwk6R4dfvOkyQqrIn4bkkCjhkj8GZdIdXpWCfWmg2xfz8Ja9BLdfztBfDMJK9YRh/wBFetGA1PghWNHJTACTWlN5K4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737277; c=relaxed/simple;
	bh=8JZYDhNrsI9HtE6ZOHDXkqloHy3uMWl7WxBeulXNIIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvzgRkFafQcgNTGl2VmqluS/Bm7yMLVbUwsomFEIfkLlhoKi9sFaB0XBDTRSZJLZUaJXY7h/zU1wQlBq5IlhYoSxVweJgDRtelLFz1UpChsC3x1oJCe9KDIDTjtTrrcyM0UmWEKP+yH0kXVcKoJTHyyMn6R92DazDEmLVN3Cpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ioLAtW16; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso7659132a91.1
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737275; x=1762342075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM17XL2D8YjMnEI2n2oDZbxwn/ekL7mieaWD4DF48lk=;
        b=ioLAtW16zgFVLPptdqS3SRTZWy3FimMgRWvjmu1YiKNBFWjDO2R2XD110IJcGDYZ/c
         E6eGAZ3Yt4TfhTv9060zve9QSoV+HXfWAgLKsaFjCRs0vwxaZM6DCQbl6kpI2rfs6cQL
         HfOvA62E3E3OZT8NgYwiDIhcdcORMJbR8Aqga+eZYZar6Gl2tevDlX2nDP0TVrcfmDJQ
         88C58qmQYP2mozK1ArDCIDsjWxHMsePN9OrpLACQ+Auuegyx9XVtKhJ6SpXWWyNXdpN4
         ZodfvmRnerZLQHA/32Eogf4K5OgCrP8GznkQ6/dsxLepzljmHBXZhWp7eRTQ9kxH/PNW
         CicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737275; x=1762342075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EM17XL2D8YjMnEI2n2oDZbxwn/ekL7mieaWD4DF48lk=;
        b=eMcrIp1N4VWRejdnom0gXliioiJOlpaL+xsDr1AW5McST0Md9RewoUdcRzwLTzNyW7
         TgYWgDZM8sUYzKM+gS8x7wZhhMTC2QHYoiOh5iUgLaVrQPTP75lal7dP7AYlkjYeOP28
         dgtXLkUF7s/vdA6u1FKwAF0wqCnqbSJzKq8tp8BhczUBlKYh8/hqun7oQds6nasQAgPp
         SLWmOrDjGNEV5+HQfedCd4Vei0HV47NdBZr5W5VxUpHga/GOAt58wm+K35CTYA5mNZZL
         pStQkDVUWAz2aAu1fmXlZNJ9skXfRL3WaYMjTQOaNuhPexOOym1uyiMRhVVqHO4Konhp
         TKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx1/f1afHuXMT4ABYan+PZotFOTb8iBNq6UOuerQBGXL6tGudsdVidZKU83j7WUyJZjm1UKZwtbKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKopcMb01LLmzRoclFw+3v1Z+3+26T4Tjy4PSe+ySo8n+L6nn
	8Cl1vzrx/j7VKyb/8B26PZLAeIy08xH7qhECzzpYZHdkir+H/CIC1114GH1e+Q30OaxdeLRZ6Y8
	qnudXBEQT7g==
X-Gm-Gg: ASbGncvp5WZK4kshpeuJBjJ8dI0fmehwm5XEPh+YOcjVhZywvLl5x0D8ATNbrtd4lpP
	lt9FHQ8UYMU05fy47c/CT5I6ihzsIkYXOuXJp9g/vDn6gJA7LyHdhPQNZO+G4f4BQfBvlkmWu1e
	PZE98TJ4aztHIPB2YTXtoXhF5jtwOOy3DemoPzhidXE3qjZIBvGeXXbRekASdVwfbmVTprTFL3F
	Dy7CWJVtD0VUNmZkvYjoTzv/lWTJDLtceaJbtB+Qejymr0Z/1JK9Ip/XKEUB0HoYoutitF2lcJ2
	FRhc2d+mDnb7fJ8kGO4HYJh7kLCcoCbCkm8orh6uS/EmZ5M3OysHcaHC44+4NJvoQ6YhuCYQ6j6
	80rddoCkOF/c0WIGRdtabiuGOuXLfZTrrSo+c/s5LWpCBiaL/rxF8qYTf2qSyBDHD5AUitPgvqx
	kpHlvZR/4gUeH1v3Esp0BeZpkcKaSl
X-Google-Smtp-Source: AGHT+IF600ISkv3fQ7BjFWjXUYnsdlJjH4uC/2j9DNguZaBAOpmO8VBsTXPp9fAX6HQJwfo0kcCWuA==
X-Received: by 2002:a17:90b:4c10:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-3403a281deemr3120310a91.19.1761737274703;
        Wed, 29 Oct 2025 04:27:54 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:54 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/10] riscv: Enable APEI GHES driver in defconfig
Date: Wed, 29 Oct 2025 16:56:48 +0530
Message-ID: <20251029112649.3811657-11-hchauhan@ventanamicro.com>
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

The APEI GHES driver is very important for error handling on ACPI
based platforms so enable it in defconfig.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc2725cbca18..3e62484e148f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -44,6 +44,9 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_ERST_DEBUG=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.43.0


