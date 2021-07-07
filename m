Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51633BEF15
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhGGSkq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:46 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232030AbhGGSkF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAq+kiyfnoVYBIYEZrWWVPyLK77lFUbjD4CTDfZRt6/wydrX5SrLDWQCGPS1g+16Y++L1hmx1F5jlsmG2cIRBMrYs/Y0EsCTGj0qaIg41RuHr8E7M8V4/pL3YDZ5SkKjJkDL+TH42XKwAhn/OPzJPJOLHS6Zwd0lxinRGH3G/ipj9+wIIUeBau2f097hg2Doz9/tTcyzQpLs4KbyLFwpYssBA2+gU3OSZrTYUDXd4kJVinsd2EVd8/MXb3Y1wGBRiwLR/w8Yj9QkDe2HCfH3MU9AAoTu4VXJHhi6qI1KcN6JEd4VuLR8ZNUvIEkuSj8dtfzpH9FIL4+I/h0W0SdRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUTgi20N0mjmusJiAzabx/QFYcRufh57rvsu2FnmrCQ=;
 b=VGTovDWsN27o6rBAT3hMwFOqEggLSrsHHjUJyzA1fZBEBR1kn+zfgxIha6gx75cEj0hcN383IytnjvcCsvL/lmg/1/Se+ulNkT0dXtACmCPy4/ek80W3GPSuo4OIhA9zxci/mOCFOmwoI4BdneHX4F50mAiVMQoL2sUpygjz0ZtEcP8cChcWnBP+0xUwy2fLTA5MDtOt7J5S1DfB6n0qGjOBaYl53uksot7sPpwWiHpCPJSwprGd5ZML+oFiSQU+coG3G5exYIpB5kFMddbEadEpnttOD95TdDFPgcISqBG7C5GHYFlLDqSl9GmvUm6MmA/0KRGztMZW1jL0z2/l7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUTgi20N0mjmusJiAzabx/QFYcRufh57rvsu2FnmrCQ=;
 b=DbH+ZXvbhvtmJS6IprbOml4fXwVABhaXpTRU3GoK4Fz50t1YoJkB5F1uqApcHSOwNajbNKIWfV/oMg8TfgrFzGi7qSfJmxhsjM61q+CKl2TmbKhF8hTuC3Hy2pfOHjlnDgRtrCZvHtmIBU0W7qArKmXNlV6RVg9v1GE1aOKzOLM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:12 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:12 +0000
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
Subject: [PATCH Part2 RFC v4 07/40] x86/sev: Split the physmap when adding the page in RMP table
Date:   Wed,  7 Jul 2021 13:35:43 -0500
Message-Id: <20210707183616.5620-8-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2da10cb9-70af-4964-4f67-08d941763c43
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28085E8CF5D1F94A63B957C5E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fv4q1GDtDiuZug/AQ23liEUNarl4wj45Zs/zLL1cexYT9TVTq6KKejETgFpQWDpZ11dgBSDfi2qnl6XixwaGz+XUojSDjx3WP1o1Tp17t0BofYaW/DH8nsZj6CsVbR6/uxTml75vrjSktCt/a3VmERpTEi63B61hD7J2g67bAxihyFDyYLpA1DjXfL6TPZQx54Ri/Y1f0NImIk7kiv5WkwW+x+LaKnoFxDYo212Xk4LWlpDYKTzSXiDaWTUlcSX0WwGEUmm3pXeJUIEHYizdRL2nQKrt2CHjM3nTG64b1Mdz4eSXDXYB9L5h6K8BI8ZWkgeEtOvLEr1oIe20FtK4FL6H6jPajJlOriegumGoKBvTIXa0lb9LHXe7J9kpIjpXyaJQta7yAVkik8Nk+gi9HXXGIp99Tjf/KsNXkGL4GSeamxPJIHUzzP2yzSB0/obfJCWsd0ZzgzXdDkTwTzgGVpsn0xtDfCtuD6dMNugbgauyLbWkiXeeE60V+p7DwFt8eQRh69goT2LT0nwKZgv/bKVGoLtR8Yq/h+AuKwZq2IFT9sibGrJCyr16d5Kt0C86TjktgTfIQ5RRHAZzO7kPAEOxre6l3ICQI7nnSGdAzYykKAfabe1/dwXo5TjcyW/0SpFTi4XI30/LFi59qP/vZDobmvYbE9UGYh+K/H7heo5YyFSW5ayrNnD1AJSo0iU7FWNZ5yvPbilDZREMwbyHPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kKRKv7yEU8I4r8JAZBfX5KymvvuKkPZuPukVwvjqAiKX2ug+6Z+OVXIi0X+O?=
 =?us-ascii?Q?sWcSmy2JOOp8gGdkdSSgfavI8iOUbhj8FItn5wKf15oyxG0drbQplp/OU/jz?=
 =?us-ascii?Q?DyrlXBLLL04bjEpWmbnqrSPC8UVgeaplg81BbJj/PHnVi8P36+lQ+hpPJKcM?=
 =?us-ascii?Q?z+w8W5mZtb3TKf483NXfoCcruqdPop4zsEkEwnwH+U41njftdXYUom4eWRJR?=
 =?us-ascii?Q?vO26cGE97EMBFtUbOFTlkOkc1LW1BwMdbRtCnLw6cgMSutn0ZReM109N/X7M?=
 =?us-ascii?Q?J2NAYKbI7VmhvtD0xn1Oqyqmpbz5IKUIBSJIzMkD8QbPYIRJRrE6wGnvTylz?=
 =?us-ascii?Q?l1rHnWoqG4B1CmyfeZ/ViCbv70RzgrI3i6VDhXU5KPiSXSYuBCUjyAVKBnYw?=
 =?us-ascii?Q?rWMGOmCRGkRbzATpLjEX2COHXz0e8LSt2Vqw0fX5IbR7ULngcHOw83xZ3Ctk?=
 =?us-ascii?Q?6EAF3o/CnqlnoibJkzzMkE7JypRmPNFOjOYmIEPoEYG0+NB/WRYddWqTivbv?=
 =?us-ascii?Q?erSrMVO+EVAT+fGLOx5LSmz+AcWViAV9wqcpu4J6BDINcI1Z5w3vxd+pkvMQ?=
 =?us-ascii?Q?HYkdKP93m0sFx39QzCZEB7GeMr+aQy9urKu6RRtQog2bZfiycJnxJWYuBKxw?=
 =?us-ascii?Q?2I8yITOabmQKqUrgzNVlJ/z+vBlPRKKz3aVK+rJKoR1OXpZXQW4y6GRtFCWd?=
 =?us-ascii?Q?tbPSSt/1OVURlAshRKVeiGBiziewGPAx40rIhNnHeunUVxIKtLUoQ1JlZo9T?=
 =?us-ascii?Q?UWSJqnQP01wvG+a2ObDIu/kPImg3/jMhciHRFG1pSwhQed8N0Z9ow8ZyV+Oi?=
 =?us-ascii?Q?26BVygvgTWF0VMg6D/SzM9a9NIx2xFQK1BU2NVqK7S3pnt020YtQdZxELFLO?=
 =?us-ascii?Q?5o1UkUPvWGr/TA1YxGQhsIbeM+UqFVV4dNLroZyYPAWrFn9r4GAJn8zgaoRp?=
 =?us-ascii?Q?YHY/z/Fay4vTa/3Qg8587Tid5lPLRI3ZsPF7i2vyR+cQKSU7kQu6pry/utPH?=
 =?us-ascii?Q?rQoZpdvcQpnnXVpB3DWzCProHsKJLJE3++gTUl2ZkAz/fQeiUubHmIVQzAj+?=
 =?us-ascii?Q?6FIhnoVa4SGqSQNVp2criXu+x3skx6B8m3DRxa2g9m95MVBE7hC9/04jLT8b?=
 =?us-ascii?Q?L+XiWm/VdeAeeebYjL3K2gI7Dv948CqaZroEhbR7if4eQ6d+1IKQyYQktO28?=
 =?us-ascii?Q?nrS2Ivjm+NZ4WZJ5FDBgBdb1EaBbOihKkXHgWcsM1aZBkWeFZH5v7MyZCYdb?=
 =?us-ascii?Q?+YHf4W/9PgmgWp3Rhkx5N+OYzNWFIeGyVhTA9xLa8c2Z82Io6R+9LlSaakio?=
 =?us-ascii?Q?iRhXGT4vE91V8t6CinW+xpyA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da10cb9-70af-4964-4f67-08d941763c43
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:12.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f3Pb0wcupJJyzEIxJ5vYy72Sqe1BlLq3ZxCimwzfaI/H9chCrkMxEJLDoM8vVfB4XEp3A2+5NKtxMu6J4GjxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The integrity guarantee of SEV-SNP is enforced through the RMP table.
The RMP is used in conjuntion with standard x86 and IOMMU page
tables to enforce memory restrictions and page access rights. The
RMP is indexed by system physical address, and is checked at the end
of CPU and IOMMU table walks. The RMP check is enforced as soon as
SEV-SNP is enabled globally in the system. Not every memory access
requires an RMP check. In particular, the read accesses from the
hypervisor do not require RMP checks because the data confidentiality
is already protected via memory encryption. When hardware encounters
an RMP checks failure, it raise a page-fault exception. The RMP bit in
fault error code can be used to determine if the fault was due to an
RMP checks failure.

