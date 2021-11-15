Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE24507EE
	for <lists+linux-efi@lfdr.de>; Mon, 15 Nov 2021 16:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhKOPNx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 10:13:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:19287 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236354AbhKOPNK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Nov 2021 10:13:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233400355"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233400355"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 07:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="644860964"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.186])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2021 07:09:56 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v10 1/4] efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and corresponding structures
Date:   Mon, 15 Nov 2021 23:09:00 +0800
Message-Id: <92ac1df6f6498fad0dd47a150e85b82646188818.1636987638.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1636987638.git.yu.c.chen@intel.com>
References: <cover.1636987638.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Platform Firmware Runtime Update image starts with UEFI headers, and the
headers are defined in UEFI specification, but some of them have not been
defined in the kernel yet.

For example, the header layout of a capsule file looks like this:

EFI_CAPSULE_HEADER
EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER
EFI_FIRMWARE_IMAGE_AUTHENTICATION

These structures would be used by the Platform Firmware Runtime Update
driver to parse the format of capsule file to verify if the corresponding
version number is valid. The EFI_CAPSULE_HEADER has been defined in the
kernel, however the rest are not, thus introduce corresponding UEFI
structures accordingly. Besides, EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
and EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER are required to be packed
in the uefi specification. Ard has pointed out that, the __packed
attribute does indicate to the compiler that the entire thing can appear
misaligned in memory. So if one follows the other in the capsule header,
the __packed attribute may be appropriate to ensure that the second one
is not accessed using misaligned loads and stores.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v10:No change since v9.
v9: No change since v8.
v8: Use efi_guid_t instead of guid_t. (Andy Shevchenko)
v7: Use __packed instead of pragma pack(1). (Greg Kroah-Hartman, Ard Biesheuve)
v6: No change since v5.
v5: No change since v4.
v4: Revise the commit log to make it more clear. (Rafael J. Wysocki)
---
 include/linux/efi.h | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index dbd39b20e034..ac526af84394 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -148,6 +148,52 @@ typedef struct {
 	u32 imagesize;
 } efi_capsule_header_t;
 
+/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER */
+struct efi_manage_capsule_header {
+	u32 ver;
+	u16 emb_drv_cnt;
+	u16 payload_cnt;
+	/*
+	 * Variable array indicated by number of
+	 * (emb_drv_cnt + payload_cnt)
+	 */
+	u64 offset_list[];
+} __packed;
+
+/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER */
+struct efi_manage_capsule_image_header {
+	u32 ver;
+	efi_guid_t image_type_id;
+	u8 image_index;
+	u8 reserved_bytes[3];
+	u32 image_size;
+	u32 vendor_code_size;
+	/* ver = 2. */
+	u64 hw_ins;
+	/* ver = v3. */
+	u64 capsule_support;
+} __packed;
+
+/* WIN_CERTIFICATE */
+struct win_cert {
+	u32 len;
+	u16 rev;
+	u16 cert_type;
+};
+
+/* WIN_CERTIFICATE_UEFI_GUID */
+struct win_cert_uefi_guid {
+	struct win_cert	hdr;
+	efi_guid_t cert_type;
+	u8 cert_data[];
+};
+
+/* EFI_FIRMWARE_IMAGE_AUTHENTICATIO */
+struct efi_image_auth {
+	u64 mon_count;
+	struct win_cert_uefi_guid auth_info;
+};
+
 /*
  * EFI capsule flags
  */
-- 
2.25.1

