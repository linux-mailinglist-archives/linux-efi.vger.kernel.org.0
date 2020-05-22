Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EBD1DEF34
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgEVSaX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 14:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbgEVSaW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 May 2020 14:30:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494DDC061A0E;
        Fri, 22 May 2020 11:30:22 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcCQz-0002l9-2V; Fri, 22 May 2020 20:30:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B327F1C0475;
        Fri, 22 May 2020 20:30:16 +0200 (CEST)
Date:   Fri, 22 May 2020 18:30:16 -0000
From:   "tip-bot2 for Punit Agrawal" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: cper: Add support for printing Firmware Error
 Record Reference
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512045502.3810339-1-punit1.agrawal@toshiba.co.jp>
References: <20200512045502.3810339-1-punit1.agrawal@toshiba.co.jp>
MIME-Version: 1.0
Message-ID: <159017221661.17951.2040359767337422693.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     3d8c11efd528d56972d44ed0de51c4e11a9a4fa9
Gitweb:        https://git.kernel.org/tip/3d8c11efd528d56972d44ed0de51c4e11a9a4fa9
Author:        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
AuthorDate:    Tue, 12 May 2020 13:55:02 +09:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 14 May 2020 11:11:20 +02:00

efi: cper: Add support for printing Firmware Error Record Reference

While debugging a boot failure, the following unknown error record was
seen in the boot logs.

    <...>
    BERT: Error records from previous boot:
    [Hardware Error]: event severity: fatal
    [Hardware Error]:  Error 0, type: fatal
    [Hardware Error]:   section type: unknown, 81212a96-09ed-4996-9471-8d729c8e69ed
    [Hardware Error]:   section length: 0x290
    [Hardware Error]:   00000000: 00000001 00000000 00000000 00020002  ................
    [Hardware Error]:   00000010: 00020002 0000001f 00000320 00000000  ........ .......
    [Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
    [Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
    <...>

On further investigation, it was found that the error record with
UUID (81212a96-09ed-4996-9471-8d729c8e69ed) has been defined in the
UEFI Specification at least since v2.4 and has recently had additional
fields defined in v2.7 Section N.2.10 Firmware Error Record Reference.

Add support for parsing and printing the defined fields to give users
a chance to figure out what went wrong.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: James Morse <james.morse@arm.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20200512045502.3810339-1-punit1.agrawal@toshiba.co.jp
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/cper.c | 62 ++++++++++++++++++++++++++++++++++++-
 include/linux/cper.h        |  9 +++++-
 2 files changed, 71 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 9d25129..f564e15 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -407,6 +407,58 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 	}
 }
 
+static const char * const fw_err_rec_type_strs[] = {
+	"IPF SAL Error Record",
+	"SOC Firmware Error Record Type1 (Legacy CrashLog Support)",
+	"SOC Firmware Error Record Type2",
+};
+
+static void cper_print_fw_err(const char *pfx,
+			      struct acpi_hest_generic_data *gdata,
+			      const struct cper_sec_fw_err_rec_ref *fw_err)
+{
+	void *buf = acpi_hest_get_payload(gdata);
+	u32 offset, length = gdata->error_data_length;
+
+	printk("%s""Firmware Error Record Type: %s\n", pfx,
+	       fw_err->record_type < ARRAY_SIZE(fw_err_rec_type_strs) ?
+	       fw_err_rec_type_strs[fw_err->record_type] : "unknown");
+	printk("%s""Revision: %d\n", pfx, fw_err->revision);
+
+	/* Record Type based on UEFI 2.7 */
+	if (fw_err->revision == 0) {
+		printk("%s""Record Identifier: %08llx\n", pfx,
+		       fw_err->record_identifier);
+	} else if (fw_err->revision == 2) {
+		printk("%s""Record Identifier: %pUl\n", pfx,
+		       &fw_err->record_identifier_guid);
+	}
+
+	/*
+	 * The FW error record may contain trailing data beyond the
+	 * structure defined by the specification. As the fields
+	 * defined (and hence the offset of any trailing data) vary
+	 * with the revision, set the offset to account for this
+	 * variation.
+	 */
+	if (fw_err->revision == 0) {
+		/* record_identifier_guid not defined */
+		offset = offsetof(struct cper_sec_fw_err_rec_ref,
+				  record_identifier_guid);
+	} else if (fw_err->revision == 1) {
+		/* record_identifier not defined */
+		offset = offsetof(struct cper_sec_fw_err_rec_ref,
+				  record_identifier);
+	} else {
+		offset = sizeof(*fw_err);
+	}
+
+	buf += offset;
+	length -= offset;
+
+	print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, buf, length, true);
+}
+
 static void cper_print_tstamp(const char *pfx,
 				   struct acpi_hest_generic_data_v300 *gdata)
 {
@@ -494,6 +546,16 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		else
 			goto err_section_too_small;
 #endif
+	} else if (guid_equal(sec_type, &CPER_SEC_FW_ERR_REC_REF)) {
+		struct cper_sec_fw_err_rec_ref *fw_err = acpi_hest_get_payload(gdata);
+
+		printk("%ssection_type: Firmware Error Record Reference\n",
+		       newpfx);
+		/* The minimal FW Error Record contains 16 bytes */
+		if (gdata->error_data_length >= SZ_16)
+			cper_print_fw_err(newpfx, gdata, fw_err);
+		else
+			goto err_section_too_small;
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
 
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 4f005d9..8537e92 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -521,6 +521,15 @@ struct cper_sec_pcie {
 	u8	aer_info[96];
 };
 
+/* Firmware Error Record Reference, UEFI v2.7 sec N.2.10  */
+struct cper_sec_fw_err_rec_ref {
+	u8 record_type;
+	u8 revision;
+	u8 reserved[6];
+	u64 record_identifier;
+	guid_t record_identifier_guid;
+};
+
 /* Reset to default packing */
 #pragma pack()
 
