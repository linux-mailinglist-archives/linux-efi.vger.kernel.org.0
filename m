Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2D63AA0FD
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhFPQPj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 12:15:39 -0400
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:35873
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232231AbhFPQPj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 12:15:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAQscdYckpyxmC2tBqmKJO07uTrXPNB7VD3FMhmoGmecrk76qFZTOopdrfcvgJfOabAvYcNcaFVZpSqoIE+06QhfFiLAawLgk+S/nzwXSqFazbh/hhcDKkVXhbAon6E7mhDOY2lfugqtchTnFS1PBKVI4LI3UpMdxvdo9/6F13YFJnNXY5KQQCC2UK9ZEjbxJ3BKM5ItkoWENcHWpNU7LCQOZQJjYakPzhyc2LDXi72SAOTUp99PVPfw2YZMSEp8UDKqJzdIwt0K8A2HHVBDkofi4S59FpDv4n6UVEJXVGAgZ08wIoPbUoET8HqKnV0cXfHKBivHIjGKq6GfKrc62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5raZ1HmSJB6Vj8iFYdSGH2JfxJHWxYshZOISf5pBMI=;
 b=l4m1UDV90Fen6ypg93pmUKTK32bAHfpo/WjLXmqGfEDiA7DFCQi5dNkPuZtrwtxuuUjv4icvQ2nt27rJNESYfcWlyIQGTTJ4tH6Hw9GuIGpgyoS8rRpuPNOzH9dW9DDAUZ7B1NGe7oqCTmJdn6hRjaSXYGGFeOQMAus4vj7QUS+HrVnkebzyxUkiJ9vDrGFw//mK1hBeS98ZIlwTSDytWguoZrJ8oD2s0mHZyr2OoCh/ZiugY7ZxCRY1BcFWbta0oYh/O1Ap2H+NoKLfBVmwgzc0MZcrTZev7gqvWYFMG0zug+o3qdLySphytqRKpzrAcL5B+YZRpvzqVoJQkKJLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5raZ1HmSJB6Vj8iFYdSGH2JfxJHWxYshZOISf5pBMI=;
 b=Hg/PJy7Ow4RCmmziCkm8cCLgbADeSgMBgiMYs5/Zzusn8scBXWnLAtbCw9Kk5/1BF+R+z6R00ED/bmCldAYwdhtCe8nkRzA1UqiTPBkMdEHwelavUgXUSpnaZNhtzLkQhR/1XHMCK0eE7AwI2aelVRhlE7Hdf//+V1CSM9YISwE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Wed, 16 Jun 2021 16:13:30 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686%12]) with mapi id 15.20.4219.025; Wed, 16 Jun
 2021 16:13:30 +0000
Subject: Re: [PATCH Part1 RFC v3 19/22] x86/sev-snp: SEV-SNP AP creation
 support
To:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-20-brijesh.singh@amd.com> <YMn3mnyLDUNYGJA2@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <8c72b9cc-4db1-b556-3c41-66abcd721eef@amd.com>
Date:   Wed, 16 Jun 2021 11:13:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YMn3mnyLDUNYGJA2@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:806:23::9) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA9PR13CA0064.namprd13.prod.outlook.com (2603:10b6:806:23::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 16:13:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d388155-7012-4466-26a8-08d930e1ae83
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02207EE070AE7BF896630A07EC0F9@DM5PR1201MB0220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsZO5vKTPFcBXhWc9mtKLFD8y9oqxlALN2l0GmaTsGY3u+sEXKEShhvfqj9SWXmF8MPnZtHU/1ZJDqKGx5haUhu1u7atEetl9ensFdj+VyIDaNZEyNfzjxTOst2SXLiX/CE8dF5Tw4zBImdMaTCdpQQVnQEVZk6bGnekB0S4e0RLCKzijMvCtHsafjwG/8Qxa9ps7iAev/m+c4p/11DLAPybkwdY3xcdBoNei/pWG78LFABRadB+unc//HaLi8MgymL8OMZT1/wTBYpIWaFXMqf4bXpFqkHZenuJyCdxAlYW6AvvyaBHdZx1xZzz1XMH8Ewxh7wTz2F2nQSAKR43vkCQvyYqCAHDP9vc2tiOddMtnQXX66wVMudZxKiIccR1/jfpRr3jXbyjhrRXWVA7uBvHGg/9YirTvCAHBwNWgVnBI+kIBzqkAVG92MYDsWvxoiYLgEwqNUr+b/5yDZStj7vRlk1/LijxGxlHBr3zHYIZb4G6FxMSqIoKFaGvVh6MIse45ex81604V1M3FgJxtBd0mR2tZDUdrTIX0piDP7v4irUlfrNYIZruhZJcjkULmKS7k8pbg5dyp8pcxtj7qsRNnOEjQcl0KsdkcL4bXVgoP9pl/TnM18Yb/bPhUsIQjKQbTFNcgvKryNqEMirVnT391RLKdfMX/4xUgu2b8ezlgJ/pfnod7M+IeP+yuhRD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(6512007)(110136005)(8676002)(6506007)(53546011)(956004)(4326008)(8936002)(54906003)(316002)(2616005)(5660300002)(6486002)(30864003)(2906002)(31686004)(86362001)(66476007)(66556008)(26005)(38100700002)(7416002)(6636002)(66946007)(31696002)(186003)(478600001)(16526019)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVVYdHRST080WDJkNTA1Y2pUS2d5Sm1uQWt2Nk4vSGcxckZtZEcvME03WUhm?=
 =?utf-8?B?elZLbVdyRTBGSjZ6SWV2azlVNWFrbTJLbVZKSVZtVDhvc29LSXZWaDYyYjR6?=
 =?utf-8?B?WVZJSUJIM0FGWEI4Sk9uVi9pbFQ0SmtNd3hPeUNPd2tJYjFRS3N6bHQ3OGZz?=
 =?utf-8?B?TmpCOWptQWEySzhhYkxVYzFGWjYyakFuS1k4Y2ZnT2xBWSswZktDRkJHWjZT?=
 =?utf-8?B?R0VHN1JsTDU5UGswRVd1b3pRYldreTlpd2puMVVnNEs2UEVaQXRzbjRrWlVi?=
 =?utf-8?B?OEwwNnhoVmdRUHdGY3cza2NvQnUvdHZoY2o5eUdDMmVvNmN1cGdaM1FzeXA3?=
 =?utf-8?B?Z2dSR3Q3amFyb3Jkb2VQb2djaXE5dENQNlZHNnB1ZFFVQmNpNC9FVFpaa1Y3?=
 =?utf-8?B?MG9reUErT0lDSkV2dE12UURqVTVOWDdOeFczc3dMM3A0Vm9BZW1RR2JVdjlz?=
 =?utf-8?B?bVFYZU9xMTVhc2lFWkowK3JKSUdDTElqeG5GUE8xckdCbDh5OC82SGZ2UFdT?=
 =?utf-8?B?emI4d0I0cjJ0ZUNzWnlXWWJmZ1VoMFppelgxUmNWVDlvUUJ3cmdSenJ4QjFW?=
 =?utf-8?B?NmREbFpkQ0JEbC85YnorOXE3M2NPLzczQ1g1QUw0WGdnQW1zQmNWN3B1ckNi?=
 =?utf-8?B?YVNRbzJ3SnF0eklTOU1WV1FTMmg4K1AraVBVYjZwUnpFYzFtc0UxUHZ5OG5O?=
 =?utf-8?B?WEFmMWUvMUF3cUhNL3NFU29xUUlraVpMUTlGMkVuczljSWZ2M0FBaFpJZ2N0?=
 =?utf-8?B?NEdRRnc2eFdYZ2QwdjVYTkxOR3dTaVl3NjBpZERQZHZlVlBXbmgvTXh5Q2to?=
 =?utf-8?B?SndIQklqZDJCWnR1OGtnbjh4R25JSmhGRjE2UGZsdGgwY0xOMHRNUCtOQ3c1?=
 =?utf-8?B?bHN1bFFkaHg2MWlscHFtZzVSbUEyMEZUaUtwWWVPVC9ibUVmeXJiNFhXaHFa?=
 =?utf-8?B?eXdnaE5EekozTjhWdVpjeXNZME9yK1AyR3BtY0cwQ2xheXVlaTdzZE5wUmNI?=
 =?utf-8?B?RGZsMVMvdmdCckh3R3NSbzFjcW5xd2YrOUx0bGNlcWg0eXZjclY4RWNZRUtX?=
 =?utf-8?B?dGF3UHlKT0pjRkN5STU0clNxK0RZOUFxUkNBeXJ2dmVjV2VwUDJxcWxNdUg1?=
 =?utf-8?B?ZnVjTzgya05HVE1tamg2UTh1Tmg2UFBsaGh0dXp4TTkwZ3h1UStGL2pTSmUw?=
 =?utf-8?B?N3ZvQjhyd3daQTJwSXBvbmJwdFRaRG9hdHI5d3dvU3VlOTQ4VGFRUmxIS1NI?=
 =?utf-8?B?OTRRVFd3ZmlYUkp0M29vUUVoWjFCaWRzdVF6eXplSFNHWlp0QlFoMW5DRXg0?=
 =?utf-8?B?ZU5SeG1ESmhOcFg5SW9Lb2VDZTBmdUZOTGNsWlhhT0MvcnpwR05ySURhcy90?=
 =?utf-8?B?NW5kRzNGTTdmdzFNZ3FtTkZhOHVNMGdNNEtvdWFUSXl2UmxLQlNkaTVyekpO?=
 =?utf-8?B?V2Ryak9rMXNzK09VN1JQVUZVWXpNWHMwVHdadWdFNFVSaG4ycU9HL0VyRzJZ?=
 =?utf-8?B?RW8vY3MyYkNENTg0VVlwM2I2N1o2MjBNeG9YR2tBUlJ1d1RiNVBpN2hhaC9R?=
 =?utf-8?B?V1Ryc0hpRUc4VUNXQnhXU1I5S1hOMU1wNnpvWkVoNXFkUWw5QWJkUnp4RlFI?=
 =?utf-8?B?VHNxT3oyQ0hwNnMwZXBMT0xSWVdQYmo4WkZXd3ZzWW5Zd2lBYnNmN21jZUNB?=
 =?utf-8?B?OUhGZm53eTlHYlk0SGxyWDEvSUswd2V3Q1dlOHJXbks4OW5nUEVUci9UMTVi?=
 =?utf-8?Q?B6rfnDnU00ssIUiRzcuKkoe92k00NiK0jwYxNS4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d388155-7012-4466-26a8-08d930e1ae83
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 16:13:30.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1yfX9W3SplUiOMVrU9/f9PleKAZd286TayEH2bJWW03v0DUGdq0C1aJW3LPTvRkfUMfs22byM8P7r/YzLAVDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/16/21 8:07 AM, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 09:04:13AM -0500, Brijesh Singh wrote:
>> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
>> Subject: Re: [PATCH Part1 RFC v3 19/22] x86/sev-snp: SEV-SNP AP creation support
> 
> The condensed patch description in the subject line should be written in
> imperative tone. I.e., it needs a verb.
> 
> And to simplify it even more, let's prefix all SEV-* stuff with
> "x86/sev: " from now on to mean the whole encrypted virt area.

Yup, I'll make those changes.

> 
>> To provide a more secure way to start APs under SEV-SNP, use the SEV-SNP
>> AP Creation NAE event. This allows for guest control over the AP register
>> state rather than trusting the hypervisor with the SEV-ES Jump Table
>> address.
>>
>> During native_smp_prepare_cpus(), invoke an SEV-SNP function that, if
>> SEV-SNP is active, will set or override apic->wakeup_secondary_cpu. This
>> will allow the SEV-SNP AP Creation NAE event method to be used to boot
>> the APs.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  arch/x86/include/asm/sev-common.h |   1 +
>>  arch/x86/include/asm/sev.h        |  13 ++
>>  arch/x86/include/uapi/asm/svm.h   |   5 +
>>  arch/x86/kernel/sev-shared.c      |   5 +
>>  arch/x86/kernel/sev.c             | 206 ++++++++++++++++++++++++++++++
>>  arch/x86/kernel/smpboot.c         |   3 +
>>  6 files changed, 233 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index 86bb185b5ec1..47aa57bf654a 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -57,6 +57,7 @@
>>  	(((unsigned long)((v) & GHCB_MSR_HV_FT_MASK) >> GHCB_MSR_HV_FT_POS))
>>  
>>  #define GHCB_HV_FT_SNP			BIT_ULL(0)
>> +#define GHCB_HV_FT_SNP_AP_CREATION	(BIT_ULL(1) | GHCB_HV_FT_SNP)
>>  
>>  /* SNP Page State Change */
>>  #define GHCB_MSR_PSC_REQ		0x014
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index e2141fc28058..640108402ae9 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -71,6 +71,13 @@ enum snp_mem_op {
>>  	MEMORY_SHARED
>>  };
>>  
>> +#define RMPADJUST_VMPL_MAX		3
>> +#define RMPADJUST_VMPL_MASK		GENMASK(7, 0)
>> +#define RMPADJUST_VMPL_SHIFT		0
>> +#define RMPADJUST_PERM_MASK_MASK	GENMASK(7, 0)
> 
> mask mask huh?
> 
> How about "perm mask" and "perm shift" ?

Yeah, I debated on that one. I wanted to stay close to what the APM has,
which is PERM_MASK (TARGET_PERM_MASK actually), but it does look odd. I'll
get rid of the MASK portion of PERM_MASK.

> 
>> +#define RMPADJUST_PERM_MASK_SHIFT	8
>> +#define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
>> +
>>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>>  extern struct static_key_false sev_es_enable_key;
>>  extern void __sev_es_ist_enter(struct pt_regs *regs);
>> @@ -116,6 +123,9 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
>>  void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op);
>>  void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
>>  void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
>> +
> 
> No need for the newlines here - it is all function prototypes lumped
> together - the only one who reads them is the compiler.
> 
>> +void snp_setup_wakeup_secondary_cpu(void);
> 
> "setup" "wakeup" huh?
> 
> snp_set_wakeup_secondary_cpu() looks just fine to me. :)

