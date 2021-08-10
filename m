Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A413E5E82
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbhHJPAK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 11:00:10 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:9184
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239443AbhHJPAJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 11:00:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCJj+Nc9o5ysXGHKorGuRhUwqs7jYngaPmeQnckzZiyGQIXkIJ3vZw+ByXxs0O0D3ar4LYZFxHsU9aVacLGNRv1BqDzSbItSQREi+gJDWdjOh5yDBgIkubsh/bcj5jFsSdar7Kn1TovvVAvHnb4XPWyD5/yRAiN3yV2+ul2lINOR0G6QusJAiDossPYH7X0e39Z5SzPgJThw1V4wLveHjXt+eaaTE4Zb/pVxIBkqJ82oh5NquAmtp42MzcQRK6ZrcL44jWv0tDWt1sYGs6Ti2Yud1FKrflKJXDbLhzleMXaplTJIh2ghrB0+4i+rwQoPdiaovRKfTD9cdRZFRSv+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KmuRp3ehmEl+JEzro76OypPlMpXSxFaITsbuMrxsbk=;
 b=XkJ3XtmhDE91NUYUSLj4qdoR91SkRBJLD1DFpXtNFv47TwJxKwQg5gvPn/iLR/zduF4TIEeeJ0RW9VL2/70R25P2YVXQ0xjUhTL/WFrahZnKMN+VtsY+hM7hfGAb3AMku6n/6/2RqrYwlq3vUz3PnL+AWLvSb15XMBsMyf5fyjPJen6uFilj3Xqv136V3wk1KOQKdKYTwTszfga++XERn+MweOuWwg043UNlQ53obhqcdWg2eh0AnE8Q7453F7IO6BnKCtMpsgifXXAj0LqvFpoNq1udIKoUIhbfRwO0TQuIb2aH2aFKc2l8B8dhSOOKOCYzitO+4D6IpDN1Tf+Akw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KmuRp3ehmEl+JEzro76OypPlMpXSxFaITsbuMrxsbk=;
 b=eC2t1//TZLvjYHMrhQRrdOFVUjo7ayhUXuiuob+7Q36myTp/JZh3r2z3wIT5X91SqZxptxA8UfVwhBmyWcf5l8xDbuUaAPFqfeTrixculW6E6ShRsA06cIhrvE5y2oS3u5onRvuELILCLNLec7IBWQuiEIQvy72jXnH8zZOy0co=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Tue, 10 Aug
 2021 14:59:45 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 14:59:45 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 05/36] x86/sev: Define the Linux specific
 guest termination reasons
To:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-6-brijesh.singh@amd.com> <YRJkDhcbUi9xQemM@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <955b4f50-5a7b-8c60-d31e-864bc29638f5@amd.com>
Date:   Tue, 10 Aug 2021 09:59:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRJkDhcbUi9xQemM@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0007.namprd04.prod.outlook.com
 (2603:10b6:803:21::17) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0401CA0007.namprd04.prod.outlook.com (2603:10b6:803:21::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Tue, 10 Aug 2021 14:59:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05b8f524-11f5-46dd-5be0-08d95c0f7d69
X-MS-TrafficTypeDiagnostic: SN6PR12MB2718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB271846E0141BC5A510AA5FC1E5F79@SN6PR12MB2718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/hf7W5CCPWnUgz6wIX6L4OJ0OPDewfjJeR+pk1sLAznjOt3sC1CMEXWhEoFVE1hQzl8VzQDpfwr84UYaCdxQSBqmg+SvQftya4VylZh3BWDzVCBYbZlus1zHqxvMYZQFBwt7DeIJAf8514UEzMHERfJIQ0h3zkcL8b1+I3gB9/HyRkmdMOr9ns/h6IPJoA4pBkQ/4vPFTa9l9+bMc+9XLI44kb3TJcjIbvPYzT2+9hMCWAambQaQpEyQygryeM5Fxc4owJxNYbWf4UfxiuN8J8gLbxIm07RDz3ArvwDRGzlwHCN+7yPtMVuFuYXVVN0KG2KAB3OSXgW1+XubG3m5yJhYmlEI2HF9Lc5cY01PReDzJw0tzXzrHNwm92rpg9oK1kJ6fViJSwU5arB1sIxRhmMHFC5ELteq6Qgxw4W+GhrKYIOynjQdgaZeCRYtRoArM1ZgX1PfHq3Ln/kjaqodmAz6icP+DyAsgXkJyDIE6kzvuzJjHkaH5bukeTvA5R46wP7Suy04lZ/ulfSpGJOEvkuYxH+E5H/qTvnUIAC9KRZ/y2krhaPa3+/dYyCSyDNIcU8eHuz/ei3h7PPfgJCp4oAxGJLlhZJg4SdPSVN/6Wk4Ga3u+nQbUnR3DE2JrX1WfqlpAgEISiNAeJvxWJLhcoX/ZSful9+VjKAo4LevCFf2SGt8rTaRHth/U6uBzRNQlDbwQFRv4XYRTQ+2RgVf8QPthbu70KETflEKuGYkFo2/2XGXqO73Zg9RkvqeuXrTBeXL4BCyQlXgfyTcABoMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(5660300002)(31686004)(54906003)(2906002)(38100700002)(186003)(16576012)(6486002)(316002)(36756003)(44832011)(86362001)(8676002)(38350700002)(8936002)(110136005)(31696002)(52116002)(7416002)(7406005)(66946007)(66476007)(66556008)(4326008)(26005)(2616005)(6636002)(478600001)(956004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTB1cDJacCthR1hBMGY1V0FpSUtQZWRpZDZpeGVIc0g0Um0rR05keTIvR3FS?=
 =?utf-8?B?cHVrR2lSMTlJR09xN0NxWE9mNTB2ZVYxSFdUMW5iN2hwczBoeG1hQ01TL0FR?=
 =?utf-8?B?cGhtcUlvRkN4Z0FVTUdmVFpsL3FJc092VjVTOURKTjlJb3p5Tk9GSzdReGlI?=
 =?utf-8?B?NVFFcm1NcG9NS1IyaUJkMWpFclhqTytaanRrZXVyZUQrZGYyQkVIWXZ3emd5?=
 =?utf-8?B?dzlMRENMcmJNREJHcGpVbDJHNzZieERqN2Z4MXM1Y2V6Tm1HdHQrWmtzVnVh?=
 =?utf-8?B?ZnllUTBQL0pvRGordG04MGo1RG84VlBMa0VBT2RVbVhZRmhkelV2TnNmM3pv?=
 =?utf-8?B?MXZpZFBDRlFNWDE4Ui9QVGhaRzB5R01Tci9kNDJJaHpYOGpQZUQxbFE0S1Jm?=
 =?utf-8?B?M2Jmbi9OT0k2cUFwTU9GTVNuVllSQnRqbjd4c1p4b0FyblN6NGIxMmhGTGsr?=
 =?utf-8?B?SVFJOHhwMTBIcy9ZWkVIY2xwN0JMZHA5ZlpKdGc0M2M2c1hxWXN1c2pxelJN?=
 =?utf-8?B?TmtGQnRKekRxcFJVbkkvRU04V3dGSmxGQkRaUmJZWmlOOFM0ZXVYV0k3ZnJZ?=
 =?utf-8?B?OG5wNjN3MXJJcXRxOUtzUXA3RmE5cVdQWFkyc3p6VjJ2cDQxN3JKZDgxZDJP?=
 =?utf-8?B?THNJekMwSXFCY0laUHYzU0lRS2lCVGs2WWR0VTJaU3JVeEZtZGZoVmRESllP?=
 =?utf-8?B?bUVFS2hLMXpUK24zdUgvcXZBbC9pdE91Z0J1RXpwQ2p2L0dNK1N0V0xNVXl2?=
 =?utf-8?B?THlickhJS3JBdEVtdG1tYlpocnpBWGRBYVM5NnlxNGRrRDZsVHFJcWMwc2hY?=
 =?utf-8?B?WUNTNGJQS1dnZ0FDNjJRQ1djTU5DZWQ4Z1VRaVR1aFRueDZLSWhDOGF6am10?=
 =?utf-8?B?WlVXckFBamY5eFJhRjIrZU01RGIxYjE4MTYxeFg1SkhaMnMvWjdyMm5kOWxs?=
 =?utf-8?B?T0tWSW5DVnpSRmw1cHJTVnB1VTVvblM2am1HVXpqVUVOWWdOaGhSNTMzMjBO?=
 =?utf-8?B?MGtHTmpiQmRuNnliSFBWMVhEcEQxeHo0bjZIMGMyNGJDa0pOY1Z3bDdSMGxj?=
 =?utf-8?B?MXRsRWZXSStuT05sSlpCSHZvenJtYTNjeTIxVkwyLzhtK0VRcWI5dVpOcEpK?=
 =?utf-8?B?NmVJN1FRSmJSQ0RCVVJ5aC9QZWo2ODd6RWlCTEQ0YldTZ1lzcG9Ec1pOT1R1?=
 =?utf-8?B?M2JxSzZmSXFVQjZTMGxpV0o2SWxZRjhSSEdVUmgxeDRrOFZPY29ReVVvdnBj?=
 =?utf-8?B?WjNiY3ljWHhvUXIxT0FLOUxUUVhaWGJyM0I3c3FOdlB0aHovOHJtKy83Vmhp?=
 =?utf-8?B?cmZxN0Z6YzRSeDNnbUp1TDR4eFV6MURCRmRHK0FWaHAwVHQxV2hzOTkyZWVj?=
 =?utf-8?B?U2pqTVFsQ283cFk3UWlleWNPSjdKOWpmdDBiQ3htbDdwU1cvclVpenMySWZa?=
 =?utf-8?B?QjBHVVlXa2FSVUNLbEs3OTV4eWNUMlB0K1VXTEdUbGlBeGhySTZUbEFpR1pM?=
 =?utf-8?B?V2l5N2JsUkIvRXFJNkEycXB3cVY0UFhKenJ4VlRXcnhyRHhZdE40RitRT0hT?=
 =?utf-8?B?RmNVTlZzbU4xa1dlVUZvU3VoM3RFY1JvVTB0T0J0QUNVYTRueDk5aHA1M0hS?=
 =?utf-8?B?a0FzdStTdTVTUXVBOVdJcXh0L2ZQWTVKWVR2Y2k0THA4RFZjTHJDY1ZCalVi?=
 =?utf-8?B?RG1kaWZHMVJKZnRrbjYvTjU2TXcrdE93Mm5rQm5hV1MxOHB5OC8yRnF2UzU4?=
 =?utf-8?Q?zmpGNRx3T61t+3ML6IC7d7OIc/vOsCMxmJwEJ6Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b8f524-11f5-46dd-5be0-08d95c0f7d69
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 14:59:45.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F0Ml2chl8qdXM7qRkeoXOfv+33mFLQxt1kL9O4upvpijlmp0kOMo3yAcc1XjvQ6yjW20doB6UOEL5Uk87Ll7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/10/21 6:33 AM, Borislav Petkov wrote:
> On Wed, Jul 07, 2021 at 01:14:35PM -0500, Brijesh Singh wrote:
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index 23929a3010df..e75e29c05f59 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -63,9 +63,17 @@
>>   	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
>>   	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
>>   
>> +/* Error code from reason set 0 */
> 
> ... Error codes...
> 
Noted.

>> +#define SEV_TERM_SET_GEN		0
>>   #define GHCB_SEV_ES_GEN_REQ		0
>>   #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
>>   
>>   #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
>>   
>> +/* Linux specific reason codes (used with reason set 1) */
> 
> ... Linux-specific ...

Noted.

> 
>> +#define SEV_TERM_SET_LINUX		1
> 
> GHCB doc says:
> 
> "This document defines and owns reason code set 0x0"
> 
> Should it also say, reason code set 1 is allocated for Linux guest use?
> I don't see why not...
>  > Tom?
> 

If Tom is okay with it then maybe in next version of the GHCB doc can 
add this text.
