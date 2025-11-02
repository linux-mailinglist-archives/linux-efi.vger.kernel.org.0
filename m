Return-Path: <linux-efi+bounces-5328-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD3C288DD
	for <lists+linux-efi@lfdr.de>; Sun, 02 Nov 2025 01:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24733B42ED
	for <lists+linux-efi@lfdr.de>; Sun,  2 Nov 2025 00:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AFC2B2D7;
	Sun,  2 Nov 2025 00:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG92NvPY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E31D555
	for <linux-efi@vger.kernel.org>; Sun,  2 Nov 2025 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762042479; cv=none; b=VQkZA/fwBR0vv8OokzcBHNLLgPdZ1KQvveI1ALiwP/bLAL31K3hKFwKiyzKQGpLl877ooAlz9HS3oNhPRbTjbdXvrJNdest1Pm23idyl/440yuVF11nxjCKVRxC5x706qF9W83dJOIMeMvnhk1XVy/Ss+YapUeyl2drS5kibTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762042479; c=relaxed/simple;
	bh=dBYE/kFrRrtwh9HaM37EUzWAIwPdYzW4NGuuKWaBJhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKI1ugMZNpQtMRcFnFEiWp8WEbuji8j/o+wEhGiG3AX+MlzC/OqQKXRFHuD06s/rUtnnyvrTDWE7eKz+3+UQJMFiWjbJoMWuMQrJmV0sXfBa5MCSrRB7FjvckB5HhqCQb5pENdwxANgTfQ+nL9QUOXThJZ6HD7iVh7KfAAntNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XG92NvPY; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477365fbdf9so8119345e9.1
        for <linux-efi@vger.kernel.org>; Sat, 01 Nov 2025 17:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762042475; x=1762647275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFfQeBsZGZDbbOy/a+Al1IQaGC3vET7wQO4QLEX/Bqg=;
        b=XG92NvPYMqzws6+QxTtMGCO0zf/LO3l4TYSIl0f3ILqxU+Veoi88/aacTPOG9RNL0j
         TbG1Y2IG4BcJVgzKsDfYzAARY9feov97ruLv1fkj/CVjttUFHZFp90Ya2vaSDzypf2tQ
         pSCs1S4/WZ6JWj+8XLNpm0m6LCXE8rtOY6Dd60IIPfE3oP0TzDIRSL8adgLbv/uS2m7Z
         B15eiDHXYI7aLx0v+Mnp/ajlZYzX137FVEvr7uzmhstb+P1jKdJ1ncM6uRnKCuKh4Vya
         ZspfovOKHgImmWNWNb9xVdWvUhWHmmJyl/COBHiRKGr532S4S889ieCkxqqWg57F2tJw
         tZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762042475; x=1762647275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFfQeBsZGZDbbOy/a+Al1IQaGC3vET7wQO4QLEX/Bqg=;
        b=keZLWvk7Gh2LYrgp2Y6eHNO1XlND+oi1YcoYW5/9cpV/FGfZLi7lBc4Su+HZ5dsTEB
         L1qFt1W6O02NRAdSSNWJ3M3WvV2TPsFjy7aG+eU5E0jJ60obstUE5mhBpsCzEYKCpmWL
         4bziE5H1+H/qnQTw3Yxb0u8U1UkpPUz3kre2gdlOPfTI4/XHE6mb/kl69eFsMeS8VfqG
         RcTQJbYdRn07n79Wsk2ZENHWuw3if3HysnexqzlQSoG/V/SNtb9vtDVuni8WUWyEMXSY
         hNiz+1AxqUHyTcc1p3XZHhlTgUAK/wuZGU48OJMMaMZcthat62lhGxe06AOkeQhhMDb2
         V6BA==
X-Gm-Message-State: AOJu0Yxz7o+01qMP33lmLBqf7JXxazc032XTfnG3qJ1CENL3rCbRgvOS
	1gKsIKw/K8VaBNd6CFz+V1ntKZX7r5aUU4cHQ4Z5QwJpbs/ICY8ux8FD
