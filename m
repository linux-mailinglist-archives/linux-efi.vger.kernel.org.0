Return-Path: <linux-efi+bounces-5334-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CB9C2BB01
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 13:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5501718959DB
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291730CDBD;
	Mon,  3 Nov 2025 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBini41k"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DD2FC010
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173229; cv=none; b=IYgqbhpyn+8R3sixbS/A4E/3Q2zm5MF9Y5NhxzFE8Rb3pGLntb3i+5f1kz9Ks6nhbYKH8HENcez+pW8J5zW+qzmTGsaMUuYYQUmJJim9n8usED7gZj/0oeHOFjt/+ZWZYl1Fpel1MQUd1gTxY6do+rJWoWtHpIMxOZ0gtJP+ypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173229; c=relaxed/simple;
	bh=ghhidARFtfJugeCzCLtclN3YKp1i6H9G6hYai1TD4Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+Ibn3zKfzFA14MI9LJaH5EVz3tLJGmIMbIRIyDp3mkRvSDVqdnADxKnGQe+2c57oKcr1g04GXy36tYFiDFffJoCI1Gdj8woiwLBKAtJyHZI5q+xoNM/r1mIuRGzo+S2odn0Inm6zGaiT5fZ05wMg756ir/sXysRRPm0mBV2n5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBini41k; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-429bcddad32so2330243f8f.3
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 04:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762173225; x=1762778025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jwjU3G+SlHqEQOLDInlGvFRjuKuVcl3NjbYL1KLyrdk=;
        b=QBini41k048D6HXSU+5w1dC87BT5zFry+1MIOSgcuJLirxaeJLSAtHl966Gro7FzRf
         ALWmUB1kjm6QULdsHwn4HsWPyEiZQD1Z0TqGiqLnw5u4+9CDYRnyp349C2Ds7ripC7ZB
         Jj8cokWXjZwnYo0IFZ+s/1Ty0dmktX7WZwj4pttlP3bXXogvvzYaewV+hlGytAnpJSMT
         yp3DZ079o0hKef1SIiokvZt/u8tcyAdITPqR3EOXNd7itbAsmhB8bIVNV4YF2riUi2OE
         LL6OLd8hIqHRl8zjRbM2z4MJO5UkJAPmM7nfSwXC/vSBDASQ8FHm+toa7L11YDVKLvH8
         x6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173225; x=1762778025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwjU3G+SlHqEQOLDInlGvFRjuKuVcl3NjbYL1KLyrdk=;
        b=SL4/Ou12GTh5Wd+H5BIF5OaMmUldf6zRbEfPjQZHyT5/UJuRBI5i7RqxvhJYXGApqT
         nMHscU8Lsqjq/+JnegdDTFRw1UmI7idMfKGApjIrlUoUW4DXTPMn9RSPf0E8yPko7gym
         vD/I6aQcmlyDE0s8Xpwc8voqJlk2sPk7RITSRmTu5DoyXrO2yT3sJmrheAVAglS4SCav
         J+j3mwv9hCjxlxjTJCJtJBEsQyNyLn6aA8whxNdHK0Nn4itMsOa1j2HIVtgd//lbV1pW
         AZzz3TJK7T+ACb6bHt6UXNgyBl6Ix34ncmAVlvk3zIL7O1Ax4tyLwWMBTPesJVGC9zZ+
         bS0w==
X-Gm-Message-State: AOJu0YwkPOiVqTUBjDptQ+26B5nxtufZAp0ERLnifYjvp0WJGdtky3SH
	BRaiiLXZQ5v/Gz4PlQjS7ondWrw01ch3HRti/benAWxhEJZIkT0gFwbB
X-Gm-Gg: ASbGncvfx4KQsNgMnISXWlPNsmIWt5qDykIEBqZ5u5nwthrnwcZWyZVyVAbPK0r6rkK
	BQiVrxT311miWp8DOp2vgfOE9PUun9MP2f8BeV0RhLg/foiMOlpHPs1GkB6e5y3hC9U2Kk1Kz7i
	yKpe69QCZsYUfhigW4rcdZks2f4A4olVxMP0JV1FcRj3Zp+uMKDN08hAEEHR8wUAiM/ZzvNxgn0
	LGIpHOCgIue+6UXi2TpwIw5ggMPbQUuGmwzAegtu7y331zoBlMRflsIEb5iJI+Rz1Lr0wU4OonW
	GTX06O9pKhNp0Gv8q3JY3nqMJvj9kmMwAGAnB7P361k7LDj31YHr4KgV0lNEKg+p0cmOY9BRYFU
	iQwZZiy1AAmIHuDR5FtMH7w1OmyMAY4TR5rmIrFm6egEO00wyAngj90/ptmm9UIh/D/K9/6vFsA
	WaFgxSGzyyR9ZLs06ppH1lYCRd9xpeI3oXxP6kopD1O4rGcovA5fUbZ6CyBzR94XVzNwwxvO+eB
	Z4=
