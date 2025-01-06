Return-Path: <linux-efi+bounces-2509-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3E2A0301E
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 20:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1419163840
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C701DF745;
	Mon,  6 Jan 2025 19:03:06 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2813775E;
	Mon,  6 Jan 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190186; cv=none; b=YamvmA5lnYBU2bFo5nswVIP0TwZzkTCcsaS1P2KuIE8EN8nEbd/SqhIShB7aOs0a7PQqUQftPF6/SpT9TchlqBHVrLKcwM94ouDbPx8NG2wn0t+NkVGRri/xnbjLMR9xE4piHXvt587dCftqLbpP3TA79eYFMDLNKw1FgfwdC0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190186; c=relaxed/simple;
	bh=1hFbOdAyQ1Rf/EUjbs+J0s/+S7tHE+WNNrA0yz7O9Yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QI//glxFPsHNbmGM/4Z1WI7yuX6HF5U/SBHXAh/Rr1CACOB6WJQaaGXFE3j7TOtibXv5kXiV/cv5H9Zd/h0SSxOtbVMgSKFOvaUwtdcrf8Nl+lCON4yt1seV6K8CsA+CQe+zez/yxEvOo5YvfQyErv2GEqAZzTabhhLxOLAMcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d8c1950da7so14080321a12.3;
        Mon, 06 Jan 2025 11:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736190182; x=1736794982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFUta7O3eGoSELPg3GbEEtx457MSNjK6QkV3l6hmYuo=;
        b=h1l9aAib46L5SXIXHQ9w+ZnFFByrXUgm3AJzHxrQPCH6Po6u0IywUz9UCMj939P+Ao
         D/rRTpEswNmj7wW3Zmpl9AGqbrVOc+XMuFVpJPCTuWtvoKqRW2M+e9A6ZbqdVKCkYnw5
         R/EjHvz8swLm3t0kuI3M4qffKMRtrd2AXslwo3TtvC2U1GB3ARv25hgfhFUWkJzHArMf
         6Fmar5HXTZH/4TRfAVlY7uZayhIemdv/W1cH74PLuc7Hhu4F+xwli1QDMVPidSHXg4qN
         0xhj7BPkwZ5l94PxyiSxkgf9MHIOlIXRDWEGaC10R52wSLjm3CYriFO3BN1TTfNzqXBF
         D2hA==
X-Forwarded-Encrypted: i=1; AJvYcCVfo0qHQ89oK/2ms0RR/2AnkfPo+1RMhEwU0UMpHjSA5T2HIuCydI8VL1WVAGk+se+MtuVYrKCSBYQ=@vger.kernel.org, AJvYcCXmiCElRir/6u8i7CVzFTmX8wZDq5Pq/InPN6GrvECOdeQVRJH9fFJyizTDS/RxmBs9aYNY0LoxGN42BVSk@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlDcp3/QcwWGtwKYpz00aJBhhGTMuiKGio+k2GClUio5kL751
	YxhKroUIb2vvVafY02+Rxmq1rt3gKlciEQD/FSqzmYjfqz9SWWc6
X-Gm-Gg: ASbGncvQq0eae7CeS8h2PvjZSZ31mNnrQPnq1z9fcy+K/e68TkGufQG0uvdPCOeAD1D
	8mGHvjFLt0UNUCcvO/KzaacwSlr/ZHvRn44zuQ45YeRUQN9/stOCR6rz/2oaWxGMRa9KCWW5WCR
	CBuEyVsT6d5DoOOCL02n+jv45R9wWEVkR/eJPT3vptD63j7VCQeYgqaJQbwgHgyq/aZeRQu9+Pv
	atMCNv7yncAc1U9W07zoJ93yeY1AgcqoxOu2R49I9w1aWg=
X-Google-Smtp-Source: AGHT+IE+XIbJ69aMgudvHSBCpUZQ4L1FmQMMDEoQc0G7bmFIAbk+dw2hprAQKQU+eN+6hfKB3OdcjQ==
X-Received: by 2002:a05:6402:430c:b0:5d2:fa65:c5e2 with SMTP id 4fb4d7f45d1cf-5d81de1fd2amr56989550a12.22.1736190182391;
        Mon, 06 Jan 2025 11:03:02 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701abd1sm23290505a12.76.2025.01.06.11.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 11:03:01 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 06 Jan 2025 11:02:50 -0800
