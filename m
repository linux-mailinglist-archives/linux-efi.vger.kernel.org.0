Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CEC3BEEF8
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhGGSkY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:24 -0400
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:41569
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232259AbhGGSkT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDYthwjiGG7FkV/g4NsBAYqytCkZR40+fBN89+hj3ew3uRuJJctjXC8QXbc5L/+LfvN1kPNS/QyrPnzAqm3w56Y3GqwWg010SK5mfc0GnHgccloN8G0e+w76O9co648VbiPYNHxpUtSwWzTEG2SSiT/UDU7rBqMMKQABV3eJs+3feGmJ5YwzYPIntsyufcL2mHghpSkOBhr0IMAjrNsoubKdn8QLNXYbRgUq5ZsLnyxSkh6LLHpR2kN+BC3HBPJMTW4TU8rI5b1vou5b8NLvVCo49h20XbfE7eToBgFZmjeEKvwEhMBU3kUHnW4okEgcSd0Db06y8ZWDYVui4zfPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6meje0A3UyP2kOLcB4Jn68av1kIezGpIQGps9JlqNA=;
 b=frU/5JSEpkAvv1XngAd4ttf7PL69LrT7HVIWIuz8w450AwyGn9JTynUFD8HH+MKsyYYUQsiTZcqh5M0THO5ybWbBBDhLdTvbyn0CuSeRWarz6PIP4sfKLmDgP8nRrgeRFY2Fpfa0vqCEaN4mhvWbjUT2cYz6FA4XvSPqL4HpDPtzSfPT/XVlIrau7KlitYk4OF+pzJJAJG+uXYclObSsO06Av6RC0NXJ4h0HuWS+DuPirVGeCqYjfatosMvRiD1svMba+x1DnclMhQCrVlzBsrqbu3BFg6N7kYSiBwFlOw2U8MhEoggk4tJT0Hx2mn2zVLnwoAsdX5BBe4dUMyP+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6meje0A3UyP2kOLcB4Jn68av1kIezGpIQGps9JlqNA=;
 b=eDrvsUgi67/0kIQjLJ9QzMxLcyKA0M0dSR0vnDjHpUpuyS313SsqE7b2qNRnUK0W8tyNrAjEv0MdnEPaV7ffOyFYZNhA+mtanE9PQG/LFltMVgRE2sSb97HzxhclH/xc9dLpTJwzcEmjBijbniffJk2AIUXxyBQjtHZ7UzMRt2E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:37:33 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:33 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part2 RFC v4 15/40] crypto: ccp: Handle the legacy TMR allocation when SNP is enabled
