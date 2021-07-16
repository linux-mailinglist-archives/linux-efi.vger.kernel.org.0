Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402063CB790
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbhGPM6m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 08:58:42 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:44195
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232804AbhGPM6l (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 08:58:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYKJLsyno1dde62rtvq4SWMS6SLshjx/8xlHMzR3ELJyytvLja2OZ1gAPOFA8tz07UR6Xgf3bLCf2/Kp2vlqlabZ+9m6k1hp7H56bBNY6LmbEcnhPFD2WKDHSp//tj1NRd+do3IdtyUTVdsWdnu+dWURHThVRId/9z15Q6W8uKTm4F7tG/c2MrbXQTpK7EaYZ77qslv/ubiARpyTmf7Bb+CS2WhTBZBdO0GdP/8EscjHyWCvn/Q3+XD+OY0zSPHj5mFfyGdSLvieOxkZ1K26szYsMvncAmNwl2zcpJh9Xy3e3as/+Kn8Fq7O//hkPmzX4UZ9GRuy/oZrFnleZxycMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BG+Lxu0G0wP2C2Vz1nthm/cvWAv6jOnqOX5czl/i1o=;
 b=h9sFcTKungtRvsn1x3pWjIABFBJ0TWLEi13rpDR33bx4OpaF59Y2gWQ2XoO58D6EaUXdpo3iXHPOMs2OyBYVBJYm0nPlty7muNT65nlu1pxByvC7dH//N1i3/h9t9j0afvgd12uhraA61NVnD9vW1xV9FWk2+U9MFktFnAtj7QNFI0LndD+6KXWMsVyPEaIkPKkQ/IgM6ZIoEN/2LIxWgos7tOPU3jBj+dHQf0OML9zcCbkXyuME4vZBELaOSxC46asR3W0hkOlcGdvuRNf2fPqeHU/yPitRlGAeTx0Sad0CHpS1I+LdL5uB5TYO1kXMYqNUtTM6tdEPIL02Tx99Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BG+Lxu0G0wP2C2Vz1nthm/cvWAv6jOnqOX5czl/i1o=;
 b=Sf0vLpF18/sUvmhjraKCqGOy+WH/aUgGMMfv+HFyi/fuakEfrZl/GpneZ+APQq6MEl0B7PZmBMS749hug5Z3cGL+RgDoPR8ai7BRif//gNFl/urkUVtVRBddKTWm0s1qzXIWeBSSNJ2CSjaf6THr+BdixhRPMueR4Oa5leG3d8Q=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 12:55:43 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 12:55:43 +0000
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
Subject: Re: [PATCH Part2 RFC v4 15/40] crypto: ccp: Handle the legacy TMR
 allocation when SNP is enabled
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-16-brijesh.singh@amd.com> <YPDJQ0uumar8j22y@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <dfa4ccb5-f85e-6294-6a80-9e4aa6d93c1e@amd.com>
Date:   Fri, 16 Jul 2021 07:55:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YPDJQ0uumar8j22y@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0801CA0020.namprd08.prod.outlook.com
 (2603:10b6:803:29::30) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0801CA0020.namprd08.prod.outlook.com (2603:10b6:803:29::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 12:55:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b117778-c9c1-4c2d-3656-08d948590584
X-MS-TrafficTypeDiagnostic: SN6PR12MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2640DF66D426B46D0BE34D57E5119@SN6PR12MB2640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aR+b1BdDbiYARNZyZXmdjdrN5p/DD2dMGw+con4y5Y2FZ1CIGaZl0L34B6P5u2QNKav/y8AdONWLLC3anJSaBJ/LcSXsLb3i9H/pyJk7pj3F3w3hSt15h1nibdBzTpVlNLQ8zS6nE+tNJNSz7IT01t4VxTvnSmnYGtOMizy9L7QszusAS7ohG3RepouMQA8n/CIOsudFRZEiPn5xnj8+Mf39UfuBsveaPs6gJG/bJgJmDjB9zlDLKx+NY08bztOsexRVemNLdybXoMcN6tRSubxGLAUQVMIiFcmFaMT09vg569nWJbTfvQiAtc1+YDTD1fesCK3DUgkGzkKpJJysDCMBWYMt6YSOUotEnooqjUBGtK9en5WvDM+oRbqjlrP0gcUfgimN4Jp3wfo6/t3A0k18ZrYVNaZejEBXWvLl1ekY4Nd1oKvl85NhasgMmu/trjiL6OBlIF7OoUGUG6jJOrEdEWz5HTGhtCF13QsXj1r07pJzG0WvDlo/GpDkfW1/23Qvf90VmGY9nKClKGXi0m/37SMNfT+K160NqC2Odmcao3mvlkQLwwxCaxEQnNXuOzQYGxbnWK01aqMKnUGSgNPI4kO9S1VXV76W8A5/wzbmpp2WOCw+z8nrzczIcBYVgEYwuaO+5Fy8PBMhAzmYih4rT7oL9eQVzjCET7o1bznDAQALsM6k4ebKHlPyPOFSRD+PHd9cUY4PIjegi2duN9xmiZdbhZDnEBkkPEUec83c4JsAO0E/dz04NpFWnG31vMf3JwvuVYlo//8wXh72Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(6486002)(6506007)(53546011)(66946007)(38350700002)(8676002)(66476007)(66556008)(52116002)(38100700002)(478600001)(36756003)(31686004)(956004)(4326008)(6916009)(86362001)(54906003)(2616005)(186003)(44832011)(83380400001)(8936002)(6512007)(2906002)(7406005)(7416002)(5660300002)(316002)(26005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjluak84cmkvaFB4Zm1URTVMWHdsdU5vSmlvL01lRDZlcGhFdlVFVy9IVzk1?=
 =?utf-8?B?dHMzeDZTRUdnaU9zbVZVVGRnRkFZOXc5cHd6Tk5GZTZTazdPWE1EQ1Q1Yitp?=
 =?utf-8?B?enRnVEw4bFNiMUU4MFhPV1ovbnZjdUc5ZzR2NUU4d2hVWjFJWkIveVZGSEVs?=
 =?utf-8?B?M1BodTZ4UDZEZmNFQWxWTVhPYVlQVGtibWw2OFNFU0tXVFFZN0swM0tWWFhO?=
 =?utf-8?B?TWZkZlp0dG1QazNyeS9hWGhNS0lLSUlhcXI2cUNLUXpJa2hndDA0MzBFNzRW?=
 =?utf-8?B?N2N6MGpLQXV0OFgrc2lPN0txNmVXN2dPbVBWQ1h3NzMzb2V2cWVSeGhRQ2dZ?=
 =?utf-8?B?NTZtaGdVZ2ZpcnVlU3pnMCtDaDNqRm1ZN3V5d1doWWhKV2dEQUJwOWNrMDdt?=
 =?utf-8?B?di8wZDRwMFNWd0I5ZnJ2aGtmMnI0cmhTYUlwNlduSS9jTE9wMmZKRDg0NVJT?=
 =?utf-8?B?Q2xPN3p6TmV3a0ZXeFpVODV5dGt1bzZ0Ym5VK1dWUGREazVYbDMzRk00SDVj?=
 =?utf-8?B?eTcyTEt0UTdobUhqNjBSN0MrblRCczJMd1JwSEFiRzVkNEFXcGtyMlRJTUhn?=
 =?utf-8?B?WmsvY1cyTWJSMDhMZXJxa0F3WlRGWlhoR3FocUpqNm9Sd1FoTDFxSTZPK0w3?=
 =?utf-8?B?eVYyZ212UGxhTmMrTEsvYWF4VU9aYUhVQXRBUTBHM011MFhvWGlPQ1BWZnZl?=
 =?utf-8?B?Rm10M2p2TWZ5RENBdFZQUDh3M2E2ZkdvbTlPZ1ZnOWNlM2tHQkRWWTVhMWFM?=
 =?utf-8?B?YkVJS2xnSGYxTldUaE9mdnVzQVo3TEllOUpLQjR4Y2M5WldaUks2aGZEcnVz?=
 =?utf-8?B?Ri96QjJMM3pIa2M4aEdKQXcxVGF3TlhzOE5mVmo4QlZTQVBhMVhUeEdodFRN?=
 =?utf-8?B?S3FQUkxHZGh4Ynh0WDh3aUxML3lIMEdCa3hhV0pxMEpBQUtUQzBsMkhMQUpX?=
 =?utf-8?B?NitiazY4T2xLN1poQ3UxVk9rM1RRait2SHFoTm9GYmdINE1JOGsxeFQ1Qk00?=
 =?utf-8?B?UENKRm5mT0xZTzArL0daVjd5aWduYm5UM1J4SmhoWjhFazlCVGdPcUtUeWIx?=
 =?utf-8?B?VDZldGNOOGtZcWs0eTVIc3FpUDQ4ck5CUEVyeDRvRjY5SkhNMXF0OHRjc3RC?=
 =?utf-8?B?YXdyMjE2TmVjaUZCUUxFbmFFcURGUGhpdWJHQjhIbGxldEZPV2hXcXplOHZ5?=
 =?utf-8?B?VkZVOS9zV1FyanlMMUdqb3hPbXhndXBWRHJkSncyTUoybkd6TEMzeCtmdWVv?=
 =?utf-8?B?T0tCK1pxY2dLTHZNb0JuV3EvQjVjbHl4ajdlRzJ3QzluaFNpdXlObEJabzlx?=
 =?utf-8?B?SkdmTlZ2SStVN1E5SFovVGI2K0ZWR0FLL2JzWTZNNVByRVVpZHhISnVpcnhq?=
 =?utf-8?B?alUvMzV2eGw0UWV2eVR2T3Vma04rUUxDRUN2ams5Mzc3VFlCbEFZUmU5dWs2?=
 =?utf-8?B?N2pUU3lrMHdxeVBLNGRiNE1ZTGZWeFhrZ1JaSEJEOUFjcDI2RmdzZ21hZkFF?=
 =?utf-8?B?YkxvT3FxYUZzTnN4dEFleDVRdXZZSHBvRk80aTdSQnFhWWRRZWJGdC9Ea1Jz?=
 =?utf-8?B?ZUtZZUNubXdCL1lrNHVQTEZ5QnZCY2lNUWlpbU91L3FDcHBpNkJYcEJ1K1VX?=
 =?utf-8?B?cHBtMTFaanAyT0pVNDkzZ1RvdnhNMno3ZEk2N1BqcVpOVDNmdnJDYktJWjZy?=
 =?utf-8?B?b3pGSEhWd1VNeDcwNjR4N3krbEY0bUFzcm1nUk01dWIybVVSK1NZMjZ2TVlU?=
 =?utf-8?Q?B6/UbNWW0vDrCw7J4WkJ0ZLoFGZKkZl+Gncncqs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b117778-c9c1-4c2d-3656-08d948590584
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 12:55:43.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcnMAHVtBM4EP7CmHMf11NHrg78ad6I604+QgPQfiaKclwGpcE4WLx0NsiMIj4OvsO34AnmNY8takHzdMvQOtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/15/21 6:48 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> The behavior and requirement for the SEV-legacy command is altered when
>> the SNP firmware is in the INIT state. See SEV-SNP firmware specification
>> for more details.
>>
>> When SNP is INIT state, all the SEV-legacy commands that cause the
>> firmware to write memory must be in the firmware state. The TMR memory
> It'd be helpful to spell out Trusted Memory Region, I hadn't seen that
> term before and for some reason my brain immediately thought "xAPIC register!".

Noted.


>
>> is allocated by the host but updated by the firmware, so, it must be
>> in the firmware state.  Additionally, the TMR memory must be a 2MB aligned
>> instead of the 1MB, and the TMR length need to be 2MB instead of 1MB.
>> The helper __snp_{alloc,free}_firmware_pages() can be used for allocating
>> and freeing the memory used by the firmware.
> None of this actually states what the patch does, e.g. it's not clear whether
> all allocations are being converted to 2mb or just the SNP.  Looks like it's
> just SNP.  Something like this?
>
>   Allocate the Trusted Memory Region (TMR) as a 2mb sized/aligned region when
>   SNP is enabled to satisfy new requirements for SNP.  Continue allocating a
>   1mb region for !SNP configuration.
>
Only the TMR allocation is converted to use the 2mb when SNP is enabled.


>> While at it, provide API that can be used by others to allocate a page
>> that can be used by the firmware. The immediate user for this API will
>> be the KVM driver. The KVM driver to need to allocate a firmware context
>> page during the guest creation. The context page need to be updated
>> by the firmware. See the SEV-SNP specification for further details.
> ...
>
>> @@ -1153,8 +1269,10 @@ static void sev_firmware_shutdown(struct sev_device *sev)
>>  		/* The TMR area was encrypted, flush it from the cache */
>>  		wbinvd_on_all_cpus();
>>  
>> -		free_pages((unsigned long)sev_es_tmr,
>> -			   get_order(SEV_ES_TMR_SIZE));
>> +
>> +		__snp_free_firmware_pages(virt_to_page(sev_es_tmr),
>> +					  get_order(sev_es_tmr_size),
>> +					  false);
>>  		sev_es_tmr = NULL;
>>  	}
>>  
>> @@ -1204,16 +1322,6 @@ void sev_pci_init(void)
>>  	    sev_update_firmware(sev->dev) == 0)
>>  		sev_get_api_version();
>>  
>> -	/* Obtain the TMR memory area for SEV-ES use */
>> -	tmr_page = alloc_pages(GFP_KERNEL, get_order(SEV_ES_TMR_SIZE));
>> -	if (tmr_page) {
>> -		sev_es_tmr = page_address(tmr_page);
>> -	} else {
>> -		sev_es_tmr = NULL;
>> -		dev_warn(sev->dev,
>> -			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
>> -	}
>> -
>>  	/*
>>  	 * If boot CPU supports the SNP, then first attempt to initialize
>>  	 * the SNP firmware.
>> @@ -1229,6 +1337,16 @@ void sev_pci_init(void)
>>  		}
>>  	}
>>  
>> +	/* Obtain the TMR memory area for SEV-ES use */
>> +	tmr_page = __snp_alloc_firmware_pages(GFP_KERNEL, get_order(sev_es_tmr_size), false);
>> +	if (tmr_page) {
>> +		sev_es_tmr = page_address(tmr_page);
>> +	} else {
>> +		sev_es_tmr = NULL;
>> +		dev_warn(sev->dev,
>> +			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
>> +	}
> I think your patch ordering got a bit wonky.  AFAICT, the chunk that added
> sev_snp_init() and friends in the previous patch 14 should have landed above
> the TMR allocation, i.e. the code movement here should be unnecessary.

I was debating about it whether to include all the SNP supports in one
patch or divide it up. If I had included all legacy support new
requirement in the same patch which adds the SNP then it will be a big
patch. I had feeling that others may ask me to split it. So my approach is:

* In the first patch adds SNP support only

* Improve the legacy SEV/ES for the requirement when SNP is enabled.
Once SNP is enabled,  there are two new requirement for the legacy
SEV/ES guests

  1) TMR must be 2mb

  2) The buffer given to the firmware for the write must be in the
firmware state.

I also divided both of the new requirement in separate patches so that
its easy to review.


>
>>  	/* Initialize the platform */
>>  	rc = sev_platform_init(&error);
>>  	if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {
> ...
>
>> @@ -961,6 +965,13 @@ static inline int snp_guest_dbg_decrypt(struct sev_data_snp_dbg *data, int *erro
>>  	return -ENODEV;
>>  }
>>  
>> +static inline void *snp_alloc_firmware_page(gfp_t mask)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline void snp_free_firmware_page(void *addr) { }
> Hmm, I think we should probably bite the bullet and #ifdef and/or stub out large
> swaths of svm/sev.c before adding SNP support.  sev.c is getting quite massive,
> and we're accumulating more and more stubs outside of KVM because its SEV code
> is compiled unconditionally.
