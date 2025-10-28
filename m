Return-Path: <linux-efi+bounces-5192-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD47EC14479
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 12:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A3CD50487A
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01F3074A6;
	Tue, 28 Oct 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh67uUSF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868D304975
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649058; cv=none; b=qUcbFMbTEJPBGQCOkJmHXsjwsYe6ncPRnPwgDHHGM033CrCNAk4j0gfKaN87+YKEA5JJyk7NSNxl0SL1xKDFz5OvlNos3OGxCOYHtuwVRe6X6DfRUeo1Jq+uDOhUh5JP30ALxppGWMYqy+PK4a7pTixMk7/I0xILmV2b/IIOpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649058; c=relaxed/simple;
	bh=EjZ623Y3caca5aec4q+HisSzkk9SYD6YdSbXcfO0xg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Niln3whzJzF9xmevFCFVX0VE0CvROURCaA760ghuFdiDMEqQ7AAXvAQNN9jK07HSRKH7/UrfBQnlYHU14yTr62G/WPiwAPIoses5WFWDvtkI939pGv9ZVNIHvjCfHAdEb5fUUbid8aTNZiyjy2crcDx8aorpwTe9vjoQ+podICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh67uUSF; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e255e9a20so6240685d50.0
        for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761649055; x=1762253855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKta5OIG3kDaKtHvMDVs9SJXcGqlkjKl/2SGt4edO/g=;
        b=Rh67uUSF6yUOSRAsHSRc/6i0MBwxfYRAEWJM51yln+IKQ6DuMXTzhLRhWMT2KPqRnG
         BSYbPUXmaic30e/UkPAN/YnF0nN6dWFZchnBhuhUuU+6g4D1M3kL8SUkWvJSmNgg3Xb7
         Xn4dMpqg36FrjcmHeTMsXYEI9mgagSEQFsjS0gND02E9cELq9Ner6HMox0sTCJ6rl/nA
         jsYjqIWyhDlhkkV09s5UIG1UskkEIDyQTpVos/f3RRCzqOuwOSFv+6/IrYs/OeyO75Ql
         jc5xKy+ZxMhH7ZRIh74X/LbX35AjMYEKOsqECxFoLgZML0feou2GyDfxNe0TDM/PjoX+
         7M8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761649055; x=1762253855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKta5OIG3kDaKtHvMDVs9SJXcGqlkjKl/2SGt4edO/g=;
        b=cy5auQElY24PO0y8fYxCTjWcPw3/wsi9yUe4LyCgi/XtwqrAqFnE1wM1uBcpTO4ylX
         9nsLuFJe+67gOBMHZcVc0tA/o/WqQa36P7FTvuJ3aBAdq8K5mwUe6vkTpSGfYGCC29VD
         uUArO+CYkcuvSyQyEtNgT36FLbdODI/ncgRkqGhFfwxFNnL+Ygb4/FWiSHa76YkQJX+3
         7V9BNsZt4/gxAF247BROW3/UbH8o/MACwezX8+/lK71izF7ZWTP6vqxK59J1PbPSAH4/
         Osaf7/I1JGqRJTu0ANrvpdYaYrGrkLn2ud8399SLLmqWZb7X8Oh2Sdi8bJuX1Pv3cqsv
         u3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVyfwKo2vXqUoIUpg3MXCsgv7bBjY2RLqYg0FS4Ykb6ePDz74FlxC2clDQzj0z2n1vLhXPmIN5q9Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgHhbrqJ8HHbC60frsJ9EuE4p98ESr3Szq4OsLm07A09Ix4L+
	pIk0WjNEKfqQqi8LIq3xfH+xsxtaKIxFvOLEk+QJnpIsh6Sk3g2mp0oJ
