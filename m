Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12733D1423
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhGUPqI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jul 2021 11:46:08 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:11232
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231219AbhGUPpv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 21 Jul 2021 11:45:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK1dyn8p2zDyvEsIYcteMaHxpeNG/81XpdzKY30gmlhQNEMMJgFBrvmqhy04U25SO3lClKnk2Wvo0t0CkHB3pWTVEzPSnMhY6vhk4In/hki8MuC52ZsV3mRfVz+w/91gVH+V3DTHAPR8rl2myaZw8qrW1o8+dCFggbp/zHnApwTFDwyadDLiDlZ9q89VyQJY4d6RMZrXOZMAe8ADvoeVcLeFFtump0VbvT0FYioZ349YulzFFu+W4dhld1ed8U3aNrXuQWWWgS72Ekq/BElEBFWcDCV2GQUoIpvRG64wV3WlnHCUX0/6IOQeR130OVh3aQxL9ZYdHHzbbC+Qv9aWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLijf7pxU1l/J7FDqBNA7ttPWOgjJXl4/mtD6QBVi9U=;
 b=KD/WPVvOavFB9Dm2JqPHBfPvuw2sMN20umKfbHgLiEto4duOo+laLCTquIHDHppYjCTqTc/c1t7TOZVm3YJfQw60sHRHTmmCd9mSjHxhvc//aMgYvheerP2G/tLQ12yhPQFJs1m7vAf8JVWSsA7VTw+WivNaLSvOSLJGrrUkTP52kIc60MXG8BOTvcVrQ7Z1ylS5dMH4AOIomDHEv+1x8Nb696G+ZdVK0lGnU/H9Tq+sUIS9+4lO+xHBkiFBkBW0wsjXfgXfBpCsDeIJET8mwumEem38BX7yBXrOF1SvsycKMqH9hIFrbCSi/4iSW884+cGpzm0BwQYPP96SGPKxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLijf7pxU1l/J7FDqBNA7ttPWOgjJXl4/mtD6QBVi9U=;
 b=0yo431RmqS5zP/t/4ghSOnCy2Yoxm1tk/mr/4gqsTq1R+n1W2H9fZGH1kP5go+y93M51vOWwcTeLDJdE/ZPJYHLXvM6T/h5RmujgMcIPYCCLvPxg9RroO8JUxQPRxkd2rgw4dNVLc92l0qv2JGcS+WcPrW+KFchRo/smM40Gm/w=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Wed, 21 Jul
 2021 16:26:25 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 16:26:25 +0000
Subject: Re: [PATCH Part2 RFC v4 39/40] KVM: SVM: Use a VMSA physical address
 variable for populating VMCB
