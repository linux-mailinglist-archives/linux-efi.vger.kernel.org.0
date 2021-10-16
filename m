Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4201430204
	for <lists+linux-efi@lfdr.de>; Sat, 16 Oct 2021 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243973AbhJPK2s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Oct 2021 06:28:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:60930 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236697AbhJPK2s (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 16 Oct 2021 06:28:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="251490521"
X-IronPort-AV: E=Sophos;i="5.85,378,1624345200"; 
   d="scan'208";a="251490521"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 03:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,378,1624345200"; 
   d="scan'208";a="488687100"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2021 03:26:36 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-efi@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v4 1/4] efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and corresponding structures
Date:   Sat, 16 Oct 2021 18:31:56 +0800
Message-Id: <2da16256a0b4228f7c35ec839bf0ffde58c287c2.1634310710.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634310710.git.yu.c.chen@intel.com>
References: <cover.1634310710.git.yu.c.chen@intel.com>
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
and EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER need not be aligned and
so the corresponding data types should be packed.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v4: Revise the commit log to better describe the packing.
    (Rafael J. Wysocki)
---
 include/linux/efi.h | 50 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6b5d36babfcc..19ff834e1388 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -148,6 +148,56 @@ typedef struct {
 	u32 imagesize;
 } efi_capsule_header_t;
 
+#pragma pack(1)
+
+/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER */
+typedef struct {
+	u32	ver;
+	u16	emb_drv_cnt;
+	u16	payload_cnt;
+	/*
+	 * Variable array indicated by number of
+	 * (emb_drv_cnt + payload_cnt)
+	 */
+	u64	offset_list[];
+} efi_manage_capsule_header_t;
+
+/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER */
+typedef struct {
+	u32	ver;
+	guid_t	image_type_id;
+	u8	image_index;
+	u8	reserved_bytes[3];
+	u32	image_size;
+	u32	vendor_code_size;
+	/* ver = 2. */
+	u64	hw_ins;
+	/* ver = v3. */
+	u64	capsule_support;
+} efi_manage_capsule_image_header_t;
+
+#pragma pack()
+
+/* WIN_CERTIFICATE */
+typedef struct {
+	u32	len;
+	u16	rev;
+	u16	cert_type;
+} win_cert_t;
+
+/* WIN_CERTIFICATE_UEFI_GUID */
+typedef struct {
+	win_cert_t	hdr;
+	guid_t		cert_type;
+	u8		cert_data[];
+} win_cert_uefi_guid_t;
+
+/* EFI_FIRMWARE_IMAGE_AUTHENTICATIO */
+typedef struct {
+	u64				mon_count;
+	win_cert_uefi_guid_t		auth_info;
+} efi_image_auth_t;
+
 /*
  * EFI capsule flags
  */
-- 
2.25.1

