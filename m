Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA4249E845
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jan 2022 18:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiA0RCV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Jan 2022 12:02:21 -0500
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:39873
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230347AbiA0RCU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Jan 2022 12:02:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF8+0ymEnrq5DTwAD7dX871zfbMted+GeQIjFkSEX+BqVJeM5bCfT+yfDvOwXod3xfWYbW9+fW50TR3lbUKyHRlXWEk5Ap3zRAxWjqzHjleTTpdGSUr1dSUAuTFQv2Au/M0FC2v+Lc1a+B/9PUjjJILJVjmVTb65ZOwDlJXZdfgeVfVTbwTc5KyIll8QfVaIwg2rxAh/WuNEMLvCHUJlgiD0huWXm/8ZG3wLqDbgglOGeTPsnnbIS90jBnrYxNtnt/3V2sGOCPA4Hpsb9R0uxyPra/OEALAgmKLfkmC4wpMTUEcbpbMBktXbKFlKNZ/A6AJ0xpBQlRowGdleej2XPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7s5qOPMcfkPpk0DGk2PV2+ks21L6nuBDU5y8AAivxQ=;
 b=jT3Z9cnigDe6N0hTKmWo944J6TRF0ZWaQSDrOLLPhDevWZEXP0qBUUBhd/8UUbAbF15UoGDIeFH7U730Tu2/9mX1by7AUAUvebSTRBnk2D/nf303HA/Nkel3W3/kS/vBva0WXk2t6S4/T2Je+nMrSEIol/xxTl2wrzF6yu1vUqvrDn+o5juJh9r0gZlyUjxAwbz7gsruOp8qxAfR0WFK7XilgmINXFrcO1v9uprq/bKy8oG27UE8lKMeqUKYVVQR0Dy7zYJParnkMom7VPaO7o8KY2UIo58M/kAwlPiUPKDReDdFcZrpLsbG2Kp0Io6gyBNwXIiQYfsyMYHbJYFTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7s5qOPMcfkPpk0DGk2PV2+ks21L6nuBDU5y8AAivxQ=;
 b=Vg4x3ueIPIdfL35yf78bYh641oD+t7VZl4q0Q1gFV71xu8A8rHgAZBoAA/ezypllXfvod9QIVI6cNGZqJhXBS/sk+c1pL5HJwu4QOd3zCSuK4TYe70C25f1CX4S1klNwS6V//PdzASZrmKNuxIyqKt5FAzSC+Vm6RVnQgnyx+qM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 17:02:19 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4909.019; Thu, 27 Jan 2022
 17:02:19 +0000
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
Subject: Re: [PATCH v8 36/40] x86/sev: Provide support for SNP guest request
 NAEs
