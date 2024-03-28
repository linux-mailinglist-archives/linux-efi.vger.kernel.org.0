Return-Path: <linux-efi+bounces-892-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC49689029A
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 16:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9D81F27076
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CF083A00;
	Thu, 28 Mar 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HuYVPnyW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAA7EF1E
	for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638333; cv=none; b=Is16FNttQtmSkoQDqqQ1iG/supOJs/g9KpCU4Q5vRbwyzTe4AR3eohEqSnbI28VAMVG9XQWe2P155v/VzQGMZyRUlV/l7ksGnh/hCdMDjwRIfphliBCILsfiel2BPLubO4NBy83tesfo5Nqu76yxazoFysAWLn7bQs7yYvd4lAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638333; c=relaxed/simple;
	bh=DvVtVkdj/xq9SPMDDWqV0PydJ85/r49KUBHLzmjWpFM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tUUoT75r/HFY1N8qY9Oiaak3W7GzN8wZcHY1SQTYEqcyT/gxdoulwm6DNW4/QCxF655KJN9tOxR53hlqc4B3rthmWPC0BeoKYhOrzEO/nmeNn1do3N1q0sWdwQ7CKXZ7U5+qhrK0EbuQl8w8RYti0hI+TWEo3a3EL0nprs4j+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HuYVPnyW; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33ed5ddd744so473946f8f.3
        for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711638330; x=1712243130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmyU6Yu7TOVivZ+D+Eulo3umiyHrJM2iYAbO8iKOjRU=;
        b=HuYVPnyWiNdzdrAJ7vnssUFkd7g1XfSItNCwNViBDMtbHY/ayMUHVVHbcki8g/jwcP
         5xUaIGo9ttQzds6Gri0KNsbk3xO3gPoVz/kvZSqBrAW9XTb5xSAmtfb6YQrspjBhi9+G
         rHSA+hGRhJXcU6IIZAiSm0n+OPnnpJFcK0ZJYLQp8F9q3fq4mpKs/THxcw8g0Wt2tc4m
         c3mgpk+T7E2iwy77wrJk7ujxnwg4VzWJn2Q5Q2weknWH+BbcezOs+I/iNv5i4/F1+HxE
         c+DTXhYG3/oobV8YGWMabL7YHrfcIELtj9ohV0yrGClb8nbl+FStnv4iLAXIumtVJ6T6
         yugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711638330; x=1712243130;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmyU6Yu7TOVivZ+D+Eulo3umiyHrJM2iYAbO8iKOjRU=;
        b=VOmPLb223/1LrQL4MS0NpieggOXga6BoDDb7WVS2Bxvpt09llZjD8aEYjqSSmfaITy
         9oPy6pqu+aBcRyjDG0kzccBVlesNsL5kNCN18DFksiAxKeTtSi6qIjxGL/MYKi1RDbUd
         SLw9UHRO7aiL6LrYm69qATx7bv1axCd+GgYKsfuAYkLkpoWKXv88i5vMe8sPPoAQHW4b
         vZ15KASYyMXIqAZgv/0h/p79vr8KrnB6BM0nwG0repRRtgMgw3lWclgXi3yfOf5zCFbe
         uudKgzEWN0+xESxI4czSYZGd61EHE3Yy+lYNrcaCwIh18RjWlhh1+D2DeYtXeXhrHTbY
         j9dA==
X-Gm-Message-State: AOJu0YyEPCBXbxnEdp5xAcKGC1zPKODoKfuT2t3RLi4aG1C5lM765ggb
	UNKEQs3Q+Y6Hn0BSREPeBnlbfIqDtCEUASspwkgqxHT1l3DkwOCOxhJMTwnXP/UyR//LgVk2tmM
	tWzk5DyoIMpiWZaUpqWsSV+nvdNVC3YXMd1u+JkROLezWVri2WraVVjWiRIf5wE2thzgEpt0Qg8
	WtpNvamREzpSN3Ds70atWI1Di90Q==
X-Google-Smtp-Source: AGHT+IHeQavSUikChNW3HWA6yHXSdwGP1+pS+iG/BsqefW9XS1E63O6QhSB+Rx7xIOBwQ0pIy9D5+P6V
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:484b:0:b0:33d:7187:3102 with SMTP id
 n11-20020a5d484b000000b0033d71873102mr6600wrs.9.1711638329971; Thu, 28 Mar
 2024 08:05:29 -0700 (PDT)
Date: Thu, 28 Mar 2024 16:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=ardb@kernel.org;
 h=from:subject; bh=ZTMdFQoy1C+mpy8vjsEBBo2nOP7zfUzVYdaGjwTiF4M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY21XXfJxkkuS05/fLcpLXuH846uB3tm6WUyPnkjUx5Sx
 vjjrOzKjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRLhNGhh3yn9Puc8bFPPpR
 b+F72jNpzQr2KZ/tNp7MyUnzmsOac4SR4cOhVSmCO3ZfXn5mtuTHZxG3JJuj70kJFxUH7d543PD NcQYA
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328150517.2584470-2-ardb+git@google.com>
Subject: [PATCH] x86/efistub: Reinstate soft limit for initrd loading
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Radek Podgorny <radek@podgorny.cz>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Commit

  8117961d98fb2 ("x86/efi: Disregard setup header of loaded image")

dropped the memcopy of the image's setup header into the boot_params
struct provided to the core kernel, on the basis that EFI boot does not
need it and should rely only on a single protocol to interface with the
boot chain. It is also a prerequisite for being able to increase the
section alignment to 4k, which is needed to enable memory protections
when running in the boot services.

So only the setup_header fields that matter to the core kernel are
populated explicitly, and everything else is ignored. One thing was
overlooked, though: the initrd_addr_max field in the setup_header is not
used by the core kernel, but it is used by the EFI stub itself when it
loads the initrd, where its default value of INT_MAX is used as the soft
limit for memory allocation.

This means that, in the old situation, the initrd was virtually always
loaded in the lower 2G of memory, but now, due to initrd_addr_max being
0x0, the initrd may end up anywhere in memory. This should not be an
issue principle, as most systems can deal with this fine. However, it
does appear to tickle some problems in older UEFI implementations, where
the memory ends up being corrupted, resulting in errors when unpacking
the initramfs.

So set the initrd_addr_max field to INT_MAX like it was before.

Fixes: 8117961d98fb2 ("x86/efi: Disregard setup header of loaded image")
Reported-by: Radek Podgorny <radek@podgorny.cz>
Closes: https://lore.kernel.org/all/a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 6a6ffc6707bd..d5a8182cf2e1 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -496,6 +496,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->vid_mode	= 0xffff;
 
 	hdr->type_of_loader = 0x21;
+	hdr->initrd_addr_max = INT_MAX;
 
 	/* Convert unicode cmdline to ascii */
 	cmdline_ptr = efi_convert_cmdline(image, &options_size);
-- 
2.44.0.396.g6e790dbe36-goog


