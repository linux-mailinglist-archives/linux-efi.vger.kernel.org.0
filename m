Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221D1210D86
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jul 2020 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbgGAOSa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jul 2020 10:18:30 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:52178 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731039AbgGAOS3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jul 2020 10:18:29 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E8M5x027199;
        Wed, 1 Jul 2020 14:17:34 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 320b6py5xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:17:33 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 0B87C83;
        Wed,  1 Jul 2020 14:17:31 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id A64032015C701; Wed,  1 Jul 2020 09:17:31 -0500 (CDT)
Message-ID: <20200701141731.560960583@hpe.com>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 09:17:32 -0500
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
Subject: [patch 01/13] Remove support for UV1 platform from uv_time.c
References: <20200701141731.377252388@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 cotscore=-2147483648 suspectscore=0 adultscore=0 mlxlogscore=936
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010102
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

arch/x86/platform/uv/uv_time.c: remove UV1 support

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/platform/uv/uv_time.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index 7af31b245636..41e982fda86c 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
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
-- 
2.12.3


