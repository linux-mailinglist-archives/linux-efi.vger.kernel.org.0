Return-Path: <linux-efi+bounces-283-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D6881E7CC
	for <lists+linux-efi@lfdr.de>; Tue, 26 Dec 2023 15:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE4B283047
	for <lists+linux-efi@lfdr.de>; Tue, 26 Dec 2023 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD69C4EB50;
	Tue, 26 Dec 2023 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3lzIHBF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86E4EB42;
	Tue, 26 Dec 2023 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9344f30caso2882226b3a.1;
        Tue, 26 Dec 2023 06:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703599433; x=1704204233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzyK4GUH3epLDlLs9OJt2/hFdq/tOmV0c5ajfbFFe8o=;
        b=Z3lzIHBFGDTmK9pKzmLYirqWcAqXjpxytdcB497cyAJTCbtRcaU7VN9yzQBjHwNjoj
         Z+YXL5j0uCaA18GDEqCYlF0uuEY6a1YyRFf+mxfpV3D2RLEWIA0ZIdwOPXV+g22ZDKGO
         meRkwCWG1u1DzPZRunfrCYk5+ewnWXGaoufz82TXC9mcUs5xdMUjmmw5Jwi+GwKMbthH
         xagN01BHYHQatSXrqTScaVmNIUQtJRwDocK0sJHzidSY3Zt7CnK+2tAo2hPIulpqw8qP
         AVuYG8u60va8P/Rnadnaw0tIY9pE0FS7WVz8qOrgkk9w1vZjO3q+/bj+0q0eWlE3OpMt
         3OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703599433; x=1704204233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzyK4GUH3epLDlLs9OJt2/hFdq/tOmV0c5ajfbFFe8o=;
        b=F97GmOBVkPd3IU2Dhuj88KAJcCP2N8SDLysWIG5Rv29wjZBaA1MbtP1Uopa2p+ENvh
         6KP2NttrWG4NZ6+3L0tA+lOIfBIY6LN6p0FEpw7G2s+e7qYGaMxYYysHzFPTjUN2IbjV
         7oR9EBh0CajRsujpFI0PGxNJl+W9CX9v8iH9W5ENzrZ4Prz/2MIC28ztZdLdL0SrzcDc
         uz6igeXAirhPf4ILMrGFJWr/Ci93ntnyUo+TKadMUcRwp7na/Rl6JqqMNNc9otXaCphm
         pZyp4EkZESFjLca1T6JgeHra36AeUdiPbi8owIKfc452kr9ROQcAPTZ5wqYJzmOLoVcF
         96NA==
X-Gm-Message-State: AOJu0Yx0hLC5FIZ6ZPccjYNvDB9kFHAZEPmVs2gIjKp9f/tmaPEZyOPO
	IsKSjPAitXyQLngDXpAMHvw3sBYXrm/MqQ==
X-Google-Smtp-Source: AGHT+IHq/6l+nK5IA80YfhCQPhmZKKXTKHygRfwkNCWaCT3rMkgHPGk0vldghVLt4id+bkALjfxpKg==
X-Received: by 2002:aa7:85c6:0:b0:6d9:b5cb:d773 with SMTP id z6-20020aa785c6000000b006d9b5cbd773mr4165318pfn.22.1703599433432;
        Tue, 26 Dec 2023 06:03:53 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id g6-20020a63f406000000b005c66e25497dsm9727724pgi.83.2023.12.26.06.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 06:03:53 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Dionna Glaze <dionnaglaze@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/efistub: fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags
Date: Tue, 26 Dec 2023 22:02:50 +0800
Message-ID: <20231226140250.224516-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KASLR is enabled, the KASLR_FLAG bit in boot_params->hdr.loadflags
should be set to 1 to propagate KASLR status from compressed kernel to
kernel, just as the choose_random_location() function does.

Currently, when kernel is booted via efi stub, the KASLR_FLAG bit in
boot_params->hdr.loadflags is not set, even though it should be. This
causes some functions, such as kernel_randomize_memory(), not to execute
as expected. Fix it.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index da9b7b8d0716..b0c68593ad40 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -787,7 +787,10 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 			efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
 			seed[0] = 0;
 		}
-	}
+
+		boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
+	} else
+		boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
 				  seed[0], EFI_LOADER_CODE,
-- 
2.43.0


