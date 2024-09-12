Return-Path: <linux-efi+bounces-1716-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD1976E30
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238431C2131A
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D5844C8F;
	Thu, 12 Sep 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPZmSpCU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2E199948
	for <linux-efi@vger.kernel.org>; Thu, 12 Sep 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156327; cv=none; b=twSTIAVjTdBUeC0wEqt/ImxvLRqEAJWn3jmIjtWRfeHa3SMz0753I6qYkToo9AhNjqRnWiaUBbel8JsuCXrKxysI7msc7r+UNrJ10ENUNba0tUJeH56UbCHrhiTzkwG5ZyfoaXMLMgVrb0icFjPCwg8FkewVhuFqN0ur1xit9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156327; c=relaxed/simple;
	bh=YezmWpeZ9VSPUA0ukgdqKU2YkESG/xVBdN+gFUJACig=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=INyOKk1mJQZZWYjJLtXCy8QvCjUpiWA8mnjRrIyqqizzfq3Fk/T2cBE7vLDQpP8W6EsNBT0UhK6Xk5dkhso6NTnZt1ONBnsy8nf4/BSE0CyeFtr/eJct1sE6BLh5tBntIDVjsfklAOUW4SlVtg1isLMQodq1cR+bulBmnjB0wrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPZmSpCU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e165fc5d94fso2139312276.2
        for <linux-efi@vger.kernel.org>; Thu, 12 Sep 2024 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726156325; x=1726761125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+6IeGNcZT5xpb/RoyFddkias/4tHQZMY5eNb96jVXQ8=;
        b=LPZmSpCUo3xBO7lM7LsLAPCxsV4DrGPm3j3dLBfKLywOdGw0gzABXaW9T5xkyXUrIL
         BXA3e90G+WhodsgOk1lW1nBJ4kFEwi0M/gbYzBbZcmhLkjE9+ps2aHrZ7HhR8sxfKW5f
         6r1+Q0IugUSAG7fTy8Nkr9sSHb0+Ejcga3qKKpbC1KCeMPKPuxtqqu6UX+EbgW9xYKjD
         qS+zwqWkgn01im9m8DGhDkuZOCFbQE73AIVbH8ysaV774FHu9I3cIV0GuRh9KlTPoUz5
         4iK/x2+4Prp3winCsolB8aDPG7ij25zKjs6fadCnZmdpLjVXUtvYF8G9v0b4A1Gmq9O8
         0joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156325; x=1726761125;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6IeGNcZT5xpb/RoyFddkias/4tHQZMY5eNb96jVXQ8=;
        b=JT4Yp2Z6RxGgRwEo+14UX1K9rBhDamI8fWyZa9LuXiyW0EheFO0lMoLWVhjUstvkTv
         f/5zRzdxTeqAZJbea//nRytEuiYI3wF/TJn/WrngiclDaxFbNveXYIxmFrtKMHG2plm5
         Nfs8FiS0JYzoqPqvBbJiE2cFIEU93TRfMNUfvfj1x0bKaw+B8YQcBl4yKSc7lrCUyIce
         Knl9yRByT40+s/KNvV4WVx/PNw4+XZEi1oQDCYMKLc6QQNLUZDNqKQQwZths+Cirqarz
         9QEc8+YNOyy1Bm9YNz6k6eUUIbMA5Kn3jbsmU5Nn+bMzIUJieB1vuN178zLLMXksd7EO
         6/JQ==
X-Gm-Message-State: AOJu0YwxPBbTGjMCkfgwVOpqMclXZi0YJCO/NLHNSPX9+tmNmskSVBnb
	Op7MC8aTACSg84sOTvL38ZClr5MlDB1E3VwZisGug61n63h1KSWWalwDcY3w74RgPj6xebznJEV
	OJj0kWgwyE5S2fVfQBQET+8MBsqgBPElOmLpif38frKbHtyhiQV0pp8SZ0qgElYDXhwZrLMSiAD
	LVaFYVn0ZugRUg5lTZqXaeYJ5vkw==
X-Google-Smtp-Source: AGHT+IEaFrTaUbZMAdb/oNCgMY9WERez272JGPYIYXm2jin3aYEbtG6HFvgUb4cCXwOddl+LYX9j0zsK
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:ec02:0:b0:e1d:2e2:f6fe with SMTP id
 3f1490d57ef6-e1d9dc66ffdmr6457276.11.1726156324559; Thu, 12 Sep 2024 08:52:04
 -0700 (PDT)
Date: Thu, 12 Sep 2024 17:52:00 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=ardb@kernel.org;
 h=from:subject; bh=9jEAXdaHNXB4dtbQr0AWEtURl6TwUgvit3ZL8yfX20k=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe0xn0L7mY/pYaxs+/euYudqORZTfsQ7vW3Kg44l9btCF
 /q1fdzSUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbysZ2R4U/c8d03c5NY7R+f
 0GJ8Hxi/O3ProWvaNtfvpaf5MVfNec/I8PmNzPKE1z8FTC4s3LtRbWJkgtFn/W8eC+f2Xf428aL VPg4A
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240912155159.1951792-2-ardb+git@google.com>
Subject: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The TPM event log table is a Linux specific construct, where the data
produced by the GetEventLog() boot service is cached in memory, and
passed on to the OS using a EFI configuration table.

The use of EFI_LOADER_DATA here results in the region being left
unreserved in the E820 memory map constructed by the EFI stub, and this
is the memory description that is passed on to the incoming kernel by
kexec, which is therefore unaware that the region should be reserved.

Even though the utility of the TPM2 event log after a kexec is
questionable, any corruption might send the parsing code off into the
weeds and crash the kernel. So let's use EFI_ACPI_RECLAIM_MEMORY
instead, which is always treated as reserved by the E820 conversion
logic.

Cc: <stable@vger.kernel.org>
Reported-by: Breno Leitao <leitao@debian.org>
Tested-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index df3182f2e63a..1fd6823248ab 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 	}
 
 	/* Allocate space for the logs and copy them. */
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
 			     sizeof(*log_tbl) + log_size, (void **)&log_tbl);
 
 	if (status != EFI_SUCCESS) {
-- 
2.46.0.662.g92d0881bb0-goog


