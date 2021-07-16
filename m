Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39C13CBE27
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 23:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhGPVHH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 17:07:07 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:4075
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234645AbhGPVHE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 17:07:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG7Tsy1tvi2ZK2JewCnJwhmUsBKagbgh9vqbdYlsYIblhb7Eoora57NdXi1doO+RePG4T++joXlOZBmtI02e7OJ8ATl3tnZuYBn0iY3aMa+CeHg31XiaJt2zIpHaCiZJk4JSVlNZFJdr98mAta/GlV05CRND9Gq3pikN8zcr2F3ZheFX9mY/l+H4UpFii0aG7u6MP+yh5xEQBD4eSjVkT8gLSCQwp0ICtTsf/FK0IaQcZqWJrTkJL4uAS0LbP4ssa6Wzgwpf6LpDkF+QolmTv4StwbnXeSfwXUYr46S2leRxbhJjAiO0CHd/z1uWKzicCwb5x9cLBmnVo57kbEmy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAfArWQ/ATZHt41qWz0zV1klf3ih37tfiAezn6UeIVo=;
 b=TokkDNL3AYa3JWjdUR+MA0iVWTajKngc7GCWDcLcvrny/phwxH5Rg+Q2aJMpa+t3Ekdr6aVRLCqv0Q8UnehqDQ11ThsPpS/9uL6sIPIu9VsMtEyJFUcddVL+3+ExwKfBDjpGuNTzn0I2fSIH2D5UXwc1PIZnSqEo3fetqtZPRe67nkvHie1ZDGMA2XZsAewtMF06PGX7a7kt0rwp6Po0wKCmxjAVhWJWO7d0yVqpW9jA+Fq2biZfxM6J0AHJoeGFiEvkDd1y0j7ZLqfpdPqcqjxjBG3yfalaAai4dI545IcOCqH4Mz56xeBgPi4ANanyUTDT0M3y0VBRxZDV8Bdpww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAfArWQ/ATZHt41qWz0zV1klf3ih37tfiAezn6UeIVo=;
 b=rrrYpQ58A16VfBKucLPK1xOejvHxItD6O0AkqaH9z/fiHy3+Jnr4v4a2MzNWUT0CLftsT4xHVEQtpW4mz/lPTryENJP0NKwrK68FVxq7c7p+HeL12bfxgVshzRjyWLYjYt9OGxbF2P9iLmVyrj6OKeI2G1l/3MKuix9oGZjTXmA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 21:04:05 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 21:04:05 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 21/40] KVM: SVM: Add initial SEV-SNP support
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-22-brijesh.singh@amd.com> <YPHJOmUOR65QY+YY@google.com>
 <ae47ae6b-16b1-f282-38d5-429d813243a8@amd.com> <YPHekXKC/XhWYlZE@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <fb54b509-29a3-f2d2-5a23-eb8d9d661fac@amd.com>
