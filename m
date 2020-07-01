Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA324210D8C
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jul 2020 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgGAOTj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jul 2020 10:19:39 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:64530 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731324AbgGAOSa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jul 2020 10:18:30 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E3clS002775;
        Wed, 1 Jul 2020 14:17:36 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 320r3bhy2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:17:35 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 596C057;
        Wed,  1 Jul 2020 14:17:34 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 3024D2015E3C2; Wed,  1 Jul 2020 09:17:33 -0500 (CDT)
Message-ID: <20200701141733.081104906@hpe.com>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 09:17:44 -0500
From:   steve.wahl@hpe.com
To:     Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mike Travis <mike.travis@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Russ Anderson <rja@hpe.com>
Subject: [patch 13/13] Remove (now unused) EFI_UV1_MEMMAP from efi.h
References: <20200701141731.377252388@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=2 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 cotscore=-2147483648 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010102
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

With UV1 support removed, EFI_UV1_MEMMAP is no longer used.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/efi.h |   20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

--- linux.orig/arch/x86/include/asm/efi.h	2020-06-17 14:21:49.798542440 -0500
+++ linux/arch/x86/include/asm/efi.h	2020-06-17 14:28:55.830071857 -0500
@@ -22,17 +22,7 @@ extern unsigned long efi_fw_vendor, efi_
  *
  * This is the main reason why we're doing stable VA mappings for RT
  * services.
- *
- * SGI UV1 machines are known to be incompatible with this scheme, so we
- * provide an opt-out for these machines via a DMI quirk that sets the
- * attribute below.
  */
-#define EFI_UV1_MEMMAP         EFI_ARCH_1
-
-static inline bool efi_have_uv1_memmap(void)
-{
-	return IS_ENABLED(CONFIG_X86_UV) && efi_enabled(EFI_UV1_MEMMAP);
-}
 
 #define EFI32_LOADER_SIGNATURE	"EL32"
 #define EFI64_LOADER_SIGNATURE	"EL64"
@@ -122,9 +112,7 @@ struct efi_scratch {
 	efi_sync_low_kernel_mappings();					\
 	kernel_fpu_begin();						\
 	firmware_restrict_branch_speculation_start();			\
-									\
-	if (!efi_have_uv1_memmap())					\
-		efi_switch_mm(&efi_mm);					\
+	efi_switch_mm(&efi_mm);						\
 })
 
 #define arch_efi_call_virt(p, f, args...)				\
@@ -132,9 +120,7 @@ struct efi_scratch {
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
-	if (!efi_have_uv1_memmap())					\
-		efi_switch_mm(efi_scratch.prev_mm);			\
-									\
+	efi_switch_mm(efi_scratch.prev_mm);				\
 	firmware_restrict_branch_speculation_end();			\
 	kernel_fpu_end();						\
 })
@@ -176,8 +162,6 @@ extern void efi_delete_dummy_variable(vo
 extern void efi_switch_mm(struct mm_struct *mm);
 extern void efi_recover_from_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
-extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
-extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
 
 /* kexec external ABI */
 struct efi_setup_data {