To:     Borislav Petkov <bp@alien8.de>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-37-brijesh.singh@amd.com> <YfLGcp8q5f+OW72p@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <87d4999a-14cc-5070-4f03-001dd5f1d2b1@amd.com>
Date:   Thu, 27 Jan 2022 11:02:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YfLGcp8q5f+OW72p@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0378.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 875508c0-c8ba-4b29-f45d-08d9e1b6c6e2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4888F6D21BC4D5FF78432480E5219@BY5PR12MB4888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9wMaLf/QTmu9xszRGqLgR8oQ7FwYMALFORqP2VwPggxXkURw03RsETPU64vewuIHmQTsKk5jj9xyBD5fysJRvJhORD2itU6a7Yx0j0cW1tsipf9VhKxuIBJrcw6RX+zHTxhrlDmZSp0KWaOQ/s0+RrsFaHtBkIfUHSOCpeqY5DXL29xuB2OCo8gADE474RpTHnfUM2SlP177izsypBXAkTctljDmCmpeOHYudcAWSoYQLkgqGTnYj9O4bfPqJpNHJzlZ0BPINyQ1ABBgwSc6qvfd7qakPZMAbJmOirSg5XegTqr3seN09ekfYctsg2T0WV8G3Qsgl7NCYoTEZ1fAaW5xK3eUvqTD374/3OSU7tICebPdnjGVKzprq3AbN+Gnh0ESdWvwEy74pDPsTwg6I/A/GsHj4Gmexpt+aHxIwdEmm/MJ8yPWCccCGGRbFKwo0DAAsI+5sKwK+unBX2Q33eTZJNwMfcX/zvef5aUcrUK7mvCrku1tGncJlPB22Bq86Plq11grVJDcBAeo2WIjAxAcOE6UMS+V7XGhSBdi3HIrDD6pCD51yz0j/rzWJtH4AMPKck0fWG7H9gbGwwMGcrWWwN/sCGDVTPP/8TQliVJJBI8y+pT7l/k4cpTSRACNYmidqEULeHw5WVnE6m/fR8cdglTI42arN8g0kmOsroWFs7bPoAteqqMlJykfAIi/r1cqwG5gA8HOfG06Zk8etGaiWsjvToajHv1cXg9dnHPalkgV3znUL0wuspn9iUzkytHwz4YfM6KCqT5kb2MWY/7XsMYZcbBeOfgMcxYsCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6666004)(6512007)(7406005)(44832011)(7416002)(53546011)(86362001)(31696002)(2906002)(38100700002)(4326008)(8936002)(5660300002)(8676002)(26005)(66476007)(6916009)(66556008)(508600001)(83380400001)(36756003)(54906003)(66946007)(2616005)(6486002)(316002)(186003)(31686004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRlMUUrQmJwZGhkbWlMaW4rT0lJTi9uUkZZV0duQVlGTzJzOHA4cVViZWg3?=
 =?utf-8?B?VGg2dXdqWlE1TFptVnRFenRacXFteENHdFR6VHVLcytUU3VwR0hjK3NRTWdm?=
 =?utf-8?B?a2lJRDlxb0VZVGlDY09DU1FDbWpmTGxGS1Fob1lXUDBwdU1TTmZuRVVYdDJ2?=
 =?utf-8?B?cFY1d3F1cnFka202SVhBc0FCZFFJMlkrUFRGWWtuTzhQTzhWbjdYY1d4cVZJ?=
 =?utf-8?B?N0RMVjV3L3p2Wklkank2MTVWYnZqY1pZS0o3V3NaczZXdTNMaVM2QjJHTWdJ?=
 =?utf-8?B?Tmc5TjVzMjRqVkRERmMrZXUxY2dadEU5eWJoT0dLVHJPUDQ2NlBiZCtjUkdk?=
 =?utf-8?B?bFM4RTZnNlZ2TGdFeG5uVzVJQUVhUnNoenJOQ1IvajdyUmhqQkdBeFFpSEg4?=
 =?utf-8?B?RGhwdUZTb2pXRnhZNktoUGRrYTRpVmEraEJ2T3I4NWM2eHVmMjZzRmxlQW9C?=
 =?utf-8?B?YnlDUFEvNUI0SGFsR2lpZGZvZnZFNGI3MWFQSnFrOURwZDhKdjZFaEVTNTFM?=
 =?utf-8?B?NGtveFp6ODBrTS90enNkY1EvMURpamxxQmJMbGQ0QWNCK3A5TTZDRnBmT3Nn?=
 =?utf-8?B?M1NFTTFycklMYWVkbFdVdlptekZRTnZrbnZOWGlFK3ZVRUxjRmhPaWlsSEk1?=
 =?utf-8?B?QzVYVHJYalhpdS96MzNjZDJqUk9uaGoyTjFuLzRmbUtTRjNEdmlWb3VBdlZh?=
 =?utf-8?B?bitvK0RTZ1c3OEgyY0VQS0loN3h2TGdEd2pnZ2QrSjMwMk81ZEF3c0pNQXRZ?=
 =?utf-8?B?bHA4d1JIT2R5bk5UM201T1QvTFFSaXk0UHBRcHNQU1FVS09mNU4wQlBhODdl?=
 =?utf-8?B?VVpJbFdjUEh4aXdiVVc1U1dicWV2UXpPNU95SzlMTHpnbDAwSEk4c3BHWU9m?=
 =?utf-8?B?UlMwMXBnTkpNWVZNT2hGQU1pQkhaRSsxMXU4UnRTN3hmUXRWQm1JYjd4S29k?=
 =?utf-8?B?bEV5anNaaEUrbG1aVEhqM1Q2QnQvYkJNU3dnOVNib2xvT0o3bGYwV0Q3Vldt?=
 =?utf-8?B?a3VEeU00QWdaRGppZ1pSWW05V043cFVpaWgrNWloQkZnYzJVTnQ2TGlFL0cw?=
 =?utf-8?B?RUVlbStyajd5TzRCaFpOb1BmM0tqYnBZbUJzaDN0NFpEbVo3d2laUWlkcStU?=
 =?utf-8?B?MzQ0enZBZkRkeE43QXdzTWtZZHhicDdGTmFMczhxcFdtem15cXNMK1kxODFr?=
 =?utf-8?B?YjZZZlZTY1ZDTjJ3T2FyMy9tM2VVbjBuSU9rZVFCZXFvR0IyMFJLVnRrL0ND?=
 =?utf-8?B?Q0Z2SDBxZ29xK3Vob1ZjZm56aHlWNm1QTU1GRWVpY2p6S2xoK2pVNFBjRVpm?=
 =?utf-8?B?VHY1WE9LNWpIbGNCV3JBUEd5UjRuOHVsNTEzWmFtVWg2VTg1WU1WSWp0cEFU?=
 =?utf-8?B?NWl2VzZUMWRnZmlFcENDVTk1SHlGS1JMbmZLUDBQZm5JZDk0aHh5bUFJUnYw?=
 =?utf-8?B?YjhNMzBpdDNNclBjTHBtbFlIclRZYkZ3cnczdm16VzJBdjY2ejF3M2VxQ2Zk?=
 =?utf-8?B?V1ZoTlZnQlF6dmo5RWFRVnNjNzBTNzgwSW5scjg4UW56T29TVEVNWDhWSFZF?=
 =?utf-8?B?UUM0V3lSNm5xVXNESGZ1SFpZRnFxU2lrZmhhT1l6dEJubkJ2WUFjaEVDZ3gz?=
 =?utf-8?B?RDU4N00yanloWXZOWDFqT2lUN1Vhajh4KzNXSkg3YUljY3M4RzNIbkVwVzhk?=
 =?utf-8?B?TWE3RGtKMVcyM3dvaFpmbDlBbU9RczdNOFNTdFFiazhJeEp4Qng3TXVkNk12?=
 =?utf-8?B?WE5BbW90Q1kzcWFuNDR0RWJrOVlSY2IxWUZmOWhjdWdTMlh1aXdNTXY0OFVa?=
 =?utf-8?B?WFo5QjMya2t1U0tVY2ZyNE5LSkhXWlg4OWJhbDBRV29ZNjZrVmlsM2lSR1I2?=
 =?utf-8?B?R2RnR0xOVmhpQUlOZjZPOGJsZ1R1RlM2UGpMUms0Sko4clJHRWtWOVhYWkwz?=
 =?utf-8?B?TEdsSGVYMFprSDRhK1hZOFhHZ0lldEdSVkdQYmplbVcwUHZmc21LWjl2VTRF?=
 =?utf-8?B?blVTdE1Dem1EbEU4VVBwUlZISmF1L1NIMXZZMVFZVkZRMlFWL2pKdE9PL1Rm?=
 =?utf-8?B?RmFCUE9CdXBVM2Y3ZzRxVHR5VnF3RjZaM1QwdkRmQ0QyNmlKMEU5SGs4OFFO?=
 =?utf-8?B?Vk5ocGc5T0IyN3BEUGVGU2U1d0NRTnlYOG9jbHZIV0RVQWpnZFhlMzllTUh5?=
 =?utf-8?Q?Op8yyh96za7vugvtPR99Pdo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875508c0-c8ba-4b29-f45d-08d9e1b6c6e2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:02:18.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bL7aB4z4ofC8QE5eC1SzfF5WrG6qBJ9dN4Z6j+pSfbc6rVSgHouSYgHChnaW/TBlFEHwdaznrV0estM9dPfstQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 1/27/22 10:21 AM, Borislav Petkov wrote:
> On Fri, Dec 10, 2021 at 09:43:28AM -0600, Brijesh Singh wrote:
>> Version 2 of GHCB specification provides SNP_GUEST_REQUEST and
>> SNP_EXT_GUEST_REQUEST NAE that can be used by the SNP guest to communicate
>> with the PSP.
>>
>> While at it, add a snp_issue_guest_request() helper that can be used by
> 
> Not "that can" but "that will".
> 
Noted.

>>   
>> +/* Guest message request error code */
>> +#define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
> 
> SZ_4G is more descriptive, perhaps...
> 

I am okay with using SZ_4G but per the spec they don't spell that its 4G 
size. It says bit 32 will should be set on error.



>> +
>> +	ret = sev_es_ghcb_hv_call(ghcb, true, NULL, exit_code, input->req_gpa, input->resp_gpa);
> 					      ^^^^^
> 
> That's ctxt which is accessed without a NULL check in
> verify_exception_info().
> 
> Why aren't you allocating a ctxt on stack like the other callers do?

Typically the sev_es_ghcb_hv_handler() is called from #VC handler, which 
provides the context structure. But in this and PSC case, the caller is 
not a #VC handler, so we don't have a context structure. But as you 
pointed, we could allocate context structure on the stack and pass it 
down so that verify_exception_info() does not cause a panic with NULL 
deference (when HV violates the spec and inject exception while handling 
this NAE).

thanks
