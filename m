Return-Path: <linux-efi+bounces-459-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71972847729
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 19:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D29B2F08F
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DF914D439;
	Fri,  2 Feb 2024 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="H62nDHHG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6114C5AD
	for <linux-efi@vger.kernel.org>; Fri,  2 Feb 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897235; cv=none; b=b4sIf4csmcRafDdMlWwq9dZ4XrGfrnH0NsMm9yTl9Cek/piM147NLqYbBN9GhQ51NhKBrl+1nGcjmN3ow18o8zV8BlPeXZsBsH0nMbvGl85AL6MHHE0o0rgXxEdXY29JlgUcZ/ZYYcnUzY5gZe5aY6EfPjErZ8/WyVzL5hKFKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897235; c=relaxed/simple;
	bh=WyNQGE65iXrMr9yngCo4GWOgGd/sXGPgehCp3iXlLL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lAvrSddEmPrsjNv+a6mhoEkIi7FvLs6KPac9p5f+ykcY61QCCfKSy8zKKpMU4XIuotZToQys9IChL1mT9HBzJwf//mwzpBVUbyrzxRyxCnOn5XRo2JNrc3M/oxAkOAulplkNR1FrWfyDL/YXxvXsc4MzklNP1N7bbdVioJzA01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=H62nDHHG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6da202aa138so1530049b3a.2
        for <linux-efi@vger.kernel.org>; Fri, 02 Feb 2024 10:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706897233; x=1707502033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Yyrip3T2gRBwGLvYCLpLjUFISir/avz/b+c2luLHGY=;
        b=H62nDHHGZYda9okCf2JfKZCp+55LjIpMigZ5Y5jAtyqGH9J1UzEB356D3pdmoyujqj
         x/0Krd6MFnGDgwUhTpgOujbbhdnw7AMR5nmplvXz9vmkO+/PHVqUdswaMm0R5Lmq4OOD
         r9wGLBVANxD8YP7S6XMIWtTTKVvrOiUjD1Xxo/qaN/k8CUHIZOcwVgMJfk3Nv2+jTX5y
         w7D34t2HgHPv81SjoaW58JJ3PjZL6v/ELD2sFFLIR6rrbK5o1397KBCDrX2Eiu2AfM3X
         94fyHHWuDlGxfXtFG/aL4LpY67jD+Fe2Lztx8kYLULlNFKK/TsKfEuCiQLNJDWF7b5ze
         d6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897233; x=1707502033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Yyrip3T2gRBwGLvYCLpLjUFISir/avz/b+c2luLHGY=;
        b=gRK0tyzCJatjb/JI/05XX5/xdURmE8pbEHvF0hpSochxDC/L7022Smj0o6yA/uphHD
         Ouw9HpqT4a0d3jzjljiBgYOL+HJkjHJgSf+aHQF08NvLE2ToAvXPz0oBjnaqH286DIE0
         8fIRWfLlmbz4YtwtkbthynOoRd8ex6S/g4mmvxTvVy9VkkazGT9yIjk0dTiV9AUDKd/d
         nhCqRZgSUC05JgHDriQEuX53wa5f+VB7WCgDik3xbGMzjCV2x0yD2m8cVdTtIsDG5j4f
         m17f6VVMGSziZ8k8bWfwacuMlRbR6ER30UqimxBbht1cucjCtluPo2zplA6zZq+2dGCc
         44Ng==
X-Gm-Message-State: AOJu0Yw6AoX2pVkJYM93D74h9lm7P4uPWMd7qFO5pVgsTs6nebanH1tz
	9oM7G2X6dxxL7V2eBQYBQja4I6rteQDJUxownmnlss36YuvO9phPUYIJFrsNHqQ=
X-Google-Smtp-Source: AGHT+IG+xYxv+LwajPk4C5nz4DY2qxbK7PqAKE+WcH5FBlppsmmhxviIkgQ4jI0JLjaR+O7wz2Jigg==
X-Received: by 2002:aa7:9e11:0:b0:6ce:751b:81d9 with SMTP id y17-20020aa79e11000000b006ce751b81d9mr3346175pfq.9.1706897233322;
        Fri, 02 Feb 2024 10:07:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5uQRhhNr4F5Tr/eDx4VZKGJkZm2fFKhzvmErVJFdhN1keJw/2/IIbPia/PAaM3mkVII16Nt5yvabl0M3Zh8DUWKa04jN+PvoVj8IbhmJzrBJJb9Arr0kaYy98U+F3QdLE5FXpj6PMaQqSExRB9qZR4DdEU4G0klU6A2Yo5YCioE6HI4Uq69jHHuQmm1KAoMudrIvnpqJDFjQ+aG90RJGeKLQrNFSBnP1dKqm3fulhCWqUkrdAXfbWK+vNySD4eg8DV/zQ0+5yqh++
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b006ddd31a701esm1989267pfe.19.2024.02.02.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:07:12 -0800 (PST)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH v2 1/2] efi: runtime: Fix potential overflow of soft-reserved region size
Date: Fri,  2 Feb 2024 10:07:03 -0800
Message-Id: <20240202180704.808766-2-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202180704.808766-1-abrestic@rivosinc.com>
References: <20240202180704.808766-1-abrestic@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md_size will have been narrowed if we have >= 4GB worth of pages in a
soft-reserved region.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
v2: use u64 instead of unsigned long
---
 drivers/firmware/efi/arm-runtime.c   | 2 +-
 drivers/firmware/efi/riscv-runtime.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 83f5bb57fa4c..83092d93f36a 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -107,7 +107,7 @@ static int __init arm_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			u64 md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index 09525fb5c240..01f0f90ea418 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -85,7 +85,7 @@ static int __init riscv_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			u64 md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
-- 
2.34.1


