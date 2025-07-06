Return-Path: <linux-efi+bounces-4133-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 147F1AFA422
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEC43ABE06
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 09:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6FC1D5CE8;
	Sun,  6 Jul 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4/IvB1z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AAD1AC88A
	for <linux-efi@vger.kernel.org>; Sun,  6 Jul 2025 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751795225; cv=none; b=BqDs5WOdpOAnUYcEpQHkdOBYUWj3AcJaCQ8/zFbj6Qot4zD0HTzOKBwzzd/+nUzR0U+x2InQ9wcjayi0GdSe/RW4pxZ1eOdvBuRzohWaoU7pqI5WEl8HgTfYyqS00J88r0qv1UjRdemDvdb2apAXwG4Y6c50BcVvY9HP5Am3/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751795225; c=relaxed/simple;
	bh=1diWdmZBf2S4Y5qISywodxu19nf7hNxT4rMUHChpw9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhyM8Vcf1HW57XAEZoKDp0wzEmt1Gw1yML68+akoR7modvMALahY/vBLa4peJVT8EkBYXsP6Dnj+OFy6cI1cmQZrnmXuCi/Bcrt1F2fZVr3p8vjvZE2FmFSM6GuyZWjJkkrUdnMGvFLmSzZknT2r/kI8e8cXNSBAzXx+sHtZ9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4/IvB1z; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo3445106a12.3
        for <linux-efi@vger.kernel.org>; Sun, 06 Jul 2025 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751795222; x=1752400022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6xlWZG3q339ZhjZezaZxN0+SbBnE2IfVSlIzuvRhdw=;
        b=G4/IvB1zm9Jb0NgGsEr7xNvGr4NI5XXG04bQSy6elN4za5f9sVkvzoV25VMoCGlhOt
         Eq6Wdq5AKBqH/KfrOO4beqgpvKAInHUgFt79MxxoAt8uAlgznCL5vnIw3UOa3Ta4lh74
         vq8Jo44/yxdHa7uNlfN0UAclr0G9t4OLMJSMk33GU3gcOEoJS3Vk7vmHi8LJ7EbWBW7G
         vJwAMOz175eY5/mW5K6pkoMSbGyibY+p+PJakwC2b3t1FXHQ1NK7MXidmPkC283Oi8xe
         rQEt/LbYJt0PHsH2U7yzuU8uoYw+MB+FqvqaAK4J76qkDHWbZtWX1BSNzf1FjTyMgsBm
         bQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751795222; x=1752400022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6xlWZG3q339ZhjZezaZxN0+SbBnE2IfVSlIzuvRhdw=;
        b=mRHL18DQ0lYc3LXXPbPLS6xeJ2IX/0+HOcmsqLRCx2o0qmZ7aWn+LAR8qXpNpQf0Cz
         zfTIEd2LBZU3Ag/ua0G6QHoiVTjdLQi9h6vrYot8stZQsUsWkh9At1rm+TdNOlWJtmpx
         2mPZoHQaedl3tF+7JyoLn31OCf4sVl2OGBfqmAVHUmEyRjtltHT+vR1AuIMBSg9bZteU
         kMCENn+yUtNl7JmJrJK39vR/mTfuL8pPemPz5OkZJam+dv1fC7w3T91UrUQK1KbAkVWV
         g0Vw/291ff0u0SqSaBHYKx2od1/lMwgGB4GVZGXq7/pSXSbUJ5CPrWeE5QrWRwQBEw8z
         nSKA==
X-Forwarded-Encrypted: i=1; AJvYcCVH+v3DNR3yczyXhWQnfpBHApIgIKTM+J+/1X3mJYYZzB/6tkC2Kebrbzj+Rn1lXXELjOaTeA59qkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzfr9xCRUd9R8VULM5pmmtBYbOgTcYC/A3RglWnL+/3p7t4IDb
	S3EePUJ3EmM52Eue1wSdIhDGKd7LTT9kKoHMZuZx33m1Tzr1Lx72zOJJ
X-Gm-Gg: ASbGnctI+cQWfPffZsfBlKUwrVcYtvYrBqu/7NQf2eYaHyoHFCK+KrvFuibrgSoZ65F
	lFR1CfX1x3JY7rgpojo6OLE0ORvVyrVTF827W6VZVEvLRMpGZDrdL9yqe1+YjkahlRPUqTWPf1x
	c1Fqtjdlwhk1Ve+JKWqd54Oo5uHULY7QYvT3yJzlr+YxwHHr9rHfmsPOu3JgUbP374Ju7/BOjEB
	bR5XPGNygBYFeyajzCdfchU5cszdYpotnibR25Vy/xcbBOiuY02KxNvGO3O2ROZ6UEhH9peQQpz
	en8DW65/1FGLPI7PefW2rObR53E9N+YocI/rL+yUZlqP+56YPZxaMoCOK9tbCBljHqOYAaYBiYy
	ix7LK+OnAHB6v
X-Google-Smtp-Source: AGHT+IEvE1J9cQQ+cEbLxXizIVcQ6mFRHumnPBTHnVWDedGZts/dbXT5y6E9R2SxjHwF6zkaCj97mg==
X-Received: by 2002:a17:907:7248:b0:ad8:a935:b8e8 with SMTP id a640c23a62f3a-ae3fe64e643mr760258866b.5.1751795221340;
        Sun, 06 Jul 2025 02:47:01 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e6f51sm482893266b.8.2025.07.06.02.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 02:47:01 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: ardb@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: gargaditya08@live.com,
	jonathan@marek.ca,
	kees@kernel.org,
	linux-efi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	lukas@wunner.de,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH 1/2] efi/libstub: Print error message if efi_allocate_bootparams() fails
Date: Sun,  6 Jul 2025 09:43:51 +0000
Message-ID: <20250706094354.1282-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

Print error message in case efi_allocate_bootparams() fails before exit.

Change the direct call of efi_exit() to "goto fail". This allows the
general error message in "fail" label to get printed.

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cafc90d4caaf..13d8eba06e4b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -824,7 +824,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (!IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL) || !boot_params) {
 		status = efi_allocate_bootparams(handle, &boot_params);
 		if (status != EFI_SUCCESS)
-			efi_exit(handle, status);
+			goto fail;
 	}
 
 	hdr = &boot_params->hdr;
-- 
2.49.0


