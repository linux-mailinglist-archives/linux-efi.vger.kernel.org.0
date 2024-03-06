Return-Path: <linux-efi+bounces-734-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E287320F
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 10:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E33228D8B7
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098405FB84;
	Wed,  6 Mar 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SO7DT2+X"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563895FB81
	for <linux-efi@vger.kernel.org>; Wed,  6 Mar 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715399; cv=none; b=AO0CFQ7GyLQ3z8hfyRv3GPB9LWfnyGugItyi5/tsbyIam7Dc9Sy7zh6F9+mnjOJrDaI4bKagT1U3UkXZb//yQygaUo30Y1eyDoDue+fFzxX+dIxmuFqiHpCQG89WYk/ZyJb9vq8S+v8fB4w1L5uu984X1XFman94Z+ASRdv9SBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715399; c=relaxed/simple;
	bh=ALSPsCpVA0CNK2wGtP8VKCF7ZyFy6s/GtdM0fjyQOjM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=gSH6jH5wpUDsUgLm1ZV/sXafDBdCOZAj9Z30t6V7yr4Yb1QjBPShnJyFArWe0a/H7BGr4X7OfgmXp9RW7JEL/oXWNvpxj0hNe23gIfMWsqb3+c3PGXeIW+qeW8W8AoLutK3VK++78k+/MXT4N84/mALQHdzprxYvwL+X4/qe++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SO7DT2+X; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e5e4b1d1f1so434913b3a.1
        for <linux-efi@vger.kernel.org>; Wed, 06 Mar 2024 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709715398; x=1710320198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=miJgmmft5IPBYmaXSyen84BtDBnhdyu7bBvtRv7/vGE=;
        b=SO7DT2+XR1Z4OLsN6CO25OwBa9XsaFkp7GP2lSemHoJuYgPyp4JLPBLuXky1AEsR6G
         qPFkCZlsPtANynBTpWZbfM2S3FHfS0KFlU0TdY0POs907lM4gizQeIA3+Mmo+0/c9NJj
         3xq+aS03liXzgMe+rEOUuufNOvGmOtqvkASbUaTm+GQ66S2GjQ4QhKN7oOCkZX0ddi/v
         7tZU5tC0Q384JKC22tsiCy8OVg8s74Pt9ZyVd81BR+rnO+ORAUWasnxqkeylKFaGZmvq
         pUlrPAdHIt9b/vzIlzftBqwPF/RmOmN1E0n3Sa7Eq4JHI6PlnSVkMU0WJyfLxNkSqAhq
         uwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715398; x=1710320198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miJgmmft5IPBYmaXSyen84BtDBnhdyu7bBvtRv7/vGE=;
        b=akx8BVUqr7U0vcyKIQ5mG3hzIOASja0GYy6JDzOujwZTdfyKCgLpnJGtebMu71wwvj
         hli6hzkvLPu7jAVS1yifpBvhjeUtI+i/bfT6vsKdsoC6oX6SfgUpV8nAokKcmfmgazAv
         kX+pHLES+7dYBM7rALvhGRhLEzxFSS8gXeaMiQzcJ1NOdUfeK8Wh4yjMqqyEOvvXOwW/
         iWBHPBQYXt6RG2RAdbBdev2t2E2QZ/fgEVhCixYi5CkoFWPX1jLhv2AwF1Og0MLASM0q
         tLWJaLBGDHF/4Io8Pa9KSxe3RFC3chTjx/NKUyP1KZi8ZI1vlGOHt0W7aRK8vikZmFPl
         eHdw==
X-Forwarded-Encrypted: i=1; AJvYcCW9TQiP2e4mUp0jsYUC4fjKUYyzdQ7r+11sE5yqRmhWEVPDRhQg/8XcQycwi6waCHoNmFKE1+uJQdWNiCiyq7sw85cWImdwcJX3
X-Gm-Message-State: AOJu0Ywowa40MgK+denzHZvOupen0SA19R30zl7wsd1uK24WBy/bRwHR
	qAYEOMOXGzI+zXVFsrB3x4X8gALPZCHddk/DbJRrEdnfzu6uD3ZORWHCSVLat3o=
X-Google-Smtp-Source: AGHT+IHSPWMWnSqJ94igWDFx0dxlS6jl64WPFzIgP3y43hLTZHJR/pVyi5tFhE8JE9eK2c3TtONwHQ==
X-Received: by 2002:a05:6a20:1442:b0:1a0:eb43:421b with SMTP id a2-20020a056a20144200b001a0eb43421bmr5447236pzi.28.1709715397698;
        Wed, 06 Mar 2024 00:56:37 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id o74-20020a62cd4d000000b006e58663dd0asm10740071pfg.110.2024.03.06.00.56.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 00:56:37 -0800 (PST)
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
Subject: [PATCH 1/3] Revert "riscv/efistub: Ensure GP-relative addressing is not used"
Date: Wed,  6 Mar 2024 16:56:20 +0800
Message-Id: <20240306085622.87248-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 31eb1e287ce1..475f37796779 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
-cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
+cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE
 cflags-$(CONFIG_LOONGARCH)	+= -fpie
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
-- 
2.20.1


