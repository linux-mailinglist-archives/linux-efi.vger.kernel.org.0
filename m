Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053F2210D83
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jul 2020 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbgGAOT1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jul 2020 10:19:27 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:17142 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731515AbgGAOTX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jul 2020 10:19:23 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E3Ev0013539;
        Wed, 1 Jul 2020 14:17:35 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 320qht24as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:17:35 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 18557AC;
        Wed,  1 Jul 2020 14:17:34 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id C8A882015DBC7; Wed,  1 Jul 2020 09:17:32 -0500 (CDT)
Message-ID: <20200701141732.706351085@hpe.com>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 09:17:41 -0500
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
Subject: [patch 10/13] Delete SGI UV1 detection.
References: <20200701141731.377252388@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 priorityscore=1501
 cotscore=-2147483648 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010102
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

As a part of UV1 platform removal, don't try to recognize the platform
through DMI to set the EFI_UV1_MEMMAP bit.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/platform/efi/quirks.c |   23 -----------------------
 1 file changed, 23 deletions(-)

--- linux.orig/arch/x86/platform/efi/quirks.c	2020-06-17 14:29:45.510015978 -0500
+++ linux/arch/x86/platform/efi/quirks.c	2020-06-17 14:36:34.473414139 -0500
@@ -558,16 +558,6 @@ out:
 	return ret;
 }
 
-static const struct dmi_system_id sgi_uv1_dmi[] __initconst = {
-	{ NULL, "SGI UV1",
-		{	DMI_MATCH(DMI_PRODUCT_NAME,	"Stoutland Platform"),
-			DMI_MATCH(DMI_PRODUCT_VERSION,	"1.0"),
-			DMI_MATCH(DMI_BIOS_VENDOR,	"SGI.COM"),
-		}
-	},
-	{ } /* NULL entry stops DMI scanning */
-};
-
 void __init efi_apply_memmap_quirks(void)
 {
 	/*
@@ -579,17 +569,6 @@ void __init efi_apply_memmap_quirks(void
 		pr_info("Setup done, disabling due to 32/64-bit mismatch\n");
 		efi_memmap_unmap();
 	}
-
-	/* UV2+ BIOS has a fix for this issue.  UV1 still needs the quirk. */
-	if (dmi_check_system(sgi_uv1_dmi)) {
-		if (IS_ENABLED(CONFIG_X86_UV)) {
-			set_bit(EFI_UV1_MEMMAP, &efi.flags);
-		} else {
-			pr_warn("EFI runtime disabled, needs CONFIG_X86_UV=y on UV1\n");
-			clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-			efi_memmap_unmap();
-		}
-	}
 }
 
 /*
@@ -723,8 +702,6 @@ void efi_recover_from_page_fault(unsigne
 
 	/*
 	 * Make sure that an efi runtime service caused the page fault.
-	 * "efi_mm" cannot be used to check if the page fault had occurred
-	 * in the firmware context because the UV1 memmap doesn't use efi_pgd.
 	 */
 	if (efi_rts_work.efi_rts_id == EFI_NONE)
 		return;

