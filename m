Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52E048C875
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 17:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiALQdv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 11:33:51 -0500
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:4154
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240971AbiALQdt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Jan 2022 11:33:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRByVMgFKkgmge6Xoly78xnaUPvNaNBawETJ46bZ9SWSRflXtkI+NzjkZPFIFi2lG8PMaK3FXhZWYolxYAPXP6s3faYdpB8sBmuBuWL3pB6eQvFZL9vZVnnU343PsjhMri4f33jbWFemKX99gPDdNDQENXdlNGKUXQy8+2QesLURyDboRpsauOyVbOBHX0arYvMQ9wMeZi/Yxjej60ebgDMopbaIS9OAv7C4UT0L3jzX4J3H3zdlnUyQB86M+HkC6iwjMZbKRhDGbkXa9lAzvLrvISiSAKWLnN+LsVIQy6L4I0K+pdN0Y+GjAonkX5lPXS6QG2vexoqy8wbdLt2Zmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pyeZ4YiEiZ95fc8AZNGQh0hh5rvq2j/1uE8vEnrlWI=;
 b=XU1e6xTEK7LW1skGBlNWlSwZBlGGVQ1MovZRf9VUuHxY5KrLL31xX+3szcCO+6R1NRBtMp5iYEJrrFkEzhCtoqR5sZ1SjDF0Uv24fkP4Ql0J0vw9HUfuFT3py4du0+3jqvtD8VPcuM5XBnSEl73b5+XJ5kRcaLHK84YSJYy95FUuCtRV0m4Gq9DKy4m7pbzG/r9ukERIzX5aLrFC0BYFmvau14UriOXKZESRd8vX0upNlCGDsZW3SjZmYrwLx7qeLPgY725ARkRxmfrf76izF07Y699zVeXV4YcJVCuymr1jbl/JFzQCpHiMOCyiKh9UBqPFYOuLfeRaheaiG9ewhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pyeZ4YiEiZ95fc8AZNGQh0hh5rvq2j/1uE8vEnrlWI=;
 b=unW7IPDmHDu0M4V8imqpejB765Q7n9nzOxEhyePx8pD08KkDTDHOJ/hTLwvr1EHW5zQchs51yDH2kiPu/hPmfLhfYZP8WkV2vRTCK34wVp5MG+qdr+v0LNioPq9qOV7hzEDQsChWjTE0t7pi2EyYh4vcTivaE1Z5EqYKGjgvbEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by BN8PR12MB3443.namprd12.prod.outlook.com (2603:10b6:408:63::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 16:33:45 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4888.011; Wed, 12 Jan 2022
 16:33:45 +0000
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 20/40] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
To:     Borislav Petkov <bp@alien8.de>, Vlastimil Babka <vbabka@suse.cz>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-21-brijesh.singh@amd.com> <Yc8jerEP5CrxfFi4@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <75c0605f-7ed0-abcc-4855-dae5d87d0861@amd.com>
Date:   Wed, 12 Jan 2022 10:33:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <Yc8jerEP5CrxfFi4@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:610:4f::40) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fc1fc4e-771e-4ebf-818f-08d9d5e94d41
X-MS-TrafficTypeDiagnostic: BN8PR12MB3443:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34433492679A7893681C9DD2E5529@BN8PR12MB3443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rX3f/cyAzYyXxPmfVQZq5k9gfMNOTig+RrWPXRtorrtH0VWIsMlPk4HSkFy5kdIDI12bAATOn4Dgyf86uqM+dStPu3NE9+AIk3Yjhx2QHj40XcgLqGm8apnK7DlXfPitB0kWeLfmpfZgaDNmgv4G5zbSIomeI+aEu7vsQXfPPaU4t85dl96BqQGv/0P4mCMj/B7ZxqlnTZaCLj2iE70PNiltIXRn6gsjY0e2XyURNc0dRAsBjjMp9++JAxvY8Tsszucb7gUzZjUDoNFNLy3RW6ApIzRl9tW2tIVZuHdR67zL9fTc067Yiu9JyvLWt9PLSCg68qDSJ1norex88OA+EpHbByVWc8csUqto7CPvscC6K8WsbNYBUvuPfskdufMEDnIm3OgKsc4e9NRfhJC9dfndPSFifsuWV6MfjJu6XiseS3hLl8KonrCLoUA39oBcXcAgvVdCkMUCRQxldxETy+fytfaGX7pNu+w4EUQc7pCZfB/hoDzpXGk4fXLWnAQFsk5SHe9eFPEznTqrvz8RRt0bQxQvqFR/HxsC1hceSuOzGX+e7q04mgy0tjtLflv22c23VLra3NZMgwmJ4lCT8/5GwwT5Jg2uiNiu8MVs7Zsgp/4D4AuEF+5PzpTCLI1ZQb/wERkIfBO1pxrHBOs0m4AYkGHwl6RqoyLCCGmQJsQ9bzJKosx2Q03XnhWX2f77UEp0ZS5ZOsWAp8jek91Pj80f72Djs1xlaYyLVplylPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(316002)(54906003)(66556008)(6666004)(110136005)(8676002)(26005)(2616005)(6486002)(7406005)(53546011)(8936002)(31686004)(83380400001)(86362001)(4326008)(7416002)(6506007)(508600001)(44832011)(38100700002)(31696002)(186003)(5660300002)(6512007)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2hKTEpsaUVUVHd5UEVGMG9tTC9HM1ZDTW1UdmUxQTVPNDBVL2ZmTDBZdVdz?=
 =?utf-8?B?Qk81aVdpTHlWYWxvQzRhUnBFcVZiU3R5R0o1U3dzdlJtbloxcWZsM2FSRXhH?=
 =?utf-8?B?QzJxakRzTzNFcXRVdjRGZ2s0RTdIRStndG1HZVBVOUV5YzlVSWpScmRwTHU4?=
 =?utf-8?B?TENPTW9yRklnZFU4UkJocVVleEdNOGhMN0ptQnB6TkFNU0lOa0FzRUI4dmxl?=
 =?utf-8?B?M2F0enlMQ3ZidGI0MXFtNFE2MTU4b0E2ZFpycVhOeEVzQytLRStpV0pNTk83?=
 =?utf-8?B?dkdYS1o3aHBqQVZmN09jN3RsSUd3OEphR25ERS9YeW5VSUV1bmtFelpNY084?=
 =?utf-8?B?dGNiRVVPbUZwamhtclFRcnIxRXJOejZ3bnQ5NjhzbGg3M3lYK3U2VkdwcWVG?=
 =?utf-8?B?dit0MGMwV2drSkFCTzIrREYvSCtDL1R5R3ovQzV0dlRKdW1Eb1Irb3luQVNr?=
 =?utf-8?B?L1dPSTR0LzZWNGRMSkVTQVdOTVUrTmhUYTVrVlJ4cDRxSHZlb1pWWmNJMkk2?=
 =?utf-8?B?SUhWYlFDY051Z3NiRjhSb1ArU01xZDU4WGdxVGU4OVUvYWkxeWdCbGFCS2Rx?=
 =?utf-8?B?SWhJN09Pd1o5K1JXbDZqemgvZVY4TjExZ2RQNWhDRkVyRDZRUHBjQnRYZFpS?=
 =?utf-8?B?SkJlbVlBYWlLd0F2WndxR05zK1ZLcXdtM0dIRW1BNS9LcVhYdWdGNFdwei9R?=
 =?utf-8?B?VzZEdmhZem93emFkYTF2Nm04QU9PTHRLdm1zaDZVMThnRDM3anpWd2tRYVhD?=
 =?utf-8?B?QVorT2lxbWdXSlNvSnUxUXNNd2VLUDhBU1prQmhkUUdGRGhPSjRSK1A5Q1Vt?=
 =?utf-8?B?NjA1NXJnNWJWN0w2dFhkSm9aZmdRd2ZvWWp0UnBPSmhlNlpEVjVTZ2J1cS8w?=
 =?utf-8?B?Ym8vV1FJakpkRDYrL29ITDVTdXVCK1dkY0xibFB5NFB6K0tibFg0M0tMUW9M?=
 =?utf-8?B?cmlVY0IyNjBHbDltOU1ZUXVrTjNTME9YWk5LZGs1eWcrQUt4T0d3RlhnSVNl?=
 =?utf-8?B?elpZejdtMGp1Yk5za1g3QllJSTRmRkNZVzhqeHZqUkplQmFoaktPL1pCaU5x?=
 =?utf-8?B?UmdnclpLcnRkTDE0S3FsWm8zcjBVYkZqV3NRaUl6QTZGTjJ3cDIycjlzRVcv?=
 =?utf-8?B?UmtyZWhLdndyRHVsYWd4L2UvOXc2emxuTkpZajVXUlZ0MTdlWFIyNWtCYnd4?=
 =?utf-8?B?WGsxTzhnRXZQYTJ0YktaMWtxUis2Q0kzMUpXUGFCMEpxZXowcDRMdlNKeTFn?=
 =?utf-8?B?VnEyWCtlRkNwNEIyY0tFWTJHeVc4QXVESjR2dWpOdkQwb3B5RHZmdnFSYXBu?=
 =?utf-8?B?NDdMalJpamJPeW5Mc3JNb2VrcFA4c2dVdElRaE53Z3hNRnlKWTVWeVRXMEg3?=
 =?utf-8?B?K0ZLTU40czg5cGpuaFFkaU5aZitaME4rcll0SWVvQ3I1Kyt6aFp2LzRZNzV2?=
 =?utf-8?B?Ti9xUmNmRGZ2YnVZcytnZDFSNkljL0pwU2VpOExPNFIySWUwNit5blc5TzFL?=
 =?utf-8?B?NVNqdnRJSFl4RmNUZmJLVGdGMDgxUFY5UkYxZEU5TGZiYktZdFBOTEdFZkw0?=
 =?utf-8?B?TzVBd1M3dkRMS0VEcndxVU04aktFOGVXUVJVYllkVnNuenVxS0cxL2doa09z?=
 =?utf-8?B?RFdMTzlXTk9VU2VoQVVCbmdnaHVNMTVpeWZmRVZWOVhza2FXeGovQUliM2dP?=
 =?utf-8?B?SFlWc3R1alBPSjh4VUxRNGNIMU5TdzVDVWVkTWtJeW9Ja0I2UHdYd1lUdDB5?=
 =?utf-8?B?a3o4NHFOd0NlUklVc3p5MW9rK0crTEIzeXFwcnNyU2ZVbk5nbmJhTDJoNUQv?=
 =?utf-8?B?eFNRQk91YnN2VjMvVmFqY1FpbnNaZnpLRnVXSzNBNVhLbGRsTnlTQ01iZUhr?=
 =?utf-8?B?NWF4QmhodTl4QlNTN1BONU9VYkRXVTNBMEN1ZmFLaVhjaEs1Vy9VMUNNYW4x?=
 =?utf-8?B?dXlYYTBUdnRHK2pZcHZiN3RSMkllUnBGK1ZpaS80NHM4MVgrTk9ISTdpSXk2?=
 =?utf-8?B?MTNQN2huSzgzTFBUcVZQNC9WcEdySDRsTVRHR29mZlg1T2hCNTduMjdCcmhU?=
 =?utf-8?B?NW5VNC9USVJLUXNKTDFhZDNHN0hTZ0dBN3ljUDQzMk1VSHU3RDhNdVpENUVp?=
 =?utf-8?B?ZzVOYlJMV3BhOVNGaUpkbE15ckpGZTh2bGlHNTlibkswOG1YODJHaVNVNjF4?=
 =?utf-8?Q?VSiIel6O6ga18rb6gWoaJ4Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc1fc4e-771e-4ebf-818f-08d9d5e94d41
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 16:33:45.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daTpiHSmBYIPeHskkbcSz1RZvoXA7RrIKWKqGeKY7t/InkEs72rRlNoFHJVSr3OHNYXFAF/VE1qJIWJ1MDsjsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3443
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/31/21 9:36 AM, Borislav Petkov wrote:
> On Fri, Dec 10, 2021 at 09:43:12AM -0600, Brijesh Singh wrote:
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index 123a96f7dff2..38c14601ae4a 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -104,6 +104,7 @@ enum psc_op {
>>   	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
>>   
>>   #define GHCB_HV_FT_SNP			BIT_ULL(0)
>> +#define GHCB_HV_FT_SNP_AP_CREATION	(BIT_ULL(1) | GHCB_HV_FT_SNP)
> 
> Why is bit 0 ORed in? Because it "Requires SEV-SNP Feature."?
> 

Yes, the SEV-SNP feature is required. Anyway, I will improve a check. We 
will reach to AP creation only after SEV-SNP feature is checked, so, in 
AP creation routine we just need to check for the AP_CREATION specific 
feature flag; I will add comment about it.

> You can still enforce that requirement in the test though.
> 
> Or all those SEV features should not be bits but masks -
> GHCB_HV_FT_SNP_AP_CREATION_MASK for example, seeing how the others
> require the previous bits to be set too.
> 

> ...
> 
>>   static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>>   DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
>>   
>> +static DEFINE_PER_CPU(struct sev_es_save_area *, snp_vmsa);
> 
> This is what I mean: the struct is called "sev_es... " but the variable
> "snp_...". I.e., it is all sev_<something>.
> 

Sure, I define the variable as sev_vmsa.

>> +
>>   static __always_inline bool on_vc_stack(struct pt_regs *regs)
>>   {
>>   	unsigned long sp = regs->sp;
>> @@ -814,6 +818,231 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
>>   	pvalidate_pages(vaddr, npages, 1);
>>   }
>>   
>> +static int snp_set_vmsa(void *va, bool vmsa)
>> +{
>> +	u64 attrs;
>> +
>> +	/*
>> +	 * The RMPADJUST instruction is used to set or clear the VMSA bit for
>> +	 * a page. A change to the VMSA bit is only performed when running
>> +	 * at VMPL0 and is ignored at other VMPL levels. If too low of a target
> 
> What does "too low" mean here exactly?
> 

I believe its saying that target VMPL is lesser than the current VMPL 
level. Now that we have VMPL0 check enforced in the beginning so will 
work on improving comment.

> The kernel is not at VMPL0 but the specified level is lower? Weird...
> 
>> +	 * VMPL level is specified, the instruction can succeed without changing
>> +	 * the VMSA bit should the kernel not be in VMPL0. Using a target VMPL
>> +	 * level of 1 will return a FAIL_PERMISSION error if the kernel is not
>> +	 * at VMPL0, thus ensuring that the VMSA bit has been properly set when
>> +	 * no error is returned.
> 
> We do check whether we run at VMPL0 earlier when starting the guest -
> see enforce_vmpl0().
> 
> I don't think you need any of that additional verification here - just
> assume you are at VMPL0.
> 

Yep.

>> +	 */
>> +	attrs = 1;
>> +	if (vmsa)
>> +		attrs |= RMPADJUST_VMSA_PAGE_BIT;
>> +
>> +	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
>> +}
>> +
>> +#define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
>> +#define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
>> +#define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
>> +
>> +#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
>> +#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
>> +
>> +static void *snp_safe_alloc_page(void)
> 
> safe?
> 
> And you don't need to say "safe" - snp_alloc_vmsa_page() is perfectly fine.
> 

noted.

...

>> +
>> +	/*
>> +	 * A new VMSA is created each time because there is no guarantee that
>> +	 * the current VMSA is the kernels or that the vCPU is not running. If
> 
> kernel's.
> 
> And if it is not the kernel's, whose it is?

It could be hypervisor's VMSA.

> 
>> +	 * an attempt was done to use the current VMSA with a running vCPU, a
>> +	 * #VMEXIT of that vCPU would wipe out all of the settings being done
>> +	 * here.
> 
> I don't understand - this is waking up a CPU, how can it ever be a
> running vCPU which is using the current VMSA?!
> 
> There is per_cpu(snp_vmsa, cpu), who else can be using that one currently?
> 

Maybe Tom can expand it bit more?

...

>> +
>> +	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
>> +	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
>> +		pr_alert("SNP AP Creation error\n");
> 
> alert?

I see that smboot.c is using the pr_err() when failing to wakeup CPU; 
will switch to pr_err(), let me know if you don't agree with it.


thx