A write from the hypervisor goes through the RMP checks. When the
hypervisor writes to pages, hardware checks to ensures that the assigned
bit in the RMP is zero (i.e page is shared). If the page table entry that
gives the sPA indicates that the target page size is a large page, then
all RMP entries for the 4KB constituting pages of the target must have the
assigned bit 0. If one of entry does not have assigned bit 0 then hardware
will raise an RMP violation. To resolve it, split the page table entry
leading to target page into 4K.

This poses a challenge in the Linux memory model. The Linux kernel
creates a direct mapping of all the physical memory -- referred to as
the physmap. The physmap may contain a valid mapping of guest owned pages.
During the page table walk, the host access may get into the situation
where one of the pages within the large page is owned by the guest (i.e
assigned bit is set in RMP). A write to a non-guest within the large page
will raise an RMP violation. Call set_memory_4k() to split the physmap
before adding the page in the RMP table. This ensures that the pages
added in the RMP table are used as 4K in the physmap.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 949efe530319..a482e01f880a 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2375,6 +2375,12 @@ int rmpupdate(struct page *page, struct rmpupdate *val)
 	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
 		return -ENXIO;
 
+	ret = set_memory_4k((unsigned long)page_to_virt(page), 1);
+	if (ret) {
+		pr_err("Failed to split physical address 0x%lx (%d)\n", spa, ret);
+		return ret;
+	}
+
 	/* Retry if another processor is modifying the RMP entry. */
 	do {
 		/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
-- 
2.17.1

