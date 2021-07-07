Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6683BEF2A
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhGGSlJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:09 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232241AbhGGSku (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu9jI3zup+V/l2W5k3oMTXYtsVdL2zpQMOMhffSi0FQEfKSPMiezhYxGB6X3N/ZPpFRypEFtf7TZVftMwihuqwYjVEBuXVITEibQkowx+NQ7Bicl8nmK2e+2MHs10aYsxtCPyeR9IIy7yU8CrQDj8Bg+JkRdvAgsDsrlZSvzOvcXrGXSIstRiAl5SZtfc7F/G/995/duR3fM0MZCfYMxY5O0N2RYaK5iIrba1JBZ11tGFf83k35zhmbbEow7YgszRnNFjybNed5cCdGnmdFPbIZXR9G2YUzFJVl42oI+upaoouglkKMiyEuomaffWgPeaeyyDvqFOWSdbRydqWOi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Cans74cvKPxP3ukIl1IfG8AoF89e0TKgk7qplJCnc=;
 b=isZzvjJUM4ih7i2TVsdgqEoiANCGdkm2VxLcD+6AJNu9dnXgGv+5FKBnSC+nzWzdfkUvrv494Me6phFrQvE7zlLcjO5ZecCEAi7opzs6/4gmnmB5Zes77wZVTV3qDKIeacA2h/fG0t3lEMQT1PZBbe35Oq4j1ArvMnNJ2swDjFZQZig55mgStwkSNVqe0DHqW/0iln/9TqvQIJNxTMef2IeYD6tkG91ci2z4sczbEEa8TCjmhfeyfhioohu72uz3C/Px/DRAUFJRfV2liDmB56v+M573RyFPSstGTR8rka2Q4k1tfEF9Vkou0zhsX9ixBWmrv1N6GLYw7tIxdb5axg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Cans74cvKPxP3ukIl1IfG8AoF89e0TKgk7qplJCnc=;
 b=AV6WfwjDG0mN8Jz+zOzxt9wYt7X2uu2WLUsKeZXiHrPupDaLrzcMAWnQITfElO0ZJ2ol7ehb6C49NjCSQAnxxVhYaMka0AHQUQ4Elm3I1aw12zel7AGjYV8x3v78qjdjGQNKFe7uQ5pE/Mu/io/aRJP0TF/SbGG9uFiifR3khiM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:44 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:44 +0000
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
Subject: [PATCH Part2 RFC v4 19/40] crypto: ccp: provide APIs to query extended attestation report
Date:   Wed,  7 Jul 2021 13:35:55 -0500
Message-Id: <20210707183616.5620-20-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 240a33f4-1f2e-42c2-7f54-08d941764f31
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28088EF366F0213EBDD683F3E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XK4mvf2gvvJtUJn1fnrP4jj8CMmlPJ/ZG9lvba5s1VFl/pp7uq8/ThJVpDNKFZ3Z3vGcvIsDY5bHpc1ASUCT3klvxGJfe7tZbnlm9XqQhZB/+9kMOjN7pwVv3Ku3WYvq5oFYMbgHJcgnWWegoX/TwzL8MJn1abPPd12yO5BeFnUujAugx7vnlZMKbkqpeRsg7lZ963UCpnZZekMjqbhG3MU52LmFPMZ1JKds1j0s2VgkwICvNNTN6qCJngD4p67E7BeFc2IdoIJtPp4pICikK6351GrGFI0ZUT/1qXfmT3uYERQVBZTkWSR9YE3mLBTFlvrGVY00v1BrvV5hqPGfJnoM36LBlmDrxp52MfQaFrvP74oWWYgRM71O6K84tz7Gd8yks8pGivshLzE2alMOMGe+eziC3o12IdmyftPM0mEKHcQnMnrt260oP5A4R/m5VhkzqNYzme8haU2n/Q03KvVkzMjN/JpFab/+UU3bVNMN0H38fnPIpyMvWPn5HYqZe02+YNMZDjjkOsY/o+tbLyUXGhnRFkVkdXpJU4Br2FTTo4lPSWY3Z75zdyDJJ0J/gsETWNqVmjcus09p7WGdH2UtJNw3BGT//yGouDgf7D/yDmrA6+d/+LY1iFblVLUZ36v0SAkt37+a4l8MtNTYf2Yrs9lRM6/UdeLFu7JEMFLwlm/thQ+mZqZgld3Qvstd6kQ0+5AYYL5NTIqJDDbPwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5GVGWle4nzNPkUFPyNrg5JQ7IvtDnU7zP8rCX1fSLVGeShfn5PowL8kG+2ch?=
 =?us-ascii?Q?Fnv/0/9yNyGXGkCo4h3XYza2Y8xLpGNllTp4aqhnD/+8EQ2FDRUI+KzrIv/3?=
 =?us-ascii?Q?V6wpqV0ToGGSUITWdRVNXSzBp32fhA4IKJZVZryR+96nJjXK6H18TvHCK8WI?=
 =?us-ascii?Q?p/L6J6vl/liUpTtjgHAaIL8B83LKvixOmXjOlYYN2YUcq8SwR0JxHhm15Q3g?=
 =?us-ascii?Q?zQIoeHK7DzFwQq5NYefE/frKfxmFq8em1Vw27dqSNzOAcyyhZaqc0S36MufK?=
 =?us-ascii?Q?FGXhfGAe5Yuz8m5iiK3KtfXEPwp4g6OdJ9i9W1zz18lifafmXs83Aw31utuf?=
 =?us-ascii?Q?enbn8v4gIgUa+dNTSlXlwrdvaZ+NRcKuW3crBWtvp+hrSnAHvmLwmGbFBiG4?=
 =?us-ascii?Q?sKHbkdUBIbshmpqiOcZWFLUiGyfVJH41hm5kbuOc1W8VfQtA16NQZhVQq3eD?=
 =?us-ascii?Q?VEXzoApLBKKKc0VInu7/aM4wto+r4EMFQg1Uz8CdxCGZeHvO4gU/VH/vwY+1?=
 =?us-ascii?Q?kTqEyOCx6MdVnFdwq1PT8tMQvL2CbIJis8xX0Bq98qjmMf/zPHCOXlF1s7YZ?=
 =?us-ascii?Q?5dLykX+fFkHXbg8c/4oEUw+8e4IePuAsllnVE4c2YbnZJVYGPJ19Uc9YaJn5?=
 =?us-ascii?Q?z5Zk9kTgiDG91YPP5K2DZfL1ef8VfLaFiJF46eEI5BonRWQwexzVh7iUhL/q?=
 =?us-ascii?Q?iruM6KSyDW1b06tgS6C1LOk5jzzDahY2zOsPI4/TERIICjB0k5kV0u6+8BQI?=
 =?us-ascii?Q?ibPyWz4Oc4Orm69qW0d8fA+bPuLHZwPZ5rF7kO71tWItJiuP+VInuuet5jwT?=
 =?us-ascii?Q?7wqtZpcBrQaOfFD9QPXZEd3pvKA1NxB0RhtxqzMhIcxxV+FUtRyn1/vW+ANH?=
 =?us-ascii?Q?DNlC5eae1sprBpueMp1LMCMPFuXt6LGl0wLiVD2PYmJQXHomWuHI1NK8nHfL?=
 =?us-ascii?Q?PpSiLBfW5Cr6uQeLoUWTXN/5ZwjwyVxe3nuuLG1FA6DjM1rTVLwyRUArzBSH?=
 =?us-ascii?Q?wj7Njk/2DI96gIi+mXq8Jg6QbF1LDuVrx0vitAVx+nL7/jHAGuO8aZwpw1tP?=
 =?us-ascii?Q?f4fObYEEmmdJ4iLBpQ3z5AqU/DSiWEcHeyZZF/uUvMHYrKW8zKaOgCGiiqfl?=
 =?us-ascii?Q?EzObzTQXL/6S7QG+w2lQ4nyZOniLqZPaSb1SD6zlKjP7yVm2Y1bCETMnie3X?=
 =?us-ascii?Q?erx18xDhqjWwI726PrzKE1/gMNOF/wVHYfcuVndPQHMJHwDsJbfXkAdof7Lm?=
 =?us-ascii?Q?vj6h+c2XR0l5mqI+r/0rQvA9oL0G3M1p4hLtFOiCb+0uC8NCLRMgwvI7Qj78?=
 =?us-ascii?Q?Yk868lv7yQJ3d73tjZfmEhwd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240a33f4-1f2e-42c2-7f54-08d941764f31
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:44.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nb6GmDpY7EPuxkL7sKX/hnCXTMDdphmCWfAbjz1l6kohSnv8WvNxWs7sj5CQtopcdYajACCNvI1lwkAycUXE1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of the GHCB specification defines VMGEXIT that is used to get
the extended attestation report. The extended attestation report includes
the certificate blobs provided through the SNP_SET_EXT_CONFIG.

The snp_guest_ext_guest_request() will be used by the hypervisor to get
the extended attestation report. See the GHCB specification for more
details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 43 ++++++++++++++++++++++++++++++++++++
 include/linux/psp-sev.h      | 24 ++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 1984a7b2c4e1..4cc9c1dff49f 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -22,6 +22,7 @@
 #include <linux/firmware.h>
 #include <linux/gfp.h>
 #include <linux/cpufeature.h>
+#include <linux/sev-guest.h>
 
 #include <asm/smp.h>
 
@@ -1616,6 +1617,48 @@ int snp_guest_dbg_decrypt(struct sev_data_snp_dbg *data, int *error)
 }
 EXPORT_SYMBOL_GPL(snp_guest_dbg_decrypt);
 
