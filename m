Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2F4A6BCCB
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2019 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfGQNNM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Jul 2019 09:13:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47484 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQNNM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Jul 2019 09:13:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HD9J7t194675;
        Wed, 17 Jul 2019 13:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=9R9vGnDDSVcIlOsrGA3wHv4ZyafWuZt2OPX/DOooBok=;
 b=ig4sFhs4TYsolVmYMcb5UwuC+TvWHZGMiXFRzgRRiOurtxKkS3IgDLLOoc5h98Fnp2Wf
 DuvyYMWe7nQdQA3LpTuXTN63iFfL0fvaCruaC+Uz7zRq0bfZgQ4ci/aESHVZSQdmTuYV
 1cGWByxGZjXO7jQzHsGIUyCIt+MvqjQSbniCp0RUmii7CS0N/zVTfrUQvIxIjXJ5dHKl
 +G+E8aeWSjl4UwUpsAiOHMkUPGRFJc6uwqXEKJMN+ErOqDbrMo7nFUALlaaioHMbQMno
 YssEewHcywELRcZYWk0swJG7Loqmop53rh7zblkMpoJbc8bDBQMNzXP30bNrTGI67xOx Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qttnae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 13:12:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HD7b9S021756;
        Wed, 17 Jul 2019 13:12:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tsmccd3w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 13:12:31 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6HDCPZR001934;
        Wed, 17 Jul 2019 13:12:30 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 13:12:25 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/efi: Remove unused variables
Date:   Tue, 16 Jul 2019 21:15:57 +0800
Message-Id: <1563282957-26898-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170160
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix gcc warnings:

arch/x86/boot/compressed/eboot.c: In function 'make_boot_params':
arch/x86/boot/compressed/eboot.c:394:6: warning: unused variable 'i' [-Wunused-variable]
  int i;
      ^
arch/x86/boot/compressed/eboot.c:393:6: warning: unused variable 's1' [-Wunused-variable]
  u8 *s1;
      ^
arch/x86/boot/compressed/eboot.c:392:7: warning: unused variable 's2' [-Wunused-variable]
  u16 *s2;
       ^
arch/x86/boot/compressed/eboot.c:387:8: warning: unused variable 'options' [-Wunused-variable]
  void *options, *handle;
        ^
arch/x86/boot/compressed/eboot.c: In function 'add_e820ext':
arch/x86/boot/compressed/eboot.c:498:16: warning: unused variable 'size' [-Wunused-variable]
  unsigned long size;
                ^
arch/x86/boot/compressed/eboot.c:497:15: warning: unused variable 'status' [-Wunused-variable]
  efi_status_t status;
               ^
arch/x86/boot/compressed/eboot.c: In function 'exit_boot_func':
arch/x86/boot/compressed/eboot.c:681:15: warning: unused variable 'status' [-Wunused-variable]
  efi_status_t status;
               ^
arch/x86/boot/compressed/eboot.c:680:8: warning: unused variable 'nr_desc' [-Wunused-variable]
  __u32 nr_desc;
        ^
arch/x86/boot/compressed/eboot.c: In function 'efi_main':
arch/x86/boot/compressed/eboot.c:750:22: warning: unused variable 'image' [-Wunused-variable]
  efi_loaded_image_t *image;
                      ^

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/boot/compressed/eboot.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 220d127..d6662fd 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -384,14 +384,11 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	struct apm_bios_info *bi;
 	struct setup_header *hdr;
 	efi_loaded_image_t *image;
-	void *options, *handle;
+	void *handle;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
 	char *cmdline_ptr;
-	u16 *s2;
-	u8 *s1;
-	int i;
 	unsigned long ramdisk_addr;
 	unsigned long ramdisk_size;
 
@@ -494,8 +491,6 @@ static void add_e820ext(struct boot_params *params,
 			struct setup_data *e820ext, u32 nr_entries)
 {
 	struct setup_data *data;
-	efi_status_t status;
-	unsigned long size;
 
 	e820ext->type = SETUP_E820_EXT;
 	e820ext->len  = nr_entries * sizeof(struct boot_e820_entry);
@@ -677,8 +672,6 @@ static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 				   void *priv)
 {
 	const char *signature;
-	__u32 nr_desc;
-	efi_status_t status;
 	struct exit_boot_struct *p = priv;
 
 	signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
@@ -747,7 +740,6 @@ struct boot_params *
 efi_main(struct efi_config *c, struct boot_params *boot_params)
 {
 	struct desc_ptr *gdt = NULL;
-	efi_loaded_image_t *image;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
 	struct desc_struct *desc;
-- 
1.8.3.1