Will do.

> 
>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>> index b62226bf51b9..7139c9ba59b2 100644
>> --- a/arch/x86/kernel/sev-shared.c
>> +++ b/arch/x86/kernel/sev-shared.c
>> @@ -32,6 +32,11 @@ static bool __init sev_es_check_cpu_features(void)
>>  	return true;
>>  }
>>  
>> +static bool snp_ap_creation_supported(void)
>> +{
>> +	return (hv_features & GHCB_HV_FT_SNP_AP_CREATION) == GHCB_HV_FT_SNP_AP_CREATION;
>> +}
> 
> Can we get rid of those silly accessors pls?

Will do.

> 
> We established earlier that hv_features is going to be __ro_after_init
> so we might just as well export it to sev.c for direct querying -
> there's no worry that something'll change it during runtime.
> 
>>  static bool __init sev_snp_check_hypervisor_features(void)
>>  {
>>  	if (ghcb_version < 2)
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 4847ac81cca3..8f7ef35a25ef 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/memblock.h>
>>  #include <linux/kernel.h>
>>  #include <linux/mm.h>
>> +#include <linux/cpumask.h>
>>  
>>  #include <asm/cpu_entry_area.h>
>>  #include <asm/stacktrace.h>
>> @@ -31,6 +32,7 @@
>>  #include <asm/svm.h>
>>  #include <asm/smp.h>
>>  #include <asm/cpu.h>
>> +#include <asm/apic.h>
>>  
>>  #include "sev-internal.h"
>>  
>> @@ -106,6 +108,8 @@ struct ghcb_state {
>>  static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>>  DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
>>  
>> +static DEFINE_PER_CPU(struct sev_es_save_area *, snp_vmsa);
>> +
>>  /* Needed in vc_early_forward_exception */
>>  void do_early_exception(struct pt_regs *regs, int trapnr);
>>  
>> @@ -744,6 +748,208 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
>>  	pvalidate_pages(vaddr, npages, 1);
>>  }
>>  
>> +static int snp_rmpadjust(void *va, unsigned int vmpl, unsigned int perm_mask, bool vmsa)
> 
> No need for the "snp_" prefix. Drop it for all static functions here too
> pls.
> 
> @vmpl can be a u8 so that you don't need to mask it off. The same for
> @perm_mask. And then you can drop the mask defines too.

Will do.

> 
>> +{
>> +	unsigned int attrs;
>> +	int err;
>> +
>> +	attrs = (vmpl & RMPADJUST_VMPL_MASK) << RMPADJUST_VMPL_SHIFT;
> 
> Shift by 0 huh? Can we drop this silliness pls?
> 
> 	/* Make sure Reserved[63:17] is 0 */
> 	attrs = 0;
> 
> 	attrs |= vmpl;
> 
> Plain and simple.
> 
>> +	attrs |= (perm_mask & RMPADJUST_PERM_MASK_MASK) << RMPADJUST_PERM_MASK_SHIFT;
> 
> perm_mask is always 0 - you don't even have to pass it in as a function
> argument.

Will do. The compiler should be smart enough to do the right thing, I was
just trying to show the structure of the input. But, easy enough to drop it.

> 
>> +	if (vmsa)
>> +		attrs |= RMPADJUST_VMSA_PAGE_BIT;
>> +
>> +	/* Perform RMPADJUST */
> 
> Add:
> 
> 	/* Instruction mnemonic supported in binutils versions v2.36 and later */

Will do.

> 
>> +	asm volatile (".byte 0xf3,0x0f,0x01,0xfe\n\t"
>> +		      : "=a" (err)
> 
> here you should do:
> 
> 			: ... "c" (RMP_PG_SIZE_4K), ...
> 
> so that it is clear what goes into %rcx.

Will do.

> 
>> +		      : "a" (va), "c" (0), "d" (attrs)
>> +		      : "memory", "cc");
>> +
>> +	return err;
>> +}
>> +
>> +static int snp_clear_vmsa(void *vmsa)
>> +{
>> +	/*
>> +	 * Clear the VMSA attribute for the page:
>> +	 *   RDX[7:0]  = 1, Target VMPL level, must be numerically
>> +	 *		    higher than current level (VMPL0)
> 
> But RMPADJUST_VMPL_MAX is 3?!

Yup, I'll make this change. And actually, the max VMPL is defined via
CPUID, so I may look at saving that off somewhere or just retrieve it here
and use that.

> 
>> +	 *   RDX[15:8] = 0, Target permission mask (not used)
>> +	 *   RDX[16]   = 0, Not a VMSA page
>> +	 */
>> +	return snp_rmpadjust(vmsa, RMPADJUST_VMPL_MAX, 0, false);
>> +}
>> +
>> +static int snp_set_vmsa(void *vmsa)
>> +{
>> +	/*
>> +	 * To set the VMSA attribute for the page:
>> +	 *   RDX[7:0]  = 1, Target VMPL level, must be numerically
>> +	 *		    higher than current level (VMPL0)
>> +	 *   RDX[15:8] = 0, Target permission mask (not used)
>> +	 *   RDX[16]   = 1, VMSA page
>> +	 */
>> +	return snp_rmpadjust(vmsa, RMPADJUST_VMPL_MAX, 0, true);
>> +}
>> +
>> +#define INIT_CS_ATTRIBS		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
>> +#define INIT_DS_ATTRIBS		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK | SVM_SELECTOR_WRITE_MASK)
>> +
> 
> Put SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK in a helper define and share it in the two
> definitions above pls.

Will do.

> 
>> +#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
>> +#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
>> +
>> +static int snp_wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
>> +{
>> +	struct sev_es_save_area *cur_vmsa;
>> +	struct sev_es_save_area *vmsa;
>> +	struct ghcb_state state;
>> +	struct ghcb *ghcb;
>> +	unsigned long flags;
>> +	u8 sipi_vector;
>> +	u64 cr4;
>> +	int cpu;
>> +	int ret;
> 
> Remember the reversed xmas tree. And you can combine the variables of
> the same type into a single line.

Yup.

> 
>> +
>> +	if (!snp_ap_creation_supported())
>> +		return -ENOTSUPP;
> 
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> #320: FILE: arch/x86/kernel/sev.c:813:
> +               return -ENOTSUPP;

Yup.

> 
>> +	/* Override start_ip with known SEV-ES/SEV-SNP starting RIP */
>> +	if (start_ip == real_mode_header->trampoline_start) {
>> +		start_ip = real_mode_header->sev_es_trampoline_start;
>> +	} else {
>> +		WARN_ONCE(1, "unsupported SEV-SNP start_ip: %lx\n", start_ip);
>> +		return -EINVAL;
>> +	}
> 
> What's all that checking for? Why not simply and unconditionally doing:
> 
> 	start_ip = real_mode_header->sev_es_trampoline_start;
> 
> ?
> 
> We are waking up an SNP guest so who cares what the previous start_ip
> value was?

It is to catch any change in the future that adds a new trampoline start
location, that may do something different. If that happens, then this will
do the wrong thing, so it's just a safe guard.

> 
>> +	/* Find the logical CPU for the APIC ID */
>> +	for_each_present_cpu(cpu) {
>> +		if (arch_match_cpu_phys_id(cpu, apic_id))
>> +			break;
>> +	}
>> +	if (cpu >= nr_cpu_ids)
>> +		return -EINVAL;
>> +
>> +	cur_vmsa = per_cpu(snp_vmsa, cpu);
> 
> Where is that snp_vmsa thing used? I don't see it anywhere in the whole
> patchset.

Ah, good catch. It should be set at the end of the function in place of
the "cur_vmsa = vmsa" statement.

> 
>> +	vmsa = (struct sev_es_save_area *)get_zeroed_page(GFP_KERNEL);
>> +	if (!vmsa)
>> +		return -ENOMEM;
>> +
>> +	/* CR4 should maintain the MCE value */
>> +	cr4 = native_read_cr4() & ~X86_CR4_MCE;
>> +
>> +	/* Set the CS value based on the start_ip converted to a SIPI vector */
>> +	sipi_vector = (start_ip >> 12);
>> +	vmsa->cs.base     = sipi_vector << 12;
>> +	vmsa->cs.limit    = 0xffff;
>> +	vmsa->cs.attrib   = INIT_CS_ATTRIBS;
>> +	vmsa->cs.selector = sipi_vector << 8;
>> +
>> +	/* Set the RIP value based on start_ip */
>> +	vmsa->rip = start_ip & 0xfff;
>> +
>> +	/* Set VMSA entries to the INIT values as documented in the APM */
>> +	vmsa->ds.limit    = 0xffff;
>> +	vmsa->ds.attrib   = INIT_DS_ATTRIBS;
>> +	vmsa->es = vmsa->ds;
>> +	vmsa->fs = vmsa->ds;
>> +	vmsa->gs = vmsa->ds;
>> +	vmsa->ss = vmsa->ds;
>> +
>> +	vmsa->gdtr.limit    = 0xffff;
>> +	vmsa->ldtr.limit    = 0xffff;
>> +	vmsa->ldtr.attrib   = INIT_LDTR_ATTRIBS;
>> +	vmsa->idtr.limit    = 0xffff;
>> +	vmsa->tr.limit      = 0xffff;
>> +	vmsa->tr.attrib     = INIT_TR_ATTRIBS;
>> +
>> +	vmsa->efer    = 0x1000;			/* Must set SVME bit */
>> +	vmsa->cr4     = cr4;
>> +	vmsa->cr0     = 0x60000010;
>> +	vmsa->dr7     = 0x400;
>> +	vmsa->dr6     = 0xffff0ff0;
>> +	vmsa->rflags  = 0x2;
>> +	vmsa->g_pat   = 0x0007040600070406ULL;
>> +	vmsa->xcr0    = 0x1;
>> +	vmsa->mxcsr   = 0x1f80;
>> +	vmsa->x87_ftw = 0x5555;
>> +	vmsa->x87_fcw = 0x0040;
> 
> Align them all on a single vertical line pls.

Will do.

> 
>> +	/*
>> +	 * Set the SNP-specific fields for this VMSA:
>> +	 *   VMPL level
>> +	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
>> +	 */
>> +	vmsa->vmpl = 0;
>> +	vmsa->sev_features = sev_status >> 2;
>> +
>> +	/* Switch the page over to a VMSA page now that it is initialized */
>> +	ret = snp_set_vmsa(vmsa);
>> +	if (ret) {
>> +		pr_err("set VMSA page failed (%u)\n", ret);
>> +		free_page((unsigned long)vmsa);
>> +
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Issue VMGEXIT AP Creation NAE event */
>> +	local_irq_save(flags);
>> +
>> +	ghcb = sev_es_get_ghcb(&state);
>> +
>> +	vc_ghcb_invalidate(ghcb);
>> +	ghcb_set_rax(ghcb, vmsa->sev_features);
>> +	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
>> +	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
>> +	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
>> +
>> +	sev_es_wr_ghcb_msr(__pa(ghcb));
>> +	VMGEXIT();
>> +
>> +	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
>> +	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
>> +		pr_alert("SNP AP Creation error\n");
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	sev_es_put_ghcb(&state);
>> +
>> +	local_irq_restore(flags);
>> +
>> +	/* Perform cleanup if there was an error */
>> +	if (ret) {
>> +		int err = snp_clear_vmsa(vmsa);
>> +
> 
> 
> ^ Superfluous newline.

Ok.

> 
>> +		if (err)
>> +			pr_err("clear VMSA page failed (%u), leaking page\n", err);
>> +		else
>> +			free_page((unsigned long)vmsa);
>> +
>> +		vmsa = NULL;
>> +	}
>> +
>> +	/* Free up any previous VMSA page */
>> +	if (cur_vmsa) {
>> +		int err = snp_clear_vmsa(cur_vmsa);
>> +
> 
> 
> ^ Superfluous newline.

Ok.

Thanks,
Tom

> 
>> +		if (err)
>> +			pr_err("clear VMSA page failed (%u), leaking page\n", err);
>> +		else
>> +			free_page((unsigned long)cur_vmsa);
>> +	}
>> +
>> +	/* Record the current VMSA page */
>> +	cur_vmsa = vmsa;
>> +
>> +	return ret;
>> +}
> 
