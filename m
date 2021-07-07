Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460973BEF08
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhGGSkd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:33 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232369AbhGGSkb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6NAUXyBpU51M4/drdV6Z4xkxWMmJVUYbn2qhw77XS9hMfyJXOnISWomre+HpLQgyWuejLndizrUtmYA8kTTdTNz0P2dMJbJ7b7rC4lmI1lhcOMlIvlHi/Nsu059ITZ41I1zU58g8vuqjC+aj9oROESb/CTq0Vi+TI6beU0hOmG9KZFuRePMiCynw06uXauQB8UCtNZ2zZPLnC9xLPsG5ThFQi1ITECHg/W1wb+X2j+IGkyW5V8jsRa91xBr+H5JwruLilrcSDl35iUVQlfkb9d2gNaxUXVamE1cGnj4ph7jtJ+tIBoEtqPj6+QEiOwVTKbpWpQYegvrFWgA+faJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ4in03Krb7voDtgn7kjfUai+nWihgOPG5KL0CHAy4s=;
 b=lG256+nznWTlBK3o9s/XyvyCujSIzctwUguzFUjSaH3uTGQlux1uVNeZ+Hkt92anIMYNA5F5A5F7khZ6HwAr+ycaBn/ve/5KIzFBSRC5ijg8wa6VIqXPIrSlmEaKzmB3+kFYvzMSoxLorR319jWESQtSVu11ntwxgzUBc/CFXHC9JNNbvxyMyCdBGlXGSt8r2mAiB96kEWxj9YySzD2kQLocwZz4cY4Nf89i+j1t5wdbXh/yX8n8JjPS7mPGjkQ0keVcQRiNq8jBPNvRaefJFKLH6EyWA7qj5ogO33Nnpe498z6m8rzxLfV9wm0+U8yLmPiuwKBWUxb+B2pmdgT9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ4in03Krb7voDtgn7kjfUai+nWihgOPG5KL0CHAy4s=;
 b=unl1AjeZZ9RS/zbYB0hNrevSf9KKcpYZYVb+I4E1lDMUfkjrpQ+c5ivPaoQ+s0SIC3L7xx3iJbt8j8VQ41GBLSUUGogoAjpKMihIYMDV15xJxCLPA7x2WdwMNoFYuUYcQVOHUKMUrKuvpRZi49vzcsaUfA6e7H5grtkrNhaO4zc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:36 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:36 +0000
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
Subject: [PATCH Part2 RFC v4 16/40] crypto: ccp: Handle the legacy SEV command when SNP is enabled
Date:   Wed,  7 Jul 2021 13:35:52 -0500
Message-Id: <20210707183616.5620-17-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fcc53c9-8a97-424a-1f40-08d941764a8e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2808F70710C7781A86D0CFC2E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PntqqJwGtY0yqq2/qc/gFPABRGBc4fsUNwOLyaYVb4GcLeb7SVYFhYg8l/bPuGuB9e0lYpkrkRG0hrunsDlQrGoC2SKOc9WFjgtAaN+iaHKCZ53Lf3NcsXUZADF8I/FeerDAQXw3lCMmciMBJkTwvkCoGGfmPxBJTqJ58txP167lhx2uYlUQQJMY3SaFou6bLIryaNbeYFjP+Ard20qhwyorlP56PP+QbpD6/6DlVJS38ojaYoG/q2WOtTMAc3UXdLVcbA7jt3fC4GtYHkMUiSJ4/bBiHxZu3nqRxB/hFPJTa2qwdZWbA8PSfAzvvgv9CJsvOAexliTrFCjkGIqCQp2u6bU8ndG2NMs/l1xjswMyrcdMLGoFD/mhwCqRiWx96eqSSjqhaFj+6oYyVylVzW3vkAakau24xkZDyFvtRFcW1YOEzZGzdVA2PA7OEJ38rDEnOJ5EqdlwTf8ieST7WSMGG9GBnXkKMoOvrnT+3KD45q8EvqD51Bco6mUD2Aba6SYL2Sstjs2a2BNRlyBuHGiuqM0KofuSq3bgPkqo1th6msjtlrGZPwG/9GbxM28OxWzcSJLNpIW9B5ChypKtR90bqEpZPtNpESrQMI/CD9wOUjRmI9/Bse06HfOByjM15mnLrvlZTlXBnljJBgDwzydK2hmZQlNCzHM5LMuXBKZOwdCqsLHvwW2FJY0OH8UdY+6cErNLceKQW7NQpEFotg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(30864003)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kclu9JL3xh6iWCzUehsQGJysKmAw0xGgFmyQLI1ZDwKBHVoCZ5jEAs4Jt5CR?=
 =?us-ascii?Q?3ub0g8BolcBSxX9b2iGAnjSByKcPUjk652Sg/9yRUaSxw2iFIOfClZ0Tp16e?=
 =?us-ascii?Q?7OXP6gSNmM3J98mz4MxNfWreOhWYQ4GGGTTVwXEZuEx12Utd7eu3xcCgcbUZ?=
 =?us-ascii?Q?O2t7/ZWHUwY27skeFtDpX6YBM7KH3i8/DPSP/Mg2PxkguFQcJ11uGGKbBTDR?=
 =?us-ascii?Q?QcFvF4mdrJ6vxFOppPuH6Tz3sWPDc3KRejs76zNrngroFkUAd+GtvUOPvkPD?=
 =?us-ascii?Q?9stDn3H03eCsK7geN2RA8GFEbkXd3wldm0gR5aflUkbo2TDmK1lpfqXBxO5w?=
 =?us-ascii?Q?9k9FBcxN8CyKmG6zKNYkKdEv/Zq7ZYBALgaN/Xq/DVRBPKx7TWBZFG7tCKyh?=
 =?us-ascii?Q?8WcQXVuGVSankVpHZO7LFR+XTBoz9939HgneHyg4HvRe3ckPvjqWrKvpFiPo?=
 =?us-ascii?Q?j3eVOxPaMwNNlI3N1qREjmCpPxYaT/HHDtHgDDSYYMIZydeWqXaDR1XBRZVO?=
 =?us-ascii?Q?zs2iP5jabOkWWOUhok/ykY41hcqUKJAhjtO9u0G+ch1OpRHKeo1xDCViPQnQ?=
 =?us-ascii?Q?LNp71uuQAT0n6+8mEvXD+Yjza+wW4ZCV7ePuziLoM3LZVpa0RPi/d4ZobLn5?=
 =?us-ascii?Q?w0awbo8VsWNahUWpsrEhazL9Etau27P5DLRrw2ZZjuGXRJgkd0mnG1/c4bpO?=
 =?us-ascii?Q?VwzuVaCkeMY7I9BihWuNlbCQMqjGQAbl4HDuwZPKM2uX16fJwqZyq97audPZ?=
 =?us-ascii?Q?xeGTB1XzdNV1gokMyf2OwYDZXyfPgZ8X7FSRT2aj+ME5CFxskFr9n+BJkHyi?=
 =?us-ascii?Q?5qLKiCBw186JDe4/J4573glUcPgdCgX4EV3RKeyuGErW+LtyqLIZL0JabIA7?=
 =?us-ascii?Q?V2VoxsPQCknyfSkk2zcgOX3tHckSMmIhxczBp6+RmTi++S2rPsZQs5SARTEI?=
 =?us-ascii?Q?9zFGxI0F/Yjbx2NFFOhUxnncvVUSH0jnBFzEfBP4YZ9CbElziVratsFTonrR?=
 =?us-ascii?Q?vEKzFJR5W9PQ13Sl0VASlzlyDts+P+UitVJbE1o8LRG+JmyLlxOOsIocsOpj?=
 =?us-ascii?Q?uUxxQvFj1ZU5b29Qur6eWiK+SdkRS5quzl5yB0sJrasCGEO6/hydp9O/UyYq?=
 =?us-ascii?Q?vqfr6Bc6KILbxnXoP/EFoXUyUQSePqARpcLiVhPO503KLQWXCmHhY5W3eCJt?=
 =?us-ascii?Q?Cl7ZS8tXfopotQ3gIaY0OwYfnaT4RkAiXT063EAwXdpA46X7YB0qG1BGsku2?=
 =?us-ascii?Q?qwtVeNUk37BLISvz0P02CDtO4i2Kpoon7cS9OHMLcpKneAApauOGxhY0cQEx?=
 =?us-ascii?Q?w++wOSxhfjnr6niudzh0YHe8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcc53c9-8a97-424a-1f40-08d941764a8e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:36.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llqbgZyD/2Bnr8kLz+fYNAguTc1a8HXN+XYgVu0c2PQjcDmv8JtyLXlRop832M0tJFHJLprKzP+01CsFqwcMcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The behavior of the SEV-legacy commands is altered when the SNP firmware
