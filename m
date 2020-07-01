Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD807210D66
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jul 2020 16:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbgGAOSe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jul 2020 10:18:34 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:58958 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731315AbgGAOSb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jul 2020 10:18:31 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E37Qc032327;
        Wed, 1 Jul 2020 14:17:34 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 32074j9927-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:17:34 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 8F8DE91;
        Wed,  1 Jul 2020 14:17:33 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 2FD982015D84A; Wed,  1 Jul 2020 09:17:32 -0500 (CDT)
Message-ID: <20200701141732.079275467@hpe.com>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 09:17:36 -0500
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
Subject: [patch 05/13] Remove support for UV1 platform from uv_bau.h
References: <20200701141731.377252388@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 impostorscore=0
 cotscore=-2147483648 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010102
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

arch/x86/include/asm/uv/uv_bau.h: Remove UV1 support
arch/x86/platform/uv/tlb_uv.c: follow structure name change in uv_bau.h

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_bau.h |  118 ++-------------------------------------
 arch/x86/platform/uv/tlb_uv.c    |    4 -
 2 files changed, 9 insertions(+), 113 deletions(-)

--- linux.orig/arch/x86/include/asm/uv/uv_bau.h	2020-06-17 14:29:45.726015656 -0500
+++ linux/arch/x86/include/asm/uv/uv_bau.h	2020-06-17 14:34:24.129604420 -0500
@@ -46,10 +46,7 @@
 #define UV_ACT_STATUS_SIZE		2
 #define UV_DISTRIBUTION_SIZE		256
 #define UV_SW_ACK_NPENDING		8
-#define UV1_NET_ENDPOINT_INTD		0x38
-#define UV2_NET_ENDPOINT_INTD		0x28
-#define UV_NET_ENDPOINT_INTD		(is_uv1_hub() ?			\
-			UV1_NET_ENDPOINT_INTD : UV2_NET_ENDPOINT_INTD)
+#define UV_NET_ENDPOINT_INTD		0x28
 #define UV_PAYLOADQ_GNODE_SHIFT		49
 #define UV_PTC_BASENAME			"sgi_uv/ptc_statistics"
 #define UV_BAU_BASENAME			"sgi_uv/bau_tunables"
@@ -64,14 +61,9 @@
  * UV2: Bit 19 selects between
  *  (0): 10 microsecond timebase and
  *  (1): 80 microseconds
- *  we're using 560us, similar to UV1: 65 units of 10us
+ *  we're using 560us
  */
-#define UV1_INTD_SOFT_ACK_TIMEOUT_PERIOD (9UL)
-#define UV2_INTD_SOFT_ACK_TIMEOUT_PERIOD (15UL)
-
-#define UV_INTD_SOFT_ACK_TIMEOUT_PERIOD	(is_uv1_hub() ?			\
-		UV1_INTD_SOFT_ACK_TIMEOUT_PERIOD :			\
-		UV2_INTD_SOFT_ACK_TIMEOUT_PERIOD)
+#define UV_INTD_SOFT_ACK_TIMEOUT_PERIOD	(15UL)
 /* assuming UV3 is the same */
 
 #define BAU_MISC_CONTROL_MULT_MASK	3
@@ -148,7 +140,6 @@
 
 #define UV_LB_SUBNODEID			0x10
 
-/* these two are the same for UV1 and UV2: */
 #define UV_SA_SHFT UVH_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_SHFT
 #define UV_SA_MASK UVH_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_MASK
 /* 4 bits of software ack period */
@@ -189,8 +180,7 @@
 #define BAU_DESC_QUALIFIER		0x534749
 
 enum uv_bau_version {
-	UV_BAU_V1 = 1,
-	UV_BAU_V2,
+	UV_BAU_V2 = 2,
 	UV_BAU_V3,
 	UV_BAU_V4,
 };
