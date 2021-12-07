Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2DE46C373
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 20:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhLGTYq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 14:24:46 -0500
Received: from mail-mw2nam08on2050.outbound.protection.outlook.com ([40.107.101.50]:43616
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236233AbhLGTYn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Dec 2021 14:24:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz3i/i8jEeq0itNFvJUpGNONF74ByKEpEzF7YoXNopKEoex6WPljpI7NQx5MuoA5GuOSExCuVQXAVsvt86Dk0r25xjJE7aMFWXMDRFD0LIp6++B/5X2FXQYQLswlHX05T2xvhCl30KNSKhEHui5ltKRi6BWcWndiuBQGr80QKmPI7VIaxaijIBsxOHqnQHSFe6FtjNLrkbxh4BGniq5XhASrtPmRc0ml79KvA55/EKU9jFT6tyu/X4EgR0vafz7T4hG8wBmol1KJZitQqYT3OBmRQcUZEErTg4X4wAnpXKSTi97z7YCavyCuGbXInGybgsprSMqBjsdv/Emho5u0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPWNpyfWi1j7tUyupznXmLBzBi8/1RJ1An7Lueu31qc=;
 b=ibacoC1fZTnjieszp/Hweg+qzyqxUXVw+YqLSrJ2r0C6g+IteKslJwEl254xO5DAfQWAtKsXCwG4KmNSnaK0d3+uJHCJqo7YTX4zQA+ehQ/y7PicHQVelc3u56QWik/2TA/mhUAlLfLNQ5Uv32ANi2fBOeCpjainZ8/mUpHbHmiIz6HVLKUYFDu0+97FBw8BMPtknZs4hQTfVpeMBnfrcgXd000+gZytppE4mdxvuPLk4KpIxhju6JtKiSKrzLJdpfP/eyPg6w2YxH0zsjHueVXlBiDSrlhKWL3MD2eW+NxEWQHvqPEyonOvAMOebEQLjh3FSkN5XcU4dCyPP+g6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPWNpyfWi1j7tUyupznXmLBzBi8/1RJ1An7Lueu31qc=;
 b=wVUgIu00TchK9LgFArSkk3YKvXEQOfjGr5Du9zO+2cQ3XrrSS/cpXHQsDWZTKsMT03H2hoZybCpN+z/XBBXT+eZw+N7b3RTEO4XlfbttoyQazvobzFOuvC7WX2vVE4GIv13QPs4+vv+W03H3CWb2qVFPZO4nGIvtuz8zG+ZulEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 19:21:11 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 19:21:11 +0000
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
Subject: Re: [PATCH v7 14/45] x86/compressed: Add helper for validating pages
 in the decompression stage
To:     Borislav Petkov <bp@alien8.de>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-15-brijesh.singh@amd.com> <Ya9J8FSeyv/cEhnb@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <35f9165b-07fa-5b88-52e2-eaee7a090afb@amd.com>
Date:   Tue, 7 Dec 2021 13:21:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <Ya9J8FSeyv/cEhnb@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0134.namprd02.prod.outlook.com
 (2603:10b6:208:35::39) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by BL0PR02CA0134.namprd02.prod.outlook.com (2603:10b6:208:35::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Tue, 7 Dec 2021 19:21:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74c2c296-2ae6-4d13-df63-08d9b9b6ba3b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4509E8B484308C674D6D7176E56E9@SA0PR12MB4509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ac9bLxz1FxFjJCMy8/9Og7gp8w8EhAx+/pJR3EgL/lFV18/tXRgf10pklPUbITNViYgWFAfW9oJDf1HlZdjdeLtzv1bT8krHFgD4k92PHACCMue23Q+pvPr1ai3Tq48VMA0p7Rtbu8xrKFKkPn7FdNdPjiEG3NKPAbx9AGG1y0ud2QINOibmaK1isLUBSYcBQX0aEsUPKaSIMfeSGkpJOctKo2EL7nBo9nfasLfAAFPAuyTHCA9oNxgAxkWEkcBoVzKWT42hTXHWAoDUfn4k+3qfnSRSXte8/JH1KMBXG0wqiZ3oiZwJjwFsKeWvgP9kwImrlLFRm0rR3wV5zz5EScrchgKqS8NLiiGkL999JVrN+p4IMl1ek+8thBvURJnvssoFiHEoyqo88NHVzZcIO7/OE1gfQbHkhuuVTm6y3SBE6oUyyYu0i4tphpTEH471w6QZjBezIhEYSEbAne/ewOp6R1rExN3QLw1ZVvVhYsHRS+R1tTUvj778vJefYx2ym+A5n7CKqhIoxoV6TD1RLgrGqeMK/XxpvEcISnagCaN+nQVJcl3vNeumHB7UjJSaKdiZ5m3jVOddApcTuxd/wj1+CrhwYv/WwdeUXYUbpECrHixJDexQlGdSdhGNxgvti0XMz+ht3dTvipqCvnyrohPk9teNiu7v12SsBCrpMEAvo796FAKHaM2Zec9yYugaR2Wq65DSfGJA+XwwYASOVro/tW8aEfSSKbXtdzJMRa77EJU0NluDSlJai17Jm5s6p2XWPtxatIXMFMsJdXPjofMzRhphn3btHp/j08W4AmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(16576012)(7406005)(6916009)(86362001)(31686004)(26005)(54906003)(5660300002)(508600001)(7416002)(6486002)(38100700002)(956004)(53546011)(44832011)(4326008)(8936002)(31696002)(2906002)(66556008)(8676002)(66946007)(186003)(36756003)(66476007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHhWU0JPNkhzakxseWNoUWpDcDRyV0lRTm9XUXpxTTNPTmY5azVYdVA1ZWY3?=
 =?utf-8?B?T3lmT2dEejJzZk16ZXUrYXk3SDFVVTJLdG84NE9vR0o5amR0MHJMUzM0UHFD?=
 =?utf-8?B?U0cvNE5PVCtwZ25GakQ3cEs3UXU2aWZhdWhJMW8wSmcvcnlWazBOT2xoYjNu?=
 =?utf-8?B?REpVbXJjQkZXK002YVJBWHptejAxWEUvVXhFZ3NVMVJtZHA1MHdGdFI1cHVW?=
 =?utf-8?B?VVNzWXRKSm5Da2N0L3A5b3VRVkc5YVhLdjlwYjV1c2tzTUtoZDhTcVZaaTkv?=
 =?utf-8?B?Tjc3YVdpRUlYRDFqbFZmSlhodkI0R3UrdExrOFZiM2x2b2dVeEo3a3FydkpG?=
 =?utf-8?B?eGY4d3c5SDhPbGxKREtsSDdudjVDOVZ0SUVzMUM3TmFtQ2RmS3NSNTlEZm5X?=
 =?utf-8?B?TVZYbW5ya3kvZEpGWmxCejR3dkIyckFpa1RvZHdqenFjZ2VYU0JSYndxMUJJ?=
 =?utf-8?B?WFVnSlRvcVRuR3dYbzJBUjdua1A1aGR1b0FTM3dERjlXQnNBbGorRk9jUU15?=
 =?utf-8?B?bk5vSCt1MTVsUlovaW1Vb1Y4LzVxdzNnSWJwdkcvY1NNT0lZRlJ4MUN1NEkw?=
 =?utf-8?B?eThRd0NiRG5TTm1xTkJET014am11bVowTW1iRWxhZE41WU82bkpBS0JSaUlZ?=
 =?utf-8?B?MVM1Ykd6cUZKMThSR3Q4dWtuMG85eTU3VHlWc2hiN0VqaVlPRXk1YjZCOEdD?=
 =?utf-8?B?QmhqVXFpWHNsS2t6SXpucmp6YVNVdlNNbkxLTDBhUjZVNzkyNXpJSHU1aHF2?=
 =?utf-8?B?T0hnYlJTSDhtbnNnanJHYlNEcW5FN2pLdjljN3ZOaU5qdENieTZlR1g1MkFW?=
 =?utf-8?B?blVQNXQrV1FmcldUOTZPb0JnZWhJZHl6UnVQaDh6cnpza0FGcFZqS3IvYU42?=
 =?utf-8?B?WkFhcVQ5TFFxU3FXWjFvQmNwbGs0RGFJTWExeFhjNjRhcTV4TVFVV2FjU1Vs?=
 =?utf-8?B?Qy9scUtGcVFDcTAvbURXOUhkK2Y4OUNlZmJjQllmTWZhYTAwQUhvVmZMZ2No?=
 =?utf-8?B?N2gyRWhTdXFtU2U3aVFvNFFWUVRMMVZWeUkwL0I5VlZXcURuM0lHdUJ4bHZE?=
 =?utf-8?B?KzRFRGdsVkJIUjA2eDNDTUpZdWREcFQvYjUwQi8ra29EQlhXeXhEQmticS93?=
 =?utf-8?B?SFdBczMyVis1RHEwaXFJdEJHb2RCYjRIdGFpZURYMjJ2bW1PMkZZcU10RmVY?=
 =?utf-8?B?UnVxQTR6WlkwZlJPeXlIb0taUC9pZ2oxMXVFYk5yR1JJZ2hmTTc4VWZCaHdE?=
 =?utf-8?B?VXA5QTlFNFJ3NnhFS0wzLzhqOFRCb2lTaTJhL0gxclNaTFR3c1M3MnZOMEJP?=
 =?utf-8?B?L01kd0V4eHYwbU1QR2R3TlI2VVVvZkkyREdtT1ZsVlNoNnZvZEwybytoL2tx?=
 =?utf-8?B?R1krWklyOUFKbnRsalJ2RlVxOTdsbktmT0x4N2ljdFc2YmxoWC9CUVcwcjh4?=
 =?utf-8?B?eGgrNFQxUkZ2cUxIWjlaSWw2bFBMYlI2b21HelBxV29NQmZRdkpIbzloeEtx?=
 =?utf-8?B?QjBRSWF3a2t2dHduY3h1UHNzVEdKMThLYnQ0czNwbytqSHVGOVIxNHdrQ3JQ?=
 =?utf-8?B?RElMY2liTjRTOXFkbW9VbzZBUTFTNi9uTTFkZTgreUdYYm50eCtSQzRTWld3?=
 =?utf-8?B?bmRhK29KelFjdCt5UHJLeWhLNG5ocWNSUU5XRVR5Y082SW9FRmxCbXdZRDFB?=
 =?utf-8?B?dzJ2dkVXNHlxcW4xREtuSDN1MkErbVhuZXdnRHVtZnc4TW8vWUIrU1hqdjhz?=
 =?utf-8?B?Z1paZ2VpM0NpckFHOTJURFlobFUvRnpXY1JkZjVTNFRDdklFZWdzR25iSGRp?=
 =?utf-8?B?a2ZBbWtxWERmTFhSZFNSKzdZV1JkdUpxenFOU1BGYnp4UklMbmpCNVM1a2t1?=
 =?utf-8?B?VEpPL0c3WXBTbm10WjJtODBKWGVwTjlsT3p1RDJGSTYvekZ1ZzVFcUg0K0tQ?=
 =?utf-8?B?OEFhUjBURnYycEZ0T0pTdXFjZDlaM1d2NHU0dkxXaWVpYjhSeURMZVM1S3BS?=
 =?utf-8?B?a0RWQS9ualJoWmpBMlVrTExwbVNLdjN1dWxUSjdvWGNnTU1sRURycW50K0Vq?=
 =?utf-8?B?dEppVmRiRytXelZkcEU4c1l5eGdDaVJSb1JCV05tNEtvanFwaC82M3hjZjV6?=
 =?utf-8?B?bFIyZTZKa0cyN1IvNUlJYkN4OHlhWEptZEtXaVFoRjVUNm1iWms3aC9WZWdL?=
 =?utf-8?Q?uV1MVx+m+bFHASix2z4DJqY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c2c296-2ae6-4d13-df63-08d9b9b6ba3b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:21:11.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqoD1XezhGGISLXsf/DtVj6XoMEVxeRAGx1DiloMdqDXaucfvh8BIRuGLajimenDUSNjg3ME3WP9zQocYJExag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/7/21 5:48 AM, Borislav Petkov wrote:
> On Wed, Nov 10, 2021 at 04:07:00PM -0600, Brijesh Singh wrote:
>> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
>> index f7213d0943b8..3cf7a7575f5c 100644
>> --- a/arch/x86/boot/compressed/ident_map_64.c
>> +++ b/arch/x86/boot/compressed/ident_map_64.c
>> @@ -275,15 +275,31 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
>>   	 * Changing encryption attributes of a page requires to flush it from
>>   	 * the caches.
>>   	 */
>> -	if ((set | clr) & _PAGE_ENC)
>> +	if ((set | clr) & _PAGE_ENC) {
>>   		clflush_page(address);
>>   
>> +		/*
>> +		 * If the encryption attribute is being cleared, then change
>> +		 * the page state to shared in the RMP table.
>> +		 */
>> +		if (clr)
>> +			snp_set_page_shared(pte_pfn(*ptep) << PAGE_SHIFT);
> 
> So I'm wondering: __page_state_change() wants a physical address and
> you're reading it out from the PTE here.
> 
> Why not do
> 
> 	__pa(address & PAGE_MASK);
> 
> like it is usually done?

I am okay to use __pa().

thanks