is in the INIT state. When SNP is in INIT state, all the SEV-legacy
commands that cause the firmware to write to memory must be in the
firmware state before issuing the command..

A command buffer may contains a system physical address that the firmware
may write to. There are two cases that need to be handled:

1) system physical address points to a guest memory
2) system physical address points to a host memory

To handle the case #1, map_firmware_writeable() helper simply
changes the page state in the RMP table before and after the command is
sent to the firmware.

For the case #2, the map_firmware_writeable() replaces the host system
physical memory with a pre-allocated firmware page, and after the command
completes, the unmap_firmware_writeable() copies the content from
pre-allocated firmware page to original host system physical.

The unmap_firmware_writeable() calls a __sev_do_cmd_locked() to clear
the immutable bit from the memory page. To support the nested calling,
a separate command buffer is required. Allocate a backup command buffer
and keep reference count of it. If a nested call is detected then use the
backup cmd_buf to complete the command submission.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 349 ++++++++++++++++++++++++++++++++++-
 drivers/crypto/ccp/sev-dev.h |  12 ++
 2 files changed, 351 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index bb07c68834a6..16f0d9211739 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -265,12 +265,300 @@ void snp_free_firmware_page(void *addr)
 }
 EXPORT_SYMBOL(snp_free_firmware_page);
 
