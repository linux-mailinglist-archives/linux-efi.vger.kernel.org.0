Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443D41D681B
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 14:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgEQM6u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 May 2020 08:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgEQM6t (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 17 May 2020 08:58:49 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94CCE20735;
        Sun, 17 May 2020 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589720328;
        bh=afhSt/ziJwuU2iemGe+CpeKSEPCVYGr/02In/Zx/9tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkK850ZefEI0HYBud2QUR0yxQ9Ifmjd4631b7ko+it0zcxFdqlTOQz9c6hOhi+rL0
         wHxv14ZF1lxvj49dnPqJenY1Eo5rR0zMCasgaduGvzR2CjqfqH+I7KbsmfzgmPxciX
         Ol0KtI6wRno3BCrykZy+tfLXgDVL82zHLC+gobS8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        linux-acpi@vger.kernel.org, Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH 4/7] efi: cper: Add support for printing Firmware Error Record Reference
Date:   Sun, 17 May 2020 14:57:51 +0200
Message-Id: <20200517125754.8934-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517125754.8934-1-ardb@kernel.org>
References: <20200517125754.8934-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

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
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20200512045502.3810339-1-punit1.agrawal@toshiba.co.jp
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
2.17.1

