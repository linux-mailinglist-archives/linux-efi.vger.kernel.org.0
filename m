Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C52455A89
	for <lists+linux-efi@lfdr.de>; Thu, 18 Nov 2021 12:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbhKRLj3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 06:39:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344111AbhKRLiW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 06:38:22 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIBJD9L008642;
        Thu, 18 Nov 2021 11:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SP+6dubD5vvPT0ZMA56BBNLSDVelDCWwbi0gGrBqYK0=;
 b=SaswI4Qgg5ERJbtBigZkJ3q5F0F/bhgCl6OkWweOHwcxFtXDZDjOf44dZ/8MaCFbiyEh
 MMjW9GI8gpORD8bsRDzl5gSSizPlHLqK/0Q9aeBg4GRIXlLMYrccU182qHOvi+WF4ban
 W8eUBZJ7L5DEkN+wK0uBcphZ2jKk1Bd3Vsyj/qffOpZRlO03zwmGo3jr2GPkYD+pMseK
 j2Uoy0NnnhFtSjH/9QcP/Dc2jj6FCZW3pGUwgxmgBnS8c7/z2iPGnSx5VokDyUIVNFVo
 Iy60jDEh+0WyDF0t/Yf55AW9qqlxRhu8mmWws9DRbZ2YkRb6aG7mV06X5432rE6RgbW2 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cdnup095s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:11 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AIBOJ7K029601;
        Thu, 18 Nov 2021 11:34:10 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cdnup0958-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:10 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIBR1Mx008954;
        Thu, 18 Nov 2021 11:34:09 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 3ca50dhgwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:09 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AIBY5mf41877840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 11:34:05 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F8A0AE068;
        Thu, 18 Nov 2021 11:34:05 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E5B2AE06A;
        Thu, 18 Nov 2021 11:34:05 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Nov 2021 11:34:05 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] efi/libstub: Reserve confidential computing secret area
Date:   Thu, 18 Nov 2021 11:33:57 +0000
Message-Id: <20211118113359.642571-3-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118113359.642571-1-dovmurik@linux.ibm.com>
References: <20211118113359.642571-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pxqOQ61q1EGWNCGJVZE-HYppBKMUbOQB
X-Proofpoint-ORIG-GUID: ZYdRp_DSmlyFp3-Yy5cUjH1rUQ69dr8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111180067
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some older firmware declare the confidential computing secret area as
EFI_BOOT_SERVICES_DATA region.  Fix this up by treating this memory
region as EFI_RESERVED_TYPE, as it should be.

If that memory region is already EFI_RESERVED_TYPE then this has no
effect on the E820 map.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..dabfa33ae2b3 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -24,6 +24,7 @@
 const efi_system_table_t *efi_system_table;
 extern u32 image_offset;
 static efi_loaded_image_t *image = NULL;
+static u64 efi_coco_secret_phys_addr = U64_MAX;
 
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
@@ -443,6 +444,21 @@ static void add_e820ext(struct boot_params *params,
 		params->hdr.setup_data = (unsigned long)e820ext;
 }
 
+#ifdef CONFIG_EFI_COCO_SECRET
+static void efi_set_coco_secret_phys_addr(void)
+{
+	struct linux_efi_coco_secret_area *secret_area =
+		get_efi_config_table(LINUX_EFI_COCO_SECRET_AREA_GUID);
+
+	if (!secret_area || secret_area->size == 0 || secret_area->size >= SZ_4G)
+		return;
+
+	efi_coco_secret_phys_addr = secret_area->base_pa;
+}
+#else
+static void efi_set_coco_secret_phys_addr(void) {}
+#endif
+
 static efi_status_t
 setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_size)
 {
@@ -494,6 +510,16 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 				e820_type = E820_TYPE_SOFT_RESERVED;
 			else
 				e820_type = E820_TYPE_RAM;
+#ifdef CONFIG_EFI_COCO_SECRET
+			if (d->phys_addr == efi_coco_secret_phys_addr)
+				/*
+				 * Fix a quirk in firmwares which don't mark
+				 * the EFI confidential computing area as
+				 * EFI_RESERVED_TYPE, but instead as
+				 * EFI_BOOT_SERVICES_DATA.
+				 */
+				e820_type = E820_TYPE_RESERVED;
+#endif
 			break;
 
 		case EFI_ACPI_MEMORY_NVS:
@@ -793,6 +819,8 @@ unsigned long efi_main(efi_handle_t handle,
 
 	efi_retrieve_tpm2_eventlog();
 
+	efi_set_coco_secret_phys_addr();
+
 	setup_graphics(boot_params);
 
 	setup_efi_pci(boot_params);
-- 
2.25.1