+int snp_guest_ext_guest_request(struct sev_data_snp_guest_request *data,
+				unsigned long vaddr, unsigned long *npages, unsigned long *fw_err)
+{
+	unsigned long expected_npages;
+	struct sev_device *sev;
+	int rc;
+
+	if (!psp_master || !psp_master->sev_data)
+		return -ENODEV;
+
+	sev = psp_master->sev_data;
+
+	if (!sev->snp_inited)
+		return -EINVAL;
+
+	/*
+	 * Check if we have enough space to copy the certificate chain. Otherwise
+	 * return ERROR code defined in the GHCB specification.
+	 */
+	expected_npages = sev->snp_certs_len >> PAGE_SHIFT;
+	if (*npages < expected_npages) {
+		*npages = expected_npages;
+		*fw_err = SNP_GUEST_REQ_INVALID_LEN;
+		return -EINVAL;
+	}
+
+	rc = sev_do_cmd(SEV_CMD_SNP_GUEST_REQUEST, data, (int *)&fw_err);
+	if (rc)
+		return rc;
+
+	/* Copy the certificate blob */
+	if (sev->snp_certs_data) {
+		*npages = expected_npages;
+		memcpy((void *)vaddr, sev->snp_certs_data, *npages << PAGE_SHIFT);
+	} else {
+		*npages = 0;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(snp_guest_ext_guest_request);
+
 static void sev_exit(struct kref *ref)
 {
 	misc_deregister(&misc_dev->misc);
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index b72a74f6a4e9..2345ac6ae431 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -925,6 +925,23 @@ void *psp_copy_user_blob(u64 uaddr, u32 len);
 void *snp_alloc_firmware_page(gfp_t mask);
 void snp_free_firmware_page(void *addr);
 
+/**
+ * snp_guest_ext_guest_request - perform the SNP extended guest request command
+ *  defined in the GHCB specification.
+ *
+ * @data: the input guest request structure
+ * @vaddr: address where the certificate blob need to be copied.
+ * @npages: number of pages for the certificate blob.
+ *    If the specified page count is less than the certificate blob size, then the
+ *    required page count is returned with error code defined in the GHCB spec.
+ *    If the specified page count is more than the certificate blob size, then
+ *    page count is updated to reflect the amount of valid data copied in the
+ *    vaddr.
+ */
+int snp_guest_ext_guest_request(struct sev_data_snp_guest_request *data,
+				unsigned long vaddr, unsigned long *npages,
+				unsigned long *error);
+
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
 static inline int
@@ -972,6 +989,13 @@ static inline void *snp_alloc_firmware_page(gfp_t mask)
 
 static inline void snp_free_firmware_page(void *addr) { }
 
+static inline int snp_guest_ext_guest_request(struct sev_data_snp_guest_request *data,
+					      unsigned long vaddr, unsigned long *n,
+					      unsigned long *error)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */
-- 
2.17.1

