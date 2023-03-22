Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955366C4D95
	for <lists+linux-efi@lfdr.de>; Wed, 22 Mar 2023 15:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjCVO0f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Mar 2023 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjCVO0f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Mar 2023 10:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D301B53DB9
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 07:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E50A6214D
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 14:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7698FC433D2;
        Wed, 22 Mar 2023 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679495192;
        bh=QfbAXXI8CQI4lKeH2ucjox+6Wzik8ACTtzOT/sXNRwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDbYhSImC9a0nsH65/zc0A6t29bRZd2JJ1KYb21KsafZqdgPSSNurErharQcB6YSW
         UggTESqGQ/Y2qvyEGYZgRGWeHmZBTLXSdy9hf3D2zLUjejiTBEa3NzC88gVc4LTiTS
         YetvKNwf+2ZZrnXRWjxfqfqZn/1vN3RjFodNufZBV4p7zGXa3AnjmAayJaYbBhY7Pi
         3CvjFzClnxUbzsFHyYW5A615QWKbbiAAC3nxltkNyCWehSUIN7gwlZoAQ1oijc46OM
         SOVtJwBvw+o9D6xEJFSNzh7PI9h+hQ2wMvEE2giwzilUlvuyRsbpfoDZpK0x51PCtJ
         +0d2JoI/1Xdpg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH 2/3] arm64: efi: Use SMBIOS processor version to key off Ampere quirk
Date:   Wed, 22 Mar 2023 15:26:20 +0100
Message-Id: <20230322142621.3685058-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322142621.3685058-1-ardb@kernel.org>
References: <20230322142621.3685058-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5710; i=ardb@kernel.org; h=from:subject; bh=QfbAXXI8CQI4lKeH2ucjox+6Wzik8ACTtzOT/sXNRwQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUVagCdgrY3r3Ts7DSeW2V6TPevQrzRXo9msUn8Dgyf/m y/TPfd0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInUVDAyXChS2eH5JH1FPA/H NpY7vE8le+wUFk/a84G/+UKvhcPn6YwMD95V21r/FnpsMGO7z7HX2x+ZPF2XkedsvtXFy7GwcZU pMwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of using the SMBIOS type 1 record 'family' field, which is often
modified by OEMs, use the type 4 'processor ID' and 'processor version'
fields, which are set to a small set of probe-able values on all known
Ampere EFI systems in the field.

Fixes: 550b33cfd4452968 ("arm64: efi: Force the use of ...")
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64.c   | 39 +++++++++++++++----
 drivers/firmware/efi/libstub/efistub.h | 41 ++++++++++++++++++--
 drivers/firmware/efi/libstub/smbios.c  | 13 ++++++-
 3 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
index 3997702663727e30..8aad8c49d43f18e0 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -16,20 +16,43 @@
 
 static bool system_needs_vamap(void)
 {
-	const u8 *type1_family = efi_get_smbios_string(1, family);
+	const struct efi_smbios_type4_record *record;
+	const u32 __aligned(1) *socid;
+	const u8 *version;
 
 	/*
 	 * Ampere eMAG, Altra, and Altra Max machines crash in SetTime() if
-	 * SetVirtualAddressMap() has not been called prior.
+	 * SetVirtualAddressMap() has not been called prior. Most Altra systems
+	 * can be identified by the SMCCC soc ID, which is conveniently exposed
+	 * via the type 4 SMBIOS records. Otherwise, test the processor version
+	 * field. eMAG systems all appear to have the processor version field
+	 * set to "eMAG".
 	 */
-	if (!type1_family || (
-	    strcmp(type1_family, "eMAG") &&
-	    strcmp(type1_family, "Altra") &&
-	    strcmp(type1_family, "Altra Max")))
+	record = (struct efi_smbios_type4_record *)efi_get_smbios_record(4);
+	if (!record)
 		return false;
 
-	efi_warn("Working around broken SetVirtualAddressMap()\n");
-	return true;
+	socid = (u32 *)record->processor_id;
+	switch (*socid & 0xffff000f) {
+		static char const altra[] = "Ampere(TM) Altra(TM) Processor";
+		static char const emag[] = "eMAG";
+
+	default:
+		version = efi_get_smbios_string(&record->header, 4,
+						processor_version);
+		if (!version || (strncmp(version, altra, sizeof(altra) - 1) &&
+				 strncmp(version, emag, sizeof(emag) - 1)))
+			break;
+
+		fallthrough;
+
+	case 0x0a160001:	// Altra
+	case 0x0a160002:	// Altra Max
+		efi_warn("Working around broken SetVirtualAddressMap()\n");
+		return true;
+	}
+
+	return false;
 }
 
 efi_status_t check_platform_features(void)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 6bd3bb86d9679a1c..330565b9263a6b01 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1074,6 +1074,8 @@ struct efi_smbios_record {
 	u16	handle;
 };
 