Subject: [PATCH 1/3] efi/memattr: Convert efi_memattr_init() return type to
 void
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-efi_fw_bug-v1-1-01a8eb40bfeb@debian.org>
References: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
In-Reply-To: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; i=leitao@debian.org;
 h=from:subject:message-id; bh=1hFbOdAyQ1Rf/EUjbs+J0s/+S7tHE+WNNrA0yz7O9Yw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnfCjiY8XLy7iF+bqCOSZPKiTSz6qUyBBUuXVdV
 f3aAi7QwuSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ3wo4gAKCRA1o5Of/Hh3
 bbLsD/wJT5/SAuVqCFsYBTW5no/3EC6EdYKEtOyRooM4UaiuMjx0G0tRFHlX0k2u3zIZl4lM71z
 4VrfrfOCb74KTFveNv8do6AmkIkopjMTYXf7bAYc+O1PjxEVzzgM+WUETtCI1M2Z1sYY2QzVnlR
 bayJvzoX8w1LDxaXqjk3lJMxQnxDgeemPtMewCsDy90jGPQB9OqJhHiekrOAw9x2nLlsRXbcWIv
 MZo1SssKaVj6SIVEHWzKIi4n/xUuOsxI+w7uZy4eN75p3PvxUhjRcYtX0UKVrzCCRaQyGQkL4yU
 VHd3ApAC/PDLwnip3qjwo01laRUoRqBFxjOxlCW0S8iHss33mJGFMOvZIFEmSdwi8h9fSzhiH/4
 LAs4bGwPUBBlu4oc4DixPeP1GCbOjs9bhnDGAEIli3pdHzbKuw0DMecD5WEIEdOTURIqw1nSoHs
 fxcIpouiJfG8XgaSfofhZ4lyXseyfkx9MSnoPxMvw5KmKzBZqUAeMTJ44a3IqfXlRXtKK0S9jmr
 Bel0L8hUN00Df6usisKmZmburA6mFCOYwoyc442r7TFZIdAC+gnCOqCa/4a0Bks3noUNM8H4Sx4
 7AqYYf9Rkc/IpmG4xRN04bLwMyNxUTV4vmALWlS6TRmwKez96j+AkL9ovFfaaoSX0jKvG/YGjqr
 AaPD/Fpe69rg6gg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The efi_memattr_init() function's return values (0 and -ENOMEM) are never
checked by callers. Convert the function to return void since the return
status is unused.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/memattr.c | 7 +++----
 include/linux/efi.h            | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index c38b1a335590d4f6b75012414a936e66f22dcd9a..e727cc5909cb676c47d787ab0d7754b6fdcb493d 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -19,19 +19,19 @@ unsigned long __ro_after_init efi_mem_attr_table = EFI_INVALID_TABLE_ADDR;
  * Reserve the memory associated with the Memory Attributes configuration
  * table, if it exists.
  */
-int __init efi_memattr_init(void)
+void __init efi_memattr_init(void)
 {
 	efi_memory_attributes_table_t *tbl;
 	unsigned long size;
 
 	if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
-		return 0;
+		return;
 
 	tbl = early_memremap(efi_mem_attr_table, sizeof(*tbl));
 	if (!tbl) {
 		pr_err("Failed to map EFI Memory Attributes table @ 0x%lx\n",
 		       efi_mem_attr_table);
-		return -ENOMEM;
+		return;
 	}
 
 	if (tbl->version > 2) {
@@ -61,7 +61,6 @@ int __init efi_memattr_init(void)
 
 unmap:
 	early_memunmap(tbl, sizeof(*tbl));
-	return 0;
 }
 
 /*
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e5815867aba971a64091bf0ea017d95f21115124..5404939df81bdc870f6ee5d0fb7cbb53394a2304 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -771,7 +771,7 @@ extern unsigned long efi_mem_attr_table;
  */
 typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *, bool);
 
-extern int efi_memattr_init(void);
+extern void efi_memattr_init(void);
 extern int efi_memattr_apply_permissions(struct mm_struct *mm,
 					 efi_memattr_perm_setter fn);
 

-- 
2.43.5


