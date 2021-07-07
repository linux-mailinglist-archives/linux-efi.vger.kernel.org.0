Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9D3BEE06
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhGGSTJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:09 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:45063
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231643AbhGGSSy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jiy0TjZ+TYvtmuj44nTHytWco0FcbE0XRvj445aKurJcHnP92YU4x5CCbXNxqbZg/S4PK3NWuMkYelK6tvvbIIqjtQw4yOZlxvV4M4g/+YJ07OzCbun5Q1Cn8NDRdP1PHgDkqIQTFgvAF4rLr5sCaQ+k/dHAti4rGQ+3/KalpIvtpJXuDmGQWw3oWwR/PimligL2wfwEC7A5d60xXVA4m2TTjnwFX4rmvfjcu+yLakitDvmpTh2Lc9np3Fy51KN7HpyWYOmK5Kr6TicFgC0n/ngJOBGN7cQDhgtT3F6WwmyZE0Jr10E5x4IOHP65FF2I9QUdX+qAFsZQ+C8E3DttBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/JhxqSka73eZEhSsicofqkCL2gbRrNJ9DD4pCzki9Q=;
 b=k5FnIuX7rjWtZ7GCr1G5zM8CexVuJ0IIsryUEdlr2B86OTut71Lg0z/6s+1WhJX9qOofxRsGmVnu1zA4eKMoigqCQ1Q+lc3prazCH+1IOzFyN3pplQTrSxhcTv/e5Lye0hx61IJyqdUCiNB1P+1aYmTwP0CIv8Nij0vr+h1CLP8RuZP1ulJfoNQWmoKbRFfqJrY0HCgVjEjRtxehEutpGyP/9nP4Cwy/iZOirw83XWihbO/02WsRqmhlQ+EjyBYVMeFA4XnfvMTu5StjaiB4XetTI9Zd6m+u0ClpaVcGEvUUBIGYw7pX4qsxJ6Iw8rKQK7VJ3asbxeRmz0isCQ9V0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/JhxqSka73eZEhSsicofqkCL2gbRrNJ9DD4pCzki9Q=;
 b=zNMq+2H/zFKKdft81z6cPzhQULA1co9DrKjSIeILuwxHi6/bkytxSxuONGULf1hChSiKhFeydR1i5h4Bd8VVkSkrYrhePPdVVTxHuGtrOJZqwNSGeWM2zn7Pk9zGMY9v6r/IvVKLH2amVXJxPSIUt9s8t4kDT8/+eMnh1JdAtkU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:00 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:00 +0000
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
Subject: [PATCH Part1 RFC v4 13/36] x86/kernel: Make the bss.decrypted section shared in RMP table
Date:   Wed,  7 Jul 2021 13:14:43 -0500
Message-Id: <20210707181506.30489-14-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb67c54-880d-42e9-1bd3-08d941734600
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB50167185A2F697E7B8A608AEE51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJpKdITOIhzmD1u++4SQBeGV4QtdNH0EKlii/LpTNn6nX1UHTxnvcW8qhhIxRdcRIwzNfEGpTnp/er259LqJr2PimN5iWq0BSPwlCkit2uLrTSfn7po63prsJ/xlhKBi/TMgYyKkfXcZIUk250GFyUJFULNu6d9eBYqjz2tZbnuIuYbYP8/0ctRm2DofsTZWZWuIJPGf2h5fwOTbh5t2Jv3plIQtumCftrud0gubGLk1dercVolw50OOvwfTiM3YDRhS2bEaaLOj4RDifhtSG1XLg1D6Ncp714YeMM59WtRl1Hrss68vb9/rXUNAbb+uP0oDs9NAzrfEno499GuUoOp+qhyv9LerLA0dlOzIY8p0lbfKw+qunO20mRtlvkdh7oH4HZN3LN27FMMYQ1xpwcfyw6O+do9/z7c3YESX/PEMSyvzHxiL2M2uBNNXxMjMtSPAqRQbffRxZ76PhURuJjCC+gQUEav+U/d8yGfjDch6Ni9yX/KDj+iuw5P0YAKAoGN58S80dd7LJiuIsFxvRM3kD3ndsGB7sDjRIog7P0Ja0k8eYF6Sy3IlWm2hGORvmg4EJxa6SRIjgytkV7f917QBh4PhtXM8saHJ0n+U+Zs7e0NIHyyljLKjTlh95woFqK3gVPoOGlvPqGdvLOWHQZWeGmsz5HiBfsVjVerBGPP23UXuhuUYNi2TrHPLXZjb9HM/stxt7lErm8wXpII+gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(83380400001)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajMtQE9AbVQQ+clFVgmOfvc0Z1YHdo3hGpmQ27G6x0nsV8cqjt5jQ1nqv3Ji?=
 =?us-ascii?Q?RS4iiqSJb1V6k1wbFTMuwVaGi99+inT9PjO2Kvsajmn9RK7JqOQR2gVN5rl0?=
 =?us-ascii?Q?HtNRPFjLRbySLPZCLH6imKwZmKQRXmcmdZSqt1cmakrYTWsPJEagQN9Otnl4?=
 =?us-ascii?Q?Xjduc/ElqmdHYm7BJoLEfkQLWuWEOofLirmZ7b+xN1fS7x9oHa6YsgzXOB7o?=
 =?us-ascii?Q?MjXV+eLfQkVb1YB0BNuoPu2sBy8k6LFdsKu4b2y/+B7x7OhT0K2i0XI/o2rz?=
 =?us-ascii?Q?pYveUSFVnQX1rhKTF4PueAqVFKEceqak5F2MTCSwMWqkS275J/KObg5QeX7t?=
 =?us-ascii?Q?MGm1Pcu1PUq1jl4wruNUvRVKklcuBwfsTsd1bJtJ1PkCO4aJvsqnI1OHXR7L?=
 =?us-ascii?Q?MSfh5C6ory1ht6OTwLg7BTQm9QhD4HXYznKkU9ZpRSlXoUGwRBFA13A6pXJH?=
 =?us-ascii?Q?2RcX5ATpkJIWaYizUyPyhJI4pX8LfD9ahoysgJeh+vm5y98rChAsw50sE7vT?=
 =?us-ascii?Q?3/NajJ1FXDh+RAth9P/8kr4Sl3M74XCiw/tjFhbNWvUhf0kz2dyAHWaLKbSl?=
 =?us-ascii?Q?KvapuVlL7ndGFKbmeyTNeihPhVyIDToZdnBK+5hovJ1+6EGFeDcR5ZR9h23C?=
 =?us-ascii?Q?J3Irn6wI8FGaf8kzAtQb5bI0gnCTEjo8C690jHxOVpPVzQeIlQdysDrltLml?=
 =?us-ascii?Q?4tfNf5iWXU3sm+AT8GhugUlMJ4MrKuUs1sqnhkM+wbCIfQOWVIJ65LmF9wgE?=
 =?us-ascii?Q?aCDMsDjvDrpH+XUGfzgpq7g16FeK/y0JfGI0n9Z4AYNF8PfBZSfpjiGXBP8z?=
 =?us-ascii?Q?vgXdUHOF671GerFOwxpwkFpV3vp7pV8YxXLQUc54SWFA+8lAU2Ie43fuxksQ?=
 =?us-ascii?Q?V6Aqzwzk/ks0mPwoyhQV3EbNJFLoRL/hpCipTGWwNRdICjgiH13QtFWrbU/e?=
 =?us-ascii?Q?0gDonnInemk5jkKnUV6DFYYpI3HgorIi4h4W9B/Fz43BlPuNjCItOKF7Qca4?=
 =?us-ascii?Q?nek4eHUyZ1BCffQZEIl+IfjEnSYdXzQyHpqO1afItz3h+Cm2IbIdd11FijIf?=
 =?us-ascii?Q?wqm3A7hhDaBdrU6z3m+J4HY8wRCGcIW6WJaaGys5IMm1eFHFZPqxlVK67/xK?=
 =?us-ascii?Q?jP3kkh3Ol9azeF9Pijo0osPBGie8/AHB8ZovX9Fwh7otWT/b83359Dt43YLC?=
 =?us-ascii?Q?yh4LOtXJ9obKjFwuYiWafIBB54ucrYc3he/rzmB9H12yz2jX2xnJaP+CWsZ6?=
 =?us-ascii?Q?0K8nqkQkwSwUh22gGEsKWyroPBrVHR+6ZG4KnStJ46isB6kQltCxnBcJQZC0?=
 =?us-ascii?Q?UU9A44fO5Gl1WDGJmrj8qOeA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb67c54-880d-42e9-1bd3-08d941734600
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:00.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tcf4KLvWm2y2EvYROL4e4u7IE2AQiKcVqrqmmyMaj2GEVwHVO3Y61vJYOxiTXbPDlSr3CaMlQOsWGcJPaec1Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The encryption attribute for the bss.decrypted region is cleared in the
initial page table build. This is because the section contains the data
that need to be shared between the guest and the hypervisor.

When SEV-SNP is active, just clearing the encryption attribute in the
page table is not enough. The page state need to be updated in the RMP
table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de01903c3735..f4c3e632345a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -288,7 +288,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	if (mem_encrypt_active()) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
+
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			/*
+			 * When SEV-SNP is active then transition the page to shared in the RMP
+			 * table so that it is consistent with the page table attribute change.
+			 */
+			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+
 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
 		}
-- 
2.17.1