X-Gm-Gg: ASbGncs3jalRw1VrDGkY4nDhRJYrUEUJt3t7HWb1qhsQ9/DoTao95norkXO0XkfE3oj
	gPQiTTpTZNYAR4WiAxBAAqlGm9KywmlaKes4V3pyyfhjqUrzp2MZjWeQzhB2rfz0PVhtUR36ImK
	VMTeTwoE4E7R/2S6iGMgTvar/wL0XWybnzISLhOrzzYkmC/IVeh1jEz2ZtGaIz2UCoNP7oLnhGO
	VZz20/W1I9Z10Wpu6qORIfGQfp1OP/DKG+9AdiA02+hFRd+CCbVJgV+HZzvGrQ54RAlLkeBlZwx
	6BmIPDKWWzrB6YPTbwTAmYt2KafVv126WjphN56gNjwkfNbFAGISTtEal00jTHzVelDxM+7FAyS
	3/lLzbINEU+tRPzJYPlezZXcKKH7UgHD17Pl86UxuyXHpSY260syJhNc5uqMIMFRZji4tXg+H1o
	9h8+fWcy5Mfh/Jrkh3u8gIZwndW6GBsdD8W4RJ8kO2N7Wn1PSFwePX5oPdGhsZZGdzm5YI3+8za
	AA=
X-Google-Smtp-Source: AGHT+IHSEZMUW6gmK3lMrd5ceeo3nU4CDwu7p5niWAAW/JHF8Kx5X3UQcUPIKtncIuh08ADLgjfEkQ==
X-Received: by 2002:a05:600c:190e:b0:470:ffd1:782d with SMTP id 5b1f17b1804b1-477305a2591mr75916975e9.6.1762042474968;
        Sat, 01 Nov 2025 17:14:34 -0700 (PDT)
Received: from workstation.vpn.francesco.cc (ip7-114-231-195.pool-bba.aruba.it. [195.231.114.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec2csm71189705e9.11.2025.11.01.17.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 17:14:34 -0700 (PDT)
From: Francesco Pompo <francescopompo2@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Pompo <francescopompo2@gmail.com>
Subject: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
Date: Sun,  2 Nov 2025 01:13:11 +0100
Message-ID: <20251102001411.108385-1-francescopompo2@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some UEFI firmware implementations do not provide the SMBIOS Protocol,
causing efi_get_smbios_record() to fail. This prevents retrieval of
system information such as product name, which is needed by
apple_set_os() to enable the integrated GPU on dual-graphics Intel
MacBooks.

Add a fallback that directly parses the SMBIOS entry point table when
the protocol is unavailable. Log when the fallback is used.

Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
---
 drivers/firmware/efi/libstub/efistub.h | 17 +++++
 drivers/firmware/efi/libstub/smbios.c  | 99 +++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 685098f9626f..68582ce81370 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1151,6 +1151,23 @@ void free_screen_info(struct screen_info *si);
 void efi_cache_sync_image(unsigned long image_base,
 			  unsigned long alloc_size);
 
+struct __packed smbios_entry_point {
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
 struct efi_smbios_record {
 	u8	type;
 	u8	length;
diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
index f31410d7e7e1..21f499035b37 100644
--- a/drivers/firmware/efi/libstub/smbios.c
+++ b/drivers/firmware/efi/libstub/smbios.c
@@ -33,6 +33,93 @@ union efi_smbios_protocol {
 	} mixed_mode;
 };
 
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
 const struct efi_smbios_record *efi_get_smbios_record(u8 type)
 {
 	struct efi_smbios_record *record;
@@ -43,9 +130,15 @@ const struct efi_smbios_record *efi_get_smbios_record(u8 type)
 	status = efi_bs_call(locate_protocol, &EFI_SMBIOS_PROTOCOL_GUID, NULL,
 			     (void **)&smbios) ?:
 		 efi_call_proto(smbios, get_next, &handle, &type, &record, NULL);
-	if (status != EFI_SUCCESS)
-		return NULL;
-	return record;
+	if (status == EFI_SUCCESS)
+		return record;
+
+	efi_info(
+		"Cannot access SMBIOS protocol (status 0x%lx), parsing table directly\n",
+		status
+	);
+
+	return get_table_record(type);
 }
 
 const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
-- 
2.51.0


