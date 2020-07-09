Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E38B21A2CF
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jul 2020 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGIO4g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 10:56:36 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:61142 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727998AbgGIO4f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jul 2020 10:56:35 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069Er2va016981;
        Thu, 9 Jul 2020 14:54:51 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 325k3hf712-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 14:54:50 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 10F9FCA;
        Thu,  9 Jul 2020 14:54:49 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id C7CEE202032FB; Thu,  9 Jul 2020 09:54:47 -0500 (CDT)
Message-ID: <20200709145447.709389827@hpe.com>
User-Agent: quilt/0.66
Date:   Thu, 09 Jul 2020 09:54:48 -0500
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
Subject: [patch v2 01/13] x86: Remove support for UV1 platform from uv_time.c
References: <20200709145447.549145421@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_08:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxlogscore=871 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090111
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

arch/x86/platform/uv/uv_time.c: remove UV1 support

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/platform/uv/uv_time.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--- linux.orig/arch/x86/platform/uv/uv_time.c	2020-07-07 10:49:50.565510013 -0500
+++ linux/arch/x86/platform/uv/uv_time.c	2020-07-07 10:56:13.473047822 -0500
@@ -74,7 +74,6 @@ static void uv_rtc_send_IPI(int cpu)
 
 	apicid = cpu_physical_id(cpu);
 	pnode = uv_apicid_to_pnode(apicid);
-	apicid |= uv_apicid_hibits;
 	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
 	      (apicid << UVH_IPI_INT_APIC_ID_SHFT) |
 	      (X86_PLATFORM_IPI_VECTOR << UVH_IPI_INT_VECTOR_SHFT);
@@ -85,10 +84,7 @@ static void uv_rtc_send_IPI(int cpu)
 /* Check for an RTC interrupt pending */
 static int uv_intr_pending(int pnode)
 {
-	if (is_uv1_hub())
-		return uv_read_global_mmr64(pnode, UVH_EVENT_OCCURRED0) &
-			UV1H_EVENT_OCCURRED0_RTC1_MASK;
-	else if (is_uvx_hub())
+	if (is_uvx_hub())
 		return uv_read_global_mmr64(pnode, UVXH_EVENT_OCCURRED2) &
 			UVXH_EVENT_OCCURRED2_RTC_1_MASK;
 	return 0;
@@ -98,19 +94,15 @@ static int uv_intr_pending(int pnode)
 static int uv_setup_intr(int cpu, u64 expires)
 {
 	u64 val;
-	unsigned long apicid = cpu_physical_id(cpu) | uv_apicid_hibits;
+	unsigned long apicid = cpu_physical_id(cpu);
 	int pnode = uv_cpu_to_pnode(cpu);
 
 	uv_write_global_mmr64(pnode, UVH_RTC1_INT_CONFIG,
 		UVH_RTC1_INT_CONFIG_M_MASK);
 	uv_write_global_mmr64(pnode, UVH_INT_CMPB, -1L);
 
-	if (is_uv1_hub())
-		uv_write_global_mmr64(pnode, UVH_EVENT_OCCURRED0_ALIAS,
-				UV1H_EVENT_OCCURRED0_RTC1_MASK);
-	else
-		uv_write_global_mmr64(pnode, UVXH_EVENT_OCCURRED2_ALIAS,
-				UVXH_EVENT_OCCURRED2_RTC_1_MASK);
+	uv_write_global_mmr64(pnode, UVXH_EVENT_OCCURRED2_ALIAS,
+			      UVXH_EVENT_OCCURRED2_RTC_1_MASK);
 
 	val = (X86_PLATFORM_IPI_VECTOR << UVH_RTC1_INT_CONFIG_VECTOR_SHFT) |
 		((u64)apicid << UVH_RTC1_INT_CONFIG_APIC_ID_SHFT);