Date:   Wed,  7 Jul 2021 13:35:51 -0500
Message-Id: <20210707183616.5620-16-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55b00c69-14d7-4ec7-0351-08d9417648b2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4082920AE0AE22E4DBD8B71CE51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttoTPZqrULI2Y/DY2pq3w7rAskmFVknsJkW8yhUz61CgUtFiI2U90PRvET63XXVd7dIUlnpILlfzKAC8MZu1TByXCjaLeFbM/hqcFvWKNRRjSz/vhHlwk6FwZASfP1uGDhhjyygmiT/C9RGEjHvuCsTputNgyl41uUugZ6DLhKwMztmirhGLjYp2wP1b96jWSdHEbhrwgB/sVK8Fo230AMUV3RqztooRHBhh41udoff77JThOU8Jwkd5375r9yRqKyL8Wl8nu7s6ZyRBAXDlFFvZKiMlNxn3UVB5Sq91wmYv8gUYzKHg52hExVhY1vVE4E9uvxarlNsLGZx65wkjSncEE/smZOXSxMEamayedZoGbRVnQuMSoENWLBEy4Sd0KC4dnSedGrW21bZx/l0BCHYhuvztNSF/DditLKdiFu2dmCUb01RTSHAtnai++WDOnXAPmedjVXkl+n9nDLabq5GITXajazZJ+EO2lP9vE+mDgRZRMtKN/B4htEF127sn75ROU8YcreZ9HQg57JDemmBcYk6W5woEKXZUBnKMY/hU1l2thpzvV+gN3WizdMYle8jt4fHc6AB1HzWSVFimrfZZz0SzuX/Q2oQ13NXV32ELfgZrB4Pu/aDxtmh/vZxdtDhTl/sxPuiQcpftIxZvmuYU/C1ZigGbqzIHFOZ4UhMwpFz95bK+0LwrocF5/zJhUF0Ei5+6/9iK+Zwsl+DxOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(6666004)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NQUhxKeiOwmezTpxFo4Mxmakn99e3nQjCzTHg2y8z2ChXgOHPaNMblZ5+mBC?=
 =?us-ascii?Q?inCLbbkzsZu/rkZsks4Uz7PoyivPp48rEYRoQH5nbARRjcBPWUyYBBHZYBdn?=
 =?us-ascii?Q?rQFgw+1ve0iFbbty9tGEHzUH0RalTwGd3/yT0fbSr+4oXu2qWh5Z3bZC98u6?=
 =?us-ascii?Q?VthH2gpr4V+AQChwf2Z1Z1INXLY0Sftn2Tb0c2fPVGD8HFRHnf9AQ9HbqbQo?=
 =?us-ascii?Q?dVMRCgfbq8lhoY669DB0WWSu83ox5tJUtmFnH8g3RA5lXUu4wI90M0EtqssS?=
 =?us-ascii?Q?X1cEtYoWtGmM8uRR1lPNqL+L5dvRwBKqoxnrkrEl7B7lhB1nFpMQ+dQUIWyW?=
 =?us-ascii?Q?tGUwz1Ug4R9HTYGhtHJoRJVUl+Gakfh5mQ/Xe7bjYfWAiBZsFsrajdt3MSPD?=
 =?us-ascii?Q?PlnUeXrMR7Ude4bxK1g8Ej1WvJ58cs0Bu3Rh4s5cJ0TXgFoaSz3IOHT5MsMz?=
 =?us-ascii?Q?xARauZcc/nP8Chc+CYTMUh1h28znjMughE8/nPArvtuc9Ag4CAEWDAxcdrNF?=
 =?us-ascii?Q?NVfUO2/x4Rln4UVDkhuX+h5fYdDpZT9Hk8/XyBqdIJ2FJIggkAeaJzTMBpR6?=
 =?us-ascii?Q?p8w+pDTGjBl+I2NSL/4Qk+O37Y7oCFJQQ6PwuZD+62YF+hcdxlNsQt4wfmCW?=
 =?us-ascii?Q?1iJomrNI2mjuxzYX4dRFCk9v0UfQE470p3WAFHW20A1OVdcBsLMBP0W7hjfP?=
 =?us-ascii?Q?s1uayzqY2chMvrxrvVAjM60vfpqbcP3d8MxZWo4i/N8wdm/BK/9KSuxa5xry?=
 =?us-ascii?Q?HGDXITEtvt3+Ax2OxxZuOHVd+bTc4uR7POpsxQWY8de/a24hA3bTnLolt5br?=
 =?us-ascii?Q?MlCK+GZqIu/Usfal6wRTGC4hPsiN3ikOC7JWslX9BEyhN1YbdkLYxjZjWyom?=
 =?us-ascii?Q?xSsFypXNNjF+mTbUTuWUYx8d+7eXgud9GetevfdW5wYSIYZcMKgrpJxGdZpg?=
 =?us-ascii?Q?rB+fbcPi44m5jkSst3H7WvavMXpqLDuUlFBFyD8+nx1eetRRd5OltyH6iZJe?=
 =?us-ascii?Q?bYMSVqnwZW7VorcRHnK8Iqo65alzsI2tuF9ouffoyRaq4zEMnVNbRWqj21vW?=
 =?us-ascii?Q?hjXcwGTR3ccpz18MHf0hdBgS5xS+6sPWkcZ+2Z1A+MwmaY/jmWWlsHfctO3O?=
 =?us-ascii?Q?m+iLDbbhTGFWTYoDITwjMXxsMagwPO8Ks6rXC5mxW6QMan5gKKcMCkvLcSM5?=
 =?us-ascii?Q?mQvAtVb3I9QtplYOj2QCwGoh4AiYN1POj75oYbCOgSUdd7GIGh54UCI493h6?=
 =?us-ascii?Q?8n5DI0pA8tiPgQegBB4Q2DaKK7AAghzyBlG2wQdnRRlQgv4Q6HmQGTDNzcO+?=
 =?us-ascii?Q?ExsatwLB7pl1BkTH3+hSu+iG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b00c69-14d7-4ec7-0351-08d9417648b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:33.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G061MTc118sHuYF/keMLhkS058cmjGKbvRdseA5rmeUg2k1HS4bEcjzHJuKruaHl3fUSBdjKZwrfleZBkAYq5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The behavior and requirement for the SEV-legacy command is altered when
