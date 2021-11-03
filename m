Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C15044495E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Nov 2021 21:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhKCUNJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Nov 2021 16:13:09 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:60801
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230243AbhKCUNI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Nov 2021 16:13:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H40RcYskgytP5pVtGWpIvYUBanGgd5raCIqP8cqj3eQ3sGRmKfwrlEiq3/sAfuLGAIoNHVuc30x4M94AZwy7sqQ++RLz7xeRzHaZ/c8SLw8lOZPnrg1j3bMmMrfbuuspEhaR3LwiZ/tOm/57I2a1wpR4+DaZjw1IjuEqrqOang5WQ79s518zZB348LMnJl+XE4Nu1a+iQS+DS8LvTf8dRnqE6rVVIAuvJYj0Z0hJOfFnx8IcTgEL3dJEAhxb1VW92tIoFD7dvGtxokeTR3FwHVmCNpagzRFGa8HIO366zXspZSzlR1vnN2lmefDMYgh37mYAbrvuOtlc1nQ9zCLHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+BvHctcBTQijhyl1a0w3G80LQPsbIRXCR24jNQBgv8=;
 b=Rn7BNSEc8VLkq67+43ffeCgqbrxmqDPs4sqig2mPpWa4DyD4M3X9vQlpBx1RUMnXzbhzmQQWuB3j8EzaGonRcyrElytKDinOq/oru9VSoh783YaZItZzsc3ZanzbVQIWIaKlAfzliBEDqH2NSl91UdbSR2KcUEPkvhw2vnSPy7f7gjC49pIlAhEcACRxcTeusvX3ZPrCBXNqGDpDIwcRxhUsy3zecJv+BJX3N8qHkafVp/anI8Sj49sWn/huF4p8H0buxXBR3rzpX6RolhZsm6/wOdIzY98KyDUMA7pleKP3UgGG0tQC7guKp6Hd7Y7Lyr9lF98Wjg31KhHwsywI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+BvHctcBTQijhyl1a0w3G80LQPsbIRXCR24jNQBgv8=;
 b=fqLvbxd67PjvZ39+UB0IM6cgKCpy3q55oeJ11Ky+optOLSUrYQnXiepOKhM/YiEzETJZJqt27h8uSrsMQ0uNyDtq2+U/GkArV60KY8JpW99mDEiuPFRN2rs7pX8uUOIU6sGA85EQ3nnLvFFOhAdZ3XHIiHFedZUD6eV7MFCKRpM=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Wed, 3 Nov
 2021 20:10:28 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 20:10:28 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 14/42] x86/sev: Register GHCB memory when SEV-SNP is
 active
To:     Borislav Petkov <bp@alien8.de>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-15-brijesh.singh@amd.com> <YYFs+5UUMfyDgh/a@zn.tnic>
 <aea0e0c8-7f03-b9db-3084-f487a233c50b@amd.com> <YYGGv6EtWrw7cnLA@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a975dfbf-f9bb-982e-9814-7259bc075b71@amd.com>
