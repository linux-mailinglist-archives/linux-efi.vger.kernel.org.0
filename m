Return-Path: <linux-efi+bounces-2811-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE6A3F2CD
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2025 12:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC9D19C7397
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2025 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D000E2080F0;
	Fri, 21 Feb 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="bU1EGT5d"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746C41EEA56
	for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136527; cv=none; b=H83KWM1n9iQ+hK5/WpvJ0ggQQ/kDopvJ5TydpJnR0tANbp2VIHbGXXeS1yZmqZR6fSVZfZdjWDCi4cgBy7M4MJaG58t0tcZ/rtpnL/Y3PZnGgNsIbUQm7B+TfD0safNmi+b2DcuIblFz4SOb2zt6YFZGADZmA1LVIW/BAtCuvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136527; c=relaxed/simple;
	bh=JC8s15lbIpk2LxEdMFhsWVRfCPianxn0zv+SiCNeII0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=am/j/JN4PHkh4WRIWQ1Na/llpxr9rbILnZ3iNPbozF3mfh83gYe4tWMii83bw6sb9BFQw55EnqLhO+qtHXJAJ5OnUI2NH+3N2dkIzqr6U31xwy18RR9cCUO/efIEC1diaT0E53hyzFQfpqKLVLADrX+cf1euEOod5camw1/VxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=bU1EGT5d; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb90f68f8cso374622166b.3
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2025 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1740136523; x=1740741323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKJsIzieDT+LZAQoeBL2lnvHU2BlH382x+Tm2WYroiw=;
        b=bU1EGT5dRXR7rAXDy0hbukoc7ZAH/H167WwNOvMfp6nbNzTbEC/Jhgnu+yPA1xqtHh
         wHJVsG6eIJtfDQIJGNs4cMol7znIQ6JW5sZ7jMMB0KHO5psKAW16+4EF+eutZsRJ/ZnE
         Td57+oZQCeLevAfY9GROgCqp3YJBz9SA3DmdlBplISLZkN1HO8dEBs1p2eMt9YpGkeG1
         xEFG2dWcrDaQ5B6S0ZZMCP6lKDN/6fkZyWL1xsk9PKgjkI3+NNebnfiPq4NRYUKN2P/9
         6jN3P70LrfF/uvui20SyHecJC8ROGr8O4Z97yMaz1KKS3aksE4RzWH2mNzJdwm4Unvzn
         Igyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136523; x=1740741323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKJsIzieDT+LZAQoeBL2lnvHU2BlH382x+Tm2WYroiw=;
        b=fVKJPTw5PMsWvqQVt1KS5ZeV8m8Se/ThaoVLwYpXg1WIeMAByCkalsAHuNhz6ubYqH
         PQLE6UMKigP7E2mRwVxLhUYQxkmoYMchaWJOsN8IQzDHSLRKXRHLlqB61I+nIVhAav5V
         xu+9oo8bpVYE9LCZNS59tHVch2jV3WiKztQdd2lp//NdUseBPT/rcAjcJ0p0X7zHPu4H
         j+JC3uyznmEh8NwsSpSrohm3o5/rZ+x1XY5hW8b+RIhZgDoPIgd5HpvLgDXigzA4a4cO
         ElBWUujwF0hZWJ9BGz+7+BttnjQ3KawJfdjsCZtkMj7Yd5m8oQ2FcmK3X44aI/QbvIT2
         /2cA==
X-Forwarded-Encrypted: i=1; AJvYcCUFQOBr4kNTOyMpqKB1T3uYEQV8aP7PoPdijr4VH97L9196zFas66xzkWf2M84qFlilHTUpe7P/kO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncmmSD3KOOUi0IMgqrfSoLioFNM5MFpY1DrsSxkOwURJc7k+I
	ds0SfvfJC7wnyu7KX7Zj8b8QTfPdoozLkBp9gOUWSmrevWuNeO8YQVx1G1HQIQGGvubgJLVXkGD
	uvJ8=
X-Gm-Gg: ASbGncti75QYGi4Ekfba+XxW64kTrirw10DDI6ynplMJxsGvIofYfZOZ/QIFeC0w58Z
	ELfaIuDwuTgXUKOmOybH+S4eKrV+UPbWPvlWO3w5wkprE/M69fqgTU5+CAlf9I8gZJfYooLPvSv
	52OvvS1fcAlfyWzw4eqAbsnOlxYFWGqURGtaH6IfX2/CZxtRm61GvnpiNpOYrt7Rbg+88xQmSyZ
	WJbJzmMuSxLX02xSgOQqdCNQqfGC9U217AthBRlLExRpclUJ9elI1CSnY6NuzKybHese9m4I47/
	K8kmDCsZn5PxZZ4eEfywDnq8IFR/b0XenhB5E2DVl5eWFbHdMfqW1nEIjGDdmvtLrGrNBG/T1Kv
	Ha4hCeaMZ8y+I56dZGrXKi6tS
X-Google-Smtp-Source: AGHT+IHfwheDAfyvVJBq8JCrmMPG7NAd/4D9fIvfDegRQukqwTY8Il/imHtsusJZsDueYJwmDU3mJg==
X-Received: by 2002:a17:907:7715:b0:abb:e7ed:d603 with SMTP id a640c23a62f3a-abc099b83d5mr286093766b.9.1740136521119;
        Fri, 21 Feb 2025 03:15:21 -0800 (PST)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbd5502c53sm499291166b.159.2025.02.21.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 03:15:20 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi/cper: Fix cper_arm_ctx_info alignment
Date: Fri, 21 Feb 2025 12:15:16 +0100
Message-ID: <20250221111516.1468261-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the UEFI Common Platform Error Record appendix, the
processor context information structure is a variable length structure,
but "is padded with zeros if the size is not a multiple of 16 bytes".

Currently this isn't honoured, causing all but the first structure to
be garbage when printed. Thus align the size to be a multiple of 16.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/efi/cper-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index fa9c1c3bf168..f0a63d09d3c4 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -311,7 +311,7 @@ void cper_print_proc_arm(const char *pfx,
 	ctx_info = (struct cper_arm_ctx_info *)err_info;
 	max_ctx_type = ARRAY_SIZE(arm_reg_ctx_strs) - 1;
 	for (i = 0; i < proc->context_info_num; i++) {
-		int size = sizeof(*ctx_info) + ctx_info->size;
+		int size = ALIGN(sizeof(*ctx_info) + ctx_info->size, 16);
 
 		printk("%sContext info structure %d:\n", pfx, i);
 		if (len < size) {
-- 
2.48.1


