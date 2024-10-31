Return-Path: <linux-efi+bounces-2077-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA599B78E6
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BDA1F24DC8
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00451993B9;
	Thu, 31 Oct 2024 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zzREUiqq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2F1993B2
	for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371447; cv=none; b=I6X8pfwkU1EVJYvDxMPgat2J3MeB7VuVf3cyX9pHo2sJj8UULeJbAZVRYyOQbzskd2lbLZulTrLT1UUNqw7wHEYwseBxBuM6GdmFb8lFndT0ixYJZsVHa07p/brMOjTIjSc+YZLFnw5Ftj7YCYo3jnQo6j/K0Ex28w6ZV9AN7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371447; c=relaxed/simple;
	bh=+jdnU8yaC6Ttu85x3D7p+RaWzPhmu87nzbmph0dKCT0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J4kjajtUiYfPLrfMpHfyCNbAWEcVK6i2g8gXk3L0mfoBL268W27ZgcsAKCoPY9i5yopMhYddJZWlRl+5NrXLAI3tp2aOZGgtiD5ZYrlvzp8m/r+zEFJW2Yk0FPV33wt8sl2XA72f9RGbIBuynEoqKjYeC/6PzUTFSvWVSo00Cq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zzREUiqq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea527764c3so18664057b3.0
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2024 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730371444; x=1730976244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Qql+cO7gNh6Zg6CVr4V9xIPeo03B8wrHYOSmlk1J0E=;
        b=zzREUiqqbtc9RCeCzvQ2BLdJjk+nolnTcugN/6D4xJSKGHZBjG6liLi03Zqo7qKhkY
         fWzItt4hQOeiBmOeVESGis0BiABL8Ea3tLEklKbvinfdGX/b16OxziUKHOjPPGRGE/DK
         vkFJWd2L/3S4A7Atx8GFtCOqXqb0qpgCO3gVIvzSKCrtpxpiehu0TAk3Vs/+t17KahPw
         7Cly/v3Jxa3wFppgUmuDbvronZJcc3qZhoOg0YgrLPIAir52CM6s2ekNjk+uULJjlwHQ
         ltOPJCLtq8MY73swHDDa2PBeYGOav4riwiAUaZDCUrmZelm9I+Fza5EAL/+oWXNwvJQH
         jsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371444; x=1730976244;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Qql+cO7gNh6Zg6CVr4V9xIPeo03B8wrHYOSmlk1J0E=;
        b=wWeqjFpe56FUf5rvkONakafiu9Awtq9Fd7w7AbSc07Z7Xa+k+igrZt0QZ/UVFoJzTA
         LHA4c0icR5vzn3MOCqGkFW3czv6Qy7nb0DhX7R0A3+gJSdYPDHw/58q+/j20R+yq6Ue+
         0AicEi5syXxRBYk4W2x6s3tsbgg6NhEosAuFBwzyZKFsfwr6sVD4f9KSoOWD1iCUK4XX
         KJV51eDccbjJVbEN9lxhDnO4D//cLrkbmNQk+4lIbIVmVIEnnQWAUudrXJ9nQkvLPLHQ
         ln0VZHNpLzm5CDbURf+S1vrgIQ6LZpjCaWSTC0LSC8E5GCxXLtQCUIij0niycwWsamE0
         hnqg==
X-Gm-Message-State: AOJu0YzBHoyYxQLgcNm0zzrpooKvFXW+Ri314SngYagaqZp5+7Pkq4Zv
	VbWGU1oD9ADBJN+jQgP+epMS1oGnI2ooZYZaIRhFRmKKUlJA2lcHl2SBwAOJWfsRvvHoy7hSaY6
	dBtWJNStagLS3k7V/R11LXQ2AnU+ikphjcKZPNSza46Q7qp2XPjkruGMDCEUVypnzmHebWaMqD/
	OMQN8wwUvGyraxxbvw79I66mZNJA==
X-Google-Smtp-Source: AGHT+IF7BAKMU7br1kHal9pp0gqUHrEIILb66GgpgSTXqZDiRnZqbY0ecq8R6i7QfmbAlHWy+NgBtORX
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:6901:b0:6e3:b08:92cb with SMTP id
 00721157ae682-6ea3b759216mr1673687b3.0.1730371444213; Thu, 31 Oct 2024
 03:44:04 -0700 (PDT)
Date: Thu, 31 Oct 2024 11:44:00 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2291; i=ardb@kernel.org;
 h=from:subject; bh=hEybNvR5bGgdl/+HX7BWyWKmRyJwvciBr4ZWqAoljK8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV05voCrafc6oyarjTeyM0/M2Ph+rWGTuvKLBx79otxZm
 a0q+R87SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERa4xgZlt5Xlf534fBHqVVn
 J/2TbXwzfXHoCmGHq/NWp7TxKc1zmcrI8EOhIF1npfmk59NTZqrc9hU6Kp7y2aKpd3L7PY7KM3I HmAA=
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031104359.2613133-2-ardb+git@google.com>
Subject: [PATCH] efi/memattr: Ignore table if the size is clearly bogus
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
 drivers/firmware/efi/memattr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index 164203429fa7..d85363d0422a 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -40,6 +40,20 @@ int __init efi_memattr_init(void)
 	}
 
 	tbl_size = sizeof(*tbl) + tbl->num_entries * tbl->desc_size;
+
+	/*
+	 * Sanity check: the Memory Attributes Table contains up to 3 entries
+	 * for each entry of type EfiRuntimeServicesCode in the EFI memory map.
+	 * So if the size of the table exceeds 3x the size of the entire EFI
+	 * memory map, there is clearly something wrong, and the table should
+	 * just be ignored altogether.
+	 */
+	if (tbl_size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
+		pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
+			tbl->version, tbl->desc_size, tbl->num_entries);
+		goto unmap;
+	}
+
 	memblock_reserve(efi_mem_attr_table, tbl_size);
 	set_bit(EFI_MEM_ATTR, &efi.flags);
 
-- 
2.47.0.163.g1226f6d8fa-goog


