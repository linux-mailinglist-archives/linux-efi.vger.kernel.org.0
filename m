Return-Path: <linux-efi+bounces-4347-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06428B05654
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 11:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90E8560C9E
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65B12356C3;
	Tue, 15 Jul 2025 09:31:46 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70AC242D67;
	Tue, 15 Jul 2025 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571906; cv=none; b=NYbvuQbxsws2LECmen0qbsaxiqjlSP2osNtZ/cXaew5wDtJUewodLiQruGsp6r2yVTSKdVi94LJDeMJhPy1/A5PLu5t3y2FwOuqsBLwQARRlvv2CCzqzEhOr0c6IUz2Ex9KKnU3ziST8zKX/DVHmMSJ16GrZCgKj1qj5jDb6Vmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571906; c=relaxed/simple;
	bh=Enm+5lj1/ZB8kwu0P++RJOLus7cmUggLHCtHYqUrHzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rypsxIZRlHpC6Ge6EZYD/+7yt0M8VRUHOogQ4sOOvOkc+j1sbRaggrMouRBmOj9+9AMiP8nGZ+QNFRV1S3xZ5F4yWYhBl2dU5z3yGoUrcCgHiuJuqIdXhTUJ7JA3YZymgS3+4W34SCJMB+d+TONJ1f0ODBYUfEzot2/ZWgmGr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae9be1697easo50577566b.1;
        Tue, 15 Jul 2025 02:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571903; x=1753176703;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NEvrnN1Iem52usWD5YMVmiNdwL79bzkTw6CkM01FJs=;
        b=e65junnM93gqKxFZevdcxgn8ICCXdH/8FVYYlVnYbyTc1Lli5rl44myctAf95ZNEwo
         Ia0W/AKyzwP+01aEf2r7H5+4gSJcNNoGUzC1dFjgEsFR6Nf2VB3sWt1C5weK+eAVRX8M
         Q4rF/3h7WDN9XE/Fy5TEf3Xa0LqFoYF5xruE0wSeIcTeteNlVF5gUSREamtHnDM1pF+4
         SKQOj383bkuy+GMHDRI3SmlWrSys3RDoYZ19jHWNwEkW5PTbRq6CLJTitc4s9eRC7iQI
         bn2h79dEyOBT3Pe8AVfrVvEe4se1aIkuNOkGPK3vQf69uYW2gPqQaL6CuernhTP57zEc
         JhYw==
X-Forwarded-Encrypted: i=1; AJvYcCU64gOam9hItyMJQSdX+rzYFmBr6o/PXNBhIhJTLyt2iaHG90V353cXwlVHa6ZjeKUdI07rRdyJBYbYeSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ULbRKfjRZubEBqCIPXHFXjJaXjO/XWUS4tnrxeXc3XG2Pr19
	ECCdClRDJb1qilo1vUwvEP5KPiGf4FBqQlgzkbY1Q+FVs4quNEE5GjoY
X-Gm-Gg: ASbGncsuuxCQoqAbPPbvu/MC75C1JzB+HR43EKBpTVSPWbMsR+vaMeIhG+kpXbjIarj
	oeE98hFXYNUOHPb+uKOAKztZQRVf4lzzi226dCZWBu3S/OAlv5Rybj5LQvewy++gmEa8G2CEoHY
	j9TfTgiu+rppgMwDdGGH2GpCogoUhtn3951B3//TbaVwwGvH3n69238/qE28NhGTWMHJb5YsL7+
	lSpXgvcn+nmZt286dwYyx1xDPKZYVhRuvLtVZY033jNOtRk+9p/FS0F2uds9kVxWbRcaoONIYSW
	8FBokzHUFe/bx67keL9qdG2xkpiDD1SnVLrxt4vaMfb70WZEhzQAypVkqJKH4B0tYciZBo6TLz5
	XiigRkvmUjSCC
X-Google-Smtp-Source: AGHT+IEgfYhUiqAFXqjOjJsoxyl3hh/BsBBaqN0B3m9m28JMb/J8aEhA/ASIWj8brBldbnf+X40lYA==
X-Received: by 2002:a17:907:3d8f:b0:ae3:eab4:21ed with SMTP id a640c23a62f3a-ae9b5bfbc5bmr275577166b.11.1752571902673;
        Tue, 15 Jul 2025 02:31:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee8d9fsm953060666b.46.2025.07.15.02.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:31:42 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Jul 2025 02:28:19 -0700
