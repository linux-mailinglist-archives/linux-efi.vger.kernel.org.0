Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9364A129FAF
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 10:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfLXJ3q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 04:29:46 -0500
Received: from mail.inango-systems.com ([178.238.230.57]:38324 "EHLO
        mail.inango-sw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLXJ3q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Dec 2019 04:29:46 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Dec 2019 04:29:46 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id 69B2A1080783;
        Tue, 24 Dec 2019 11:21:29 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1fxzy3dGzunS; Tue, 24 Dec 2019 11:21:28 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id DE3D9108078E;
        Tue, 24 Dec 2019 11:21:28 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com DE3D9108078E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
        s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1577179288;
        bh=CAmI7apeyL7jZ6co+qwW6zsFPTjggPHOPX6bTaAoTBQ=;
        h=From:To:Date:Message-Id;
        b=jYec26/eP5rkBjgKag80Q62vw95TEj1y+Cs11iTw2xYKxUdpAqnI1mkOqARJm/YFL
         JOwhfcR7m56oX2R0jCchrumekxx2qvoRS/D3Yb2qsKSR+r/AWquos/6GhLVv7xbLT+
         3cbi4gPunzbfWPZTPi3s4UN31yBoWaC9DH5e0PhslvdmNH7EZw7JwQcYO7Pnq+KhQe
         PB6BbYt6+i66zx9XL6vVMxLmzdKR6k4aPwAAvdEGJkAySQfQ1N1HF3GuQYRVw+PVna
         mDN8Et9jKR6+LGkc51+HBgXuHHqW7tCJz8fwyjBPSL5BeHf4C7PKbEmqd0FevXMUuG
         Bl+UamaTZxy9A==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VoL7VamDXbEy; Tue, 24 Dec 2019 11:21:28 +0200 (IST)
Received: from nmerinov.inango.loc (unknown [194.60.247.123])
        by mail.inango-sw.com (Postfix) with ESMTPSA id 22D7B108023C;
        Tue, 24 Dec 2019 11:21:28 +0200 (IST)
From:   Nikolai Merinov <n.merinov@inango-systems.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, Jens Axboe <axboe@kernel.dk>,
        linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nikolai Merinov <n.merinov@inango-systems.com>
Subject: [PATCH v2] partitions/efi: Fix partition name parsing in GUID partition entry
Date:   Tue, 24 Dec 2019 14:21:19 +0500
Message-Id: <20191224092119.4581-1-n.merinov@inango-systems.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181124162123.21300-1-n.merinov@inango-systems.com>
References: <20181124162123.21300-1-n.merinov@inango-systems.com>
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

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index db2fef7dfc47..51287a8a3bea 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -715,7 +715,7 @@ int efi_partition(struct parsed_partitions *state)
 				ARRAY_SIZE(ptes[i].partition_name));
 		info->volname[label_max] = 0;
 		while (label_count < label_max) {
-			u8 c = ptes[i].partition_name[label_count] & 0xff;
+			u8 c = le16_to_cpu(ptes[i].partition_name[label_count]) & 0xff;
 			if (c && !isprint(c))
 				c = '!';
 			info->volname[label_count] = c;
diff --git a/block/partitions/efi.h b/block/partitions/efi.h
index 3e8576157575..0b6d5b7be111 100644
--- a/block/partitions/efi.h
+++ b/block/partitions/efi.h
@@ -88,7 +88,7 @@ typedef struct _gpt_entry {
 	__le64 starting_lba;
 	__le64 ending_lba;
 	gpt_entry_attributes attributes;
-	efi_char16_t partition_name[72 / sizeof (efi_char16_t)];
+	__le16 partition_name[72 / sizeof (__le16)];
 } __packed gpt_entry;
 
 typedef struct _gpt_mbr_record {
-- 
2.17.1

