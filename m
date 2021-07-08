Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C5A3C17D3
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jul 2021 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhGHROC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jul 2021 13:14:02 -0400
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:25952
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229489AbhGHROB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 8 Jul 2021 13:14:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjW9RuSCHwLBeome86dp3kH4kS3x2OUFgiwickAIoCwlnL2sXzQFdFFKf0pPjk2c7K0QiH2tUEtVfUW0tYENHNjAFjo0hvPB9Xzcac5ImS0r66uDMlpZRA0oeIQQ57jA3yZqLfUh9C2H1NegGk9/UnHcg7Z5D7sX2t+ff8TeGCOD8uFb3RnSFRvznbOPkXFN+nTh69SCSSc2azO7TfAmBxeBGIXUCPTBSXgEswz7IxBBjdBOuYPNHb/qiu9mz/Sagpc/kC8zDbklbMD1io37t1S9SqbZB2peIVDJ2IgzdMXNX0h+XGivz/VLTys6KyyD49zcLq+qhy1NMRgiqr9uJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPq3zMxzPCts67hAoPw+ZE/gSv/0Vn/W/bbxMA3QRw4=;
 b=fEuj/HpnvGOZGyhHjwlk1ErICnVcH+rpx4u8PocRijpJQXIKqvjuwYQlHFnMOyrci6NFLLzDepYsMQBKCrTmPfsjypMI3/0+NmivtNKCkePi3z4sR/I/bfdDV2ZI2GdVk9tXFPjjoPDUo/5oAY4JqIC2K9Tu1EQ3G4TA9LTIm2vZ1XOF9oI1s+08DDxHjgngBAjT46kW5aSeY1zy4rnEr+GozbHwPwg3j0ybh/vxUIoVQ+jvNz/F30ao3iVVepmoEU4R3GB6zMhIwT9JGBgqG9lOOdYm/C4tMDaNTLVM+vLG3ApwaPKc6mlOHxSmLI3JGGre4iuaeP6eZQQgshXo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPq3zMxzPCts67hAoPw+ZE/gSv/0Vn/W/bbxMA3QRw4=;
 b=b0PRu0WnDcWstejtpzgbeuxkN9cs2EnbjWlEqd9lV+eH69BDMDvDzPJZqEzpC8RK0idP7hw4qWVbbdtjHfLo4FeRdMWOwJ+XJ4z631iCramyaMGJFZ9NyOb+x7DOIamJNthw5sIGie3WeIKFxNRiwijNEHbhhxXxej2xqGNSlJs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 8 Jul
 2021 17:11:16 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.022; Thu, 8 Jul 2021
 17:11:16 +0000
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 09/40] x86/fault: Add support to dump RMP
 entry on fault
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-10-brijesh.singh@amd.com>
 <cb9e3890-9642-f254-2fe7-30621e686844@intel.com>
 <0d19eb84-f2b7-aa24-2fe9-19035b49fbd6@amd.com>
 <15d5e954-0383-fe0e-e8c1-3e9f8b0ef8ff@intel.com>
 <23dbe0da-581e-2444-7126-428e79514614@amd.com>
 <8c4852e4-8f57-354b-630d-cea8176fc026@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <5861dd0a-7e46-af3d-3d0e-28b41ca17e1e@amd.com>
