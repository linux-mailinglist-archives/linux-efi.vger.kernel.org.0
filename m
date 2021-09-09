Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3C405A99
	for <lists+linux-efi@lfdr.de>; Thu,  9 Sep 2021 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhIIQSY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Sep 2021 12:18:24 -0400
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:34439
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230033AbhIIQSX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Sep 2021 12:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7jlRLKQRpMUfUm57X7MIwDwhpsEjWGCbUHuZ9Kfcuo/4ibFRrTHTyB2a3iWRfAWIRIZOH9NV/nCtKSjtq0uereA8aQKkuxfn0RzL+F0WYEggZdJeyXryN4YzdISzqr4aM42zLOh3RgQw0K2aGVvX0VTw5Wp8iAR+GKEvUCgwuOdlp2fG13lZKKvn4E8yhkNjg+SJTmq2CWqIbqpRFQK6KU80BbXUCyF3zwP7u6uWoTtTs6bjdpqAxOykPLxBlkI5LMLhXSqN+a6KYYM7pV2QIUiUZYd/67B/GftF2C2Pb38Bza+vkykMrrxlKGYVhEhUCkmq1yp/QcnfmExDtEUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tuDJ7dXrW+kfNGsAT4K//MBvDNldAcR+KKc1D7XG8Ug=;
 b=WB938YR+kP7jLeOIFCPul3xjuaq69oRpwgZ5mQt/BhPNOF2tote7TFXa6H8eaxLQfQDS96S/FVG6YuLB/gDJTCM2uR//2OJcoWIqHiQX+n43FCxbMzxNhpABm7QxqEp6EpDOqBWYFxnqirW1TBheGFrOilu5dTcie6+ravi3sojZ6f61WzKqcYoHsVpBdnx+IvlLU58uIxf1yPst2N6vd2umerFgydakYnvI3LvwGcikJrtkVZTv79wPF+CIiPzu2VApPWdo/gbUeiZ3RPumO4T44pyr/YfdVG6AlKTnTyWzwMa2ma8q2tquvKp24Bv2jN0u2ADce7ntlvc4i5tKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuDJ7dXrW+kfNGsAT4K//MBvDNldAcR+KKc1D7XG8Ug=;
 b=RGkibFnA4L4xekCByuQyD6Esg/YBVVp9zn/fWQ9iJewsH4mcwvUW1UAzx3QHaK2RY9TlBg4r4DqvXM2X3mhT984SkzfvY3uHc8+dSHLiyug9iYwGuZXbd/Lj6qscvePNbXyEbhj9CYwH+jb3fhaMfp2qu/qIVbaZcYohvGKJPow=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Thu, 9 Sep
 2021 16:17:12 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4478.027; Thu, 9 Sep 2021
 16:17:12 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        Marc Orr <marcorr@google.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 34/38] x86/sev: Add snp_msg_seqno() helper
To:     Peter Gonda <pgonda@google.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-35-brijesh.singh@amd.com>
 <CAMkAt6qQOgZVEMQdMXqvs2s8pELnAFV-Msgc2_MC5WOYf8oAiQ@mail.gmail.com>
 <4742dbfe-4e02-a7e3-6464-905ccc602e6c@amd.com>
 <CAMkAt6pT4vkgLxTN1Lj54ufaStyCHHitNaHAdZvEgDV8Nyrx-Q@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f54f3fc3-14c3-5c36-2712-62eb625a958b@amd.com>