+static int alloc_snp_host_map(struct sev_device *sev)
+{
+	struct page *page;
+	int i;
+
+	for (i = 0; i < MAX_SNP_HOST_MAP_BUFS; i++) {
+		struct snp_host_map *map = &sev->snp_host_map[i];
+
+		memset(map, 0, sizeof(*map));
+
+		page = __snp_alloc_firmware_pages(GFP_KERNEL_ACCOUNT,
+						  get_order(SEV_FW_BLOB_MAX_SIZE), false);
+		if (!page)
+			return -ENOMEM;
+
+		map->host = page_address(page);
+	}
+
+	return 0;
+}
+
+static void free_snp_host_map(struct sev_device *sev)
+{
+	int i;
+
+	for (i = 0; i < MAX_SNP_HOST_MAP_BUFS; i++) {
+		struct snp_host_map *map = &sev->snp_host_map[i];
+
+		if (map->host) {
+			__snp_free_firmware_pages(virt_to_page(map->host),
+						  get_order(SEV_FW_BLOB_MAX_SIZE),
+						  false);
+			memset(map, 0, sizeof(*map));
+		}
+	}
+}
+
+static int map_firmware_writeable(u64 *paddr, u32 len, bool guest, struct snp_host_map *map)
+{
+	unsigned int npages = PAGE_ALIGN(len) >> PAGE_SHIFT;
+	int ret;
+
+	map->active = false;
+
+	if (!paddr || !len)
+		return 0;
+
+	map->paddr = *paddr;
+	map->len = len;
+
+	/* If paddr points to a guest memory then change the page state to firmwware. */
+	if (guest) {
+		struct rmpupdate val = {};
+
+		val.immutable = true;
+		val.assigned = true;
+		ret = snp_set_rmptable_state(*paddr, npages, &val, true, false);
+		if (ret)
+			return ret;
+
+		goto done;
+	}
+
+	if (unlikely(!map->host))
+		return -EINVAL;
+
+	/* Check if the pre-allocated buffer can be used to fullfil the request. */
+	if (unlikely(len > SEV_FW_BLOB_MAX_SIZE))
+		return -EINVAL;
+
+	/* Set the paddr to use an intermediate firmware buffer */
+	*paddr = __psp_pa(map->host);
+
+done:
+	map->active = true;
+	return 0;
+}
+
+static int unmap_firmware_writeable(u64 *paddr, u32 len, bool guest, struct snp_host_map *map)
+{
+	unsigned int npages = PAGE_ALIGN(len) >> PAGE_SHIFT;
+	int ret;
+
+	if (!map->active)
+		return 0;
+
+	/* If paddr points to a guest memory then restore the page state to hypervisor. */
+	if (guest) {
+		struct rmpupdate val = {};
+
+		ret = snp_set_rmptable_state(*paddr, npages, &val, true, true);
+		if (ret)
+			return ret;
+
+		goto done;
+	}
+
+	/* Copy the response data firmware buffer to the callers buffer. */
+	memcpy(__va(__sme_clr(map->paddr)), map->host, min_t(size_t, len, map->len));
+	*paddr = map->paddr;
+
+done:
+	map->active = false;
+	return 0;
+}
+
+static bool sev_legacy_cmd_buf_writable(int cmd)
+{
+	switch (cmd) {
+	case SEV_CMD_PLATFORM_STATUS:
+	case SEV_CMD_GUEST_STATUS:
+	case SEV_CMD_LAUNCH_START:
+	case SEV_CMD_RECEIVE_START:
+	case SEV_CMD_LAUNCH_MEASURE:
+	case SEV_CMD_SEND_START:
+	case SEV_CMD_SEND_UPDATE_DATA:
+	case SEV_CMD_SEND_UPDATE_VMSA:
+	case SEV_CMD_PEK_CSR:
+	case SEV_CMD_PDH_CERT_EXPORT:
+	case SEV_CMD_GET_ID:
+	case SEV_CMD_ATTESTATION_REPORT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+#define prep_buffer(name, addr, len, guest, map)  \
+	   func(&((typeof(name *))cmd_buf)->addr, ((typeof(name *))cmd_buf)->len, guest, map)
+
+static int __snp_cmd_buf_copy(int cmd, void *cmd_buf, bool to_fw, int fw_err)
+{
+	int (*func)(u64 *paddr, u32 len, bool guest, struct snp_host_map *map);
+	struct sev_device *sev = psp_master->sev_data;
+	struct rmpupdate val = {};
+	bool from_fw = !to_fw;
+	int ret;
+
+	/*
+	 * After the command is completed, change the command buffer memory to
+	 * hypervisor state.
+	 *
+	 * The immutable bit is automatically cleared by the firmware, so
+	 * no not need to reclaim the page.
+	 */
+	if (from_fw && sev_legacy_cmd_buf_writable(cmd)) {
+		ret = snp_set_rmptable_state(__pa(cmd_buf), 1, &val, true, false);
+		if (ret)
+			return ret;
+
+		/* No need to go further if firmware failed to execute command. */
+		if (fw_err)
+			return 0;
+	}
+
+	if (to_fw)
+		func = map_firmware_writeable;
+	else
+		func = unmap_firmware_writeable;
+
+	/*
+	 * A command buffer may contains a system physical address. If the address
+	 * points to a host memory then use an intermediate firmware page otherwise
+	 * change the page state in the RMP table.
+	 */
+	switch (cmd) {
+	case SEV_CMD_PDH_CERT_EXPORT:
+		if (prep_buffer(struct sev_data_pdh_cert_export, pdh_cert_address,
+				pdh_cert_len, false, &sev->snp_host_map[0]))
+			goto err;
+		if (prep_buffer(struct sev_data_pdh_cert_export, cert_chain_address,
+				cert_chain_len, false, &sev->snp_host_map[1]))
+			goto err;
+		break;
+	case SEV_CMD_GET_ID:
+		if (prep_buffer(struct sev_data_get_id, address, len,
+				false, &sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_PEK_CSR:
+		if (prep_buffer(struct sev_data_pek_csr, address, len,
+				    false, &sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_LAUNCH_UPDATE_DATA:
+		if (prep_buffer(struct sev_data_launch_update_data, address, len,
+				    true, &sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_LAUNCH_UPDATE_VMSA:
+		if (prep_buffer(struct sev_data_launch_update_vmsa, address, len,
+				true, &sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_LAUNCH_MEASURE:
+		if (prep_buffer(struct sev_data_launch_measure, address, len,
+				false, &sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_LAUNCH_UPDATE_SECRET:
+		if (prep_buffer(struct sev_data_launch_secret, guest_address, guest_len,
+				true, &sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_DBG_DECRYPT:
+		if (prep_buffer(struct sev_data_dbg, dst_addr, len, false,
+				&sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_DBG_ENCRYPT:
+		if (prep_buffer(struct sev_data_dbg, dst_addr, len, true,
+				&sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_ATTESTATION_REPORT:
+		if (prep_buffer(struct sev_data_attestation_report, address, len,
+				false, &sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_SEND_START:
+		if (prep_buffer(struct sev_data_send_start, session_address,
+				session_len, false, &sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_SEND_UPDATE_DATA:
+		if (prep_buffer(struct sev_data_send_update_data, hdr_address, hdr_len,
+				false, &sev->snp_host_map[0]))
+			goto err;
+		if (prep_buffer(struct sev_data_send_update_data, trans_address,
+				trans_len, false, &sev->snp_host_map[1]))
+			goto err;
+		break;
+	case SEV_CMD_SEND_UPDATE_VMSA:
+		if (prep_buffer(struct sev_data_send_update_vmsa, hdr_address, hdr_len,
+				false, &sev->snp_host_map[0]))
+			goto err;
+		if (prep_buffer(struct sev_data_send_update_vmsa, trans_address,
+				trans_len, false, &sev->snp_host_map[1]))
+			goto err;
+		break;
+	case SEV_CMD_RECEIVE_UPDATE_DATA:
+		if (prep_buffer(struct sev_data_receive_update_data, guest_address,
+				guest_len, true, &sev->snp_host_map[0]))
+			goto err;
+		break;
+	case SEV_CMD_RECEIVE_UPDATE_VMSA:
+		if (prep_buffer(struct sev_data_receive_update_vmsa, guest_address,
+				guest_len, true, &sev->snp_host_map[0]))
+			goto err;
+		break;
+	default:
+		break;
+	}
+
+	/* The command buffer need to be in the firmware state. */
+	if (to_fw && sev_legacy_cmd_buf_writable(cmd)) {
+		val.assigned = true;
+		val.immutable = true;
+		ret = snp_set_rmptable_state(__pa(cmd_buf), 1, &val, true, false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+
+err:
+	return -EINVAL;
+}
+
+static inline bool need_firmware_copy(int cmd)
+{
+	struct sev_device *sev = psp_master->sev_data;
+
+	/* After SNP is INIT'ed, the behavior of legacy SEV command is changed. */
+	return ((cmd < SEV_CMD_SNP_INIT) && sev->snp_inited) ? true : false;
+}
+
+static int snp_aware_copy_to_firmware(int cmd, void *data)
+{
+	return __snp_cmd_buf_copy(cmd, data, true, 0);
+}
+
+static int snp_aware_copy_from_firmware(int cmd, void *data, int fw_err)
+{
+	return __snp_cmd_buf_copy(cmd, data, false, fw_err);
+}
+
 static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 {
 	struct psp_device *psp = psp_master;
 	struct sev_device *sev;
 	unsigned int phys_lsb, phys_msb;
 	unsigned int reg, ret = 0;
+	void *cmd_buf;
 	int buf_len;
 
 	if (!psp || !psp->sev_data)
@@ -290,12 +578,26 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	 * work for some memory, e.g. vmalloc'd addresses, and @data may not be
 	 * physically contiguous.
 	 */
-	if (data)
-		memcpy(sev->cmd_buf, data, buf_len);
+	if (data) {
+		if (unlikely(sev->cmd_buf_active > 2))
+			return -EBUSY;
+
+		cmd_buf = sev->cmd_buf_active ? sev->cmd_buf_backup : sev->cmd_buf;
+
+		memcpy(cmd_buf, data, buf_len);
+		sev->cmd_buf_active++;
+
+		/*
+		 * The behavior of the SEV-legacy commands is altered when the
+		 * SNP firmware is in the INIT state.
+		 */
+		if (need_firmware_copy(cmd) && snp_aware_copy_to_firmware(cmd, sev->cmd_buf))
+			return -EFAULT;
+	}
 
 	/* Get the physical address of the command buffer */
-	phys_lsb = data ? lower_32_bits(__psp_pa(sev->cmd_buf)) : 0;
-	phys_msb = data ? upper_32_bits(__psp_pa(sev->cmd_buf)) : 0;
+	phys_lsb = data ? lower_32_bits(__psp_pa(cmd_buf)) : 0;
+	phys_msb = data ? upper_32_bits(__psp_pa(cmd_buf)) : 0;
 
 	dev_dbg(sev->dev, "sev command id %#x buffer 0x%08x%08x timeout %us\n",
 		cmd, phys_msb, phys_lsb, psp_timeout);
@@ -336,15 +638,24 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 		ret = -EIO;
 	}
 
-	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
-			     buf_len, false);
-
 	/*
 	 * Copy potential output from the PSP back to data.  Do this even on
 	 * failure in case the caller wants to glean something from the error.
 	 */
-	if (data)
-		memcpy(data, sev->cmd_buf, buf_len);
+	if (data) {
+		/*
+		 * Restore the page state after the command completes.
+		 */
+		if (need_firmware_copy(cmd) &&
+		    snp_aware_copy_from_firmware(cmd, cmd_buf, ret))
+			return -EFAULT;
+
+		memcpy(data, cmd_buf, buf_len);
+		sev->cmd_buf_active--;
+	}
+
+	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
+			     buf_len, false);
 
 	return ret;
 }
@@ -1219,10 +1530,12 @@ int sev_dev_init(struct psp_device *psp)
 	if (!sev)
 		goto e_err;
 
-	sev->cmd_buf = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
+	sev->cmd_buf = (void *)devm_get_free_pages(dev, GFP_KERNEL, 1);
 	if (!sev->cmd_buf)
 		goto e_sev;
 
+	sev->cmd_buf_backup = (uint8_t *)sev->cmd_buf + PAGE_SIZE;
+
 	psp->sev_data = sev;
 
 	sev->dev = dev;
@@ -1276,6 +1589,12 @@ static void sev_firmware_shutdown(struct sev_device *sev)
 		sev_es_tmr = NULL;
 	}
 
+	/*
+	 * The host map need to clear the immutable bit so it must be free'd before the
+	 * SNP firmware shutdown.
+	 */
+	free_snp_host_map(sev);
+
 	sev_snp_shutdown(NULL);
 }
 
@@ -1335,6 +1654,14 @@ void sev_pci_init(void)
 			 */
 			dev_err(sev->dev, "SEV-SNP: failed to INIT error %#x\n", error);
 		}
+
+		/*
+		 * Allocate the intermediate buffers used for the legacy command handling.
+		 */
+		if (alloc_snp_host_map(sev)) {
+			dev_notice(sev->dev, "Failed to alloc host map (disabling legacy SEV)\n");
+			goto skip_legacy;
+		}
 	}
 
 	/* Obtain the TMR memory area for SEV-ES use */
@@ -1364,12 +1691,14 @@ void sev_pci_init(void)
 	if (rc)
 		dev_err(sev->dev, "SEV: failed to INIT error %#x\n", error);
 
+skip_legacy:
 	dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_inited ?
 		"-SNP" : "", sev->api_major, sev->api_minor, sev->build);
 
 	return;
 
 err:
+	free_snp_host_map(sev);
 	psp_master->sev_data = NULL;
 }
 
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index 186ad20cbd24..fe5d7a3ebace 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -29,11 +29,20 @@
 #define SEV_CMDRESP_CMD_SHIFT		16
 #define SEV_CMDRESP_IOC			BIT(0)
 
+#define MAX_SNP_HOST_MAP_BUFS		2
+
 struct sev_misc_dev {
 	struct kref refcount;
 	struct miscdevice misc;
 };
 
+struct snp_host_map {
+	u64 paddr;
+	u32 len;
+	void *host;
+	bool active;
+};
+
 struct sev_device {
 	struct device *dev;
 	struct psp_device *psp;
@@ -52,8 +61,11 @@ struct sev_device {
 	u8 build;
 
 	void *cmd_buf;
+	void *cmd_buf_backup;
+	int cmd_buf_active;
 
 	bool snp_inited;
+	struct snp_host_map snp_host_map[MAX_SNP_HOST_MAP_BUFS];
 };
 
 int sev_dev_init(struct psp_device *psp);
-- 
2.17.1

