Return-Path: <linux-efi+bounces-1630-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBA19662D0
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 15:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B9F1F24DA8
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5901ACE00;
	Fri, 30 Aug 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lJu7PwFm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C921A2860
	for <linux-efi@vger.kernel.org>; Fri, 30 Aug 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024209; cv=none; b=ViebhiT73y9dst6/aY2yuW1Q4TwEGrotVgEecyWSvBYE1kWFAmu4CdBvxHgzIyFQGDfJHms1evXrIznU85i6Id7qbrmUQv0sF/F1pesH61bVaJp9MI/NYh4IogLZO6gOOAdZJQL/G1NetreDraS65IGHbipE/XgTsW52hzh9r64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024209; c=relaxed/simple;
	bh=JovN/q1rCM8s8I0KqmQeIxeWvruT6E9Yj4kMIRceKe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJycxZhoQoxYuM4XqTsOK69S5Qg4lup0fQlL79ZB+BJCyjQN2MLA5b43Yet4wJAKgjWMyYFUqCqcbzrjSUDGm6du/IQdfqjEfg3pm6A2Ko1RVSx4knMRLr2K3iPFLJtzYf0li3W6A+by48EJUUl6CoDeVevFZ5K0++b3BAtqu1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lJu7PwFm; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c35334dfb1so879536d6.0
        for <linux-efi@vger.kernel.org>; Fri, 30 Aug 2024 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725024207; x=1725629007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTgw4zeKGXQ1BnSya5EmmUz/kqtWZMgtCFIviz8ICC4=;
        b=lJu7PwFmYW8c2DFI48YMauxL8f7qE2p55o3IOHgpMRAQAIMbmV6bVaS37JeArrMkWj
         sOrWDLlSZHfSKCqokogRsNsDYrJukBWOCiiG1b7UILay9tmEWctYJcr/nuvme4XoVWPE
         UVrpncG3rXtZVMzFr2yBHvajBrxOR26B0JUCXqapuJPGpusc4KeajxQp7FPncnU6I4BO
         vDj+S6s3psIzq4YzNHRvLuac6NnkZ+jVe5Mcvy4AE7NJSzF94pkdMJSxvZ0IxOrhZVGi
         1BzkTUrf7PpF4dSN4QQ41gqaXsOffB/wRVK1utU9S1SxVWxqoXd9duZ8jBnQW+boqjPb
         EX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725024207; x=1725629007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTgw4zeKGXQ1BnSya5EmmUz/kqtWZMgtCFIviz8ICC4=;
        b=wspfa4tIplhCJQvJU4RwAt04IPPdvGhFnL1nNrGPrpk4RE9ZoR46PtxRt7IqngkzU1
         bzUWFOPtmxT1iyDh/qihtvfARDHwOERg5KUUhfQ2wcsSqfjpISzF8ECj/iXLqJCqj7gb
         STrC743QD1b0zX3TOGrIo/c3YecWafDrdZpKIOsMJRVhMIgcY5gRHrqd8Wjm9GhT5Iwe
         S8NodrqT3UGplEh+R4eyvMgnuoTzNenoTX+Cn44P6UWGEQN46ExO4oKn4kx9dq25aWZN
         7dcNIQwttt2KgqjyznEaGi/jAbQpgsTCmsHCFajHlOCG1/jm/FY2t8H4JOokddDJULh2
         T31g==
X-Gm-Message-State: AOJu0Yx3hOaWwKXrgPKzetkBx4eCo/ImZ1+mQSFYniOihtpbQykwwoZn
	3XXDuGkTHtgU+GUfEFqykBMiC37aolOXzeFEx4hdfl43h8mmYPpaWF5Xb/0XfW+hbpjhI1r0cJ8
	2
X-Google-Smtp-Source: AGHT+IFgmKjMD5PnWPuZ2ZPMTG0mC0q4bT3k2BC7Djoy8PoEcdxeAoEtHZSZ5DAP23yCelxr+ewTCQ==
X-Received: by 2002:a05:6214:5b88:b0:6c3:33b1:20d0 with SMTP id 6a1803df08f44-6c33e6a7f5bmr70648506d6.53.1725024207070;
        Fri, 30 Aug 2024 06:23:27 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c44619sm14485066d6.74.2024.08.30.06.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:23:26 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org
Subject: [PATCH 2/2] tpm: do not ignore memblock_reserve return value
Date: Fri, 30 Aug 2024 09:23:03 -0400
Message-ID: <20240830132303.6665-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830132303.6665-1-gourry@gourry.net>
References: <20240830132303.6665-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm code currently ignores a relevant failure case silently.
Add an error to make this failure non-silent.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/tpm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 9c3613e6af15..b6939a6d44d9 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -61,7 +61,11 @@ int __init efi_tpm_eventlog_init(void)
 	}
 
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
-	memblock_reserve(efi.tpm_log, tbl_size);
+	if (memblock_reserve(efi.tpm_log, tbl_size)) {
+		pr_err("TPM Event Log memblock reserve fails 0x%lx - %x\n",
+		       efi.tpm_log, tbl_size);
+		goto out;
+	}
 
 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
 		pr_info("TPM Final Events table not present\n");
-- 
2.43.0


