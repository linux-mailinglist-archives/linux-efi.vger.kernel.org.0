Return-Path: <linux-efi+bounces-5919-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAB6CD8FAB
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 11:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB5BD30215CE
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 10:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4DB27453;
	Tue, 23 Dec 2025 10:56:10 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256A31076B
	for <linux-efi@vger.kernel.org>; Tue, 23 Dec 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487369; cv=none; b=RKXgVf/Nl8LDTgV/HWY3aoJOqNIIFdpLXktZlRMhexXA/0fO1W4wjaanFH7CbRcDuJ1L4OptPjXFpFSR/pRwTIRACX4JzZHlk4qbzFmudohOC06LFPkfBK4Lo+4wZmPhu1EiTJU9zwFEDxm9pXKSttwDiJvoHiO5A6T2snO0Ty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487369; c=relaxed/simple;
	bh=JPX11ECPaVPrf1MUlS1NHwPHSQuz31NB4jHoPAD7UEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CD0oXMYxeVE1Lt2iBuD9gxnDden0bdpOkkK+EA8B2KG+A/qZVxXhSU0KjWAO9Cm1FOwu6mJelUBX8D1ro0QsnT6DJUqzVkI6V+lzEsPcVvu8hpaUuTj8H7yRWFrvPbo24frPPmnlxwIGLLcZOow4v8bNisLUx3CyKkyFFkP56y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c76d855ddbso1382899a34.3
        for <linux-efi@vger.kernel.org>; Tue, 23 Dec 2025 02:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766487367; x=1767092167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P+FdLdYIbfO7vOmrfvIwEh+YRn/9rHzC4lMj63oYJMc=;
        b=kqv+7eysk2l8R2Nn9r/yi29zQYlM5xmLDTShLzC9B8Vh/+zqzFH7roaBRdzYP/M0+7
         7gIlwEdM9LV9XRtLRoNDcQcGrN4mj9VXVbFXp4YxATgNGe9/AMIYh2D7XKSVqW1cjPjF
         dptd/tvC2GaWPWA1MS2N3/eW+Qe70QYHnSUY74RGnb5cP+YroxfDgO6oyySPWgPfLCqB
         g1yaMap/iWuGX14+vIbElOGB2XXrfh71Gkv0PiJ35wAEhuSOoUmDxUn6uW/ZKaPeNpvN
         lsz+wUqbdSchxesY12bo1pwXeiO5iMEIqW9IRyOqQtT+H1jmNFwK9i0AwbcrEp43yADI
         UfLw==
X-Gm-Message-State: AOJu0YzYwbBRlRUy39smm0++Ca4wSziWnxtWOMxtsafEOFWwhGgf60Sz
	KzAAvswGzprLGN1/91gjTgFQRkS/bS+z031WzAkG4tTbgg2TZp7ECHfs5aUXoHf1
X-Gm-Gg: AY/fxX5yhUcC77NSQzukw+njBcIBb1lVv14+h8qdfw4Ioi5QkVG8xSJfw1M/bLV5uq3
	zs9ehObAxA71CHjeUvgj6KkZEUXHB16hQ71BuySel4wwjJV0/Mi3W5GlbB00Vx7Q4phsJOygVWY
	d8dI8BK6J9NddeD7dznUNuwmg3kShW+wEET6igrLylJdb9f8VShpJGHAwhdPydxy4KyxvYJeFbb
	jWZdJ15yrEC6WXQgK4hriDcj52pdcxAwxVDwPC+8cnpQS3mftZBITRE+3LvG/UBNCebhuCk7jwT
	eqAWY8A8vX/NiIAP08+EQut29G9N2PrIXvShRIKy/hISYAZ4GK79IIOxcmKhht/ICncC6R7RbK0
	uzrZEmAICoCfsaMEAVCBpgT4V9Eu55a31jIrwhXzD3a9e0rCOhHk0FZkmliqTJ4+sCK8TjcZxdo
	QpqvjXszrHn3r/0Q==
X-Google-Smtp-Source: AGHT+IHN2V35Klregw+9YTKsH2OtlmwwB/mDyXPjK++QZTB2CC0RR+jqY6r+PZxq7ko/5WlgLmeZrw==
X-Received: by 2002:a05:6830:314e:b0:7c6:cb39:adf7 with SMTP id 46e09a7af769-7cc6689c9d0mr6676247a34.6.1766487367049;
        Tue, 23 Dec 2025 02:56:07 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6673bdabsm9065064a34.10.2025.12.23.02.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:56:06 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 23 Dec 2025 02:55:43 -0800