X-Google-Smtp-Source: AGHT+IEwV7DamHH8yuNQtr/2Vcl0mNBkIWyq3ZNNbW0+a4hs/HLsXuOao7LPKAznJr3kDLofhaikAA==
X-Received: by 2002:a05:6000:2f88:b0:429:bb53:c8f4 with SMTP id ffacd0b85a97d-429bd6a4bd3mr8480044f8f.34.1762173225005;
        Mon, 03 Nov 2025 04:33:45 -0800 (PST)
Received: from workstation.vpn.francesco.cc (ip7-114-231-195.pool-bba.aruba.it. [195.231.114.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f32edsm19673346f8f.41.2025.11.03.04.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:33:44 -0800 (PST)
From: Francesco Pompo <francescopompo2@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Pompo <francescopompo2@gmail.com>
Subject: [PATCH v2] efistub/x86: Add fallback for SMBIOS record lookup
Date: Mon,  3 Nov 2025 13:25:39 +0100
Message-ID: <20251103123335.1089483-1-francescopompo2@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Apple EFI firmwares do not provide the SMBIOS Protocol,
causing efi_get_smbios_record() to fail. This prevents retrieval of
system information such as product name, which is needed by
apple_set_os() to enable the integrated GPU on dual-graphics Intel
MacBooks.

Add a fallback that directly parses the SMBIOS entry point table when
the protocol is unavailable.

Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 107 +++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f8e465da344d..13059412fdb9 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -225,6 +225,110 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
+struct smbios_entry_point {
+	char anchor[4];
+	u8 ep_checksum;
+	u8 ep_length;
+	u8 major_version;
+	u8 minor_version;
+	u16 max_size_entry;
+	u8 ep_rev;
+	u8 reserved[5];
+	char int_anchor[5];
+	u8 int_checksum;
+	u16 st_length;
+	u32 st_address;
+	u16 number_of_entries;
+	u8 bcd_rev;
+};
+
+static bool verify_ep_checksum(const struct smbios_entry_point *ep)
+{
+	const u8 *ptr = (u8 *)ep;
+	u8 sum = 0;
+	int i;
+
+	for (i = 0; i < ep->ep_length; i++)
+		sum += ptr[i];
+
+	return sum == 0;
+}
+
+static bool verify_ep_int_checksum(const struct smbios_entry_point *ep)
+{
+	const u8 *ptr = (u8 *)&ep->int_anchor;
+	u8 sum = 0;
+	int i;
+
+	for (i = 0; i < 15; i++)
+		sum += ptr[i];
+
+	return sum == 0;
+}
+
+static bool verify_ep_integrity(const struct smbios_entry_point *ep)
+{
+	if (memcmp(ep->anchor, "_SM_", sizeof(ep->anchor)) != 0)
+		return false;
+
+	if (memcmp(ep->int_anchor, "_DMI_", sizeof(ep->int_anchor)) != 0)
+		return false;
+
+	if (!verify_ep_checksum(ep) || !verify_ep_int_checksum(ep))
+		return false;
+
+	return true;
+}
+
+static const struct efi_smbios_record *search_record(void *table, u32 length,
+						     u8 type)
+{
+	const u8 *p, *end;
+
+	p = (u8 *)table;
+	end = p + length;
+
+	while (p + sizeof(struct efi_smbios_record) < end) {
+		const struct efi_smbios_record *hdr =
+			(struct efi_smbios_record *)p;
+		const u8 *next;
+
+		if (hdr->type == type)
+			return hdr;
+
+		/* Type 127 = End-of-Table */
+		if (hdr->type == 0x7F)
+			return NULL;
+
+		/* Jumping to the unformed section */
+		next = p + hdr->length;
+
+		/* Unformed section ends with 0000h */
+		while ((next[0] != 0 || next[1] != 0) && next + 1 < end)
+			next++;
+
+		next += 2;
+		p = next;
+	}
+
+	return NULL;
+}
+
+static const struct efi_smbios_record *get_table_record(u8 type)
+{
+	const struct smbios_entry_point *ep;
+
+	ep = get_efi_config_table(SMBIOS_TABLE_GUID);
+	if (!ep)
+		return NULL;
+
+	if (!verify_ep_integrity(ep))
+		return NULL;
+
+	return search_record((void *)(unsigned long)ep->st_address,
+		ep->st_length, type);
+}
+
 static bool apple_match_product_name(void)
 {
 	static const char type1_product_matches[][15] = {
@@ -240,7 +344,8 @@ static bool apple_match_product_name(void)
 	const struct efi_smbios_type1_record *record;
 	const u8 *product;
 
-	record = (struct efi_smbios_type1_record *)efi_get_smbios_record(1);
+	record = (struct efi_smbios_type1_record *)(efi_get_smbios_record(1) ?:
+		get_table_record(1));
 	if (!record)
 		return false;
 
-- 
2.50.1


