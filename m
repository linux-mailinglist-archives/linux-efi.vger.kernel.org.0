Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632C84A5C76
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 13:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiBAMpF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 07:45:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229966AbiBAMo7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 07:44:59 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211CWQiY016550;
        Tue, 1 Feb 2022 12:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DA4zKq5f8Mbx+qUvrQ9JVFikcVpliOcHc7Dt9FAM6Ug=;
 b=VQ5bDRrOKjftlsCHRK8ACgyMQMaZzMMrF3HZqbB7IFrfOMvqtCsLb5OQFeXiCGAKWN7K
 GuMbhyTr+VeSIG7zVheKWwdrF4Wf/KJLCjXd30gqSvbkG66O7z6xy+AIjFRwqsmz/sMm
 xziI2qQW7ChFW2e+sODeTnDg1t1l3Q/bOtJ210HLbZ+oGPhniSc1BDj755JRpGtiZJPC
 OrZ9HNd2zjOqB/XzurdbyXGegrA6PeMAz6cy/KSBt/au5+2AfU7bh7a8EShdjU+8WVPT
 g6G0kIosjrxVdozGZtZ+02KOOtKSLYf29x0OjgU5x4e/sGjSoRYUcaRZbAJXCFLXBPjS LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxn4hta06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:50 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211Ccw0Q009211;
        Tue, 1 Feb 2022 12:44:49 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxn4ht9yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:49 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211Cc9Jt014558;
        Tue, 1 Feb 2022 12:44:48 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3dy0sw4y7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:48 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211Ciiek35455442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 12:44:44 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F00E8BE04F;
        Tue,  1 Feb 2022 12:44:43 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2863ABE051;
        Tue,  1 Feb 2022 12:44:42 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 12:44:42 +0000 (GMT)
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
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/5] efi/libstub: Reserve confidential computing secret area
Date:   Tue,  1 Feb 2022 12:44:10 +0000
Message-Id: <20220201124413.1093099-3-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lyRwoRtaUMyquN-URZjP_IfbUP6W6zne
X-Proofpoint-ORIG-GUID: I6jk8EXgLe6tI7qo59Nd734MtEDitFfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_03,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010068
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
index 01ddd4502e28..4f1218cb87ca 100644
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
@@ -787,6 +813,8 @@ unsigned long efi_main(efi_handle_t handle,
 
 	efi_retrieve_tpm2_eventlog();
 
+	efi_set_coco_secret_phys_addr();
+
 	setup_graphics(boot_params);
 
 	setup_efi_pci(boot_params);
-- 
2.25.1

