Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFE21E22F
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jul 2020 23:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGMVbW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jul 2020 17:31:22 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:25540 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbgGMVat (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jul 2020 17:30:49 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DLOJsm027098;
        Mon, 13 Jul 2020 21:29:59 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 3276qr2kuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 21:29:59 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 400D38D;
        Mon, 13 Jul 2020 21:29:58 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id BDD61200F784F; Mon, 13 Jul 2020 16:29:55 -0500 (CDT)
Message-ID: <20200713212955.667726896@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 13 Jul 2020 16:30:04 -0500
From:   steve.wahl@hpe.com
To:     Steve Wahl <steve.wahl@hpe.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Subject: [patch v3 10/13] x86: Delete SGI UV1 detection.
References: <20200713212954.444086564@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_17:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130153
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

As a part of UV1 platform removal, don't try to recognize the platform
through DMI to set the EFI_UV1_MEMMAP bit.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/quirks.c |   23 -----------------------
 1 file changed, 23 deletions(-)

--- linux.orig/arch/x86/platform/efi/quirks.c	2020-07-07 10:49:50.017510679 -0500
+++ linux/arch/x86/platform/efi/quirks.c	2020-07-07 10:56:15.209045740 -0500
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