Date:   Thu, 8 Jul 2021 12:11:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <8c4852e4-8f57-354b-630d-cea8176fc026@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0046.prod.exchangelabs.com (2603:10b6:800::14) To
 SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN2PR01CA0046.prod.exchangelabs.com (2603:10b6:800::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 17:11:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d93122b-e903-40ea-2218-08d942336514
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23678918B48A011FD4C209D2E5199@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4flnORIf1SiFoWH5+i9CtaYn+//Mka1wtWzHk+F6jpFKaIsvlCgVC/gTKmJEr6YRNWHwKARzO1FHDnTbQSXs6t7ar8tHaxTGPbVWobay2mKmHZqg14aaoFqZvQpndD25A+NkrWWAbPMxXXikh1/7kl1piNjtjA+Nh5VnZtWVo/iVIFhRw0oGgD6wwinTEtLmbo5RQ55XHapPtG7ytcCe4kn42imFODHCYBJ+KWK1Pr+765H9fqV71f7BSfgSI+7aw3+04Whd+PfUwWRYnH4kWH8jYRBfk798L1ZvXRfWh0uUq2JVr/yEmv0iNyuIl4eLkwQAR6bkt0nJtSzT6N3KJUTRHIFnaaqvP/IkAQC5HLP3t99A0WorZxbvbBI2kR1uVOh0saKD9tua5mrv7o3m54N/ir0y/YFaFxEO7s2FlImBsNRRtI7BDlhfe+jfaW/x1ZoRJA61QfnjwIgeMUxi/VfiLBOM3wwHRXSkDlJOLSfGUkRYFADUZuLIbaxaEXzr2MVfguRjmey2grneQRPtmrLe1jzmvM2nolp/VFbZMPdWektTc0fpT5jaPkE1ooUdrjWz/QB+bX7S82XXSem+h1Phv4bVMcXTrbndNn+Y/EKwodb6Y03JbNOh9DUgTkXNPNw4pg431dQ+Ag8wR1q7E5FVEFJpC7awfhvRmED7/LgdYYDoNvYz7Q8nt63M6jlA13+19QOibOvCMuIXBYioq0seeo7DETw1DiblGNANyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(478600001)(7406005)(8936002)(7416002)(316002)(2616005)(956004)(31696002)(36756003)(66556008)(66476007)(31686004)(52116002)(38350700002)(16576012)(186003)(8676002)(26005)(66946007)(44832011)(4744005)(5660300002)(6486002)(86362001)(2906002)(54906003)(4326008)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzB5WEJVMG0rRE1nc1lNcmNnZlJ2NFZydndFVGRJcG15QXdUWDBDTnNiYit4?=
 =?utf-8?B?MU1WWGlzTC9HTER5ZUlpQmI1dW95UHRKYUZvNXFaM3g4SVlPWHphd2taSit4?=
 =?utf-8?B?bEtiR3h3b3llZCt4MDVXd3hsd1J1WEZhVkZXZWJNRVg4R0ZrWVpzL3J6d3RN?=
 =?utf-8?B?dllqWUEvNUR1ODlkcDRXLzhyOE1BOTR6cUF6YVVuQkpBd1NxcnRkbDNCYktt?=
 =?utf-8?B?VFkyd3J5cWRYQ2lvNzBhSFFFa3p6eDNNcHpRaEpaRC9aR3V5QUdjNVRmWTJW?=
 =?utf-8?B?aWJSOTgzd0RPbDdndHdRUENtd05qSGUvOEtSUThQQnhaV05uL2NKTUxnTmJB?=
 =?utf-8?B?SUdHZEMyT3psZ0xOUFFaaGE1TnM2b0RuY1lrbVlaV3dJMTVLY1lEbUVKNW9E?=
 =?utf-8?B?ZGhkTk5lK1QvVTZ1VjZYTzJNbHM5QWpEdnNucWhGRW94Q0NSZ2JxSkRjOWIw?=
 =?utf-8?B?aVVxT2ttTUpDK01WNm5ITERZN1hKZzJKT09nSXZvV2hHZjJCOGd0LzFUNFNU?=
 =?utf-8?B?MCtMNWF0WGxTZHZGbmtCbVl1SFQwREpYdFVYV0F4ZXZ0dEFPTkV5TENZeHpk?=
 =?utf-8?B?WXY1VVNPSzducmhIWXhGYWZDNGFuSS9FSE44dWI0TmF6aWVWb0FHMlAydlR1?=
 =?utf-8?B?b3R3MXAxdk44UmhCSHA0cktmTlpPTEV6NFBES3BHQ3paTnRIUS9hb0ViU2kw?=
 =?utf-8?B?MnBweE9XbVUwcnVtNC9yZ09uVmlIc25PUWtxOU12MVlWMlV1RGdLQ1lPS09V?=
 =?utf-8?B?Mll1MVRCSkhCOVFuUTRsdDJuVkVLV3RSMlhJQXE2UnU1dXN1NGEwVHhCNHNR?=
 =?utf-8?B?cTVTUmpRblg3UHY0dU9LbW5NUXljT1hDWFRLTHh1N2NtYVY5SFV2c3p2aTdK?=
 =?utf-8?B?VlJnR2VrQTd0RXNKcy9OK3pqcitEdnZVQjQxVXJmN1FiQk84ak02VTltYVFW?=
 =?utf-8?B?cmEwcTFPaFo3UFNmc29kVytRSEUrU1NKVmE3T2IwVk11UUpKaTFtSzBVTVpX?=
 =?utf-8?B?N21GZUNHY094SHBDR0paYnJEN1hSdTVsbkV4UGhGdndsVTludXlxVVhHdG5K?=
 =?utf-8?B?dlRINHorNXB6aWc3bzZWZ2tQQmhmakoxakxQRWJTUkVKeWIxdndQeU9TcW9C?=
 =?utf-8?B?clBIbm8rSTQ1SlM5cEFNM2RsZ3g3NkF2a3lPd3loc0VrVGYya250ZzExQ3RH?=
 =?utf-8?B?bWVWNGpKdUhzaUMyVGIxVkY1V0hXdjN1dndnQ0QvQ1QwUzZ3bjhuRzRscmlX?=
 =?utf-8?B?T1J3dTVKSThoanQ5QmFHMDdKSjc3by9xakFONWpkTnZxUXJlektBSWVMTHNa?=
 =?utf-8?B?VnF6ZTBwcmVPRHhVaFpFaVBzZGxhM1paWEhMcWpBTFdKM2tGZXV0NHBQVXAy?=
 =?utf-8?B?dDRHTERHTUc2U2pmRndwTndzbVJoTFZWSE1wZDRLcFMvdXZST2FXbURzMmFQ?=
 =?utf-8?B?amxuSHNvbzRxcGtQYU1nRStwZEFzK3V1K0hBRStCa0pLYkI2emZ3WXo5VWVX?=
 =?utf-8?B?eVdMSDdSWHdyRGdqbXV2U2RDdW5JZEFadFFSOWVJTWVKLzVwWDhGUVF6Vysv?=
 =?utf-8?B?cHBLa3IyRExUV3hOcHhTTUhXZy9SL3FLdElVMUMrTjgveTlueFQwRTJ2TlQ4?=
 =?utf-8?B?WkhwQWNibU94LzA5ZjFWb3pJVHVvd3JIREVIdFNYeXczdGErUDRiSnpDUXdi?=
 =?utf-8?B?VWxuWFJ2VFFpd2Z2SHp1elhMNW1ZOUc3Mjg3eVMzL0FISmljTXc4VEdwcyth?=
 =?utf-8?Q?fA/wpbka7geyDVvR7v13N/vp+7kaVDetqLwIctM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d93122b-e903-40ea-2218-08d942336514
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 17:11:15.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeZ6Q73xYZizYsCCcoQndqqq3N3TM6Kx2/rEp7ihFLZNCbeKszRH7unDryQ+uARLc2ZblVtl2T/8ZxljvKnsdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/8/21 11:58 AM, Dave Hansen wrote:>> Logically its going to be 
tricky to figure out which exact entry caused
>> the fault, hence I dump any non-zero entry. I understand it may dump
>> some useless.
> 
> What's tricky about it?
> 
> Sure, there's a possibility that more than one entry could contribute to
> a fault.  But, you always know *IF* an entry could contribute to a fault.
> 
> I'm fine if you run through the logic, don't find a known reason
> (specific RMP entry) for the fault, and dump the whole table in that
> case.  But, unconditionally polluting the kernel log with noise isn't
> very nice for debugging.

The tricky part is to determine which undocumented bit to check to know 
that we should stop dump. I can go with your suggestion that first try 
with the known reasons and fallback to dump whole table for unknown 
reasons only.

thanks