Date:   Thu, 9 Sep 2021 11:17:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAMkAt6pT4vkgLxTN1Lj54ufaStyCHHitNaHAdZvEgDV8Nyrx-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:806:125::30) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.31.95] (165.204.77.1) by SN7PR04CA0175.namprd04.prod.outlook.com (2603:10b6:806:125::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 16:17:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f06704f-edec-4438-6a71-08d973ad4799
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45576E9FDAB9C73CA8B3FAEEE5D59@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTO6W/d1wDlbQ94pINfSy+EYQR7CPsBQI7xs7yth1qrZr3g20bTuDTSSOPn3QzyqmYAAwfLhN/WvPYnvcqJzLoyZlrDGRo0xEGv2GcF8B/3X3zQHjpZoAWCM5xVj8AzyBLzjSB6AJbChMS+f1l9y2e2K18TqMPGzbTRqpO3wisskB+zMbN9Bc0v4CJs2lZk5TTBMcNT+6CUiFiAsPAEAb/E+Xt/6ZtRyLp26hK6a0lk9CS+wY34X7DC3JmL6dmrkXAjjwa/etr+tIJI/Ii54biGUIvjuMSpGn8UZsA8kYmFdxZ+5WlxSy0TK0Dx1AbJk8D9d5jamASioIdhVBxab0gjKf8X/A8Xc5Crs4xvYb1+NvrOavVbnDzLPAIosCjtkFlKzqby/U2mLgCLqJsKQ3bQEj44fnrk1/e8yfLWWxkAiL8X8jEYELldyJfppx9a3ywrzWql+73RuDf2FOkX6FfIbYUWXVTYzsw00PFP2e7NLAalYPtlE0+AoQ6PnfMq4e7I1XzC3cvZ2Ey9K3Vv9S+Uuq+v6G2v3eBmIg6qXDUwdC+K9FBE/W5IhV0smPvxoeGyUW5DCGBl2u0IAhJQ1aEWANglUKmVUQ27xeS6Jm3coQJ5fTedfP9MQOzUIL1J2ClZzv0QFPVu96m92dPfAnd9z71c7l9LNg9GlHmjqC3SyoR00vxpumocf1RCTyFsJ/FNzCLqjlQBFj5xVn630Vv4tvFJnSd5fAYnT23k6tiHVkaisUoNKTY/HuIAwiSSukz+XqDRQ3kZDKIXeE4VElw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(2616005)(31696002)(956004)(36756003)(316002)(16576012)(7416002)(86362001)(7406005)(52116002)(66556008)(6486002)(66476007)(478600001)(31686004)(2906002)(4326008)(66946007)(26005)(8936002)(8676002)(38100700002)(38350700002)(53546011)(54906003)(83380400001)(44832011)(186003)(5660300002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXZ1TE44TmhZUWgzQy9kZW1jMzFPQmRYR1lhTngvdUVpSmxhUTNxVkord2VN?=
 =?utf-8?B?SmVwdExyUWtpcUp1T25NYlBkM2c1VmZsbUNoNUUxcjFCMWtLVFZRdFphMnVh?=
 =?utf-8?B?b0llcVlQdnRtRUtYK3RTM0hIWDNuMTF5eitPV2pRSFoxclZCa2tFMmd2RFkw?=
 =?utf-8?B?QkpJMnU4aVpkL1Mwc0xzK2FyUTRLLzdUblZMTDhLd2U2MUJTRm4rWWprRUQ0?=
 =?utf-8?B?enFaV2NJdTVtQ24wOFBPMStSMExoN2d4emlCa0hxMUFESEd6TGNZMDdGeXB3?=
 =?utf-8?B?cnN0eWZveWhWamVaMzRJN3pmWWpvdmE5YktXYTJwSVEwbWFnY1lnTE1pblF2?=
 =?utf-8?B?QmxIc3doM1psRUp4dGlveWIxb0h2OWlqcVFaZndkb2NabTdyVXBwdysxb1Ju?=
 =?utf-8?B?alZvdmdYNU5yQ0svaEVZbFZiK0Rtd2N3WG1UYlErYmUzaTA5TW42SHRidWFD?=
 =?utf-8?B?YTR1L21VMHVrcHVoWXFlMDUyTEZzT09YRXhyc052VEpKVG9MdVBxd2crY1E1?=
 =?utf-8?B?SEI0UFJUNVRqeUNqMTZEWko1R29XWWxPQkh1WWdmL2g2RFExTzM4UXZIQW1U?=
 =?utf-8?B?cTI1bVlhNXc1aHd0dkxXSnh3VjUxWTJKODZuNSs0YnVWU1A1RS9oRW1nSUFh?=
 =?utf-8?B?ZFk3Tk5ia05QYXF4T3Q2ZHI4TGJJTVdMT2ZKUTVCb09TMXpBWktBYXNlQmkv?=
 =?utf-8?B?UHczd2NFb2dFWU5jWTFtMlZFQ1J1alk4YkFwMFBlaE4zZ3lIeWxxT1YxYVNR?=
 =?utf-8?B?Y214OXQ5Qm1GZXhzUGdCVndTbUgzTWNTMG1kdTllVjdYRDR5WExXeUxMciti?=
 =?utf-8?B?QTJxRERITFpiOENRV2RxbFJWbDNNYStSaUlSaDZ0YXJ2R05XSW0veHNwTzli?=
 =?utf-8?B?cUdJODArYWdNUFl0Y081dlJXaS9IemhTNEhJUGoraTM1Y1hja0Fwem4vR3cz?=
 =?utf-8?B?N0twbGpFMjVuVldYa1cwUzBjb3BzVk9OSi9QYTB4OFhPZnp1R2lLL3NIc0dC?=
 =?utf-8?B?WTZ2V3dlblZSMGtKY1ZXZTJ6NFFTZmY2ZWxRNUV0b3RsaXdFZkROaEhoeklQ?=
 =?utf-8?B?S041QlNHODJiYndmOE10dkdLVDdIVmExcHB6QWpGSWsycXkrdjMrUUVSbjRh?=
 =?utf-8?B?Z2lJczBDR3pUWnZkTEdlQUhMZ2VqSVdWTVgzUjF0NFlXQmY4ODkxSW51NGw2?=
 =?utf-8?B?YmxzeWZpVFZpdU5GelpLV3FNYUFhUlBsdHB5NXZIVFNaeHdzZklFNXhDZURj?=
 =?utf-8?B?Q3d6akQyZ2RnU1ZjZjdEc21jMzh4cFNPR2hkRmtOMWx2Z25vNW5EUXZXZ3gw?=
 =?utf-8?B?Rk44cXlnRWZ0UXNQL3RlaUsvcDZyQ0VjL1NXd1JQNkllM0dEMzdjWlNiWVJw?=
 =?utf-8?B?bzJYUGFOQWRzK0I0NFFzTHVqY3QxNmlpdXhjLzQvbkRvaUFJd2ZyeHNmVXRU?=
 =?utf-8?B?cFdEKy9kQmRaYitadjZmUEtjV0ZlNldWOGFzTy9jTmt4TFdWdU1oOGRBTEU1?=
 =?utf-8?B?WFlYRjlQYUhqNXBWbStIcnFMai9aK3NnYzJJY0ZqQkg4WkdQNm5IcG56V1RR?=
 =?utf-8?B?RXFSaHh3cklYRndDd21vM1psUVlkRExFYXhQaUFaQnV6WDA3YytDSk5LRU1O?=
 =?utf-8?B?bS8rdndJVjVVVXlyQnU2U0sxWWpPL0VkOUhCRkl1bElQV1JSbHJzSUxqcERm?=
 =?utf-8?B?aTh5KzBCMXY2OXdmelhVTWREWnUwVmZNN3pkN3ZsK0RTU00xOTg1NDY1OXBy?=
 =?utf-8?Q?Hah2O/kydLJBILvV3V5F6npt2AVrgYC7HlpzIPW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f06704f-edec-4438-6a71-08d973ad4799
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 16:17:11.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM+iI8Xyd9mZdTEgkDlWx011hRuXupn0aOV89qo8BxZKR6MtPmz9Ijww1hl8OX7hw9wh8dBOYbFyMnajnQ+1Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 9/9/21 10:43 AM, Peter Gonda wrote:
...

>>
>> Does this address your concern?
> 
> So the 'snp_msg_seqno()' call in 'enc_payload' will not increment the
> counter, its only incremented on 'snp_gen_msg_seqno()'? If thats
> correct, that addresses my first concern.
> 

Yes, that is goal.

>>>
>>
>> So far, the only user for the snp_msg_seqno() is the attestation driver.
>> And the driver is designed to serialize the vmgexit request and thus we
>> should not run into concurrence issue.
> 
> That seems a little dangerous as any module new code or out-of-tree
> module could use this function thus revealing this race condition
> right? Could we at least have a comment on these functions
> (snp_msg_seqno and snp_gen_msg_seqno) noting this?
> 

Yes, if the driver is not performing the serialization then we will get 
into race condition.

One way to avoid this requirement is to do all the crypto inside the 
snp_issue_guest_request() and eliminate the need to export the 
snp_msg_seqno().

I will add the comment about it in the function.

thanks
