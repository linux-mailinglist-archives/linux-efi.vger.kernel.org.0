Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C3F3EB6A1
	for <lists+linux-efi@lfdr.de>; Fri, 13 Aug 2021 16:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhHMOVq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Aug 2021 10:21:46 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:26176
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233567AbhHMOVp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 13 Aug 2021 10:21:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne19XzovXIUurJCUI7TYwxSZSTISSCikfAKmPccSEskYI8U0yQXr9vlXPmbILbguqjmSzaPlxnSuyMlsSZv4wGApakhk5DHL93uqMeXErUy8DOMzQ75lErRtf/Dr+mW1J5Z7fvfria6vq2yfcQW5mg114b6gVYNmLVe61pcz9Sv6OgZAkfQkmvEv9OOrzJthqsAPL3KRYrlMEneHnCvbks0X5PowbVMYbDAgX5Wv+k73mTzfEZdfE9WPzb4ijm191hG39TLkVgiTziLAKdINL9WjZEZWK1kZn7hgFymUy2frek7b4jfsIyfYj9gE3Rl379qgREDMg0IUZ3v71l2KiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzOEbGD1NjT7zx8CjUUzUaHGs4jadV56i48/BH3yj9Q=;
 b=Ykcj4DF07mWTh4c7r70+Z6p9a7oiAmi92Vn9CjHYKY20dPI+Mgp/91Ib/eWtd4p+w88izqsmDJ+EWmg7ThEwgErGeFer2kzX3JcH3uDWMiNL5WYq6VZmZQ3bzeAN+pcRTBXJNnOetx8SoqjJChImVNIMQyeXDWtregfmz84+Ii0rsY2l7yC71TbMHZneHLwUToq+w9k0lAWWpMleSnJs7LeiLjaxTkeTqgeinew0bMd4PNiLaE2bZpAeo4HogjfAJGGST2BeE2lL3P8pyQlnxlT9d1bxrnLkLjh3QiPHQnQJ6j0rc0+xsz+gDnN+LbbrpkMMhTxsm4HxKWxbdQ0Zkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzOEbGD1NjT7zx8CjUUzUaHGs4jadV56i48/BH3yj9Q=;
 b=X/DpPj2qKwoodKy+BbpDc5m7DwB4Tk+SwVo6UJmnq/Pk7I94eIKK78EXXr8dXFSr/XUItMcmvrYPpiIPYzvF2Um4e4PQZsCZNFgep6AwJZbqWgGROEyCBhpOjLZytXgNnundEsil8fySoycjAtNP5T6UZ6P5Rn5J5wjGEYZOWBI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 14:21:16 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 14:21:16 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 09/36] x86/compressed: Add helper for
 validating pages in the decompression stage
