Return-Path: <linux-efi+bounces-1452-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB979343EB
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 23:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC01B2211D
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 21:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8261849FA;
	Wed, 17 Jul 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="lotvYbmh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C70364CD;
	Wed, 17 Jul 2024 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251974; cv=none; b=F1hFmPFnGC2wQ6k3D9l+AZcieofawiAUpcbUuoP3PnjkB7P21izjcolimq8xALLqRpS9XNVRmwvsnuUKfZGWyUgbR5a4Ax6Zr2JT7V6uApJG8Edem2C+nP/mzVZSKg7AQTbU9sNSYddbA03IMmw1FWufpOkevLiyNp3PBbFLIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251974; c=relaxed/simple;
	bh=pBawZxHaYBQT2t62wERrG9s82JSHOZeCgIQYqIENj64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RqIlgFDSoUsHx/ftkQH1SOzy+gA/TeSpAEJieZeTMCyidzlci9v2SR3Dvudv9a2x7elc+gA2/u+a62NpHvUeCaSpa1XB+UhBLs18+GbTGzDQx98YJIChIcFPlpOgwGN1mkqlrX3L0Vg+EFDMIEGHCfJ3xUhDc6tO3iH+RXFCNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=lotvYbmh; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HGuXVl017540;
	Wed, 17 Jul 2024 21:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pps0720; bh=ma6MWGfDS
	iybBQfLQjd48GruvjHUoPF2GnYDc9S5+xA=; b=lotvYbmhp4v8vYRwlMR7qQdlB
	+LBZRT/gaSNsnlE9z/KJTHGnpro0rgmryY68m70hznuBcHlscc5xPZrASMjWfPQ9
	ExRZZlm2kDY/ZSSW0IklzS0WtBtkzZoZwlfpSk77jMmy24oGl81VqtMVmq8uu3ax
	UA2fwCF8gw20vwyDB67sQ8pNm5Dkcwri4+/hDA8uckIoP+P42hLXP7AxaWCEge3T
	IRFhY/uSFaExu39v14nt++rMxj/KUR5IMaOdQ8zUVe4M/Qis6zXt11Pbg2lTGC+M
	5vg8bdtDbhlo6dT7QqlCHBhn0c3+8htwqD/pAsitQhJ9ipQAvVrXtmtAP1Q/A==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 40ehwqhnv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 21:31:27 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id B9A0E147B7;
	Wed, 17 Jul 2024 21:31:24 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 73BEF80046F;
	Wed, 17 Jul 2024 21:31:22 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 3D9E8300C5F8C; Wed, 17 Jul 2024 16:31:21 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>,
        Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH v3 2/2] x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
Date: Wed, 17 Jul 2024 16:31:21 -0500
Message-Id: <20240717213121.3064030-3-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240717213121.3064030-1-steve.wahl@hpe.com>
References: <20240717213121.3064030-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nYI9MFPl_E_FGmWXQRAm7xw7Fmy9Db5v
X-Proofpoint-GUID: nYI9MFPl_E_FGmWXQRAm7xw7Fmy9Db5v
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_16,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407170163

When ident_pud_init() uses only gbpages to create identity maps, large
ranges of addresses not actually requested can be included in the
resulting table; a 4K request will map a full GB.  This can include a
lot of extra address space past that requested, including areas marked
reserved by the BIOS.  That allows processor speculation into reserved
regions, that on UV systems can cause system halts.

Only use gbpages when map creation requests include the full GB page
of space.  Fall back to using smaller 2M pages when only portions of a
GB page are included in the request.

No attempt is made to coalesce mapping requests. If a request requires
a map entry at the 2M (pmd) level, subsequent mapping requests within
the same 1G region will also be at the pmd level, even if adjacent or
overlapping such requests could have been combined to map a full
gbpage.  Existing usage starts with larger regions and then adds
smaller regions, so this should not have any great consequence.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
---
 arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..a204a332c71f 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_leaf(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
-- 
2.26.2