Subject: [PATCH] efivarfs: Suppress false-positive kmemleak warning for sfi
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-kmemleak_efi-v1-1-c07e68c76ae8@debian.org>
X-B4-Tracking: v=1; b=H4sIADIfdmgC/x3MWwqDMBQFwK1czreBaCOVbKVISc2JvfioJCAFc
 e+Cs4A5UJiVBV4OZO5a9LfCS10Jhm9YRxqN8ILGNq191s5MC5eZYXozqfkwJrouPKyLqARbZtL
 /3b3687wAnMmrCl4AAAA=
X-Change-ID: 20250714-kmemleak_efi-bedfe48a304d
To: Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=leitao@debian.org;
 h=from:subject:message-id; bh=Enm+5lj1/ZB8kwu0P++RJOLus7cmUggLHCtHYqUrHzI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBodh/90G2Ll6Fc9Cq7iQPkQeZyYayJ1fjcZ0Xg3
 HQRjZpj9YyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHYf/QAKCRA1o5Of/Hh3
 bTlUD/498CUujYZVG8HJT5z62Jq9OJNJ2jypGgKS82BWDwiZVx5JALUc6MUbaN+pFqSZcAMbGZR
 Tw7sKNvZsIFpILL6RE07yMlUI+2Mejf+ckyICxTfGcIzpW7/mnZ7COdiQHMfyoS5r30OeZwMYrg
 SR0w7noqc+//dkK5sk5hq5FuDgrR2q4N45UkIRHvQ2Hv1kS/kEf14JGZWQDckoX+B2pnIJwxP68
 7N/EZzbXIfqmiTv8uULOrppN8enmIx0pDMiInlBW7TDumtXoNNCRhy/o4l6R9g5iHWyGE3W7gLE
 YhiRb0qmlflpjvaBp7s14B6OKoYOte5pdURMdvnNDdX2X94k03segaHW42rBHiRLIEnSh2dnhp5
 2cvlTnPMH5OxgPEXkO6G0cQeRzabDA3WFy9mOFvgFFnTLddRQMtW6WO19TOlFy9uXhQ5Lx47OPK
 5qawikrzWrfSIBKuFYl0mA43r6+u6YcPOGd8wT7tf9sckz3ZuBKNNZlAwe+q4e2Sec/vEdGNaKr
 DyKjWpyYZ6scN00q6SkLBXZfCR7fuxID+qAVQNZL1EAZpnZBz3os/S9aBFctl9nEXXYqIjFKxV3
 Um/MQHUFBVaSu/fKyD/6nFgzzwyQ+Y1eMSFJVJnjd2yu3apJNpuJTG4qZuumQI44/xUUv86cDYY
 98ryaAqOOhxSmAg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When kmemleak is enabled, it incorrectly reports the sfi structure
allocated during efivarfs_init_fs_context() as leaked:

    unreferenced object 0xffff888146250b80 (size 64):
    __kmalloc_cache_noprof
    efivarfs_init_fs_context
    ...

On module unload, this object is freed in efivarfs_kill_sb(), confirming
no actual leak. Also, kfree(sfi) is called at efivarfs_kill_sb(). I am
not able to explain why kmemleak detected it as a leak. To silence this
false-positive, mark the sfi allocation as ignored by kmemleak right
after allocation.

This ensures clearer leak diagnostics for this allocation path.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/efivarfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index c900d98bf4945..5f867ad2005ae 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -19,6 +19,7 @@
 #include <linux/notifier.h>
 #include <linux/printk.h>
 #include <linux/namei.h>
+#include <linux/kmemleak.h>
 
 #include "internal.h"
 #include "../internal.h"
@@ -498,6 +499,7 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 	if (!sfi)
 		return -ENOMEM;
 
+	kmemleak_ignore(sfi);
 	sfi->mount_opts.uid = GLOBAL_ROOT_UID;
 	sfi->mount_opts.gid = GLOBAL_ROOT_GID;
 

---
base-commit: 8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2
change-id: 20250714-kmemleak_efi-bedfe48a304d

Best regards,
--  
Breno Leitao <leitao@debian.org>


