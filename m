Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91201CEC35
	for <lists+linux-efi@lfdr.de>; Tue, 12 May 2020 06:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgELEzf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 May 2020 00:55:35 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:48958 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgELEzf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 May 2020 00:55:35 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 04C4tBCB028612; Tue, 12 May 2020 13:55:11 +0900
X-Iguazu-Qid: 34trcFcTSdIJNcGUFe
X-Iguazu-QSIG: v=2; s=0; t=1589259311; q=34trcFcTSdIJNcGUFe; m=lDCzbs4o132H/rv9S8n0JfYb3mfEtVjfQUawIKZ1uaI=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1510) id 04C4t9oB017332;
        Tue, 12 May 2020 13:55:10 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 04C4t9HT029314;
        Tue, 12 May 2020 13:55:09 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 04C4t8Au032254;
        Tue, 12 May 2020 13:55:09 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [Patch v2] efi: cper: Add support for printing Firmware Error Record Reference
Date:   Tue, 12 May 2020 13:55:02 +0900
X-TSB-HOP: ON
Message-Id: <20200512045502.3810339-1-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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
---
Hi Ard,

I've updated the patch based on your feedback.

As you noted, some aspects of the spec make it a bit tricky to support
all revisions in a nice way (e.g., size check) but this version should
fix existing issues.

Thanks,
Punit

v1[0] -> v2:
* Simplified error record structure definition
* Fixed size check
* Added comment to clarify offset calculation for dumped data
* Style fixes for multiline if blocks

[0] https://lkml.kernel.org/lkml/20200427085242.2380614-1-punit1.agrawal@toshiba.co.jp/
---
 drivers/firmware/efi/cper.c | 62 +++++++++++++++++++++++++++++++++++++
 include/linux/cper.h        |  9 ++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 9d2512913d25..f564e15fbc7e 100644
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
index 4f005d95ce88..8537e9282a65 100644
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
 
-- 
2.26.2

