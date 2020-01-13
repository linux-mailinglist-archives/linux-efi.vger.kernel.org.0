Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D45138F01
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 11:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgAMK1d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 05:27:33 -0500
Received: from mail.inango-systems.com ([178.238.230.57]:50846 "EHLO
        mail.inango-sw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgAMK1d (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jan 2020 05:27:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id 54C431080786;
        Mon, 13 Jan 2020 12:27:30 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6RZ3lKHhyPMI; Mon, 13 Jan 2020 12:27:29 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id E19E71080790;
        Mon, 13 Jan 2020 12:27:28 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com E19E71080790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
        s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1578911248;
        bh=THTE1okMxz8IYZP5XaSN31O51fGXzRMX71TEetGqCAs=;
        h=From:To:Date:Message-Id;
        b=bF5v9klEHwgnw8MspBJCle0YY3J0qXaa+Uw1ccqeMsegQTqxIrEN6YgRnDreCXzK2
         RQIjyN2ZlnlV4+tZDVBw4N8Q00i7dsi+24aciLaRHIar/70CNiNUD8gkMvpvaMqJTO
         uUC1mczcRg0Bvc/1PKWw47hu76o3Sq/rDHPUWJQNSPD5w2vB8WQOEyblhIoH2SIm3S
         EeDTo3iQAaC9mfx2VOotVJ7HUsa1Vo7g/hbXdFEvVlWmna4Q9prXXeEBZk60iwz55e
         GkI4a4CcVe7srrFo5+9zOt36fKbsEEZo4DEscGnPUcETd38Pr4d80D2vmLkmD+EcmC
         FyxH55K3mikjA==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kQ81MXoXyOqu; Mon, 13 Jan 2020 12:27:28 +0200 (IST)
Received: from nmerinov.inango.loc (unknown [194.60.247.123])
        by mail.inango-sw.com (Postfix) with ESMTPSA id E1E281080782;
        Mon, 13 Jan 2020 12:27:27 +0200 (IST)
From:   Nikolai Merinov <n.merinov@inango-systems.com>
To:     hch@infradead.org, Davidlohr Bueso <dave@stgolabs.net>,
        Jens Axboe <axboe@kernel.dk>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nikolai Merinov <n.merinov@inango-systems.com>
Subject: [PATCH v3] partitions/efi: Fix partition name parsing in GUID partition entry
Date:   Mon, 13 Jan 2020 15:27:23 +0500
Message-Id: <26f7bd89f212f68b03a4b207e96d8702c9049015.1578910723.git.n.merinov@inango-systems.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108133926.GC4455@infradead.org>
References: <20181124162123.21300-1-n.merinov@inango-systems.com> <20191224092119.4581-1-n.merinov@inango-systems.com> <20200108133926.GC4455@infradead.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

GUID partition entry defined to have a partition name as 36 UTF-16LE
code units. This means that on big-endian platforms ASCII symbols
would be read with 0xXX00 efi_char16_t character code. In order to
correctly extract ASCII characters from a partition name field we
should be converted from 16LE to CPU architecture.

The problem exists on all big endian platforms.

Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
---
 block/partitions/efi.c | 3 ++-
 block/partitions/efi.h | 2 +-
 include/linux/efi.h    | 5 +++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index db2fef7dfc47..f1d0820de844 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -715,7 +715,8 @@ int efi_partition(struct parsed_partitions *state)
 				ARRAY_SIZE(ptes[i].partition_name));
 		info->volname[label_max] = 0;
 		while (label_count < label_max) {
-			u8 c = ptes[i].partition_name[label_count] & 0xff;
+			u8 c = 0xff & efi_char16le_to_cpu(
+					ptes[i].partition_name[label_count]);
 			if (c && !isprint(c))
 				c = '!';
 			info->volname[label_count] = c;
diff --git a/block/partitions/efi.h b/block/partitions/efi.h
index 3e8576157575..4d4cae0bb79e 100644
--- a/block/partitions/efi.h
+++ b/block/partitions/efi.h
@@ -88,7 +88,7 @@ typedef struct _gpt_entry {
 	__le64 starting_lba;
 	__le64 ending_lba;
 	gpt_entry_attributes attributes;
-	efi_char16_t partition_name[72 / sizeof (efi_char16_t)];
+	efi_char16le_t partition_name[72 / sizeof(efi_char16le_t)];
 } __packed gpt_entry;
 
 typedef struct _gpt_mbr_record {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index aa54586db7a5..47882f2d45db 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -45,9 +45,14 @@
 typedef unsigned long efi_status_t;
 typedef u8 efi_bool_t;
 typedef u16 efi_char16_t;		/* UNICODE character */
+typedef __le16 efi_char16le_t;		/* UTF16-LE */
+typedef __be16 efi_char16be_t;		/* UTF16-BE */
 typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
+#define efi_char16le_to_cpu le16_to_cpu
+#define efi_char16be_to_cpu be16_to_cpu
+
 /*
  * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
  * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
-- 
2.17.1

