Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F281B48C919
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 18:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355508AbiALRKM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 12:10:12 -0500
Received: from mail-dm3nam07on2055.outbound.protection.outlook.com ([40.107.95.55]:46331
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355553AbiALRKK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Jan 2022 12:10:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlQBnP1aHK9u8bVek6hAOXNSwSNwkF50LXiN1w3BK3uzmo8N9oJyVDFXpUJq0zCyxq2aRnU6NmBJqtLGh0DBwtNOb6Z0WU+KM3/3myP4foxYUFocfA6Um0zZYmxW0FgH0NF/0ca3m8YOvs4g+FLcw1/Y77f5epObAJPKbMaqri6qcbI0z/XZ7cLgL6pmXUtkIlaSitF/voxoRAd8qPwmpefTpjZ8KO9HUJfwNWm/AttkPdlUGrgCbpSMKgSGW6J2X1EoXW4urLx5aU0EiQGhonFf3v17C3LlowmFTR1NZ+dXDJ4x99sgqwR77FL0RE3aByg3pRdxohCilV1S0jgX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3y+unU2w6ZJnYhINw8WCJtoCJHGgWfl5fK4U+hqFtcc=;
 b=NPTvHr3h2M1LsSVmWq3gFRZ5ExIgUJW8OtRoPw7igyC7xKCGXSJGIMlshlR29GLcQ5SbwyYF4+ZgXtC3pEuP99LxpRujQZaWRS5uPPCOgUMB63gGSyB10c/o57DGu/GqWwTxLvjN9zfe0IS/AWJoHCJrc4esXa+Rkq6eTxudpYAGWWQZo42TmR1t1Jft7JpnD6CreX8yxBK5lfOCPTIU6nghbZJ2zvUmQK2zOZ97lyYHUGWwjDkI3clsJ8LPpavOp7hz7D6bpfMy/kHFYTMg/JRa6dN31eYfkWZNOUEP4rTRjsWEbh8z3SUbHhy+Z9/QB/pFGS2iSqHvbphvEgRSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y+unU2w6ZJnYhINw8WCJtoCJHGgWfl5fK4U+hqFtcc=;
 b=Nr81cyoxqr2UazQaTNxFY1oUF/yqeWCS3xadv/mFvKWsc9L6OZ+CZY3WLMA/TGcIGnHK+0UELvp1RPpJOjGQvagnjFUCCaajjpmGRKYXhYq6Ryro6dn90uBob6QKtV0DNpUsYSqKvpTTm6nkCpFcyee72DAgS9v09QjHIhku+tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5135.namprd12.prod.outlook.com (2603:10b6:5:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 17:10:09 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 17:10:09 +0000
Subject: Re: [PATCH v8 20/40] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-21-brijesh.singh@amd.com> <Yc8jerEP5CrxfFi4@zn.tnic>
 <75c0605f-7ed0-abcc-4855-dae5d87d0861@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <346da2f7-220f-83bd-2dbf-29e681fc089b@amd.com>
Date:   Wed, 12 Jan 2022 11:10:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <75c0605f-7ed0-abcc-4855-dae5d87d0861@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4905f2d2-9489-47ad-42c0-08d9d5ee62fc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5135:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB513577F5D235E46ACD7282CEEC529@DM4PR12MB5135.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jSwHvidyUxR7IlF4ez7Ge9AjHcnalMsX68WM1wT00ikfQaOvqZ3dFt+JPdjFTmyjx9BBc5IRPXROoX7tqqyhcQarG+l19FPfv7yb/XvTPJ+4n9Td8ZbEmWPWIRG68Gzef6eb/+TteAOYSippsl3SxrIo4gQOJh2t4bDgPEMgbOfsOoUEfnuQFAMMDD27Ic9uVl0GaXt/Vq8UImK6ioTntVrnV1+IHpoQ2yHg/t3MWPwiCdt1b+7VNFj2orO+3GaJE2u3U1MgqhcEkbn14ytQQvlyBuZ67mTjUQtK9MnmhrXDxyJTU6qRRWclNSx600alAPwKTZidjj0eB04KySf4hPsj6QmXQFcU6b4TAJ23yeJq4Ktitxtox5H8WkQMRtblrTwEu2v6IZlyCLHVDn5yZJ9r/RGgYh6VTJeHVLLMKJWCalN1h+KNMAUEipJGkIxjOa8BfMgxxs9ewYvfWZUrEM1dvtHlqRUjHmDsJ7kcIm9O1ORfM2qlwiRXkEaBZqv3GrAR0wYbtImw69MU+PInVJ7AwS1yAAJtcjYdjoK9X8jVpai8FJEF6aq5PR1sBARUD4KU+C9FDikpKL23wKuQgiC1YPgJlJkbyHRf6EK6rjWflJIKM2U5yabSp2A0NFPddxFKWt0/ksfBh3IKdR4MnTrp79lQOXMVCa0bWR2eKnWRzQxChlRImIa5kT96coU/ec389iANs5yNZSfYDmudc9KzD9KqqmPHCQ/pFf9nDkX+SGAey1z3+L/n28VaOSU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(31686004)(38100700002)(7416002)(6486002)(66946007)(54906003)(7406005)(66556008)(31696002)(6666004)(66476007)(2906002)(6512007)(316002)(2616005)(4744005)(6506007)(508600001)(86362001)(26005)(36756003)(8676002)(186003)(53546011)(83380400001)(110136005)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVdsL0UraDlHZkw0SUhkMEU3MGdNeDV6dWF5UUJ1aEQvbWw3OUtxbG1HVFBt?=
 =?utf-8?B?M3lodi9iQ1FvaExsendiOFpFQVRyZm9udG5JaEprQTdnTW5pbVBXbUZwdEVk?=
 =?utf-8?B?QjdzalNjU0FVbmpVVWxuc1E1RnRqZGRScFR2VDkxQlRuWCtiUndJSkNod2Uv?=
 =?utf-8?B?SG9CQlZrMHRuWHhmbElDZ2MvdkkxREJ6Z2pKd0pKalBabUJrL1hqYWdBNnJp?=
 =?utf-8?B?RHFuTU1NcWtGR3dLNkRuNjUyaW9hUzJkenl0eDJYcGM3N0t5MkpXN0ZEd2lj?=
 =?utf-8?B?YlVHMUNZUnJyU3dlbUpYeDJFRzVZdGhIMndZaHVON2JtUXFQTUVwdGRnbCtX?=
 =?utf-8?B?dWlTbTFKM3ZGdE9ReGhUR2h1dUt0c0k1aFBzektNd3JCdm91cHZielBEMjBn?=
 =?utf-8?B?ZmcxTlRibHZXNzNxSXdua2h0dWFLQ1BlUWJ1SFpHOEJOd2MxcWpMTlgxRkpS?=
 =?utf-8?B?a1ZNVlRxdU1zYkZvbTJ2Wm52eHdpUGp1QnFoQzJaYno0ZmpudEVLSW9OTE90?=
 =?utf-8?B?U0dOamdoZzJRRnRMdTUwZURKRGRqS1JYYTFCVFdJZlJ1dGZ3N1QyNWMybnVP?=
 =?utf-8?B?YXVmTUhlYWpscitaM1dUOHpvbGdaYTdZRk9qMjFQL3NyZWlsd29jZi83UmpP?=
 =?utf-8?B?aFFUSXpEb2xyRWxZT3hFUExzN1JyTzV3NE54bWEzWXRJeW1neEtlZlFvdjZk?=
 =?utf-8?B?NDNRTTZ0ZEV6eElSUXRCTE1EWWhJZlBDUGFYTWY5VTRwdm9tU3lwbVRuUXd5?=
 =?utf-8?B?a2hoUmQ5OUxDQk04S1N3L09mUXR0MEZGdU9mckVhaThMSzIyNTJ1SHpXazdN?=
 =?utf-8?B?S2xtcFdaVnd5THJXdENTa2RVeWhDU2JNTXZEYTRhVTlGdGowcDlGcTgvc1N2?=
 =?utf-8?B?RytWN2p3dFd6UkxvMkNhRVdRVTVpRzRLNXAzRkh4M1o4bXg0KzJYV1VVQmcz?=
 =?utf-8?B?Y2ZBMktpVldhVHdDRSt4YWhERFZYOHplSHVVMmpNakNnZExGOEhaM08wTUxx?=
 =?utf-8?B?aWtRQjR1M21XVmJhTnI0MmJEUU1kamZSM29yK2EzRkhuTHlkU3hOcWdxcXVP?=
 =?utf-8?B?enNSaU0ya3NhQTVsNjF1N3hUQldFZEh2N3puRzFyekhVcDJPTHMyYjJyb3R0?=
 =?utf-8?B?NHNUa0lLRkQwTDBzS0MwSnJBcEpNTFNZNjJMZGlZcTN4dGszdFRVWE5sZUJ1?=
 =?utf-8?B?Q0V1WnlEay80akEwd2pIek90Y0plbkpKN3ZYMHRDeGltbGVUVk1YbFFXaVRI?=
 =?utf-8?B?RVJIYmo0VHB0dHNubVlHQ0dselZLMXVzVnZxOTM1Rk1UMWIzTnhjalo5bThF?=
 =?utf-8?B?bTBYSXZHOStKbTN4RTF0L2RIaTVZZHNpaXp2c0kvNGF0NTlOYlAvRWF5MjdW?=
 =?utf-8?B?Y1FPWGpoZmYreXNwWDFhR1I0S0FZSUFsOGZmRHA1S3laNWFKQzJUSUpHNExU?=
 =?utf-8?B?V3pDT2dYOGN4UlhLcW1PU2llbnM4STZZMk4xS291YXM2MzdNV1QwTW55T2lm?=
 =?utf-8?B?WS9hR2ZMbGlZQS9KczBuVVdWa3p1VldBSjhzUXc0NFpXWlpFMGlWVmRWNDNY?=
 =?utf-8?B?QVhZM003QW5hcDBTbDlqbGl6Q2R2YlA5ek1UUVVqKzQwYVI2RWt2eEFSeGNr?=
 =?utf-8?B?SUhSOHlwVGxLYkVnVWJZV2dDN09UUTJmQy84b211YjVkbnNlQThTTit0M0N5?=
 =?utf-8?B?VXFTL1VlS3Awc3Q3MUczMlJMT0lkSFhMNzAzRHlnWjhQU0doUUl2dW1xUEpE?=
 =?utf-8?B?OEczeTI5UTJwM05hS2RldHNYZk55NS9JMVBjZDBVTXNRZFZwL2ZyWW5UYVhT?=
 =?utf-8?B?dEN1SEh2WjlLc1dVWnNmMjdXbmxoWlJRMkNXa3Erd2UwN0VSdWFhY0tGVzNp?=
 =?utf-8?B?bUtOb1hrWlVmQUFCNG5PRXRZelYwZ3RCdTFXNTFXc1FJTU0rWlN3ekNhRVVp?=
 =?utf-8?B?a0MxQ1hKTGQ5TXVWNnBYa1A1Qi9sallxWHpOWHJ3cEY4MjVKZ2M4dVFOeTZp?=
 =?utf-8?B?MCtPSytnVFFHZXVpVHl3b3dreDdUZHdlZFFjSi8xb0NyRStYbE9iaVlySDhD?=
 =?utf-8?B?djdJaDhJaGovUGhMSXVSeTJ5MDczMEtLQVV6T2llYjZUekJtUGxKVmFLd2FG?=
 =?utf-8?B?dkFIeDRnZVFhbk85Y25YbGxDUy91VnBDS1JXL29OZFBoa3I1S2pKWGRsUDla?=
 =?utf-8?Q?G/l7jmVcNFzQ1nNUPkSdXUw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4905f2d2-9489-47ad-42c0-08d9d5ee62fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 17:10:09.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4alvji0elOSBFymBLlM/FoUi15rmr1rXWtlfOHFO9O5D3yX+ux7d83PbJysb4xZaN98o8T/+438BR71UEfQwUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5135
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/12/22 10:33 AM, Brijesh Singh wrote:
> On 12/31/21 9:36 AM, Borislav Petkov wrote:
>> On Fri, Dec 10, 2021 at 09:43:12AM -0600, Brijesh Singh wrote:

>>> +     * an attempt was done to use the current VMSA with a running vCPU, a
>>> +     * #VMEXIT of that vCPU would wipe out all of the settings being done
>>> +     * here.
>>
>> I don't understand - this is waking up a CPU, how can it ever be a
>> running vCPU which is using the current VMSA?!

Yes, in general. My thought was that nothing is stopping a malicious 
hypervisor from performing a VMRUN on that vCPU and then the VMSA would be 
in use.

Thanks,
Tom

>>
>> There is per_cpu(snp_vmsa, cpu), who else can be using that one currently?
>>
> 
> Maybe Tom can expand it bit more?
> 
