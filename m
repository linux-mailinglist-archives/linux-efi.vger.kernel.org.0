Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F479210D81
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jul 2020 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgGAOTX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jul 2020 10:19:23 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:23732 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731331AbgGAOTW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jul 2020 10:19:22 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E3QLm032247;
        Wed, 1 Jul 2020 14:17:36 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 320mu6kb8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:17:35 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id B451153;
        Wed,  1 Jul 2020 14:17:33 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 4E6372015D84F; Wed,  1 Jul 2020 09:17:32 -0500 (CDT)
Message-ID: <20200701141732.206155269@hpe.com>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 09:17:37 -0500
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
Subject: [patch 06/13] Remove support for uv1 platform from uv_hub.h
References: <20200701141731.377252388@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 cotscore=-2147483648 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010102
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

arch/x86/include/asm/uv/uv_hub.h: remove UV1 support

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 60ca0afdeaf9..c0bcadf015fb 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -224,17 +224,11 @@ static inline struct uv_hub_info_s *uv_cpu_hub_info(int cpu)
  * This is a software convention - NOT the hardware revision numbers in
  * the hub chip.
  */
-#define UV1_HUB_REVISION_BASE		1
 #define UV2_HUB_REVISION_BASE		3
 #define UV3_HUB_REVISION_BASE		5
 #define UV4_HUB_REVISION_BASE		7
 #define UV4A_HUB_REVISION_BASE		8	/* UV4 (fixed) rev 2 */
 
-static inline int is_uv1_hub(void)
-{
-	return is_uv_hubbed(uv(1));
-}
-
 static inline int is_uv2_hub(void)
 {
 	return is_uv_hubbed(uv(2));
@@ -265,7 +259,7 @@ static inline int is_uvx_hub(void)
 
 static inline int is_uv_hub(void)
 {
-	return is_uv1_hub() || is_uvx_hub();
+	return is_uvx_hub();
 }
 
 union uvh_apicid {
@@ -292,11 +286,6 @@ union uvh_apicid {
 #define UV_PNODE_TO_GNODE(p)		((p) |uv_hub_info->gnode_extra)
 #define UV_PNODE_TO_NASID(p)		(UV_PNODE_TO_GNODE(p) << 1)
 
-#define UV1_LOCAL_MMR_BASE		0xf4000000UL
-#define UV1_GLOBAL_MMR32_BASE		0xf8000000UL
-#define UV1_LOCAL_MMR_SIZE		(64UL * 1024 * 1024)
-#define UV1_GLOBAL_MMR32_SIZE		(64UL * 1024 * 1024)
-
 #define UV2_LOCAL_MMR_BASE		0xfa000000UL
 #define UV2_GLOBAL_MMR32_BASE		0xfc000000UL
 #define UV2_LOCAL_MMR_SIZE		(32UL * 1024 * 1024)
@@ -313,25 +302,21 @@ union uvh_apicid {
 #define UV4_GLOBAL_MMR32_SIZE		(16UL * 1024 * 1024)
 
 #define UV_LOCAL_MMR_BASE		(				\
-					is_uv1_hub() ? UV1_LOCAL_MMR_BASE : \
 					is_uv2_hub() ? UV2_LOCAL_MMR_BASE : \
 					is_uv3_hub() ? UV3_LOCAL_MMR_BASE : \
 					/*is_uv4_hub*/ UV4_LOCAL_MMR_BASE)
 
 #define UV_GLOBAL_MMR32_BASE		(				\
-					is_uv1_hub() ? UV1_GLOBAL_MMR32_BASE : \
 					is_uv2_hub() ? UV2_GLOBAL_MMR32_BASE : \
 					is_uv3_hub() ? UV3_GLOBAL_MMR32_BASE : \
 					/*is_uv4_hub*/ UV4_GLOBAL_MMR32_BASE)
 
 #define UV_LOCAL_MMR_SIZE		(				\
-					is_uv1_hub() ? UV1_LOCAL_MMR_SIZE : \
 					is_uv2_hub() ? UV2_LOCAL_MMR_SIZE : \
 					is_uv3_hub() ? UV3_LOCAL_MMR_SIZE : \
 					/*is_uv4_hub*/ UV4_LOCAL_MMR_SIZE)
 
 #define UV_GLOBAL_MMR32_SIZE		(				\
-					is_uv1_hub() ? UV1_GLOBAL_MMR32_SIZE : \
 					is_uv2_hub() ? UV2_GLOBAL_MMR32_SIZE : \
 					is_uv3_hub() ? UV3_GLOBAL_MMR32_SIZE : \
 					/*is_uv4_hub*/ UV4_GLOBAL_MMR32_SIZE)
@@ -352,8 +337,6 @@ union uvh_apicid {
 #define UVH_APICID		0x002D0E00L
 #define UV_APIC_PNODE_SHIFT	6
 
-#define UV_APICID_HIBIT_MASK	0xffff0000
-
 /* Local Bus from cpu's perspective */
 #define LOCAL_BUS_BASE		0x1c00000
 #define LOCAL_BUS_SIZE		(4 * 1024 * 1024)
@@ -560,15 +543,6 @@ static inline int uv_apicid_to_pnode(int apicid)
 	return s2pn ? s2pn[pnode - uv_hub_info->min_socket] : pnode;
 }
 
-/* Convert an apicid to the socket number on the blade */
-static inline int uv_apicid_to_socket(int apicid)
-{
-	if (is_uv1_hub())
-		return (apicid >> (uv_hub_info->apic_pnode_shift - 1)) & 1;
-	else
-		return 0;
-}
-
 /*
  * Access global MMRs using the low memory MMR32 space. This region supports
  * faster MMR access but not all MMRs are accessible in this space.
@@ -660,7 +634,7 @@ static inline int uv_cpu_blade_processor_id(int cpu)
 	return uv_cpu_info_per(cpu)->blade_cpu_id;
 }
 
-/* Blade number to Node number (UV1..UV4 is 1:1) */
+/* Blade number to Node number (UV2..UV4 is 1:1) */
 static inline int uv_blade_to_node(int blade)
 {
 	return blade;
@@ -674,7 +648,7 @@ static inline int uv_numa_blade_id(void)
 
 /*
  * Convert linux node number to the UV blade number.
- * .. Currently for UV1 thru UV4 the node and the blade are identical.
+ * .. Currently for UV2 thru UV4 the node and the blade are identical.
  * .. If this changes then you MUST check references to this function!
  */
 static inline int uv_node_to_blade_id(int nid)
@@ -821,8 +795,6 @@ static inline void uv_set_cpu_scir_bits(int cpu, unsigned char value)
 	}
 }
 
-extern unsigned int uv_apicid_hibits;
-
 /*
  * Get the minimum revision number of the hub chips within the partition.
  * (See UVx_HUB_REVISION_BASE above for specific values.)
-- 
2.12.3