To:     Borislav Petkov <bp@alien8.de>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-10-brijesh.singh@amd.com> <YRZIA+qQ7EpO0zxC@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c519e685-5447-1847-2c97-99c5fcbbaa15@amd.com>
Date:   Fri, 13 Aug 2021 09:21:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRZIA+qQ7EpO0zxC@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:806:21::31) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA9PR13CA0026.namprd13.prod.outlook.com (2603:10b6:806:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Fri, 13 Aug 2021 14:21:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abaf655d-65a4-4d7a-5a68-08d95e659c76
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4431E6D1A8EC8E963CF2356CE5FA9@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ea6oVCmQ3ph4c3t/GfddKikoC24q8pRQDAOrAC7XElp5vcOPUSsJETtt0MMQNAS/IPZe7tyQ2zJZSk3iM6FIK6ye/V8cLDc9Q0gp/2c7OPET34GyrN0jVfV6CvEDt8KFYil9O/D1iDfIU4AzGcvbcmxxnSh6lGvoLtTmQPiwfLnGENSWiyeNTtHyyOH0NEHH7RmrZ2tq3Xw5KW4mUQqGylLDcIVAgWSEpjBCxrV4CjjGyhphA/XraqLvAWqovrHk8e8ludtYdwgGIHOZiOyxBbUXHbz20NEefb+5D4O9wziMpY+9xccRqm1z1zhBFhuvfuEwaUKG3Vo9g4AobI3boLIdwXciUhycMB4lb4AmNAt0Ukikn3YjhamCYerDIi0NYm7axFfwGlmtZLNPpKnvzpPcfRrqiWDFTCJKYIXCzAJbdZngwUSgb5BYyb5j2Uyqgjq3ZMTBY+LfBWu0Gu5RmdDv14uSAhKbG1pHUDLoC4V87CcoS24H5tuPKDJldNIW+zSQ/6LyoroStBh0zPknZjpi5FxZerQyc2sMkuCJ3Z1pS+sEz6SwSc2FOnP6NG/qrSN0bJ0UC5tNEGV3Mv/zlQhGcSQRklEZpjRL3PJkm0M1zJy8rGK5ltctQISvKnokAK0l1jQYxpwbEM1+ljY/xEv9m2+Razm5tlkgUUxejzePK6+llr5Url6twF0ywbxwI52Tln3372ft3+oRqUpBIhMxVRSS2xhEx/zzFCJxA8VrSGYee0rnVr2eZpdTYWTxECDEtHQscFOKwCNdouWewg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(2616005)(956004)(2906002)(478600001)(52116002)(53546011)(86362001)(7416002)(7406005)(316002)(6916009)(16576012)(5660300002)(54906003)(44832011)(4326008)(36756003)(31686004)(31696002)(66946007)(66556008)(26005)(66476007)(6486002)(38100700002)(8936002)(186003)(38350700002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5QTi9nbGp0RmhVTWExL1ZqM2svN2I2SjBTVFJjQ05YdmdreHJjSHZBMzlM?=
 =?utf-8?B?TnpJS2ZCaEdBOENhcFFmUkhDbTc0eUJvQnJsTm9OSEl2d0d3L1dyMCtDQ0dZ?=
 =?utf-8?B?blNzUWFlU0U3b0RPU1ZYald2ZUN3aUFjbWoyWDZDQ0RJS0J5Tk9KQ3lhRitt?=
 =?utf-8?B?dlRIcmRPRnZGZm9vSERmY1k1dTdQZWlpTjRHVnVyNmRSa1ZFNzdXeS9yNUtU?=
 =?utf-8?B?emdmakNFb3duU0ZyM1pLTHlORmpqMGpaNUhCTjVWVXpjMTRzM0xxeWJSbDJ3?=
 =?utf-8?B?ZVVTMDhSQXY5VEVpa1hGK2pjYnJ6V3hIclNuZWFIcTVDWkIxN2dEMklHb2F5?=
 =?utf-8?B?R2xadHZUQk9lNmFsbkQwdDJEL0YrK2M5Nmg4THVGU3JPUmVyV2FWVGV0T09p?=
 =?utf-8?B?bVh6MlRlSFk0V3g5c0tCNzZ3QUErQ09SRjMrcVlUcXNIeHptNlU0Tk1BenFr?=
 =?utf-8?B?MUZKdXkxdWxKOXVrUXVickJtM25WVWFVVmZwZGQ1WElyWGRFRjViQjRzOGFH?=
 =?utf-8?B?VVFpQWFSaUtvZFdLY2xQa2FpSmVPNTF5QUhLSmFmVWFXQm0zNHZSUzZhM1R1?=
 =?utf-8?B?d1pybjdrTm1IUHY0d095dnNrY1N1dUFiRytjbDhrbUFnd0gxcjFGVmNhR1VF?=
 =?utf-8?B?RXh0TVU2UHBacVhUVnNieUU2MkF6VzA5d0JwRkFpU3RNdnhwcGkwTFdvVFFy?=
 =?utf-8?B?R2VPQU44TUxUcXMxNUFrUG9iN1VQT1VaNlJORHAxdGNRSTlYU3NkZFdicEYw?=
 =?utf-8?B?RzIrVjBuSVBaOUZGUE9OUENNenZYSHRubUVoZi9ZQWg0SmtndmNnQmc4ZlpE?=
 =?utf-8?B?SEJGUHdhZzRZOWNWOVJCTFVMK1I5MW1iY0YzeDBjQ0FOTnpHU3R2L3hDam5h?=
 =?utf-8?B?ZUo0aFNHQStWREs2cXBKRHFpaktPTmVvRE5INGcrU3pQOFVJUmpMemFQWVhH?=
 =?utf-8?B?TkpHSThlWlJDb1l5bXFXSzBwTXo0dE9MbHhISGRvazY3L1M0ekh5THdiN3Rw?=
 =?utf-8?B?Nk43S1ZzMTJVb1FBNnNqcE45UmZPMGUwdnNkcmhVL1hKMERFbXEydVlKWW9P?=
 =?utf-8?B?cmNXczA5b1NXZ0tBVzZIclJ0WkIxNmdMMXltSlY2ODlsclF2cDhDamIxUDRj?=
 =?utf-8?B?eUVtMksvYjZqbEpBT014a1ArOVVMVkZRUUxrVjBmRUJlbWorRGVhMEEvSVQ3?=
 =?utf-8?B?WjJiZ3JTV0xENm1zTnc2K3NGdTF6UzVTMzZUeVBrTnFIdnZsMlJTUE8xTVVa?=
 =?utf-8?B?V0dpRWVPd1FNaWgwY2dMMUkrdkxNLzI0YjBMZyttSVhjRGh4V1ptRUxRNUdk?=
 =?utf-8?B?QWM1N2pya3pjRkxtaHZMR3hDVHVWYmVJQWNSY1RrMUV4TjVRckpINGJJTlQ4?=
 =?utf-8?B?OXNYMjdjcTJnNjE0NUZtTWFaek42clFheXlsZHJwaVpwdGZIY0VTeXhydEVa?=
 =?utf-8?B?QlIyb3FXMGRmbWZLVTRiem5OaHdwVnQzTUJ5aDFoalVFV0NMSTJiZWF1dHlH?=
 =?utf-8?B?bGVLdFM1cXNvUm9GRE9oa3puZ2N6Y0QrY3VzRU9JN0JhbnFsVFV3Q01jWWZt?=
 =?utf-8?B?S2dhbkhiVTZhOE5uTGFEaE9lZlVuM2ZCV2I0ZWJBekxDOThwM3N1RjVRT3Ir?=
 =?utf-8?B?QlgvdTJ3UWluTUZpMnFMT1psdDM5THZpSHozbGVaMWVTY1dVVU5QZW9NMlUw?=
 =?utf-8?B?SFRBbUJoekVFWXFHUUZIcXc0bjUwT28zQkZuOFlVZHZ5aUxPakVIa0pFd2N2?=
 =?utf-8?Q?IkY/oOT6KBLlZlIPSpka16KgE9E+fVuzXVp20wQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abaf655d-65a4-4d7a-5a68-08d95e659c76
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 14:21:16.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYY1dE0DoghugYyAuk6kJ7qlY0DckWtY3cWtgOgOC2FVEhz0CbNIHvZxakPMnrz1y6jNR2HAUMzwkDSe4RT9Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/13/21 5:22 AM, Borislav Petkov wrote:
>> +static void __page_state_change(unsigned long paddr, int op)
> 
> That op should be:
> 
> enum psc_op {
> 	SNP_PAGE_STATE_SHARED,
> 	SNP_PAGE_STATE_PRIVATE,
> };
> 

Noted.

> and have
> 
> static void __page_state_change(unsigned long paddr, enum psc_op op)
> 
> so that the compiler can check you're at least passing from the correct
> set of defines.
> 
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index ea508835ab33..aee07d1bb138 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -45,6 +45,23 @@
>>   		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
>>   		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
>>   
>> +/* SNP Page State Change */
>> +#define GHCB_MSR_PSC_REQ		0x014
>> +#define SNP_PAGE_STATE_PRIVATE		1
>> +#define SNP_PAGE_STATE_SHARED		2
>> +#define GHCB_MSR_PSC_GFN_POS		12
>> +#define GHCB_MSR_PSC_GFN_MASK		GENMASK_ULL(39, 0)
>> +#define GHCB_MSR_PSC_OP_POS		52
>> +#define GHCB_MSR_PSC_OP_MASK		0xf
>> +#define GHCB_MSR_PSC_REQ_GFN(gfn, op)	\
>> +	(((unsigned long)((op) & GHCB_MSR_PSC_OP_MASK) << GHCB_MSR_PSC_OP_POS) | \
>> +	((unsigned long)((gfn) & GHCB_MSR_PSC_GFN_MASK) << GHCB_MSR_PSC_GFN_POS) | \
>> +	GHCB_MSR_PSC_REQ)
>> +
>> +#define GHCB_MSR_PSC_RESP		0x015
>> +#define GHCB_MSR_PSC_ERROR_POS		32
>> +#define GHCB_MSR_PSC_RESP_VAL(val)	((val) >> GHCB_MSR_PSC_ERROR_POS)
>> +
> 
> Also get rid of eccessive defines...

I am getting conflicting review comments on function naming, comment 
style, macro etc. While addressing the feedback I try to incorporate all 
those comments, lets see how I do in next rev.

thanks
