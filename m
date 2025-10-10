Return-Path: <linux-efi+bounces-5017-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B893ABCC969
	for <lists+linux-efi@lfdr.de>; Fri, 10 Oct 2025 12:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0A2C4EDB82
	for <lists+linux-efi@lfdr.de>; Fri, 10 Oct 2025 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA2284696;
	Fri, 10 Oct 2025 10:44:16 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DE2848BF
	for <linux-efi@vger.kernel.org>; Fri, 10 Oct 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093056; cv=none; b=HdfwVbIX/4YDoZSLbT5wljY9BFxb9mKmKYbZeB0MAmwwNk7Hh9BZTe/oioowXzT2bxkYn+v3O1sDkSqYHbgUFhiBcw3VNZu6IrW49s+OZTk5vt0WIZTyQz+B3BWegbXpha9eHJyE/QlyEeuKFwf2TbyuvJjGbpZeczdNnU0GANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093056; c=relaxed/simple;
	bh=Xv8vfELqxCi0M3JUv12/9oo5sF3vO6GI19h00ESuh1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jBQOUxDjTOuMW7tJs9AkPLMCe8ado8ANycsSqiBS9pBNbpDyTzZpYEZy9iMjOOeDb46SwI9GGNmb7di16Fq9pz360XUXS3B7oOR29n4ZwWDSEoSmv92SK+mzdHfD4AUtZ5gosoNv235NuMSfjzYlj8BUrzvk2/tJiJaH/hcHXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so261613966b.2
        for <linux-efi@vger.kernel.org>; Fri, 10 Oct 2025 03:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760093052; x=1760697852;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hjZQiho0iGA/YlIfjvASm46/AFyTuFHZ48K45pFHug=;
        b=Tf/YGBGDJgcXIUsWwhwNDQrI6I48YmYuN8Z/5YD6SPvD2/4b7NgbO6R5hhNTMFjVTT
         6hOxt+d/skWNicq1GNOhkphEZ5JpOVywcDfiMrse3vUWCSgF4NBZSMSsceqCv20xwb6p
         IDwZGyAwqjH7sjMIaTYHTDXrYkxlfc9pjLWNdZjGaIW/rH9uoeiQXJLDo24rW2pHOR+k
         PK/1LVR9mzAGFT2fskTZtI23hKQ2EqhfCcLVTqk1TLMZr7psMQt4c9Hpe7e089hg3MQ5
         eTg8MTS8aDb8gmxm9swnoaYVYLWZuU33DzJU9cJzCiz1jBjGpNBHt+3fay7I1JVDOm0q
         69sg==
X-Gm-Message-State: AOJu0YzaceRGx8yBkCwsT2PUHat0NM011k+GltncuW2s3KelCQaJXhqn
	CcLu45JAxeL9jgWGdHJki9txwn41pa2jwgnmKbzs08z/OemzcYUDe9f311TRzQ==
X-Gm-Gg: ASbGncuYjDNLChqFUeKlfigVtrMNbsgMXq7LTz8aSRZgJ5uWIQlunlSVLSciI2RXoIA
	0TMEHom3bnNGaJyYBbL3ldEWpv7BM5iC9uFfpyzJq7q9028VZEx3+D2UkJJdWLUxDDNFTZdH09B
	TbL0KX2YV/s6b5Fvah8PDjaaEsnq94NUXdM11Fh4N0Y/B3VJtMjjOZtq6Xc3kVst2yivP9HVZJ4
	Ku0BQcA5cB792GHd8r00otwhR6YT4D68gfog1Vs5Ci9jymplQRE8EEqAJUp3Cq8cZWBdx/BOLrw
	PKMShbhcpIOKzc7N2DRHoTm3vxjY2Esf3VQkE8KXEcKuQ6im/wPwGsqOj4xzMWAth3WOCbQGajP
	GOuzBwtpdcwFRT74AxZOXYcdrPKFeRdQbesgA
X-Google-Smtp-Source: AGHT+IHEr3FgoOnkzJSJ3QXTjdVVTT0W9OMbIhq6GsugiZh5aafP9iMGPMQXEE4tmD+zXgXWqXCs1Q==
X-Received: by 2002:a17:907:3f14:b0:b41:3c27:e3ca with SMTP id a640c23a62f3a-b50aa4909admr1122902966b.7.1760093051867;
        Fri, 10 Oct 2025 03:44:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9525bdesm201931466b.78.2025.10.10.03.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:44:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Oct 2025 03:44:04 -0700
