Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AB547CC1D
	for <lists+linux-efi@lfdr.de>; Wed, 22 Dec 2021 05:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242384AbhLVEbn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Dec 2021 23:31:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:4322 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235909AbhLVEbn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 21 Dec 2021 23:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640147503; x=1671683503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FeU74oApdHZJHNSiDNnwefLFp5MOW/LGdM2nNiqnURc=;
  b=YQF1VThteVUeDcZlN8PdZxLYaPtbqeFRb2rIdUXFMqzO6eauIyMwLK6T
   gN5j117RHoMGYSRqC/pKMN+KLROVoj5YPBn9m3tPxSrCk0nTQm1GdvzTZ
   8RKapLVVzd1KTPj/0TPieVMeLASzSgYI7IcXSdkKa1fO18C2pVci0umlS
   ipy3a6foYlui9eoLVFWkkL+LcAzLi73aFPFAmAj3casc/Lxv7VE+bDin6
   8KKJ+y4YZt+5hc/NovUihepHsey3MdXCVwi4rjqNOCdwfAb2fjd/Sznve
   11/VnePDS7Oo4WZfsR69wK8Zmdo3klHUno+4e/mzaffgYNv6FhhF/SbQp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="221219596"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="221219596"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 20:31:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="617004817"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.186])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2021 20:31:39 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Hongyu Ning <hongyu.ning@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH v13 1/4] efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and corresponding structures
Date:   Wed, 22 Dec 2021 12:31:03 +0800
Message-Id: <75a64f0643521c7518c1a6215da48f00fdaf2783.1640007183.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1640007183.git.yu.c.chen@intel.com>
References: <cover.1640007183.git.yu.c.chen@intel.com>
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
version number is valid. In this way, if the user provides an invalid
capsule image, the kernel could be used as a guard to reject it, without
switching to the Management Mode (which might be costly).

EFI_CAPSULE_HEADER has been defined in the kernel, but the other
structures have not been defined yet, so do that. Besides,
EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and
EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER are required to be packed
in the uefi specification. For this reason, use the __packed attribute
to indicate to the compiler that the entire structure can appear
misaligned in memory (as suggested by Ard) in case one of them follows
the other directly in a capsule header.

Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v13:No change since v12.
v12:No change since v11.
v11:Add explanation on why version check is introduced
    in kernel rather than letting Management Mode to do it.
    (Rafael J. Wysocki)
    Revise the commit log to better describe the pack attribute.
    (Rafael J. Wysocki)
    Refine the comment for hw_ins and capsule_support.
    (Rafael J. Wysocki)
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
index dbd39b20e034..80e970f7e6f8 100644
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
+	 * Variable-size array of the size given by the sum of
+	 * emb_drv_cnt and payload_cnt.
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
+	/* hw_ins was introduced in version 2 */
+	u64 hw_ins;
+	/* capsule_support was introduced in version 3 */
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
+/* EFI_FIRMWARE_IMAGE_AUTHENTICATION */
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

