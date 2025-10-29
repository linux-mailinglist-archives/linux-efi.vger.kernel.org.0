Return-Path: <linux-efi+bounces-5218-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 503BEC1A01A
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 12:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF5BD340380
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D33314C1;
	Wed, 29 Oct 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WTi4wd3o"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB15335091
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737251; cv=none; b=ENBaON7vu+P38NhYfn+YWXlBX7j36fHIppYgt8H9e+8UsPr7x0QklXeyekRGbJORK9FydDJqlEb2j3TK+gQGNqWVfEnfUkwtneiuEFAMmhtMOehUofdKj7SiMxhRoY7RLSnJb8K9IjeYr0+weH9udffjhQF//wkoPTiQsBPQBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737251; c=relaxed/simple;
	bh=TSz747FjNEhM7uf1XzqCJ/IKzP85Xywzfa1M0ZRoX+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTccwmaoVY0X9p1hYNXAxnKTWSfdw2xsC1cG26YYshA1uQEcOzrDUUuWWOjzU4+PGqBkLam9sFccAvGv31Dx2NS15w7D8XPehaBgj0DI7ZAwuotDCK5lJGhJI3NWz5JYO/3EWZHGEjAUk5HCnAZeMgYxqI4B+YMHVQIUnS5ft+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WTi4wd3o; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781010ff051so4875454b3a.0
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737249; x=1762342049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hiwSqBhR1Qws96GQdbU4nAKreYqDyRXg+IAoSlhXoM=;
        b=WTi4wd3oXOxF8q1Jd84m90kQ33Jx02mWFL06AgA/izDdMv0Wgd7ehAWAQuteldL+nM
         wOVL63CdMbIZ+63TaJH08k0SPDLF1j/zbgMEYA6Lr4Carul3Vkn+vghCZEquZ5S55fba
         xpwTanLyB1ge2YZSiltHVjk27vyCC5uRhvLVg683NZTFXJ7lyfluZfS33LHyC8oMq8K3
         w53Dt570zmJTchho7PdkgUGjHk6Hc8aZ8glzvYaN9bQyV/c4NZv0deviZyX0MumrDzgX
         VHoiqlC9nVqpJ8w9rQsRx+jqdAWBljXFQ0bj0HKI1T2VyL46qR8ptlGORZfgvQfU0UqH
         N/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737249; x=1762342049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hiwSqBhR1Qws96GQdbU4nAKreYqDyRXg+IAoSlhXoM=;
        b=tEZlyI/OenCUp6IWdZaYKxRAZZtNxo9pax/rH9Y4uwPSYceX/rm8okK/RVCkLRr/oL
         2T8arjvuInxxRdc/xNbc4T2itOVnWIuzyD5jAJsTLdy4iQCttMzTVP3sLh6/tmo99FtO
         7YS7KbFibbZNZgb1Qnr5oljdH9CJEsOjuCtK77hNmnntHjlw1M5mCjCo6Xbb/qasqhqr
         BYm9UWrOB+2FecVgyKYBuqifcpUAhbcONPIIIg2b1TNBo/bLOlbE03fB2x8Nk+b6qcp2
         ZJRM05d/v7atF03RSpCxifzuu9Mx1Q40mnVxQQu1yIn5FBGCcrQ80lc1B4jCZrsW0sdW
         QJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCUaSL3UJvN89lBhrto7qNAfihl0Ly0urmJcuPzv7BPzFeJf57K5Y1BMQvYr4z1nYTBQRvZ1MIfcfSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbf8026HwP5vX/rtfgu+FmaWKuaTJytomYGNG7iM5HYjCS/xP
	486CBcZR6OuoDRRlHAsr8iGcS+6fLkWyp5S6eY8DCYXGt4OScT84IsII08z8vFI1nQw=
X-Gm-Gg: ASbGnct90riBFw4Svdy/tLkEJQkjcWlWs2tqkk8Wh91EgyTrSZGaPyAmKLXb7P+nRdc
	1lFmkuggJMXcV/9gG2MUhP9rDjJr5nnXWiK9Ucyr9npZvD60fH11n8llYevU1rAeddGWPrJcd3e
	eaK+b8qa9IzeqeDgrVZ8oXiHFKXeaeK/KmCB1454SLiZBo/jF546nkuYQfRSiGDLaZHZwGBkgoP
	jLf0s1syjYwh7YfPhBknRA6DyPK3G7XRR/1hGcXXKS/vCry263LJHtKt0duxP7VKmNbdC5oZcbn
	fiK0qXWsvbric20MWeV3ToS6nqr+TY/zCeMP22EXfx8GQR1TxFM/xLYXjPmi+lYxYw5pkvXzcA3
	Bq6Nq9PHRh5FW/ibDZpI1JBx7u1lWPwObIA0jW9RnbIZLzX/+JVWl0wk0aSHYVwDEOl0yoEVtrf
	43SQaxU18l6i9qr044aXWqmU2KRV8B
X-Google-Smtp-Source: AGHT+IHs9/yah7+LL8dEcqJhQQLW+XK5ngSWHXrirtA5CcwyDvBqFPLqGRdj2uDT9wLcliFabWN9TQ==
X-Received: by 2002:a05:6a20:4328:b0:341:ea4:b977 with SMTP id adf61e73a8af0-3465381d8f4mr2997177637.44.1761737249215;
        Wed, 29 Oct 2025 04:27:29 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:28 -0700 (PDT)
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
Subject: [RFC PATCH v2 05/10] riscv: conditionally compile GHES NMI spool function
Date: Wed, 29 Oct 2025 16:56:43 +0530
Message-ID: <20251029112649.3811657-6-hchauhan@ventanamicro.com>
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

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 97ee19f2cae0..f2cbd7414faf 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1356,6 +1356,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1374,6 +1375,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0