Subject: [PATCH v3] efi/memattr: Convert efi_memattr_init() return type to
 void
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-efi_fw_bug-v3-1-78259db0f39a@debian.org>
X-B4-Tracking: v=1; b=H4sIAHTj6GgC/23MQQ6CMBBA0as0s6ZmpkK1rLyHMaSFKXQDptWqI
 dzdwMKExO1P/pshcQycoBYzRM4hhWmEWhwLAe1gx55l6KAWoFBVSKgl+9D4V+OevVROKza2pLM
 xUAi4R/bhvWHXWyFgCOkxxc9mZ1rrXyaTRIlkz+xKdJ7dpWMX7HiYYg+rk9XvJSTcvUqS1OSUo
 apr+aR377IsXynJKK/hAAAA
X-Change-ID: 20250106-efi_fw_bug-2b62e9a41899
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; i=leitao@debian.org;
 h=from:subject:message-id; bh=Xv8vfELqxCi0M3JUv12/9oo5sF3vO6GI19h00ESuh1U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo6ON6W6e3C/Qe3WoG1ip9wiq+lAK/++yi87Kr+
 y9kz1yoRvaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaOjjegAKCRA1o5Of/Hh3
 bQtSEACdpPEJKfBod/cJDK5qm/LcmMRN9hfEyG2qJHSEvRQ/tsM2RGAdgf74izCo3sPyNcne3zK
 IvzZ6GTwDOuQgHLKA5J9oQc8KBh+gSB3AVNP8mnNekhytbpzfEh62Yfx3gLBpDVUVGQz8WZyRg+
 e9LY32dEjrY/AmoBd9LtgFz04IPwF2Kjs/FbPta1KrEEsRa4HmrXRTMaGQ8n1hlOTbd7FwA3VQf
 p/ap0mpfWXvYKxwZVWnJsV2JdQDsnntebB/mHFuuDvU2jeC0ooG1YGlLgCwim+btY1k2L6nwYJj
 qupDG15x+TbW+e42cnJtvewYpJp4WE6uKBuTn42aWfXlUVLCdFjQEGU4vjm8oVvX9/XcwysePfd
 bWQl0L6guEhVaEq2WNu0++kfjw4v/krQj0RFrJ9ez2VMhMQLF8bzgqyP1vck/fk1GTJVXcSH7XI
 74E7r2Vqabp28EQEl4OkThZQuAjUcFqyhR4s2otISjIlcqrwD+hZitx9v0WMYISRsSCOY5nvJNA
 ivSbRUe3xW3UHrW9u2U23lU21E9LFpkwDwgGbxnEwpYUVAZMvg67unYmcWjIYJ05Wloy0shtKcy
 VrAV3TfUNMNqaXy7dtzBuur59i4tjszJ5NvC43Kn9JD1R4pHaVLNn2OG/HWKtKFTtMIWukGKgha
 qspb2Hn1QkxEfBw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The efi_memattr_init() function's return values (0 and -ENOMEM) are never
checked by callers. Convert the function to return void since the return
status is unused.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20251010-efi_fw_bug-v2-1-61b2915dce76@debian.org

Changes in v2:
- drop the other patches from the previous patchset
- Link to v1: https://lore.kernel.org/r/20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org
---
 drivers/firmware/efi/memattr.c | 7 +++----
 include/linux/efi.h            | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index c38b1a335590d..e727cc5909cb6 100644
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
index a98cc39e7aaa8..0b9eb3d2ff977 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -772,7 +772,7 @@ extern unsigned long efi_mem_attr_table;
  */
 typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *, bool);
 
-extern int efi_memattr_init(void);
+extern void efi_memattr_init(void);
 extern int efi_memattr_apply_permissions(struct mm_struct *mm,
 					 efi_memattr_perm_setter fn);
 

---
base-commit: 18a7e218cfcdca6666e1f7356533e4c988780b57
change-id: 20250106-efi_fw_bug-2b62e9a41899

Best regards,
--  
Breno Leitao <leitao@debian.org>