@@ -233,12 +223,12 @@ struct bau_local_cpumask {
  */
 
 /**
- * struct uv1_2_3_bau_msg_payload - defines payload for INTD transactions
+ * struct uv2_3_bau_msg_payload - defines payload for INTD transactions
  * @address:		Signifies a page or all TLB's of the cpu
  * @sending_cpu:	CPU from which the message originates
  * @acknowledge_count:	CPUs on the destination Hub that received the interrupt
  */
-struct uv1_2_3_bau_msg_payload {
+struct uv2_3_bau_msg_payload {
 	u64 address;
 	u16 sending_cpu;
 	u16 acknowledge_count;
@@ -260,89 +250,6 @@ struct uv4_bau_msg_payload {
 };
 
 /*
- * UV1 Message header:  16 bytes (128 bits) (bytes 0x30-0x3f of descriptor)
- * see table 4.2.3.0.1 in broacast_assist spec.
- */
-struct uv1_bau_msg_header {
-	unsigned int	dest_subnodeid:6;	/* must be 0x10, for the LB */
-	/* bits 5:0 */
-	unsigned int	base_dest_nasid:15;	/* nasid of the first bit */
-	/* bits 20:6 */				/* in uvhub map */
-	unsigned int	command:8;		/* message type */
-	/* bits 28:21 */
-	/* 0x38: SN3net EndPoint Message */
-	unsigned int	rsvd_1:3;		/* must be zero */
-	/* bits 31:29 */
-	/* int will align on 32 bits */
-	unsigned int	rsvd_2:9;		/* must be zero */
-	/* bits 40:32 */
-	/* Suppl_A is 56-41 */
-	unsigned int	sequence:16;		/* message sequence number */
-	/* bits 56:41 */			/* becomes bytes 16-17 of msg */
-						/* Address field (96:57) is
-						   never used as an address
-						   (these are address bits
-						   42:3) */
-
-	unsigned int	rsvd_3:1;		/* must be zero */
-	/* bit 57 */
-	/* address bits 27:4 are payload */
-	/* these next 24  (58-81) bits become bytes 12-14 of msg */
-	/* bits 65:58 land in byte 12 */
-	unsigned int	replied_to:1;		/* sent as 0 by the source to
-						   byte 12 */
-	/* bit 58 */
-	unsigned int	msg_type:3;		/* software type of the
-						   message */
-	/* bits 61:59 */
-	unsigned int	canceled:1;		/* message canceled, resource
-						   is to be freed*/
-	/* bit 62 */
-	unsigned int	payload_1a:1;		/* not currently used */
-	/* bit 63 */
-	unsigned int	payload_1b:2;		/* not currently used */
-	/* bits 65:64 */
-
-	/* bits 73:66 land in byte 13 */
-	unsigned int	payload_1ca:6;		/* not currently used */
-	/* bits 71:66 */
-	unsigned int	payload_1c:2;		/* not currently used */
-	/* bits 73:72 */
-
-	/* bits 81:74 land in byte 14 */
-	unsigned int	payload_1d:6;		/* not currently used */
-	/* bits 79:74 */
-	unsigned int	payload_1e:2;		/* not currently used */
-	/* bits 81:80 */
-
-	unsigned int	rsvd_4:7;		/* must be zero */
-	/* bits 88:82 */
-	unsigned int	swack_flag:1;		/* software acknowledge flag */
-	/* bit 89 */
-						/* INTD trasactions at
-						   destination are to wait for
-						   software acknowledge */
-	unsigned int	rsvd_5:6;		/* must be zero */
-	/* bits 95:90 */
-	unsigned int	rsvd_6:5;		/* must be zero */
-	/* bits 100:96 */
-	unsigned int	int_both:1;		/* if 1, interrupt both sockets
-						   on the uvhub */
-	/* bit 101*/
-	unsigned int	fairness:3;		/* usually zero */
-	/* bits 104:102 */
-	unsigned int	multilevel:1;		/* multi-level multicast
-						   format */
-	/* bit 105 */
-	/* 0 for TLB: endpoint multi-unicast messages */
-	unsigned int	chaining:1;		/* next descriptor is part of
-						   this activation*/
-	/* bit 106 */
-	unsigned int	rsvd_7:21;		/* must be zero */
-	/* bits 127:107 */
-};
-
-/*
  * UV2 Message header:  16 bytes (128 bits) (bytes 0x30-0x3f of descriptor)
  * see figure 9-2 of harp_sys.pdf
  * assuming UV3 is the same
@@ -418,25 +325,14 @@ struct bau_desc {
 	 * message template, consisting of header and payload:
 	 */
 	union bau_msg_header {
-		struct uv1_bau_msg_header	uv1_hdr;
 		struct uv2_3_bau_msg_header	uv2_3_hdr;
 	} header;
 
 	union bau_payload_header {
-		struct uv1_2_3_bau_msg_payload	uv1_2_3;
+		struct uv2_3_bau_msg_payload	uv2_3;
 		struct uv4_bau_msg_payload	uv4;
 	} payload;
 };
-/* UV1:
- *   -payload--    ---------header------
- *   bytes 0-11    bits 41-56  bits 58-81
- *       A           B  (2)      C (3)
- *
- *            A/B/C are moved to:
- *       A            C          B
- *   bytes 0-11  bytes 12-14  bytes 16-17  (byte 15 filled in by hw as vector)
- *   ------------payload queue-----------
- */
 /* UV2:
  *   -payload--    ---------header------
  *   bytes 0-11    bits 70-78  bits 21-44
--- linux.orig/arch/x86/platform/uv/tlb_uv.c	2020-06-17 14:33:24.501691937 -0500
+++ linux/arch/x86/platform/uv/tlb_uv.c	2020-06-17 14:33:27.457687593 -0500
@@ -1062,8 +1062,8 @@ const struct cpumask *uv_flush_tlb_other
 	switch (bcp->uvhub_version) {
 	case UV_BAU_V2:
 	case UV_BAU_V3:
-		bau_desc->payload.uv1_2_3.address = address;
-		bau_desc->payload.uv1_2_3.sending_cpu = cpu;
+		bau_desc->payload.uv2_3.address = address;
+		bau_desc->payload.uv2_3.sending_cpu = cpu;
 		break;
 	case UV_BAU_V4:
 		bau_desc->payload.uv4.address = address;

