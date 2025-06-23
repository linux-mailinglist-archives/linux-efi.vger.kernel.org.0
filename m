Return-Path: <linux-efi+bounces-3906-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E57AE3833
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 10:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0320E188D017
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F281F4161;
	Mon, 23 Jun 2025 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhWhxhLx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D21D6DA9;
	Mon, 23 Jun 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666664; cv=none; b=dQ104kMBdhwxuiE6hOqfG1lKV0Kf4JQU+USZbh0cMU3uHSAZzwbw4vkN/yCzIc+bk88mPW3jWLnJKdetPWlDD+X2MfMLvJk805a2QCR6sNIJxvXthyFgU4hi4biaPMuM1kEsUefuwQqCUBu7djXrdChRTUWktcmRHrGHZr3Ovhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666664; c=relaxed/simple;
	bh=xABlpFKCI7tvbKgSAmn4BEyY09ekpiP8IizGsmnqo1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJqCO4iM3fHr9x7R15zyLKCCfK+W+BoVEw48rW73ZWRyS7MX2zNWsnBAMdHJAWkudb2ir6zO2zWRajsOztsf48uNQzSDGOCj8btnYBkay47nxbsxkGJQ3CUl92LyIZ77Locl4LxLtBZFNGRyxpUF7oggLyZg1qTAZqSDOtiq2hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhWhxhLx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-609c6afade7so9068137a12.1;
        Mon, 23 Jun 2025 01:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750666661; x=1751271461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0ldZjivV1lpUZD2fqgWNSEgeUozCBiIx7NicXZLPzM=;
        b=XhWhxhLxab+7722d7MeHkcAjXYxvjY16oBS5WBoSJLfhf1iXvflhATc5PXpfb9niUl
         H9k7uANVNaqAy3JRB8aLyyz1pBjhkvjLEaTcccsRDsASGnoZadCE7UUu1fsVsNBeNH1J
         xRSyXdZyQ0tzsIZyIDx096F++x64zJS+RCoKlMMjzNF7VHwrW8ONdGmbebdoyITRwEM7
         j+mToQIdg3MVwi8OJxnso2qrGItoyDg8k/rbdISNHYZ4W+MZciYKVovg371EFaxyUqCm
         x+0i4CE2NFCT6Y88HVYipmhFw0CSM2BTW2PB1cP/OGkskHxyafhfJPRwm9lptx8phFp5
         UMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666661; x=1751271461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0ldZjivV1lpUZD2fqgWNSEgeUozCBiIx7NicXZLPzM=;
        b=giqJElPHuXGX/VCJZKrPDyA9XlZfaIJg/L7/HmieSmTpqIX5vh0mBY/rRWGl6EflPd
         bVQwgNImsBgOYS4w29NERvlLtpb1Y8smcYop7Aacq6Wpj2IyrlU4qtXmvDmHQzfNKqE1
         +wy2gY9W6S/S+Qs0wIWbRYxsHMQJjT80tyAc4KHlx4lGKDAEo+IXrVj5erDFbDSIR/Qy
         CxAurKrTvsj924cRQK5+v5KED0KNyTmWWYm+8KDFy8k8lyHLshbCSY4u91XZ2ktfpjF2
         bknr+z88xirQVsw1lkF5fyg45FOZr1hsZMQ0lt8ggsWGZmNbhNe02z4M7KpxBxKln7WU
         mByg==
X-Forwarded-Encrypted: i=1; AJvYcCWOR6TUebhj8cWTgVdZ3Vv9QUOsL92qEixRGBBWIHQ7TjuCL09AWMRq/xAgmSl3M362lga71ADkWaRYNqaD@vger.kernel.org, AJvYcCWSBSveamSlXkqn2Tpi4dtq5P8ucEAci3xuAHBIhFHFJ3gHhfVEmQNg1EVFAk38QGM13tsM6i7zWYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXd1a34Cvrefihe9iORm6vX9LS4ZVrdCldiac4zxnVKmsoriA+
	561+8v6BSPLw31cJvDCKaEwc9QhwICqRq03M/S5rAjoZMyMaVCt90J9X
X-Gm-Gg: ASbGncslH8GNKTT4i0MKTxFTTb8r2rNMKruxtGLLsq9sTZiA0HXWw/hVWciMQP+a7pV
	KvOrZl3efMsaRDbO3P9zXRXI/y/A6tab4C1rGrKG/U1uFn/0uhSdkK6qpxeqaz+ZEsXFBCCbzak
	Ki5r9bVtx6U7QDL/avSINgCKHXW/tqjiPlepRExu6JaEJUJb1vao6UDt1MnxUlSk4Jx2akpvHn+
	8vq6JfKiT79/DWGBMyvukT2f2fRngkOyaGj3p1OwArIOxgTlnE8ZMUK8ts/2o0/C0C+gKFh9EaO
	zFZqoIvUnhfpm2lQEDOvMM7m/TUy6HW1RClCSxj/2I+gkXcNdTW6WX+UR8sGqJ17kDpexciSe+Z
	v
X-Google-Smtp-Source: AGHT+IGygq4BgBIH/An5jrlMX4bO2TbpXKrBaZx0SApj+U+km9rMpRWoZwUu6E6qBZXhz9adheWngQ==
X-Received: by 2002:a17:907:1c95:b0:ade:44da:d2cf with SMTP id a640c23a62f3a-ae05afc1bacmr1232128866b.18.1750666661183;
        Mon, 23 Jun 2025 01:17:41 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0540833fasm674982766b.103.2025.06.23.01.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 01:17:40 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ubizjak@gmail.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH v1 3/3] efi/efistub: Make libstub to supply boot_param from RDI
Date: Mon, 23 Jun 2025 08:16:39 +0000
Message-ID: <20250623081656.1303-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

This adjusts the libstub to supply argument from RDI instead of RSI.

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 09ed1c122106..9da9b6295b1d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -794,8 +794,8 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
 static void __noreturn enter_kernel(unsigned long kernel_addr,
 				    struct boot_params *boot_params)
 {
-	/* enter decompressed kernel with boot_params pointer in RSI/ESI */
-	asm("jmp *%0"::"r"(kernel_addr), "S"(boot_params));
+	/* enter decompressed kernel with boot_params pointer in RDI/EDI */
+	asm("jmp *%0"::"r"(kernel_addr), "D"(boot_params));
 
 	unreachable();
 }
-- 
2.49.0