Subject: [PATCH 1/2] arm64: efi: Fix NULL pointer dereference by
 initializing user_ns
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-efi_fix_619-v1-1-e0146b8b9d73@debian.org>
References: <20251223-efi_fix_619-v1-0-e0146b8b9d73@debian.org>
In-Reply-To: <20251223-efi_fix_619-v1-0-e0146b8b9d73@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, riel@surriel.com, puranjay@kernel.org, 
 usamaarif642@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2290; i=leitao@debian.org;
 h=from:subject:message-id; bh=JPX11ECPaVPrf1MUlS1NHwPHSQuz31NB4jHoPAD7UEs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpSnVERN1w34K2bU0P1LvowG6Xgn8s0jFHxj1T+
 myf6uG4fiKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaUp1RAAKCRA1o5Of/Hh3
 bcV4D/wMbGBfSuzqozvQHGdYEhbyw9hw7JGeECYucULIyAmq1QKPRk6tmC/KNW66EbKynHk3W0B
 lwz/otxPI/YJZKk9TW7HbW64zgXZ2cICMblLGA8+G/0hqDbsYorXNZ7b+cIRTU3ACDrnP/2zlIP
 iYRjfPI25MWAo08KO8n/FFnekS8D65B1BJqNz/gE9L0qOcRqxQAZfeDvx5kKtlpgwXXsXkaBv+v
 pklHh9H5eJGNGf/LECjmedGBDU2lknktPo807TbRjjF2WhitXoY7UG7mc/3lDvLQ0yjPGno3Nxw
 +1tvxWsEDPI/S241Q18a67nm6rLr4CoF8JY+c+6XaktdUI0bQKOVRXsBI3T/ZRR5nyD8lGdVhk8
 H8IdIJhpJ9pdpbUwYFY9bEOGmP85bjrYtMH7Bl2Fk/ijhZQHzp+HnQL02jQ0eNW6iZJKpltBy9Z
 /k7eShirBHO01BNDZjdc7P3jHTrE33iTh9BCsUnWChJxFhcVToq1RXIJ8FrSY5n6OJBq1ePcqXm
 GwCwSu70Xut+SZvBgSm2ofGBPoqwsz5DS99ipygfYmKcZoyXuJDcjFsFFPAQvZw+JtrTHxWf0KP
 QT8O93E6sgd/j/ZSmvroKHwXYp43yIUyo5R2BZm+OYi+Fwz8yjaA26DoKvT3SneoCsDHtlS3yyK
 MU54OZsno/DXPFA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Linux 6.19-rc2 (9448598b22c5 ("Linux 6.19-rc2")) is crashing with a NULL
pointer dereference on arm64 hosts:

  Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c8
   pc : cap_capable (security/commoncap.c:82 security/commoncap.c:128)
   Call trace:
    cap_capable (security/commoncap.c:82 security/commoncap.c:128) (P)
    security_capable (security/security.c:?)
    ns_capable_noaudit (kernel/capability.c:342 kernel/capability.c:381)
    __ptrace_may_access (./include/linux/rcupdate.h:895 kernel/ptrace.c:326)
    ptrace_may_access (kernel/ptrace.c:353)
    do_task_stat (fs/proc/array.c:467)
    proc_tgid_stat (fs/proc/array.c:673)
    proc_single_show (fs/proc/base.c:803)

I've bissected the problem to commit a5baf582f4c0 ("arm64/efi: Call EFI
runtime services without disabling preemption").

From my analyzes, the crash occurs because efi_mm lacks a user_ns field
initialization. This was previously harmless, but commit a5baf582f4c0
("arm64/efi: Call EFI runtime services without disabling preemption")
changed the EFI runtime call path to use kthread_use_mm(&efi_mm), which
temporarily adopts efi_mm as the current mm for the calling kthread.

When a thread has an active mm, LSM hooks like cap_capable() expect
mm->user_ns to be valid for credential checks. With efi_mm.user_ns being
NULL, capability checks during possible /proc access dereference the
NULL pointer and crash.

Fix by initializing efi_mm.user_ns to &init_user_ns.

Fixes: a5baf582f4c0 ("arm64/efi: Call EFI runtime services without disabling preemption")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a9070d00b833..55452e61af31 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -73,6 +73,7 @@ struct mm_struct efi_mm = {
 	MMAP_LOCK_INITIALIZER(efi_mm)
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
+	.user_ns		= &init_user_ns,
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
 #ifdef CONFIG_SCHED_MM_CID
 	.mm_cid.lock		= __RAW_SPIN_LOCK_UNLOCKED(efi_mm.mm_cid.lock),

-- 
2.47.3


