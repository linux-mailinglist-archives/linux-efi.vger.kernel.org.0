Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C083C21A2D2
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jul 2020 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGIO4h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 10:56:37 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:63888 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728346AbgGIO4g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jul 2020 10:56:36 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069EpVnO029778;
        Thu, 9 Jul 2020 14:54:52 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 325k3syaua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 14:54:52 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 14AD4D1;
        Thu,  9 Jul 2020 14:54:51 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 9D4E420203302; Thu,  9 Jul 2020 09:54:48 -0500 (CDT)
Message-ID: <20200709145448.536244754@hpe.com>
User-Agent: quilt/0.66
Date:   Thu, 09 Jul 2020 09:54:55 -0500
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
Subject: [patch v2 08/13] x86: Remove vestigial mention of UV1 platform from
 arch/x86/include/asm/uv/bios.h
References: <20200709145447.549145421@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_08:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090111
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

arch/x86/include/asm/uv/bios.h: remove UV1 reference

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/bios.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux.orig/arch/x86/include/asm/uv/bios.h	2020-07-07 10:49:50.153510515 -0500
+++ linux/arch/x86/include/asm/uv/bios.h	2020-07-07 10:56:14.841046182 -0500
@@ -72,7 +72,7 @@ struct uv_gam_range_entry {
 };
 
 #define	UV_SYSTAB_SIG			"UVST"
-#define	UV_SYSTAB_VERSION_1		1	/* UV1/2/3 BIOS version */
+#define	UV_SYSTAB_VERSION_1		1	/* UV2/3 BIOS version */
 #define	UV_SYSTAB_VERSION_UV4		0x400	/* UV4 BIOS base version */
 #define	UV_SYSTAB_VERSION_UV4_1		0x401	/* + gpa_shift */
 #define	UV_SYSTAB_VERSION_UV4_2		0x402	/* + TYPE_NVRAM/WINDOW/MBOX */

