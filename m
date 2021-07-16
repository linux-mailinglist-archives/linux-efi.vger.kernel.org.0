Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199F93CBC0A
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 20:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhGPSta (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 14:49:30 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:50400
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232198AbhGPSt3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 14:49:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuDsqJdB39AZsA7tm+YYwFXL0yVebupQUrOUjzsAkMPKlc6t4jG4f9P5AJdbvFb5J3A2VzMtz57NIwuLEv42UEcoosb+efr4jkWrqPYLVnn8tfSK4dtBWPbhzm154qaz8LvyFunifj2m9Ev1addzeINQYnnvON1F5jPggNLcA454x/WFjqaI7smiu/ReQ00lNQR507Ipmh6oGM2A6Rq2Z3XWKavAXM1LeIQ0F1s8wClJneRg66EC4SHzn34nxHvgkuLW4rPd/F/BXzEOtlzc4Z0UYWw4VV6ZJpQSsAo+Vz3HiYFYmyxs5VBI1OvQ0nBfsDqjWLElsH3GV0fsYpSi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx/RpJYbAbgXhBFX82PcZ2ddlvsGADk0HPvwEtFVSMc=;
 b=W0bUvR+ajc0ekZSdg/8ImlT6S08E/n7D89IcMhdZ2VlyzjfcYi8OnpuaAtETJi7+Abk0OAJUmd+p8vJbHCK4FsDwIT8kLZfKwOdxlyD+gAB/Ou50VYzrnytHMx4DQKPP7u3N9qiVmxt15/rMm5CYUpxw2wrjNZBo/dLmlQBoWl3FJuWCQz78OntKw+5zoxdEmeHGnMdqMGqRu5Nxy1VN6mPNMMk4dzZv4zEsexVununcO9peqooCebEs77qO1Okin8owiwa9OfFT3f+o/AcokYfQqedOvuzCCRvAbOMhA3KwZs2tBf2/JCoVX2qitfYvHFmcZEnOlJf1LEDNiLReqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx/RpJYbAbgXhBFX82PcZ2ddlvsGADk0HPvwEtFVSMc=;
 b=T07434+SswSj97xNAOLqh1K9dTefIUzR8adsumrwAvc7MyDfbgWmtEb7xGQ1MjFEKbXW69OcMqapLNrupCN9wiLvSU83FjHr3IQoFIRMmzmzQpyg9aVXDdtlof6YkVzKaBwGi3pSh+bOg1o544u3d6cdE/b8/w2uDEhJGUzwEpM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 18:46:28 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 18:46:28 +0000
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
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ae47ae6b-16b1-f282-38d5-429d813243a8@amd.com>
Date:   Fri, 16 Jul 2021 13:46:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHJOmUOR65QY+YY@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0156.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::11) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SA0PR11CA0156.namprd11.prod.outlook.com (2603:10b6:806:1bb::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Fri, 16 Jul 2021 18:46:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e16e5574-320a-460a-711e-08d9488a0580
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447199B68CB1E10F162B192E5119@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBZkqNnK8IsoKrf5AwdC5fMQfgHNsrwalwXLwChbb2OWoo/UmXeAjpP3huasbVYNMBBOSUuCQeO+fW/hb+qmJY26fr93vRwcSEjk9N2plZdyyrKxM+Zldoy3K83G8ESp9erR/9Z5ImBmVUVxL3pwwS1TpMGPyJ7XSAVfckQvN7Mn6cScHCK/P4U+ZTzquh67XX5LEZ0U47ICS1y6BWxJjVn/qv384R/dZyOHVF4dZL/INqJhsCMxiScHgiYinD7c9DL/78MShUPPxaZVDAt2+iJ9ITQUY232Tm+KDcaDTA/Hl417uU0n91njlOowHPasPaHK9pEt+mQeRlGT+CwSuG5rjZ+y90xFX1LErmMPpTok8ddwdsDcBoX7UMAoDk6i8ysQc87c+HZI42UY2H8E2Wrpj9ZTj+GQTgRF8OTFGxqS8Vb3Z0Ji2GJEJo+w2t6A8gDG3hGC9gtQUg/XGjU/Ez6nchIdCWeFURGJRw/Lq/WzSHpd193XpxRa+bATdNpnWmeJ/gKcG7zPM34BacGz2eZ2vHVg1qskCHu59JIWJSfpKspVyEdXEAqOmMiO0aULmM7b+hoPTNIpTZN75yZYat9E8SegQSGbwoUumKtU1vapAkTFJvEL3pScmiiuu6+2cUZ7d8pKmTBdmB9ZL74hQIizy3A+EmeKNgVZBzFNv+Afy/Pz6twWxOjw7WhRx9llty2iLcAII+MsJHS8xggxxVzNUAkA8YcWZI3vg1pluCINc4cDUJ27hMpE4sDJtF1p/Plyi2xxruhraE7d3evGvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(86362001)(38350700002)(6486002)(53546011)(6506007)(38100700002)(478600001)(2906002)(31686004)(6512007)(186003)(36756003)(26005)(956004)(316002)(7406005)(7416002)(8936002)(66476007)(44832011)(8676002)(54906003)(83380400001)(52116002)(66556008)(4326008)(6916009)(31696002)(5660300002)(66946007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJpbnpQaVBpQWVpOFUyZE01ektCODkwREtEa0k1dHNURkxNMEZadDh6OUNa?=
 =?utf-8?B?aU00YSt0L0VuTkEwUHRaWTQ4L2thSndncWkxeXpMUTNxUzF5Rk45eFJ1azNo?=
 =?utf-8?B?Z1J6Q3ZhbkpFcE5MOFBmcVB0RHl5QXpaNEdXK3k1Y3o5dmxjWUJMemFFa1Bj?=
 =?utf-8?B?SjhLOHFUUHFJVjZnc0ZvR2I5TnBjb1ZSaE9Xckcrd0tPWnI4OCtKSzUrL2lj?=
 =?utf-8?B?U3RDVVpMNEkxNkVnRXIzSEU3V0F6Snptc2V1V2NKNHh5eVhRMlk0emJic0xw?=
 =?utf-8?B?cE9YRDVzOHlPZFhubUFkV0lIN3FFZlZrbnZkQUxMNUZDU0xOcVozZzlMOGFM?=
 =?utf-8?B?RWQ5bFpUMzJaRExUK3NIdTViekRYUnRLb29qdGlKbStMc3FSUlp3MmcwdkNR?=
 =?utf-8?B?SzhXSnlkTDQrMnJNeUs0OWpxQzlja2g0VnNaejVEbFNwaDJzVG5GNFF4RWtr?=
 =?utf-8?B?Rm5UV1didUJBT0FrWjRhRmpSOStrYWg4dmVYU0lhYU1VeU1Dc2toMytWZzNM?=
 =?utf-8?B?WEhyWS83WEpDbGIrMkRXRE43dGZPNllNeHJRSExJU3Q5MlBEMUJHUi9lUXdr?=
 =?utf-8?B?K0p6QXNmeDA5M3BsN1FFam03Qkw5VmpmMGYyNzlpVXEwNndNdi9wc0xQcEw1?=
 =?utf-8?B?ZEJ6VnFka0haVXUzU0Izd3pVSW1RTVk0Mmh6RDhmZFN3VXYzYjB4b0dISGtP?=
 =?utf-8?B?ckJLK3JRR3JFUXh6ZTVhZEdDTzNMRlNhb3NldDFLdXUrTytTenVoQzNuN2RM?=
 =?utf-8?B?UTdIa1MyTXRqNnVJTVcxeVR2eWtGU0hITjMzREJmUC9KV3p3d0tZaXB2MVZS?=
 =?utf-8?B?clBTNHJUYVN3b0c3SE5Obnd5S2VhS0dNNHJuS2VIWEZ2UWtxZWU3M2VnS0c1?=
 =?utf-8?B?bkxNZGVlamhiMjVBNEVvNWVEd2V4S0pHUnlzUGNCS2hvQy9wZW53Y3NGZUNR?=
 =?utf-8?B?b3A5cE1yZ1Z2aUZFNU1DL0ZESlh3SUx1N3dSWTAyMURsS1BlaDV2eWpwVnY4?=
 =?utf-8?B?YThZenl2djlHWWJPdUNQNVFvNkx6Z3NrOS9zZnBQN2t0d1pPa052bk44TTJQ?=
 =?utf-8?B?b25SWkcwTGoyS05RY3pQVnY2ekMxU1hjS3Q5QWt5cGQ1S3Z0Z3lEWjNUeFZT?=
 =?utf-8?B?N29IQ1VSN1ZDUHVyWHE4OVZNeEFCV2hUaWpHV2doOE9ldDN1RUhqWlJ5d3BP?=
 =?utf-8?B?anJiV3FCT1hVQ1FxQ1ZTdWZ4NURhSTFPN0FqSE9SSE51UG55ZWl6RUZDT0Vx?=
 =?utf-8?B?aXJveU5zK24wSEVxMDIyeTRVeVQwRjNIVUZpZnBEeTU5NHhpTkRhRUp2SWpN?=
 =?utf-8?B?L0IyR1U0dDVBNGhGQkxBRjh1blA2OUwzakFlM0hNQzA0OGNHUm44cHBoMzRa?=
 =?utf-8?B?RFJtRk1NUDc2QlZnZkYrSU51Y0JVM20vVjhnK3lYNDI5RVJ0RWdpaEErUS8z?=
 =?utf-8?B?NnRFMzlKekh0RjBaZ2ZpMDE4ekR2SlJWaHZZdjE4R1IxMUxWMmFWcVBSZWd5?=
 =?utf-8?B?ZXc2Z3ZxZktGS2ZycHd6ZmJ0dVFuWHdjK0h6TE5uL2MxNlJMc1RLRWVGdEta?=
 =?utf-8?B?dFFJN01GSG1QSjBxdkFLVE9hQjVVcHpYY1VyeTJSSjgweGZIZFlHVW9yTnlr?=
 =?utf-8?B?ZWZKK0szd2FZMDRZdFpyamRFWmV3MzRuMEdYN2w0VXQ1REtxSWpKNFluN0F1?=
 =?utf-8?B?aFFIWmhrK0NYQ3dJZFNVRy95Tkk2aCs5bU1pVTJnWG5PVHhERGszTW5KREtx?=
 =?utf-8?Q?slfRNPss7y75UfDKDvXMw3zBB60jxtrlHAVXy3J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16e5574-320a-460a-711e-08d9488a0580
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 18:46:28.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BOqA3cbugLum4mYwhB0+4hKd/C3cxAXnNmCJw24PiiFpRu8W3Sh69EvyTcahJZgWzofgJpdWqy0NSBMpoxUqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 1:00 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 411ed72f63af..abca2b9dee83 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -52,9 +52,14 @@ module_param_named(sev, sev_enabled, bool, 0444);
>>  /* enable/disable SEV-ES support */
>>  static bool sev_es_enabled = true;
>>  module_param_named(sev_es, sev_es_enabled, bool, 0444);
>> +
>> +/* enable/disable SEV-SNP support */
>> +static bool sev_snp_enabled = true;
> Is it safe to incrementally introduce SNP support?  Or should the module param
> be hidden until all support is in place?  E.g. what will happen when KVM allows
> userspace to create SNP guests but doesn't yet have the RMP management added?

The SNP support depends on the RMP management. At least the patch
ordering in this series adds the RMP management first then updates
drivers to use the RMP specific APIs. If RMP is not initialized due to
someone not picking the commits in the order, then SNP guest creation
will fail. This is mainly because the first thing a guest creation does
is to call the SNP_INIT. The SNP_INIT firmware command verifies that RMP
is initialized before creating the guest context etc..


>> +module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
>>  #else
>>  #define sev_enabled false
>>  #define sev_es_enabled false
>> +#define sev_snp_enabled  false
>>  #endif /* CONFIG_KVM_AMD_SEV */
>>  
>>  #define AP_RESET_HOLD_NONE		0
>> @@ -1825,6 +1830,7 @@ void __init sev_hardware_setup(void)
>>  {
>>  #ifdef CONFIG_KVM_AMD_SEV
>>  	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
>> +	bool sev_snp_supported = false;
>>  	bool sev_es_supported = false;
>>  	bool sev_supported = false;
>>  
>> @@ -1888,9 +1894,21 @@ void __init sev_hardware_setup(void)
>>  	pr_info("SEV-ES supported: %u ASIDs\n", sev_es_asid_count);
>>  	sev_es_supported = true;
>>  
>> +	/* SEV-SNP support requested? */
>> +	if (!sev_snp_enabled)
>> +		goto out;
>> +
>> +	/* Is SEV-SNP enabled? */
>> +	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> Random question, why use cpu_feature_enabled?  Did something change in cpufeatures
> that prevents using boot_cpu_has() here?


During the boot the kernel initialize the RMP table. If RMP table
initialization fail, then X86_FEATURE_SEV_SNP is cleared. In that case,
the cpu_feature_enabled() should return false. The idea is,
cpu_feature_enabled() will be set only when the RMP table is
successfully initialized and SYSCFG.SNP is set.


>> +		goto out;
>> +
>> +	pr_info("SEV-SNP supported: %u ASIDs\n", min_sev_asid - 1);
> Use sev_es_asid_count instead of manually recomputing the same; the latter
> obfuscates the fact that ES and SNP share the same ASID pool.
>
> Even better would be to report ES+SNP together, otherwise the user could easily
> interpret ES and SNP having separate ASID pools.  And IMO the gotos for SNP are
> overkill, e.g.
>
> 	sev_es_supported = true;
> 	sev_snp_supported = sev_snp_enabled &&
> 			    cpu_feature_enabled(X86_FEATURE_SEV_SNP);
>
> 	pr_info("SEV-ES %ssupported: %u ASIDs\n",
> 		sev_snp_supported ? "and SEV-SNP " : "", sev_es_asid_count);
>
Noted.


>> +	sev_snp_supported = true;
>> +
>>  out:
>>  	sev_enabled = sev_supported;
>>  	sev_es_enabled = sev_es_supported;
>> +	sev_snp_enabled = sev_snp_supported;
>>  #endif
>>  }
>>  
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index 1175edb02d33..b9ea99f8579e 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -58,6 +58,7 @@ enum {
>>  struct kvm_sev_info {
>>  	bool active;		/* SEV enabled guest */
>>  	bool es_active;		/* SEV-ES enabled guest */
>> +	bool snp_active;	/* SEV-SNP enabled guest */
>>  	unsigned int asid;	/* ASID used for this guest */
>>  	unsigned int handle;	/* SEV firmware handle */
>>  	int fd;			/* SEV device fd */
>> @@ -232,6 +233,17 @@ static inline bool sev_es_guest(struct kvm *kvm)
>>  #endif
>>  }
>>  
>> +static inline bool sev_snp_guest(struct kvm *kvm)
>> +{
>> +#ifdef CONFIG_KVM_AMD_SEV
>> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>> +
>> +	return sev_es_guest(kvm) && sev->snp_active;
> Can't this be reduced to:
>
> 	return to_kvm_svm(kvm)->sev_info.snp_active;
>
> KVM should never set snp_active without also setting es_active.


The approach here is similar to SEV/ES. IIRC, it was done mainly to
avoid adding dead code when CONFIG_KVM_AMD_SEV is disabled. Most of the
function related to SEV/ES/SNP call the
sev_guest()/sev_es_guest()/sev_snp_guest() on the entry. Instead of
#ifdef all those functions, we can #ifdef sev_snp_guest(); compiler will
see that if() statement will always return false, so it will not include
the remaining body of the function.


>
> Side topic, I think it would also be worthwhile to add to_sev (or maybe to_kvm_sev)
> given the frequency of the "&to_kvm_svm(kvm)->sev_info" pattern.
>
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>>  static inline void vmcb_mark_all_dirty(struct vmcb *vmcb)
>>  {
>>  	vmcb->control.clean = 0;
>> -- 
>> 2.17.1
>>
