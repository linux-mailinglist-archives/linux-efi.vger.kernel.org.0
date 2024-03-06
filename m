Return-Path: <linux-efi+bounces-735-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE989873211
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 10:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E9B1C21FAB
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EFE5F487;
	Wed,  6 Mar 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JXucF6vb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386660B80
	for <linux-efi@vger.kernel.org>; Wed,  6 Mar 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715404; cv=none; b=dSw6vdD8Uv8X7bN0DwOJ0ptSibMBj0ofUhr7TB3BywxIPEGKc1mBdyLywLCUHyb3ygO5xjJFQ5QerbmHH9aNGYAkadOH4U7gRvV8WrhRwSnzE+N/FB5FTQBcSYy14Zrw9FRDnJyXAN9WYwa9iUunRIper9sdeHpgNpXM62ZFGTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715404; c=relaxed/simple;
	bh=a6eeGsVPbJ4geGSegwTUJJlLAqhxpUbQgapuYeVQNSk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUSmWrz2v6STP8nIQ049VukY0PEwYVSjJrt2WOrq1SEgSGwFulKnZc5yLsrQ1Q2K4irX+PPtcJx3EX8wWiuMm1A+ynTW54ReNL1Hl4EgYRHtl9rzKDQNaYaFairYaAyi/VhoadN2GmDRu8kk+8/7rSYh2yjHQMSr/XsYrkxidKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JXucF6vb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e64997a934so575712b3a.0
        for <linux-efi@vger.kernel.org>; Wed, 06 Mar 2024 00:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709715403; x=1710320203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRr7LxSbEFR3x5uzGtBz3X+EqjDvEmVPS57p5cg+Ap0=;
        b=JXucF6vbVt404QQBuRHWHlD/HxH9/eQ5hH2OSoVPOjV5fZUzaCt17Fre8E3xn3rha8
         FNr3iCD330095bPlqG0Y4kUcSQJFCQnXugkhG3LK3lc+0cneJ4xiA/MIcVhWQDpQTYkM
         OnZigoRTHFv9NNMrcPwDoWUCvlS/UYfbMBA9D/ODVTCVOc9DSS2lkjKZnfXjYImhn7H9
         XdTy1/n9TbHYzmxSvp7xuW7DvFYUxxSx5Q4Rqa+d0yJjKawb5NrS86uKOjyAvuYxErJ6
         nLyNiwjXHVrvhkZ6ApFQYCPatz4Jdz+o+gPRnLaOAeGLTDuxi1xHQ9H668TpUF7/gbeM
         2IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715403; x=1710320203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRr7LxSbEFR3x5uzGtBz3X+EqjDvEmVPS57p5cg+Ap0=;
        b=DSvGM2rEJXuVFLy8QF2iJlHXLYPgg1A9xIFbZ8QfAznD9tqA8pTgtf+TgpRZ1yRYEB
         ZzXqbLhS6s+n/wTiWfBiKbx4SBv+oRtHPmmGcOH3GucxJZ5zPjDwG2U62d7xkMHEtFxJ
         IFOvxIa7iMZhkqjbCIksrvnP5mgbYCpJuJfAlvBPyO8JBy76300ymIlq4ZkGpNZbI2PW
         XYJvQ7pd6p5kfArrkrp4y9g3V37uFC9JEVb9x+xTXRCPtl9qWo/k5oYWLPef3akBsUz3
         cBZ/Re7JyICoGEkEdumsfMtyp+BlkA8LDw+eClxe7RQaCE0t9Gnzr0760QjY3BN1ieW8
         hn3A==
X-Forwarded-Encrypted: i=1; AJvYcCU061lgFeZoMPLemReRtxkNBc8yDdhpAssV01k869XHcRVIwiPrKZjQbKj76YYs3gttzxh6I2XFO9cE6Pe3+NlvN+2djvlpL3Uv
X-Gm-Message-State: AOJu0YwTLwAgwYk3PXN6pRpffs8yBpcFlFRwolcZxbgiLYIm4q8os2J4
	T7TJptLQetKWskivNWpl63oL5+WPysVlhsTSsmINB2Ht3N2PzrGP6dcaLpvYVhY=
X-Google-Smtp-Source: AGHT+IEzhVmTzXyIgnGWoxvhwL9j1MSvK9SInEe+8cuDZjgq6TdrkmluNqbtPfM9F2D3l0tBwG18Eg==
X-Received: by 2002:a05:6a00:2354:b0:6e5:80a4:2ff2 with SMTP id j20-20020a056a00235400b006e580a42ff2mr15831466pfj.30.1709715402744;
        Wed, 06 Mar 2024 00:56:42 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id o74-20020a62cd4d000000b006e58663dd0asm10740071pfg.110.2024.03.06.00.56.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 00:56:42 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	cuiyunhui@bytedance.com,
	xuzhipeng.1973@bytedance.com,
	alexghiti@rivosinc.com,
	samitolvanen@google.com,
	bp@alien8.de,
	xiao.w.wang@intel.com,
	jan.kiszka@siemens.com,
	kirill.shutemov@linux.intel.com,
	nathan@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 2/3] Revert "riscv/efistub: Tighten ELF relocation check"
Date: Wed,  6 Mar 2024 16:56:21 +0800
Message-Id: <20240306085622.87248-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240306085622.87248-1-cuiyunhui@bytedance.com>
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d2baf8cc82c17459fca019a12348efcf86bfec29.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 475f37796779..a223bd10564b 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -143,7 +143,7 @@ STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
 # exist.
 STUBCOPY_FLAGS-$(CONFIG_RISCV)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
-STUBCOPY_RELOC-$(CONFIG_RISCV)	:= -E R_RISCV_HI20\|R_RISCV_$(BITS)\|R_RISCV_RELAX
+STUBCOPY_RELOC-$(CONFIG_RISCV)	:= R_RISCV_HI20
 
 # For LoongArch, keep all the symbols in .init section and make sure that no
 # absolute symbols references exist.
-- 
2.20.1