Date:   Wed, 3 Nov 2021 15:10:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YYGGv6EtWrw7cnLA@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610::21)
 To SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by CH2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Wed, 3 Nov 2021 20:10:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89cd9a35-f380-48dd-256c-08d99f05fa79
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2685B7F60868615528426850E58C9@SN6PR12MB2685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgDpo6tJmOY8HYxCJgGx0A4MCwj7c2qo9hx4D1vPq7rXD2rbpK6aNzUb/4IsS+8XhMnwgIjjLMYUn68Zlj5lg5q5BoLhgVbM1ppbSqlje54Cyj2NxNONUGQi3HP2AckGqMAq2tHbPZ0XNxyGm3cDLfqiHmDjlaD4s4mHf9z1uo0U1TAEHTknU0TOI9C2AKyIVlthGrzGrTit3mJmkAWQtvqralXXMYEIzrLO+AD318Ne+M6/p96VBMXs6gS602+Q+Z1h8p5nfdqbUizaQQf560dU7duX9ZH/nUqY0VYQ9+6e5AGv+73Ze5m3rj71kUHLLyvy5q3KczU/IseWSE8o7fYdRfl2uQ0DAyEX1o4cHHjYxbhiLEM8dA4SGafZmFqsk2awyLne0cvGVlhgo1niur5sT6YJnEli0GaRJDTONxPTgoJu83zuTSeIzO8Sly5rVqfws6mVqrdC3xOjNkjVf6HdQAhVkxs4RPD8JdLwtodlMUVgq1bRvWvg80OO5iOm+kgSM9z96Bd2WNsz5F82NwuGc3v7iY6P5w13kBTGtblwrkMszySqxbyEACIxUkhHGKY3Pl21xNVe/TFuEMjjqN/+LKP6YJKKLsdJJxFo2P2SNcdl069mMwKgOvmW81JXHH9VDUU6EfVwjfQATCF9mwgHmLAsUWflyy+RKHs3oO9GpNHgjU7peR048fyIHRqfq0nbla+wru3CIt9ysx8uWttEAA+NEu+wcHR73R+9V0GR+4YdgGyaVRCbmbIMvDTi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(36756003)(6916009)(2906002)(31686004)(2616005)(44832011)(66476007)(66556008)(956004)(66946007)(186003)(16576012)(316002)(8676002)(31696002)(86362001)(7406005)(6486002)(7416002)(26005)(4326008)(508600001)(53546011)(8936002)(83380400001)(54906003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUNzVVBXRWNwUlk3bVJQSUxFWGRqU3ZKZGpMbDZBeFdoYlhtZ21Ub09lbVdL?=
 =?utf-8?B?UE9NTjN2ZCthK1JhWVh1clgxZjllaGdpNUM1aWhxTFdiditvcXFOUTNtc3RU?=
 =?utf-8?B?SzBDYWlKaHJaVnd5ZWVjQ3pSclRFQ3EyOHFjZjJpMXF4VzQyTXZRMlIveTgv?=
 =?utf-8?B?RlBEZXVxNGZldGxPc1R3b1hVd0d2WEhwbktLanBZQU9kODZKbW4zMTBYSm9X?=
 =?utf-8?B?WXM0SmZ5ZUg4WmhPb0ZlRnJYQlIwMks1WmV0amJZdCtCaEhjcHVJKytFNDBC?=
 =?utf-8?B?Z2tNd3Vza2lOLzVRa3FQQTJJT0VYMlQ0ZndtZTVKdGwrMVYyNnE5a092MXhT?=
 =?utf-8?B?NWpGTVk3Y21VTnRlWE44SWFYcjIxN0UzaFNCZmw4RmJ6WERaY3lOR1MzQU9C?=
 =?utf-8?B?d0d3cjBySzkvWXVaVC8wckwyL2lWWXc4bnFka2J1VTAwckVUYVdWNnNWTjhV?=
 =?utf-8?B?SXpXZ05tYThHMHNIOVRUd01HTnN1TFlzVEgrZkhEWW1pdWhVV1U3OTIxY1Iy?=
 =?utf-8?B?SlluYzI2OGxVV0JzSVlQZTBvNXlnOEc2cWlqeEZZWTdPSnRrRC9hbWRXVzVK?=
 =?utf-8?B?TlNiTVN4akloM29zSHJQR1pRTlNIcFl1TjB3NjF3bThabWZrcUtBd0xGb3Zs?=
 =?utf-8?B?dlMrMzllVW43Sm95YTdGTlY2aTNyNHkxZmZPSCtwNkNicFRnWWdZUlloQzZa?=
 =?utf-8?B?ZXJwRXpaVjZIMElEeWkrV1Y1LzRaOXFuNUQ1TFZyeTc5ZmhXMUlkR25lUXJl?=
 =?utf-8?B?L3VncXpScnpoSnhxMUdZYjJuMm8ybi9rWUIxWHF3SVRLK2RtUVJaZ1Q2N3d6?=
 =?utf-8?B?MkU1UTdveGJLOGhEV0ExQ3ZpVXYrdzU1bHdZYkpKMGE5TWQwWGRsbGMwRWgx?=
 =?utf-8?B?VHUrTndGTXJCaHJVMzdyVjFJd3BQMStEQVRpQmM4MmFQa2ZoWVZxMkZjYXRt?=
 =?utf-8?B?Y2lFcFc3REJRbDN3OXJzWlp2Q2dZYVYzVkJXL2JmWW5rVmo3QmRQSnVjR3pL?=
 =?utf-8?B?c2NHVEZHaXhQWEMwS2lFbkN6dnl4MmJMdUhocVdIcFZ2Qk5PZlNoSWRzbkdt?=
 =?utf-8?B?cjloQTc5ZTlZMUdRdkRSTWJHY1RvVmRVeWdnRFRQWWhjbldteFJFVmJpOVNz?=
 =?utf-8?B?UFBTWDFScCtaY3ExYXZkZzhxK2s4Z1NGS2NuSnluN0w3akFyVmZzWElzcWFz?=
 =?utf-8?B?MGFMTUxweVBTVyttZ1hMeVYrYWY3ZENtRk9FVHgzRysyK1VQUFN6MExCTFNp?=
 =?utf-8?B?STQzMHNEVHFRM2Mvd0RLUUhjdThwUTgrS2NCMVpZa2I2WFhRSWdlV0tvWUlX?=
 =?utf-8?B?M1pHMENja3RFcnR1WU90VlRIeXhNWTRTSURhSTlWeGdQUGtVU0VHZzZDM3Jn?=
 =?utf-8?B?Tnh1QVBtczhEWUw3bDlHd2hXMGtyMmpwS3dhbmw3Z3Fxb2ltbFE0ZHB2V2dy?=
 =?utf-8?B?OU5WVno0dDFKeFd2aGY4bTBXQ1ZVTEpRSTZKcE5vVGtHcDVGdmRoQm90TGtQ?=
 =?utf-8?B?U1ZRWUIwdDQ0MHZ0d1RFN2FpUGQ4TVVDU3Q1L3ppcTBNWUl2N05HZGlKNVlS?=
 =?utf-8?B?NDNCUFBsZDRkemEyK2VPQXlISXhwSmlweFIwYXNHY3BWRlJ4SFFDTDNkTnVt?=
 =?utf-8?B?N1hDKzZYWFRIM2lFVVpRWWx3b3BDcHBjeVQ5YXRDTEt3WVdlVUNleE1vWFZB?=
 =?utf-8?B?TWxzd2RyQWdNU2tiSGFaMjY4SWw3SmhkUTFUWW9QN3QrMEdxU2xFL3ptNW1V?=
 =?utf-8?B?S202NDJBY2x6RFdEZk03VW5HT1ZzMHJYc0d2RU9iMklrTm40K3FVQ1BlQmhv?=
 =?utf-8?B?WWJpU3dEOVpteWVMWE9XR1AyRHF6YU5OVEoyOXVQc1Y4aXRUQ1BveUdicXYv?=
 =?utf-8?B?OERLUGVVT1RoRFZPdUtVTHVaSUFuYUdiUzNmeVd3aGU2WVpoUXlzalphVThJ?=
 =?utf-8?B?cjZEVFpjT1dHNVhldlhwWmJNaHU4OTBlQ2tyZE1pY2JRY2ZlbyszeEdiWmJ5?=
 =?utf-8?B?ZWJpMThLZjlhdlZ2ZFBscnVBL2lkWVRUZ1dyRi9rZDhhR2dYVlQ0d3Jkdzlz?=
 =?utf-8?B?TkFrZG9oUU5TNURRUWV2alREelF1aG8wVXpWeWVOQ2hSVDFLV2F0UHV5SlI1?=
 =?utf-8?B?emM2cHhDSnFKT1dqSWVKVGpRazVDUDRDUkdSZnNOUUlxa3FTb0tib2EzSGVY?=
 =?utf-8?Q?hZjIPKzgoLZI1nCENJmq2YE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cd9a35-f380-48dd-256c-08d99f05fa79
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 20:10:27.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmR3dwi9FODNeiIfw7AAcJKTnq3E/CwuTW/cbJIpmZz+F78s1IcNi3Vehh+Cr6nVcIQ+r0s7fuPKiaSA8dzAbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Boris,


On 11/2/21 1:44 PM, Borislav Petkov wrote:
> On Tue, Nov 02, 2021 at 01:24:01PM -0500, Brijesh Singh wrote:
>> To answer your question, GHCB is registered at the time of first #VC
>> handling by the second exception handler.
> 
> And this is what I don't like - register at use. Instead of init
> everything *before* use.
> 
>> Mike can correct me, the CPUID page check is going to happen on first
>> #VC handling inside the early exception handler (i.e case 1).
> 
> What is the "CPUID page check"?
> 
> And no, you don't want to do any detection when an exception happens -
> you want to detect *everything* *first* and then do exceptions.
> 
>> See if my above explanation make sense. Based on it, I don't think it
>> makes sense to register the GHCB during the CPUID page detection. The
>> CPUID page detection will occur in early VC handling.
> 
> See above. If this needs more discussion, we can talk on IRC.
> 

Looking at the secondary CPU bring up path it seems that we will not be 
getting #VC until the early_setup_idt() is called. I am thinking to add 
function to register the GHCB from the early_setup_idt()

early_setup_idt()
{
   ...
   if (IS_ENABLED(CONFIG_MEM_ENCRYPT))
     sev_snp_register_ghcb()
   ...
}

The above will cover the APs and for BSP case I can call the same 
function just after the final IDT is loaded

cpu_init_exception_handling()
{
    ...
    ...
    /* Finally load the IDT */
    load_current_idt();

    if (IS_ENABLED(CONFIG_MEM_ENCRYPT))
      sev_snp_register_ghcb()

}

Please let me know if something like above is acceptable.

thanks