X-Gm-Gg: ASbGncvyhWAdE9m5G6Ht268cAHySs/yE6CXNRqHmRISDDop6FnKiAoJZOME4SzfqDcZ
	InHZivdrAW7avNh5tEjwz5d4sa/MMYtFydfh6MkNPeCT8ZCFartzlZ9eamTNBIyiGqtSx/zXPOe
	y38eGqqJoh/mwcA4rNkJOb0Z4pDYX2kVIcyXMuOWZ5nYSCx3GAKmwKCQ3hqj7G4KbGyqDQULvM7
	C6And0/HUuAuNwBpK4fdacQPori3BTy6RfhcJlgEX4XX9qOWp69GTazoaxnK6PAftKc1qWF8G9A
	zZz6KtZYWs6j2Fx+mGAvuc7rVoNWcXw9LbXb80Q9nmlFB1nMZrh32Jg5X4NNWWLpMGix4MmCL91
	1qUm3OZCpSiCA8lCqyq6g+3RJ/uINLoF7JmgazbldGYrhGw2dEv9kuAvRNh6hjdiRzit/ex21Bf
	20QvVl8uop
X-Google-Smtp-Source: AGHT+IGQvUSHbn6/MJOvJ8swj31M4eBdE1W+SDgBok+Y6BScwqg28GcVuucyOJcpszsAmA8W5cbT7w==
X-Received: by 2002:a05:690e:160a:b0:63e:28ae:97a8 with SMTP id 956f58d0204a3-63f6ba5fe3dmr2173155d50.45.1761649053935;
        Tue, 28 Oct 2025 03:57:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c45491fsm3107939d50.23.2025.10.28.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:57:33 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: dwmw@amazon.co.uk,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	hpa@zytor.com
Cc: x86@kernel.org,
	apopple@nvidia.com,
	thuth@redhat.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: [PATCH v2 1/2] x86/boot: Fix page table access in 5-level to 4-level paging transition
Date: Tue, 28 Oct 2025 10:55:56 +0000
Message-ID: <20251028105637.769470-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028105637.769470-1-usamaarif642@gmail.com>
References: <20251028105637.769470-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transitioning from 5-level to 4-level paging, the existing code
incorrectly accesses page table entries by directly dereferencing CR3
and applying PAGE_MASK. This approach has several issues:

- __native_read_cr3() returns the raw CR3 register value, which on
  x86_64 includes not just the physical address but also flags. Bits
  above the physical address width of the system i.e. above
  __PHYSICAL_MASK_SHIFT) are also not masked.
- The PGD entry is masked by PAGE_SIZE which doesn't take into account
  the higher bits such as _PAGE_BIT_NOPTISHADOW.

Replace this with proper accessor functions:
- native_read_cr3_pa(): Uses CR3_ADDR_MASK properly clearing SME encryption
  bit and extracting only the physical address portion.
- mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
  flags above physical address (_PAGE_BIT_NOPTISHADOW in particular).

Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")
Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
---
 arch/x86/boot/compressed/pgtable_64.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index bdd26050dff77..f812b81a538c2 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -3,6 +3,7 @@
 #include <asm/bootparam.h>
 #include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
+#include <asm/pgtable.h>
 #include <asm/processor.h>
 #include "../string.h"
 #include "efi.h"
@@ -168,9 +169,10 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
 		 */
-		*trampoline_32bit = __native_read_cr3() | _PAGE_TABLE_NOENC;
+		*trampoline_32bit = native_read_cr3_pa() | _PAGE_TABLE_NOENC;
 	} else {
-		unsigned long src;
+		u64 *new_cr3;
+		pgd_t *pgdp;
 
 		/*
 		 * For 5- to 4-level paging transition, copy page table pointed
@@ -180,8 +182,9 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * We cannot just point to the page table from trampoline as it
 		 * may be above 4G.
 		 */
-		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
-		memcpy(trampoline_32bit, (void *)src, PAGE_SIZE);
+		pgdp = (pgd_t *)native_read_cr3_pa();
+		new_cr3 = (u64 *)(pgd_val(pgdp[0]) & PTE_PFN_MASK);
+		memcpy(trampoline_32bit, new_cr3, PAGE_SIZE);
 	}
 
 	toggle_la57(trampoline_32bit);
-- 
2.47.3