Date:   Fri, 16 Jul 2021 16:03:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHekXKC/XhWYlZE@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:806:20::35) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA9PR03CA0030.namprd03.prod.outlook.com (2603:10b6:806:20::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 21:03:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d51fda21-626a-4454-8da4-08d9489d3ee7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447203EF2357F4000293A7DE5119@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flp3REkdRRhjGjBs2Enqe5CpEO5i2eW/3HlX91kvAklg0S+jsEJ8QilTm6i3wMWwsGdVIDQcFqEsgtILds4JiJLuUUMVpXjWclf9kpOUS2nCsdJis7yfpJ/3FU3gRbYTYLobpyuO1bndJFBtZ4h8hZIceFqNYCVyL5wzk0yS711xhCo+rT+jOypWk75kPthRWWDqLsBV89ovTZyqfrw7+4VPSn+cGejR7Rk+oQptRrjKoCMssIROgcK3XZTTg/upuMgKuX7tPBcVsa3lic2LyRi9Vd2OcMVoSchFN0zNPGTNeXlKAs5n9LSC3PIxNTiKB/ZviMGw2JOrmnTjyWLzRRWgrwhr4XoGdHRJjx4qNS9yDqj7jX4sySNGM2weGWDcDW416lSYSNXNrMbxtsf0z7XSW8w4jFHBsxrQlh4gKIqD5ylPSx5mLfibs9kj4O7H5Mh/3BHATSIak+yp0+/4jhqQ85UDjztPyTTep8CL8YpmkiMrxGwQX92NuIm+0btlZCL/Lt39QNJrghIFKZLFQxWut4njxQVGw56DVlYTf+AjrsVDITnKrZys3gL4BHRJaBm+EtS7je39SKUctgPs0AppEGe+HRQM+t6+ZNuqEP7Dk7DCIvb1EB4HCerweXg8A7m2oJPreuQRIYG43QA7N6U6icjldfg9aa5kcWNeB/F4415BrYXecSi43R7UXX0JGsPnyjPRknTTsdesTyZ94Gh7La8TLQXJBOTv3qIVBeQ0juj5RVZAEA35kpgcKx3vz6/fMBfqjhNCu6ar72xapg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(86362001)(38350700002)(6486002)(38100700002)(6506007)(478600001)(2906002)(6512007)(31686004)(186003)(53546011)(36756003)(26005)(316002)(956004)(7406005)(7416002)(8936002)(66476007)(44832011)(54906003)(8676002)(83380400001)(52116002)(4326008)(66556008)(6916009)(31696002)(5660300002)(66946007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVIxUTdBZnlLVlhTbk5pamxtNjI4WWFGV1dqOEFVdVhVWENsTi9PeHdHcW1h?=
 =?utf-8?B?MkdqSkdZdy85TXRUQ1FTWVl2ekNma0w1VFMxb0pqOW9La0dUVElnTG1wbWIx?=
 =?utf-8?B?aVpNZExRWHpTcHRHK1NwK2FhY2lFTDA0THZFQU80akxPd3FUTmZmLy80Z29q?=
 =?utf-8?B?bUZMSUVXc0x6VWc5Wjg1bUd0ajBXN3BFQmN4bWRXa3JqRXc4TGUybnJ6MDc3?=
 =?utf-8?B?RzdyekM2NkRHTVJlOGpnaFo2ZEdBTXdDdmR3eUhBYXFkT3NKWmd6MGpIamNQ?=
 =?utf-8?B?eW1CZ0RreTVMR3Y5QzdQclVOWVEzVGN2dXg3YmFFbUpqRnNNWXIycHJFaDFL?=
 =?utf-8?B?VmhSZUJpbDRleFlEQUk1Nk1nc0lrU0kxTEhhbWFCNVJCVm84dkplbEFrd21j?=
 =?utf-8?B?VGdhaFNpY2VyaVc0V1FpdjZFeTdLME9tUHpLbGFXYk9NdGpwQnRxU092czZQ?=
 =?utf-8?B?SEN1OXVKMjV0LytsZWZ6MFpGVkV3R2NJY0dibXVueXVHQjR1MFFWc282YkJi?=
 =?utf-8?B?cEJRbnQ2dXFhNFplcVZrWFBETDBicmJYVC9xUlg4VzlCV0RGaDRpK2JlRDdR?=
 =?utf-8?B?S29TeitRMlRJekRFOFk4OW1oYVdUR1MzUUVOMTBjNmhjdlJwL1ZZRVd2TjNn?=
 =?utf-8?B?akx6QWZZa1haT2ZpbHU5NWUyWjZWVGhXSzlGMm8xZ0RVUUlRRk01V3ZFWHlt?=
 =?utf-8?B?cThmcEVCU3dkS1ZDNHRReGRUYXEyQVdoblpKRnhKcG5uZkFoblFnRmhWTEUv?=
 =?utf-8?B?cndIOUJ4RVREV2lVek5rcDBnRFVQTjh6RHZFMmtuUHNwVnhwU3JaY2JDYWt3?=
 =?utf-8?B?MUlVVGZmT3FtOExEMXZ2Qk16RklSdmx3bndWRmxjWFIzQUF4dzdoaC9pMnFO?=
 =?utf-8?B?L0V5eHlFNm5Pc3Z5ZDBlQ0UzeE85cVlkVlBuajkyamErdVp2bVNYQTA5bFhw?=
 =?utf-8?B?OEZ5V3JodmxWZ3k2aFFKSXFuVGJPNUZHWVU0QUlDcmlxYlovQU1wN2t2bzhW?=
 =?utf-8?B?RUtqdlFsMldFT2ZwTjdueC9kOGNPby8xZGJTNnNiN2lCUG42ay96OWFmL3ZL?=
 =?utf-8?B?M3daVWpkRGwybFpLc0VCeHphdFFaNFRzdTJCdkRoQ0JmQ0dtZkx3RGRac0Y5?=
 =?utf-8?B?V29rc25adDdLbG0vdUkzSVZQWG5JODhiQVg0aWpJSkZHdVY3UWpraDVuWWow?=
 =?utf-8?B?bmxOVk1ocGRUOU9qOXhKOExDT1dvbS9nenNyWlRZRmFBdXp2Q0E4ckZDaTFN?=
 =?utf-8?B?UTc4dXZBM1ZCTGNSUXMyQVc2ZURkWDRhOWxKSWdaVGNFTC9qNWZUbkV1STRL?=
 =?utf-8?B?ZnR3dmc2cnM1MlJtam83Mjd5MmJNekxjSnVJNm9CTGlTczZJUnFCLzdka3hC?=
 =?utf-8?B?NmlRQXlEcW5yZ05nZUtpaldHcUxLRHVxN0FFM29DcTFJOW5FTEc3VHltNFBy?=
 =?utf-8?B?TURwYmZDK096VGtWNTJlQVhsTkVNSW1lWnNhck1BSi8yZXhZTXAwZW11c2ww?=
 =?utf-8?B?QVV6YXdPSHdtN3FMYTJQa083T1UwMjJrN2V2eVNLTEVsR0hNU0FRaWRvY20v?=
 =?utf-8?B?SG9TNUJMalJCSkhHcm9IWGxxQnl0bHI1UG5xUWE3NlN3V2lUWDlwZXhFVDVz?=
 =?utf-8?B?cStIRjhpVTVtRk4vYUlzV3J0UE9pcXBaTDA3Vk4vSEUzK0w0TDRURkNuWTRI?=
 =?utf-8?B?ZGxHekZna1lUL1NMR3RqSDltSlJoR2hLTXk4WURNOXREdjFqR1d1bXppRllq?=
 =?utf-8?Q?12U5SsN7HG2RCOHg2eUv9mLBp6z4KT04pPeYPzg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51fda21-626a-4454-8da4-08d9489d3ee7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 21:04:05.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrN8N0ouZ5ImIB2ObUuDiy2JKOlkK/aWGYA/SBhiNBkyJ1Kv4MtLMXgzMu7Sa6xK3mTwWCdSHk+lkw7YBRyjiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 2:31 PM, Sean Christopherson wrote:
> That's not what I was asking.  My question is if KVM will break/fail if someone
> runs a KVM build with SNP enabled halfway through the series.  E.g. if I make a
> KVM build at patch 22, "KVM: SVM: Add KVM_SNP_INIT command", what will happen if
> I attempt to launch an SNP guest?  Obviously it won't fully succeed, but will KVM
> fail gracefully and do all the proper cleanup?  Repeat the question for all patches
> between this one and the final patch of the series.
>
> SNP simply not working is ok, but if KVM explodes or does weird things without
> "full" SNP support, then at minimum the module param should be off by default
> until it's safe to enable.  E.g. for the TDP MMU, I believe the approach was to
> put all the machinery in place but not actually let userspace flip on the module
> param until the full implementation was ready.  Bisecting and testing the
> individual commits is a bit painful because it requires modifying KVM code, but
> on the plus side unrelated bisects won't stumble into a half-baked state.

There is one to two patches where I can think of that we may break the
KVM if SNP guest is created before applying the full series. In one
patch we add LAUNCH_UPDATE but reclaim is done in next patch. I like
your idea to push the module init  later in the series.


>
> Ya, got that, but again not what I was asking :-)  Why use cpu_feature_enabled()
> instead of boot_cpu_has()?  As a random developer, I would fully expect that
> boot_cpu_has(X86_FEATURE_SEV_SNP) is true iff SNP is fully enabled by the kernel.

I have to check but I think boot_cpu_has(X64_FEATURE_SEV_SNP) will
return true even when the CONFIG_MEM_ENCRYPT is disabled.


>
>> The approach here is similar to SEV/ES. IIRC, it was done mainly to
>> avoid adding dead code when CONFIG_KVM_AMD_SEV is disabled.
> But this is already in an #ifdef, checking sev_es_guest() is pointless.


Ah Good point.