To:     Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-40-brijesh.singh@amd.com> <YPdoTK9V3anPZe7C@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <0195b407-4a2a-41f7-bdea-16789a800e3f@amd.com>
Date:   Wed, 21 Jul 2021 11:26:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPdoTK9V3anPZe7C@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0108.namprd02.prod.outlook.com
 (2603:10b6:208:51::49) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by BL0PR02CA0108.namprd02.prod.outlook.com (2603:10b6:208:51::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.27 via Frontend Transport; Wed, 21 Jul 2021 16:26:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46d84595-40f2-4a88-09f1-08d94c644906
X-MS-TrafficTypeDiagnostic: DM4PR12MB5199:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5199A5242AF0BA5A6C911DA5ECE39@DM4PR12MB5199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0KZPdFRhr/LjsVvqyH+4v4BcKEGeTOGYvyV25YNszMf0AwXFpdpXyNA9geMfFgOJs9n/dHPkcPA/qK84EmRfoWe4a6jne9HupEvSTxkztPDcU8X6KRn+gDJ2dP3tgg7pTm+v1RTJM5j+9b8TDYJMguN2+RytlJEEAatm8xz5zCI+1B0UdqYT9Qi9DDn2HF+/r7wKGuTfgwr9d5rdv5nsGgB7cR6yjYAaMDo88bbFbI0Ox5ZGmQf7PJZcGxw+j54pOxQLEgkuTFnP4t/rWR30/LOONrMfczFIwpBC+57iU0v6XVMdGmFytF6CsEy1ziom8+QssaN3N6XgriiVsAlMXcrA5+TRtIJMeMzMbZniLWRcKLHApDqbly3IgKYchr60ZCXW08hbIWr6i5vWYGz6NcwfvMfiO9lNIqmTNWG5ftFGB6RB2PeZ4qO2eDSrrRGMahSVCtDcQVnRGyJ77+DOKXdzgC5dAl4yzICeOZeiBTyDqvSvKfqKKAwmStiebsuYlfGsUh2543f1MCyOAk3fObdcESmuE3z5yoJpFJuXAtafTFRC7tsdUbiwP6UKWPzWZJ6xinJ/EO+23Z17OTlPU3yIDSAQmWZ2hkvkehWV1cxRreuKDd/Xk8uOdV3LrjwfzKmnc6aJjhMQTzuJCotrWyDKGqtwvQS8j9skyrabGPiT624vjUeEcwXvMvauHAf79VJVzKDZXkVvbQ4dYTxZKHb2G0+WTgm6yL+XrGwPdH0Ia9d93+dWRL2yAyGJibx0FGRmEoSE+6xhBxozjNlQLyrtGisozE1BMVzaYRPKNIW4UpNoGP5lqJrqXZrsuOW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(31686004)(6486002)(186003)(2616005)(5660300002)(83380400001)(2906002)(53546011)(86362001)(956004)(8676002)(66556008)(66946007)(6636002)(54906003)(36756003)(4326008)(478600001)(31696002)(7406005)(7416002)(110136005)(38100700002)(26005)(45080400002)(316002)(966005)(16576012)(8936002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUU2d0NCU25SdllUdnFoUlV5WGhaMEpna0ZKV1lCTGxPQytOcUJTQU5lV1E4?=
 =?utf-8?B?Mis5QnJJME1zSGpzNUpQdWJBR0hqZnY1TExUUnpQUzVOaVdHTklEMFJ1engv?=
 =?utf-8?B?bERPWjA0SFR4N3lKUTlCMzMveitjeVFaSXBjUWZIUVV2NEtwd0h0QUdSbVZm?=
 =?utf-8?B?VUV6QXlWV2J3UEJ4OXJaZnlSQnFadGJsd0JuVUNVZ01nRGYzbW5Id0ljSzVx?=
 =?utf-8?B?a0Y2a1QwdExoZHlncHYwZVV5azFkalJqYUUwbytWSUMzNjFJWFhnUVQxbFlG?=
 =?utf-8?B?YUZDSitkekpsU2ZGNjlHdmVZaHFzSmxBaFhPY2FtVVNkR1ROV3YwcE1iSEp1?=
 =?utf-8?B?dzlScnRGSjkxNklPZmRrWFFVOXUyM0Raa05SVmQ2c1hlclNybXEraFc2TkFw?=
 =?utf-8?B?T0NCdTJmZzlXTlNlelR6M1Jhc3A1djJqZDFlWHVnVzRpSCtqVnA3UHJtZ2xz?=
 =?utf-8?B?eDVRTGJ3em5TWFB0TmdFcWpFU2JHekxQT05LQ3hvUWVNN1hTVHM1SUp3cjFG?=
 =?utf-8?B?WWwvakIwUVo0OTZ1eFprUlU0dTVmMUExcU5HM0srMUJ4Sys1akl0WStjTkxS?=
 =?utf-8?B?UG1DLzR2WUdSKzJYdlF1M3hDMzNGK1I5ckFjaFpmekNrQU9qK2R0cm42Znhh?=
 =?utf-8?B?VjI0WHlrZTBMWEZUdmFWNklMSDlUYzI3UCsxVWZBb3o0WTJLM1ZIY1JBSTkw?=
 =?utf-8?B?VHFtaWs0SnR0TUM0eG5mTERsWVdlY3k5Y0toS3JFTmdzZ3lvcmM5cnZmWGYx?=
 =?utf-8?B?YkMwT2duTUt1QzY5T1Y1QmZwUlNvZ0E2V1d6MWttdUY3WDA5ZUxFbFBiczdF?=
 =?utf-8?B?SnNrMTY4VmN2OFZXQkYrV3h5b3lFUFVzYVFzQ2F0cEM5WThtUmxFcmVWTGoy?=
 =?utf-8?B?dENndkNDdFdzZGl3bnZmL3pickR6MXZtSTZvODN3eUtGUWhURjFJM1Q0eHpP?=
 =?utf-8?B?U1pINnB1MW8za3p0ZVdpWER4RFBRVUdoWllQbm9TUTNmYUx3emRBQkUyOGRo?=
 =?utf-8?B?QTBNNzF6bjRhR0JmOWk2d09mM3B6N2Z1MkZXSzdUY1JzelF1c3hQbEFDa0hL?=
 =?utf-8?B?eG94RWtSbGVXdU11M1JueGpOa1dJTjZvTjRjaE9PdjJkaHZDR0dRZWhMSDdi?=
 =?utf-8?B?RFZQQnE3U0VUSFlaZ1orSnZ1c1pERGJLaHk2MzlTTndMcEpLWDBNWXZIdlM1?=
 =?utf-8?B?QkdVNkFGTGtvRFFvNnZsK0ZtS2lZb3lxMkZZVWRMd21WZnpGbG90emsyRVlu?=
 =?utf-8?B?TkQwR1RvalJqK2RidmN0TjVhZVBUZkEwWmVVK1lJYnJNd0FLa1FZalBFQ2hJ?=
 =?utf-8?B?RjlMelcvVUtXdk11UHpkcHd2MC9yR2IvQklYR1U2V0pId0xjdG9iMnhQNUE5?=
 =?utf-8?B?TW5UVmFNVUdWTDRwNUVEN0Nvd1dkSjBXRUpEZjduZW5tN0Mrd3JlZElJSnNZ?=
 =?utf-8?B?L01QQmh0OEp6Q2g4WXFnRnhzbko1ZzhlSnNLSnNXNDlOK2IyWUFlZDBCZmpt?=
 =?utf-8?B?VUYxSTZpeTJVanpWMFF0MlVFekdVcmY3UjRwN0RtQUtpejZ3YVRxYlVEVzhx?=
 =?utf-8?B?aU5IdTgwbTl1OHhBSTc2ZEd2dnZEQkR4QVNpdWhMVnczZFh4TXYyejFhY25E?=
 =?utf-8?B?bjJUZUcxN2ZYQTR1TjZ0SVQ5NGtXRTNXQ2Y2cTBjVHpjMlZaTENWcTlheTBD?=
 =?utf-8?B?Q05RalRrb2p6dGkvUjd5a1Vwa1RIMS9DNENQMGk5U3lTWmhJbm9iazJYRjgv?=
 =?utf-8?Q?bCo1bZYsZhdGZh4maVag8KEMJ6jArECEQISsxdf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d84595-40f2-4a88-09f1-08d94c644906
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 16:26:25.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIcv/uePLxudN0KCL/MIklnqdpDM4wqUWxvKTk+mmiFPK1Yk2Tq4HcHmxPAvnC2rnfFj7zX+xh27gwxviDc/fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/20/21 7:20 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> In preparation to support SEV-SNP AP Creation, use a variable that holds
>> the VMSA physical address rather than converting the virtual address.
>> This will allow SEV-SNP AP Creation to set the new physical address that
>> will be used should the vCPU reset path be taken.
> 
> I'm pretty sure adding vmsa_pa is unnecessary.  The next patch sets svm->vmsa_pa
> and vmcb->control.vmsa_pa as a pair.  And for the existing code, my proposed
> patch to emulate INIT on shutdown would eliminate the one path that zeros the
> VMCB[1].  That series patch also drops the init_vmcb() in svm_create_vcpu()[2].
> 
> Assuming there are no VMCB shenanigans I'm missing, sev_es_init_vmcb() can do
> 
> 	if (!init_event)
> 		svm->vmcb->control.vmsa_pa = __pa(svm->vmsa);

That will require passing init_event through to init_vmcb and successive
functions and ensuring that there isn't a path that could cause it to not
be set after it should no longer be used. This is very simple at the
moment, but maybe can be re-worked once all of the other changes you
mention are integrated.

Thanks,
Tom

> 
> And while I'm thinking of it, the next patch should ideally free svm->vmsa when
> the the guest configures a new VMSA for the vCPU.
> 
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F20210713163324.627647-45-seanjc%40google.com&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7Cef81e5604f5242262b6908d94bdd5b32%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637624236352681486%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=O3LKXhVLqNuT1PpCNzkjG8Vho7wfMEibFgGbZkoFlMk%3D&amp;reserved=0
> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F20210713163324.627647-10-seanjc%40google.com&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7Cef81e5604f5242262b6908d94bdd5b32%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637624236352681486%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=rn6zZZbGEnN4Hd60Mg3EsPU3fIaoBHdA3jTluiDRvpo%3D&amp;reserved=0
> 
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  arch/x86/kvm/svm/sev.c | 5 ++---
>>  arch/x86/kvm/svm/svm.c | 9 ++++++++-
>>  arch/x86/kvm/svm/svm.h | 1 +
>>  3 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 4cb4c1d7e444..d8ad6dd58c87 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -3553,10 +3553,9 @@ void sev_es_init_vmcb(struct vcpu_svm *svm)
>>  
>>  	/*
>>  	 * An SEV-ES guest requires a VMSA area that is a separate from the
>> -	 * VMCB page. Do not include the encryption mask on the VMSA physical
>> -	 * address since hardware will access it using the guest key.
>> +	 * VMCB page.
>>  	 */
>> -	svm->vmcb->control.vmsa_pa = __pa(svm->vmsa);
>> +	svm->vmcb->control.vmsa_pa = svm->vmsa_pa;
>>  
>>  	/* Can't intercept CR register access, HV can't modify CR registers */
>>  	svm_clr_intercept(svm, INTERCEPT_CR0_READ);
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 32e35d396508..74bc635c9608 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -1379,9 +1379,16 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>>  	svm->vmcb01.ptr = page_address(vmcb01_page);
>>  	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
>>  
>> -	if (vmsa_page)
>> +	if (vmsa_page) {
>>  		svm->vmsa = page_address(vmsa_page);
>>  
>> +		/*
>> +		 * Do not include the encryption mask on the VMSA physical
>> +		 * address since hardware will access it using the guest key.
>> +		 */
>> +		svm->vmsa_pa = __pa(svm->vmsa);
>> +	}
>> +
>>  	svm->guest_state_loaded = false;
>>  
>>  	svm_switch_vmcb(svm, &svm->vmcb01);
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index 9fcfc0a51737..285d9b97b4d2 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -177,6 +177,7 @@ struct vcpu_svm {
>>  
>>  	/* SEV-ES support */
>>  	struct sev_es_save_area *vmsa;
>> +	hpa_t vmsa_pa;
>>  	struct ghcb *ghcb;
>>  	struct kvm_host_map ghcb_map;
>>  	bool received_first_sipi;
>> -- 
>> 2.17.1
>>
