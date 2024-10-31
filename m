Return-Path: <linux-efi+bounces-2081-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F729B81FD
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 18:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DCB2825FC
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEBC1C9B79;
	Thu, 31 Oct 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0/e3gxd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AB1C579D
	for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397513; cv=none; b=cJsajo8cIsLnm3tmOeg/BcgtTYCSg/P6QQNE9wlk0jNjievFJzC6REMZFfA0xcwV9Z+aJkf/NSbRlemZf4krqBs/phs8k6iZdz3aIsjdCScBglMANZoj0I9hjdCr3jRBzMWDYaia6EvW0sTWwMvqUqJya1RoVoeyDpG+vhgSrI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397513; c=relaxed/simple;
	bh=2aqgteoKVeRlFhwVkPOkFEG8a/Qsf/ZMUBb2BG8dvxw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pDoxKasXRZk5YAGy2wXQHG6NCdJN8S2tj6MaBIlPTpCgiQ0li5PPEJT/CDFtTv7xIpe9aRoXqe6geq+3Kbt12nPU+KlAgasw3gfkNa8i5NkZiHDZb5+Bu0gTkULKKkrNNvGPNv8STJMyb1MECQdfCTwioAM2yN99zV0RHwniQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0/e3gxd; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37d4af408dcso519490f8f.0
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2024 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730397509; x=1731002309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=smdlm0xKmZOfDGNgrbbskOB/rjBGJp4BN0iFxzqGzV4=;
        b=f0/e3gxdbJqCjXwR8lO1p8N/Yw72DoDgPiQZAOI+wHrxzZPty3hN1fOCe05qEO6wYG
         aqEbUiL2wDfsl4Za9iQxypgbCTrvByt1PukxhmSJ6RV76ese1lAA5WF/XAuqTwOMLgdY
         U9UL681KvDkfewUydSoLJsiWxzLhCZA5fJ9QR5I0A2p3CW/rH/5rUlPWyx4wWajcmRNr
         ACFSn0/MbBbq9/P2ZiS8X8yKkjQLXgLlTCIK45SDnioOcmsAS4gIlzdM76r67EDmCGo8
         ffyudCRIXlRuk1t6aF1R0jHKtwYsupCh1RuiAPYmsrDOYQdE4gDvQJpIzm4O3fNjeX/L
         7scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397509; x=1731002309;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smdlm0xKmZOfDGNgrbbskOB/rjBGJp4BN0iFxzqGzV4=;
        b=tgm4JGEV/rl91xnqJaN9u0LgsgrHVo/gvi5LuO7b9U68KrhD0hou+4ldmgp+J8WkRK
         VLvRAbQ73Hw2DKE9bEQAHm5pS8Ycwx6b1cJ1x/qiuc6OrdAsg9k9OLv67luVtCF1XSEd
         PnEkFjxzSwUQ4IW5jtIaqY64gClpp7Aci/kcuNaP4DO4BnTNO6Xg8qX8Gymdl4FVDLXC
         4jqpuqK5rJJ4xu3wX8jFvK4HorfHtbU/XNIcR4Mz5I86qkrf4vYa2Jg184qwsbs9UpjB
         OWJVjt5JScAO/kGXS8yb5zP9RSzrbJN8DAJe7ltm/SrKU+Bh7gdk/oG3XfLXf7tWNZXI
         0tmw==
X-Gm-Message-State: AOJu0YzoHDjEWJ8kpgLo3nicDMfCVFtr3eh8AYkNHsK1q87O/qKdWBew
	4t6I0KGUNROH5PDHHSkC5NAac5V9rxGMktAGpgl1xQqPLsIRoCEdLSjb4Ww+reDiWYHhjFekr2e
	aV7fV+gSwma9qlSzqBVXMoBv/JnBGZB4ywbxiz78JVZ3ueCi8Lh79BKZy09rQ/e+oXWxl2jFBNZ
	jHVDcnvPQDp7+eTDO68c/Y/edq7A==
X-Google-Smtp-Source: AGHT+IHkA4yUD7SYL5HvdStKah1q8g7UAoWGRq0OKdv2Q8AGhteIJLiZ1pqH8stAok+8Yjp0M2gJxHOn
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:adf:f9c9:0:b0:37d:49e6:641b with SMTP id
 ffacd0b85a97d-380611245c8mr15196f8f.3.1730397509072; Thu, 31 Oct 2024
 10:58:29 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:58:23 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2788; i=ardb@kernel.org;
 h=from:subject; bh=6BIpjlziRb4U6rRVK+aalyFEhC2tvIAA9gsSumX4pq8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV35qP2ebfu7722IMGkX7S8uvH1dd8nm33YPNrs7+64oV
 7jygOtjRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIIzPDP6sFn/nXvL577dA5
 45lNp481zsl50zL3U+jKa3t1BUx35ssxMux4MmW/c82Uhr7Cxws425peVTB9sznIvOvCDcPYEHb LlcwA
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031175822.2952471-2-ardb+git@google.com>
Subject: [PATCH v2] efi/memattr: Ignore table if the size is clearly bogus
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Usama Arif <usamaarif642@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

There are reports [0] of cases where a corrupt EFI Memory Attributes
Table leads to out of memory issues at boot because the descriptor size
and entry count in the table header are still used to reserve the entire
table in memory, even though the resulting region is gigabytes in size.

Given that the EFI Memory Attributes Table is supposed to carry up to 3
entries for each EfiRuntimeServicesCode region in the EFI memory map,
and given that there is no reason for the descriptor size used in the
table to exceed the one used in the EFI memory map, 3x the size of the
entire EFI memory map is a reasonable upper bound for the size of this
table. This means that sizes exceeding that are highly likely to be
based on corrupted data, and the table should just be ignored instead.

[0] https://bugzilla.suse.com/show_bug.cgi?id=1231465

Cc: Gregory Price <gourry@gourry.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: use unsigned temp variable to avoid signedness issues and to avoid
    assigning tbl_size in case of failure

 drivers/firmware/efi/memattr.c | 20 ++++++++++++++++++--
 1 file changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index 164203429fa7..cbc41935fe6c 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -22,6 +22,7 @@ unsigned long __ro_after_init efi_mem_attr_table = EFI_INVALID_TABLE_ADDR;
 int __init efi_memattr_init(void)
 {
 	efi_memory_attributes_table_t *tbl;
+	unsigned long size;
 
 	if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
 		return 0;
@@ -39,7 +40,22 @@ int __init efi_memattr_init(void)
 		goto unmap;
 	}
 
-	tbl_size = sizeof(*tbl) + tbl->num_entries * tbl->desc_size;
+
+	/*
+	 * Sanity check: the Memory Attributes Table contains up to 3 entries
+	 * for each entry of type EfiRuntimeServicesCode in the EFI memory map.
+	 * So if the size of the table exceeds 3x the size of the entire EFI
+	 * memory map, there is clearly something wrong, and the table should
+	 * just be ignored altogether.
+	 */
+	size = tbl->num_entries * tbl->desc_size;
+	if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
+		pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
+			tbl->version, tbl->desc_size, tbl->num_entries);
+		goto unmap;
+	}
+
+	tbl_size = sizeof(*tbl) + size;
 	memblock_reserve(efi_mem_attr_table, tbl_size);
 	set_bit(EFI_MEM_ATTR, &efi.flags);
 
-- 
2.47.0.163.g1226f6d8fa-goog


