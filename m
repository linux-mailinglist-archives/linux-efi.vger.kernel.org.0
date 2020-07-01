Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6F210D60
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jul 2020 16:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbgGAOSe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jul 2020 10:18:34 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:49350 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731290AbgGAOSa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jul 2020 10:18:30 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E6gnu031004;
        Wed, 1 Jul 2020 14:17:35 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 3209tgy2pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:17:34 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 29A0063;
        Wed,  1 Jul 2020 14:17:32 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id E4FE42015D828; Wed,  1 Jul 2020 09:17:31 -0500 (CDT)
Message-ID: <20200701141731.820821383@hpe.com>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 09:17:34 -0500
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
Subject: [patch 03/13] Remove support for UV1 platform from x2apic_uv_x.c
References: <20200701141731.377252388@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 cotscore=-2147483648
 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010102
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

arch/x86/kernel/apic/x2apic_uv_x.c: remove UV1 support

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |  121 +++++++------------------------------
 1 file changed, 25 insertions(+), 96 deletions(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c	2020-06-17 14:22:16.106513397 -0500
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c	2020-06-17 14:25:21.838308296 -0500
@@ -24,8 +24,6 @@
 #include <asm/uv/uv.h>
 #include <asm/apic.h>
 
-static DEFINE_PER_CPU(int, x2apic_extra_bits);
-
 static enum uv_system_type	uv_system_type;
 static int			uv_hubbed_system;
 static int			uv_hubless_system;
@@ -40,7 +38,7 @@ static u8 oem_table_id[ACPI_OEM_TABLE_ID
 static struct {
 	unsigned int apicid_shift;
 	unsigned int apicid_mask;
-	unsigned int socketid_shift;	/* aka pnode_shift for UV1/2/3 */
+	unsigned int socketid_shift;	/* aka pnode_shift for UV2/3 */
 	unsigned int pnode_mask;
 	unsigned int gpa_shift;
 	unsigned int gnode_shift;
@@ -48,8 +46,6 @@ static struct {
 
 static int uv_min_hub_revision_id;
 
-unsigned int uv_apicid_hibits;
-
 static struct apic apic_x2apic_uv_x;
 static struct uv_hub_info_s uv_hub_info_node0;
 
@@ -139,12 +135,8 @@ static void __init uv_tsc_check_sync(voi
 	/* Accommodate different UV arch BIOSes */
 	mmr = uv_early_read_mmr(UVH_TSC_SYNC_MMR);
 	mmr_shift =
-		is_uv1_hub() ? 0 :
 		is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
-	if (mmr_shift)
-		sync_state = (mmr >> mmr_shift) & UVH_TSC_SYNC_MASK;
-	else
-		sync_state = 0;
+	sync_state = (mmr >> mmr_shift) & UVH_TSC_SYNC_MASK;
 
 	switch (sync_state) {
 	case UVH_TSC_SYNC_VALID:
@@ -223,21 +215,6 @@ static void __init early_get_apic_socket
 	pr_info("UV: socketid_shift:%d pnode_mask:0x%x\n", uv_cpuid.socketid_shift, uv_cpuid.pnode_mask);
 }
 
-/*
- * Add an extra bit as dictated by bios to the destination apicid of
- * interrupts potentially passing through the UV HUB.  This prevents
- * a deadlock between interrupts and IO port operations.
- */
-static void __init uv_set_apicid_hibit(void)
-{
-	union uv1h_lb_target_physical_apic_id_mask_u apicid_mask;
-
-	if (is_uv1_hub()) {
-		apicid_mask.v = uv_early_read_mmr(UV1H_LB_TARGET_PHYSICAL_APIC_ID_MASK);
-		uv_apicid_hibits = apicid_mask.s1.bit_enables & UV_APICID_HIBIT_MASK;
-	}
-}
-
 static void __init uv_stringify(int len, char *to, char *from)
 {
 	/* Relies on 'to' being NULL chars so result will be NULL terminated */
@@ -280,36 +257,25 @@ static int __init uv_acpi_madt_oem_check
 
 	/*
 	 * Determine UV arch type.
-	 *   SGI:  UV100/1000
 	 *   SGI2: UV2000/3000
 	 *   SGI3: UV300 (truncated to 4 chars because of different varieties)
 	 *   SGI4: UV400 (truncated to 4 chars because of different varieties)
 	 */
-	uv_hub_info->hub_revision =
-		!strncmp(oem_id, "SGI4", 4) ? UV4_HUB_REVISION_BASE :
-		!strncmp(oem_id, "SGI3", 4) ? UV3_HUB_REVISION_BASE :
-		!strcmp(oem_id, "SGI2") ? UV2_HUB_REVISION_BASE :
-		!strcmp(oem_id, "SGI") ? UV1_HUB_REVISION_BASE : 0;
-
-	if (uv_hub_info->hub_revision == 0)
-		goto badbios;
-
-	switch (uv_hub_info->hub_revision) {
-	case UV4_HUB_REVISION_BASE:
+	if (!strncmp(oem_id, "SGI4", 4)) {
+		uv_hub_info->hub_revision = UV4_HUB_REVISION_BASE;
 		uv_hubbed_system = 0x11;
-		break;
 
-	case UV3_HUB_REVISION_BASE:
+	} else if (!strncmp(oem_id, "SGI3", 4)) {
+		uv_hub_info->hub_revision = UV3_HUB_REVISION_BASE;
 		uv_hubbed_system = 0x9;
-		break;
 
-	case UV2_HUB_REVISION_BASE:
+	} else if (!strcmp(oem_id, "SGI2")) {
+		uv_hub_info->hub_revision = UV2_HUB_REVISION_BASE;
 		uv_hubbed_system = 0x5;
-		break;
 
-	case UV1_HUB_REVISION_BASE:
-		uv_hubbed_system = 0x3;
-		break;
+	} else {
+		uv_hub_info->hub_revision = 0;
+		goto badbios;
 	}
 
 	pnodeid = early_get_pnodeid();
@@ -323,14 +289,6 @@ static int __init uv_acpi_madt_oem_check
 		uv_system_type = UV_X2APIC;
 		uv_apic = 0;
 
-	} else if (!strcmp(oem_table_id, "UVH")) {
-		/* Only UV1 systems: */
-		uv_system_type = UV_NON_UNIQUE_APIC;
-		x86_platform.legacy.warm_reset = 0;
-		__this_cpu_write(x2apic_extra_bits, pnodeid << uvh_apicid.s.pnode_shift);
-		uv_set_apicid_hibit();
-		uv_apic = 1;
-
 	} else if (!strcmp(oem_table_id, "UVL")) {
 		/* Only used for very small systems:  */
 		uv_system_type = UV_LEGACY_APIC;
@@ -347,7 +305,7 @@ static int __init uv_acpi_madt_oem_check
 
 badbios:
 	pr_err("UV: OEM_ID:%s OEM_TABLE_ID:%s\n", oem_id, oem_table_id);
-	pr_err("Current BIOS not supported, update kernel and/or BIOS\n");
+	pr_err("Current UV Type or BIOS not supported\n");
 	BUG();
 }
 
@@ -545,7 +503,6 @@ static int uv_wakeup_secondary(int phys_
 	int pnode;
 
 	pnode = uv_apicid_to_pnode(phys_apicid);
-	phys_apicid |= uv_apicid_hibits;
 
 	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
 	    (phys_apicid << UVH_IPI_INT_APIC_ID_SHFT) |
@@ -576,7 +533,7 @@ static void uv_send_IPI_one(int cpu, int
 		dmode = dest_Fixed;
 
 	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
-		((apicid | uv_apicid_hibits) << UVH_IPI_INT_APIC_ID_SHFT) |
+		(apicid << UVH_IPI_INT_APIC_ID_SHFT) |
 		(dmode << UVH_IPI_INT_DELIVERY_MODE_SHFT) |
 		(vector << UVH_IPI_INT_VECTOR_SHFT);
 
@@ -634,22 +591,16 @@ static void uv_init_apic_ldr(void)
 
 static u32 apic_uv_calc_apicid(unsigned int cpu)
 {
-	return apic_default_calc_apicid(cpu) | uv_apicid_hibits;
+	return apic_default_calc_apicid(cpu);
 }
 
-static unsigned int x2apic_get_apic_id(unsigned long x)
+static unsigned int x2apic_get_apic_id(unsigned long id)
 {
-	unsigned int id;
-
-	WARN_ON(preemptible() && num_online_cpus() > 1);
-	id = x | __this_cpu_read(x2apic_extra_bits);
-
 	return id;
 }
 
 static u32 set_apic_id(unsigned int id)
 {
-	/* CHECKME: Do we need to mask out the xapic extra bits? */
 	return id;
 }
 
@@ -721,11 +672,6 @@ static struct apic apic_x2apic_uv_x __ro
 	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
-static void set_x2apic_extra_bits(int pnode)
-{
-	__this_cpu_write(x2apic_extra_bits, pnode << uvh_apicid.s.pnode_shift);
-}
-
 #define	UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_LENGTH	3
 #define DEST_SHIFT UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR_DEST_BASE_SHFT
 
@@ -920,15 +866,7 @@ static __init void map_mmioh_high(int mi
 		return;
 	}
 
-	if (is_uv1_hub()) {
-		mmr	= UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR;
-		shift	= UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_BASE_SHFT;
-		mmioh.v	= uv_read_local_mmr(mmr);
-		enable	= !!mmioh.s1.enable;
-		base	= mmioh.s1.base;
-		m_io	= mmioh.s1.m_io;
-		n_io	= mmioh.s1.n_io;
-	} else if (is_uv2_hub()) {
+	if (is_uv2_hub()) {
 		mmr	= UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR;
 		shift	= UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_BASE_SHFT;
 		mmioh.v	= uv_read_local_mmr(mmr);
@@ -936,16 +874,15 @@ static __init void map_mmioh_high(int mi
 		base	= mmioh.s2.base;
 		m_io	= mmioh.s2.m_io;
 		n_io	= mmioh.s2.n_io;
-	} else {
-		return;
-	}
 
-	if (enable) {
-		max_pnode &= (1 << n_io) - 1;
-		pr_info("UV: base:0x%lx shift:%d N_IO:%d M_IO:%d max_pnode:0x%x\n", base, shift, m_io, n_io, max_pnode);
-		map_high("MMIOH", base, shift, m_io, max_pnode, map_uc);
-	} else {
-		pr_info("UV: MMIOH disabled\n");
+		if (enable) {
+			max_pnode &= (1 << n_io) - 1;
+			pr_info("UV: base:0x%lx shift:%d N_IO:%d M_IO:%d max_pnode:0x%x\n",
+				base, shift, m_io, n_io, max_pnode);
+			map_high("MMIOH", base, shift, m_io, max_pnode, map_uc);
+		} else {
+			pr_info("UV: MMIOH disabled\n");
+		}
 	}
 }
 
@@ -1081,9 +1017,6 @@ void uv_cpu_init(void)
 		return;
 
 	uv_hub_info->nr_online_cpus++;
-
-	if (get_uv_system_type() == UV_NON_UNIQUE_APIC)
-		set_x2apic_extra_bits(uv_hub_info->pnode);
 }
 
 struct mn {
@@ -1114,9 +1047,6 @@ static void get_mn(struct mn *mnp)
 	} else if (is_uv2_hub()) {
 		mnp->m_val	= m_n_config.s2.m_skt;
 		mnp->n_lshift	= mnp->m_val == 40 ? 40 : 39;
-	} else if (is_uv1_hub()) {
-		mnp->m_val	= m_n_config.s1.m_skt;
-		mnp->n_lshift	= mnp->m_val;
 	}
 	mnp->m_shift = mnp->m_val ? 64 - mnp->m_val : 0;
 }
@@ -1318,7 +1248,7 @@ static void __init build_socket_tables(v
 	size_t bytes;
 
 	if (!gre) {
-		if (is_uv1_hub() || is_uv2_hub() || is_uv3_hub()) {
+		if (is_uv2_hub() || is_uv3_hub()) {
 			pr_info("UV: No UVsystab socket table, ignoring\n");
 			return;
 		}
@@ -1500,8 +1430,7 @@ static void __init uv_system_init_hub(vo
 	unsigned short min_pnode = 9999, max_pnode = 0;
 	char *hub = is_uv4_hub() ? "UV400" :
 		    is_uv3_hub() ? "UV300" :
-		    is_uv2_hub() ? "UV2000/3000" :
-		    is_uv1_hub() ? "UV100/1000" : NULL;
+		    is_uv2_hub() ? "UV2000/3000" : NULL;
 
 	if (!hub) {
 		pr_err("UV: Unknown/unsupported UV hub\n");

