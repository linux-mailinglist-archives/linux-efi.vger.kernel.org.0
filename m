Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D51D461415
	for <lists+linux-efi@lfdr.de>; Mon, 29 Nov 2021 12:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbhK2Lsw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Nov 2021 06:48:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244428AbhK2Lqr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Nov 2021 06:46:47 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATAm2rv013010;
        Mon, 29 Nov 2021 11:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SP+6dubD5vvPT0ZMA56BBNLSDVelDCWwbi0gGrBqYK0=;
 b=VG9ZkZ973UwvVAG8zbzl6yn0VlEL95sHF2UIwED6XbWlxk96Y+XfPxAvJuSuKoMKoTj3
 UwSKBKMlSCi1u1hUljDKNIvBkIW0X9Ts3i0zWV/nUH9piXn2Xy6WHVsw2djiwAD0Z2TF
 WceL17i5gx1fFMhyi4NMb8YbGkk0SyL8fMs3HQX/naBI7JlF6Vnpnnh4K8glU1JtKjXC
 Ej0ULFjIJL4mK01rvT10U5Guwkvpxt0dVWsyEBIFCcUFsr6yC5SEmnKpnGiTLi8eTRIi
 cxWc0/gPFhX2zoAJBXonVS+kwEJRfcZ4iR7unbPt3+8jW0h0N3ej1MFwRkLVC+ie/3VP 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmwdv160j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:43:04 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATBaTfR010952;
        Mon, 29 Nov 2021 11:43:03 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmwdv1603-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:43:03 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBWao3019394;
        Mon, 29 Nov 2021 11:43:03 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcaa7dqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:43:02 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATBh05c65667392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:43:00 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 404C4124054;
        Mon, 29 Nov 2021 11:43:00 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1A47124058;
        Mon, 29 Nov 2021 11:42:59 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 11:42:59 +0000 (GMT)
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
Subject: [PATCH v6 2/5] efi/libstub: Reserve confidential computing secret area
Date:   Mon, 29 Nov 2021 11:42:48 +0000
Message-Id: <20211129114251.3741721-3-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KImGb9G4tKI5bAhCW9COTpBl197Z9n5f
X-Proofpoint-ORIG-GUID: Dgscfk579ant8giX_mAK9fzxLgeDvGsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290058
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