the SNP firmware is in the INIT state. See SEV-SNP firmware specification
for more details.

When SNP is INIT state, all the SEV-legacy commands that cause the
firmware to write memory must be in the firmware state. The TMR memory
is allocated by the host but updated by the firmware, so, it must be
in the firmware state.  Additionally, the TMR memory must be a 2MB aligned
instead of the 1MB, and the TMR length need to be 2MB instead of 1MB.
The helper __snp_{alloc,free}_firmware_pages() can be used for allocating
and freeing the memory used by the firmware.

While at it, provide API that can be used by others to allocate a page
that can be used by the firmware. The immediate user for this API will
be the KVM driver. The KVM driver to need to allocate a firmware context
page during the guest creation. The context page need to be updated
by the firmware. See the SEV-SNP specification for further details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 144 +++++++++++++++++++++++++++++++----
 include/linux/psp-sev.h      |  11 +++
 2 files changed, 142 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index ad9a0c8111e0..bb07c68834a6 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -54,6 +54,14 @@ static int psp_timeout;
 #define SEV_ES_TMR_SIZE		(1024 * 1024)
 static void *sev_es_tmr;
 
+/* When SEV-SNP is enabled the TMR need to be 2MB aligned and 2MB size. */
+#define SEV_SNP_ES_TMR_SIZE	(2 * 1024 * 1024)
+
+static size_t sev_es_tmr_size = SEV_ES_TMR_SIZE;
+
+static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret);
+static int sev_do_cmd(int cmd, void *data, int *psp_ret);
+
 static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -151,6 +159,112 @@ static int sev_cmd_buffer_len(int cmd)
 	return 0;
 }
 
+static int snp_reclaim_page(struct page *page, bool locked)
+{
+	struct sev_data_snp_page_reclaim data = {};
+	int ret, err;
+
+	data.paddr = page_to_pfn(page) << PAGE_SHIFT;
+
+	if (locked)
+		ret = __sev_do_cmd_locked(SEV_CMD_SNP_PAGE_RECLAIM, &data, &err);
+	else
+		ret = sev_do_cmd(SEV_CMD_SNP_PAGE_RECLAIM, &data, &err);
+
+	return ret;
+}
+
+static int snp_set_rmptable_state(unsigned long paddr, int npages,
+				  struct rmpupdate *val, bool locked, bool need_reclaim)
+{
+	unsigned long pfn = __sme_clr(paddr) >> PAGE_SHIFT;
+	unsigned long pfn_end = pfn + npages;
+	struct psp_device *psp = psp_master;
+	struct sev_device *sev;
+	int rc;
+
+	if (!psp || !psp->sev_data)
+		return 0;
+
+	/* If SEV-SNP is initialized then add the page in RMP table. */
+	sev = psp->sev_data;
+	if (!sev->snp_inited)
+		return 0;
+
+	while (pfn < pfn_end) {
+		if (need_reclaim)
+			if (snp_reclaim_page(pfn_to_page(pfn), locked))
+				return -EFAULT;
+
+		rc = rmpupdate(pfn_to_page(pfn), val);
+		if (rc)
+			return rc;
+
+		pfn++;
+	}
+
+	return 0;
+}
+
+static struct page *__snp_alloc_firmware_pages(gfp_t gfp_mask, int order, bool locked)
+{
+	struct rmpupdate val = {};
+	unsigned long paddr;
+	struct page *page;
+
+	page = alloc_pages(gfp_mask, order);
+	if (!page)
+		return NULL;
+
+	val.assigned = 1;
+	val.immutable = 1;
+	paddr = __pa((unsigned long)page_address(page));
+
+	if (snp_set_rmptable_state(paddr, 1 << order, &val, locked, false)) {
+		pr_warn("Failed to set page state (leaking it)\n");
+		return NULL;
+	}
+
+	return page;
+}
+
+void *snp_alloc_firmware_page(gfp_t gfp_mask)
+{
+	struct page *page;
+
+	page = __snp_alloc_firmware_pages(gfp_mask, 0, false);
+
+	return page ? page_address(page) : NULL;
+}
+EXPORT_SYMBOL_GPL(snp_alloc_firmware_page);
+
+static void __snp_free_firmware_pages(struct page *page, int order, bool locked)
+{
+	struct rmpupdate val = {};
+	unsigned long paddr;
+
+	if (!page)
+		return;
+
+	paddr = __pa((unsigned long)page_address(page));
+
+	if (snp_set_rmptable_state(paddr, 1 << order, &val, locked, true)) {
+		pr_warn("Failed to set page state (leaking it)\n");
+		return;
+	}
+
+	__free_pages(page, order);
+}
+
+void snp_free_firmware_page(void *addr)
+{
+	if (!addr)
+		return;
+
+	__snp_free_firmware_pages(virt_to_page(addr), 0, false);
+}
+EXPORT_SYMBOL(snp_free_firmware_page);
+
 static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 {
 	struct psp_device *psp = psp_master;
@@ -273,7 +387,7 @@ static int __sev_platform_init_locked(int *error)
 
 		data.flags |= SEV_INIT_FLAGS_SEV_ES;
 		data.tmr_address = tmr_pa;
-		data.tmr_len = SEV_ES_TMR_SIZE;
+		data.tmr_len = sev_es_tmr_size;
 	}
 
 	rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