+const struct efi_smbios_record *efi_get_smbios_record(u8 type);
+
 struct efi_smbios_type1_record {
 	struct efi_smbios_record	header;
 
@@ -1087,14 +1089,47 @@ struct efi_smbios_type1_record {
 	u8				family;
 };
 
-#define efi_get_smbios_string(__type, __name) ({			\
+struct efi_smbios_type4_record {
+	struct efi_smbios_record	header;
+
+	u8				socket;
+	u8				processor_type;
+	u8				processor_family;
+	u8				processor_manufacturer;
+	u8				processor_id[8];
+	u8				processor_version;
+	u8				voltage;
+	u16				external_clock;
+	u16				max_speed;
+	u16				current_speed;
+	u8				status;
+	u8				processor_upgrade;
+	u16				l1_cache_handle;
+	u16				l2_cache_handle;
+	u16				l3_cache_handle;
+	u8				serial_number;
+	u8				asset_tag;
+	u8				part_number;
+	u8				core_count;
+	u8				enabled_core_count;
+	u8				thread_count;
+	u16				processor_characteristics;
+	u16				processor_family2;
+	u16				core_count2;
+	u16				enabled_core_count2;
+	u16				thread_count2;
+	u16				thread_enabled;
+};
+
+#define efi_get_smbios_string(__record, __type, __name) ({		\
 	int size = sizeof(struct efi_smbios_type ## __type ## _record);	\
 	int off = offsetof(struct efi_smbios_type ## __type ## _record,	\
 			   __name);					\
-	__efi_get_smbios_string(__type, off, size);			\
+	__efi_get_smbios_string((__record), __type, off, size);		\
 })
 
-const u8 *__efi_get_smbios_string(u8 type, int offset, int recsize);
+const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
+				  u8 type, int offset, int recsize);
 
 void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 		     unsigned long code_size);
diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
index aadb422b9637dfc0..f9c159c28f4613f8 100644
--- a/drivers/firmware/efi/libstub/smbios.c
+++ b/drivers/firmware/efi/libstub/smbios.c
@@ -22,19 +22,28 @@ struct efi_smbios_protocol {
 	u8 minor_version;
 };
 
-const u8 *__efi_get_smbios_string(u8 type, int offset, int recsize)
+const struct efi_smbios_record *efi_get_smbios_record(u8 type)
 {
 	struct efi_smbios_record *record;
 	efi_smbios_protocol_t *smbios;
 	efi_status_t status;
 	u16 handle = 0xfffe;
-	const u8 *strtable;
 
 	status = efi_bs_call(locate_protocol, &EFI_SMBIOS_PROTOCOL_GUID, NULL,
 			     (void **)&smbios) ?:
 		 efi_call_proto(smbios, get_next, &handle, &type, &record, NULL);
 	if (status != EFI_SUCCESS)
 		return NULL;
+	return record;
+}
+
+const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
+				  u8 type, int offset, int recsize)
+{
+	const u8 *strtable;
+
+	if (!record)
+		return NULL;
 
 	strtable = (u8 *)record + record->length;
 	for (int i = 1; i < ((u8 *)record)[offset]; i++) {
-- 
2.39.2

