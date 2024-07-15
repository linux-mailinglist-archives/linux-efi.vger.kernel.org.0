Return-Path: <linux-efi+bounces-1437-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6389931A8B
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jul 2024 20:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8DD28305E
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jul 2024 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE047CF33;
	Mon, 15 Jul 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="O+SvTFNR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB04EB37;
	Mon, 15 Jul 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069670; cv=none; b=SvFaOeDXEeQKZEMnhp780VjXfLiHqIQqfaxLkj1DjHWy3o5NU/nZpWAVJp2OxI6MLmCT9Lh6YpGewCVqtm9w7MG83nZ2eDeYn+9WvPhpJi+1nDnDfizPEDaaoVIrgO6SviDdcHkI+s9WTaKvi7B7PAjS8z/vRXSO95xEukjkzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069670; c=relaxed/simple;
	bh=406glRtonkqGEa7am3+UpFuEnHxkwOFnqUzjS1hNNmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQiQjtY4ZbAVp5BeKikDQ4y+1Pj+37xbAdvkmDDy9ygm6xRICb68k2K1OJbr0xxm8I5tiqfUmROjeYF+Wt39wE4FswtczZYsShE5aZui747oXsnUwNLlecJhPwPM7vQn/KfjjVbBqnHtvDuC4qI83pseiJrtunvVtuT4dYJVeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=O+SvTFNR; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FIQa1N020560;
	Mon, 15 Jul 2024 18:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pps0720; bh=b9w0XB6La
	ytVB7Wdf1B/UO3yLAMzxQddtR5FFc0xAXI=; b=O+SvTFNRZkkemnyioMs1vrQ4l
	jVXcMUACB5nrzwiDNaNGLK0k+O9ajXlVnjrVQN60+fXs7RAQT3Ja6X2OCm1iFRFJ
	0a88OzVEqSSOY7RLA9a+Ke9c/z/mpPgnSN/MoKJUPsavMDsLxQm3m+laJ2gGnX6L
	p6mnfnA6vTQfg+ROKKS5/TFEO0zZVn3c9fRlOi6tGjFSP6UK+1rJpL069I2gxA0W
	C/WW1mmIj7JTJhIqC31/fVWHBgLsyLgZVejeXd7EMGvs2F2CS7Toq5JRcD6gM3Oi
	7+QwaU5Eh0zo+ER6/kZamfEPvhgE7JRz60jPO3JGbdxMPfVj6CsSnqjOLMtqg==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 40d920g5dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:53:14 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 62DFF147B7;
	Mon, 15 Jul 2024 18:53:13 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 4597380A808;
	Mon, 15 Jul 2024 18:53:11 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id D919B3003D738; Mon, 15 Jul 2024 13:53:09 -0500 (CDT)
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
Subject: [PATCH v2 1/2] x86/kexec: Add EFI config table identity mapping for kexec kernel
Date: Mon, 15 Jul 2024 13:53:08 -0500
Message-Id: <20240715185309.1637839-2-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240715185309.1637839-1-steve.wahl@hpe.com>
References: <20240715185309.1637839-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: erjPfCL_YkXRsiLsrvsUrX7KQgUKW0HO
X-Proofpoint-ORIG-GUID: erjPfCL_YkXRsiLsrvsUrX7KQgUKW0HO
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1011 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407150147

From: Tao Liu <ltao@redhat.com>

A kexec kernel boot failure is sometimes observed on AMD CPUs due to
an unmapped EFI config table array.  This can be seen when "nogbpages"
is on the kernel command line, and has been observed as a full BIOS
reboot rather than a successful kexec.

This was also the cause of reported regressions attributed to Commit
7143c5f4cf20 ("x86/mm/ident_map: Use gbpages only where full GB page
should be mapped.") which was subsequently reverted.

To avoid this page fault, explicitly include the EFI config table
array in the kexec identity map.

Further explanation:

The following 2 commits caused the EFI config table array to be
accessed when enabling sev at kernel startup.

    commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
                          earlier during boot")
    commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
                          detection/setup")

This is in the code that examines whether SEV should be enabled or
not, so it can even affect systems that are not SEV capable.

This may result in a page fault if the EFI config table array's
address is unmapped. Since the page fault occurs before the new kernel
establishes its own identity map and page fault routines, it is
unrecoverable and kexec fails.

Most often, this problem is not seen because the EFI config table
array gets included in the map by the luck of being placed at a memory
address close enough to other memory areas that *are* included in the
map created by kexec.

Both the "nogbpages" command line option and the "use gpbages only
where full GB page should be mapped" patch greatly reduce the chance
of being included in the map by luck, which is why the problem
appears.

Signed-off-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
---
 arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index cc0f7f70b17b..563d119f9f29 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -83,10 +84,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 #endif
 
 static int
-map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
+map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -102,6 +105,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 	if (!mstart)
 		return 0;
 
+	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI system table\n");
+		return -ENOMEM;
+	}
+
+	mstart = efi_config_table;
+
+	if (efi_enabled(EFI_64BIT)) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
+	}
+
+	memunmap(kaddr);
+
 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;
@@ -241,10 +268,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	}
 
 	/*
-	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
-	 * not covered by pfn_mapped.
+	 * Prepare EFI systab, config table and ACPI tables for kexec kernel
+	 * since they are not covered by pfn_mapped.
 	 */
-	result = map_efi_systab(&info, level4p);
+	result = map_efi_tables(&info, level4p);
 	if (result)
 		return result;
 
-- 
2.26.2