@@ -630,6 +744,8 @@ static int __sev_snp_init_locked(int *error)
 	sev->snp_inited = true;
 	dev_dbg(sev->dev, "SEV-SNP firmware initialized\n");
 
+	sev_es_tmr_size = SEV_SNP_ES_TMR_SIZE;
+
 	return rc;
 }
 
@@ -1153,8 +1269,10 @@ static void sev_firmware_shutdown(struct sev_device *sev)
 		/* The TMR area was encrypted, flush it from the cache */
 		wbinvd_on_all_cpus();
 
-		free_pages((unsigned long)sev_es_tmr,
-			   get_order(SEV_ES_TMR_SIZE));
+
+		__snp_free_firmware_pages(virt_to_page(sev_es_tmr),
+					  get_order(sev_es_tmr_size),
+					  false);
 		sev_es_tmr = NULL;
 	}
 
@@ -1204,16 +1322,6 @@ void sev_pci_init(void)
 	    sev_update_firmware(sev->dev) == 0)
 		sev_get_api_version();
 
-	/* Obtain the TMR memory area for SEV-ES use */
-	tmr_page = alloc_pages(GFP_KERNEL, get_order(SEV_ES_TMR_SIZE));
-	if (tmr_page) {
-		sev_es_tmr = page_address(tmr_page);
-	} else {
-		sev_es_tmr = NULL;
-		dev_warn(sev->dev,
-			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
-	}
-
 	/*
 	 * If boot CPU supports the SNP, then first attempt to initialize
 	 * the SNP firmware.
@@ -1229,6 +1337,16 @@ void sev_pci_init(void)
 		}
 	}
 
+	/* Obtain the TMR memory area for SEV-ES use */
+	tmr_page = __snp_alloc_firmware_pages(GFP_KERNEL, get_order(sev_es_tmr_size), false);
+	if (tmr_page) {
+		sev_es_tmr = page_address(tmr_page);
+	} else {
+		sev_es_tmr = NULL;
+		dev_warn(sev->dev,
+			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
+	}
+
 	/* Initialize the platform */
 	rc = sev_platform_init(&error);
 	if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 63ef766cbd7a..b72a74f6a4e9 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -12,6 +12,8 @@
 #ifndef __PSP_SEV_H__
 #define __PSP_SEV_H__
 
+#include <linux/sev.h>
+
 #include <uapi/linux/psp-sev.h>
 
 #ifdef CONFIG_X86
@@ -920,6 +922,8 @@ int snp_guest_dbg_decrypt(struct sev_data_snp_dbg *data, int *error);
 
 
 void *psp_copy_user_blob(u64 uaddr, u32 len);
+void *snp_alloc_firmware_page(gfp_t mask);
+void snp_free_firmware_page(void *addr);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
@@ -961,6 +965,13 @@ static inline int snp_guest_dbg_decrypt(struct sev_data_snp_dbg *data, int *erro
 	return -ENODEV;
 }
 
+static inline void *snp_alloc_firmware_page(gfp_t mask)
+{
+	return NULL;
+}
+
+static inline void snp_free_firmware_page(void *addr) { }
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */
-- 
2.17.1

