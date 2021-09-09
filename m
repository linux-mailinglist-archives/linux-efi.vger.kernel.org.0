Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0A405D4F
	for <lists+linux-efi@lfdr.de>; Thu,  9 Sep 2021 21:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbhIIT2F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Sep 2021 15:28:05 -0400
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:8192
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237494AbhIIT2E (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Sep 2021 15:28:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6AhbOEKiFQemSTBLYGeycaJPPkRm7t6/jpk00oZ9rqBfXZ9XTrZL4ph1aScAeWOwy4+UMCWrjwjicFzDz0txpbwBq09XQKnFSY2uzFXwmw34SGlwL/To38EqgnCtBK6ReHvvI3UQJKv7jrbYJkVjsi1w2zgThdFcc+HxW/lcmcvMokO+KpbP9KxCae8hFkRJbBjIVYP8lD8l0S/edv4Qm/xaTzORNkm/xl+EEwLPOBgfQ3go8FjhhAvn22zlbPdDGdJO/0O2rceYIMV7MJa2xtN57uoKJuXCkaiI1ggESV3j+XfSjsec4B/qYwdDmo3ZcRKsfM8CJnwS/K71+xTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2xPi+62VJK36gSx2wO8HjAynl7TtPz3Hn3y6hunmpO4=;
 b=TK7j+8zXB0dsluD12Q/tyo+bJMD44Ns9K0p4ALaeceEUOf39bEwYZqWdkUmW7bBP9gyKi/AozQbuKUK/cvb90ean1/XjyWWOXIHRSwCSDgKUQoiFYc1YCGbk5r4ibkOALoVQkte/rS0J7IStuOAmqiKQoEwc4nhr/vPUZpi71qwZEUf9Gc9X54xyYtwQgT3uYvNGla80XTV5RUaf7ubz21JjqxTuENPwvz4W2H5PorQKRkU3UAjOi2SvaqigNADtrmJahPmZzQwoeb+XMF99zN1DmBhPouPxLz8WKuX9HYIOH2GrQh8FbKsl3gucrhS8U6X3FDOZR/CIArrCEyAUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xPi+62VJK36gSx2wO8HjAynl7TtPz3Hn3y6hunmpO4=;
 b=FtTDhVBVqU6dMXGfe0xfzOiNyY91+SwtxhGNMhcXslUTCF5cA+n1O5fb3my+206nh//Rfjk+o/uf6YeuEXUAzsozSz+p2wIOnpfQCu9nLITPJf2nKkgkNj7U4rZbb5VCtLwVmQD5zBTNyh6p+jR/yVFFK7vC3onqrm3v7E2qQwY=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 19:26:52 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4478.027; Thu, 9 Sep 2021
 19:26:52 +0000
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
 <f54f3fc3-14c3-5c36-2712-62eb625a958b@amd.com>
 <CAMkAt6oG0L4an-VgsADxz1xs6-wq3x4Qpxk9BdP=F2W3uT8U4g@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <7ddc78d4-745d-217e-11f1-77643863e6ee@amd.com>
Date:   Thu, 9 Sep 2021 14:26:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAMkAt6oG0L4an-VgsADxz1xs6-wq3x4Qpxk9BdP=F2W3uT8U4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::10) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.31.95] (165.204.77.1) by SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Thu, 9 Sep 2021 19:26:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0e94c00-63ae-416f-1e64-08d973c7c6cf
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44319320323C4A269EF9B8BAE5D59@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OxRA81P/pxotK/9fjx/dzOAuEwL4RuIem0Gy+aJTlhw/5T65mPRQ+lyP5S2eJgi98h6rPvSN1EiQcqogqN57fUD8ePXaXBHSncF7ZegHu5bQMa4yQ74qvBRLin16IzB3/Om02RvNFF3M4UvlXIatFsWl/Rr70CPInvv9MEWCIHX11CN10wNzJtFGgVBVdavOO0zZcMNYZzgMBKTkvKbGMBbjehhi02Iz0zFlMeXKVywGE7LNRkrt0ViLV/KGsdvTFB4R+BwUL0uEdwXJMwvSwNDUMv9sbs0Uo9O+oi/L8+eAk3s+p0amb2QB3Njp/AEF5XK5NOhxgal6Sg5alt9aIlTJYzGOsjEe7FjptchgrGD3wMdkDEE7k9bpNOIAIaJdv3Pwm1ErrUcbe4Yz8OHEvm0QCDAOmyJmizNLixneg0PUYlsEgYGRzR7sh6XFIqPTs2/MhV3QfUtW64KUygJHHXDkWf9/5pykrbC3V+mxEDijygEquz+e+KjK7LX5lRWIy8Zn3XNuxCCsVfGTjcGEAAFEedUg9462B7pT/HQ+fTWODJVIzrMN7T2P3hHnE/MZf9HNkNyWXE31hrIW1t1t/y/6jcEO3pJmlEC5fUzo7ZbXaEAm3tXaeqrC+SwaCMQstd1v6Jwh31qXFMBDtD1uFHHuWORhFBtbpprMYo2fGYFRKAr6j5V8193Q7Jb6DO5qjZOC5HyKmuexxTR/eS1/hinrBx8D3CK6LTv0lHScZSmSSxP0MNkPiEs9Jc9R3nOL5NA9ZHacT+1dHTI5xs6MH4SYF8Q/QTwqs/W5P8oee2yGc0gKds0UUE+WHpUhCxP0YL3hg4jBvJVd9TAG52CpxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(4326008)(36756003)(31696002)(16576012)(66476007)(83380400001)(86362001)(66556008)(316002)(8676002)(6486002)(44832011)(66946007)(38350700002)(31686004)(2906002)(54906003)(38100700002)(186003)(8936002)(45080400002)(5660300002)(26005)(6916009)(956004)(2616005)(966005)(7406005)(478600001)(7416002)(52116002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lzc5UGRKbXNkcnZGeFVxNjNjRkxhNXNiMDByU2JxNDhvSGVUKzFNdGNWUTU5?=
 =?utf-8?B?dklBVHZucXlSck90SzQ2NjF5ODUrVmUrMS85TTNhWWovSFYzNmUvbHdnWWdG?=
 =?utf-8?B?OUNINUYxanBPSzZWZ2Z3d3Z1MUw1b0NZN3RWc0U3eTVHL1V1UVdDVUlGeDg5?=
 =?utf-8?B?dEhIKzhoMTZIT2hJWEM5Uit5eU90ckxIakEycTJEQi9nUkR2ckdESDR4KzRi?=
 =?utf-8?B?WFZjYnJVZlVCTnI3NCtZZnR1Tko2VHBzTXFTWHc4cGFUNS84TFFySlJXajVC?=
 =?utf-8?B?VG9ZaG5oZGtVMS9xTG1NWUZLcVdOQ3JkRXFmL3Q4L08xS01xcjdRc0xYazJG?=
 =?utf-8?B?VmphbzBMSTJpOVhNQkN4K0RFWDYvczlpU3Y0L2ZrVkxlaUdXT2hYT3dJSUV5?=
 =?utf-8?B?TnVVUVU5elJXdEhrQlBoMmRqL01vMHB4VUQ0WjhUUU0xbmxjZlFaNG45bU54?=
 =?utf-8?B?WGJWcGU3V0RpZk1IcHJ6Z2hMVFNLV2NSVHJjR1FHaW9JMjlUcE94MFg3S1ZZ?=
 =?utf-8?B?Wk43VUJOa2pSKzNKc3plbGRKNkcxM3RoLzVjTXhpY3lDaThqWTZSY2Y1TlhC?=
 =?utf-8?B?bjdpTzNEdXNIR0k3ekhiWnh5N2NDZlF6WU41TjNBMEcvb2lvOUlMZlF3RlJB?=
 =?utf-8?B?MUJ5RXN0bFRpK0trdEJVVlFtTUd3c0RCVmRCc1F5eDBJODZYSTFoblp1bUs4?=
 =?utf-8?B?a29icnZBMnBhQkF2NlpSbkdwMXJuRnJsYnlIL1NKbWJxaEI1U2h2cGRSQlNs?=
 =?utf-8?B?SERjczI1QUVxd0NIZXN0NkxOVVdYNjEyTThVSk9QcThUWkJLcU01NzdtQk9E?=
 =?utf-8?B?U3I2Y0ZYQjZROWovbS96UGMxNVZqRGZ5V2VTT1c5dlorOWNHM2wzMFdqR21E?=
 =?utf-8?B?bktROUVpZFZqekNiUEZDVjBuMmdWbkRnU25sUXE5KyszVnNkSUN2SlRVbnR3?=
 =?utf-8?B?NmZFNjk2NjMvZmczeTQ0MEFhZnVBY1lpOHg4SHBsRVEyQWVsczlTUUxDUlZB?=
 =?utf-8?B?cHVibnRqRXhJSzUxUTdmZUpSNithYnU3MGZVeFh3N3V4MmhZL2FWbXNwMmtp?=
 =?utf-8?B?VGJLN2lISHZCV0xVNlo1T243ZDRLWTdJcUFpNGZEbm5RR3FZZWU3RWhWTHlM?=
 =?utf-8?B?TC9rY2EzOURzeFVxOS9KRzR2SGR2QkY2RzZHaUFhZzJ0aGJyZUVIdXpkelJB?=
 =?utf-8?B?OEJzd0JSZ0RkTmk5c1Z4ZzZ5dUs1QXNWUUdpbDB5bmphSUx1N2VqUTdXaXht?=
 =?utf-8?B?TDRwOFhFczVHU0ZYc1FtcjlJc0JiM29VM2M4RDFrRmlIQjRCMFM4eWZhNWlH?=
 =?utf-8?B?NHlqZExDbHFTcC9CZUxuaFFTbWJCWUN2RUNBTlRFTWZDWm5PdlorT2dmYmln?=
 =?utf-8?B?dlA0SjQxRmJyMGE0aXNyNW9iNjdsK2ZoVW9WMjRSYWx3QytqbGM3RmY5eXA5?=
 =?utf-8?B?N2JQeEVLT0dNdVNUR2ZJWFVsbzUwMFJlcFdCMVp0M0MyWUlRYXFMcU9wWlZ1?=
 =?utf-8?B?WEczeGJVWmcrK054UmllU2wwamdDL1FWWEJGcGU2a3NxYUlSWSswKzQ2MzB1?=
 =?utf-8?B?YXBPcjlMYThSY05pbFhLSFU5Zmx3RDFka1VUblZ1dUoxNmlyZHBzc1dxVldi?=
 =?utf-8?B?TkowYWVYMnd0N2tHMFpYYXhaU0kxNnJiU0xMaldXWGo3emZwbytKcHR5Qnk1?=
 =?utf-8?B?eDZPZzlEaEN4UmtTaUxGRlVHbDB1SnVzYzNYNTZ0VmJzOERidUV1cXU0QWE1?=
 =?utf-8?Q?O/2sxDGr0JBNio7Bzo9HihYuP/G1khHgaTgj9TM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e94c00-63ae-416f-1e64-08d973c7c6cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 19:26:52.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meFqzL+zls7RCZAi32i3VJ1wW/jMTkV7iKeOyxaCTt3wbRx+fi+giHRW4bdvDiw09e1fPrR27QTAICj0mnx5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 9/9/21 11:21 AM, Peter Gonda wrote:
> On Thu, Sep 9, 2021 at 10:17 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>>
>>
>>
>> On 9/9/21 10:43 AM, Peter Gonda wrote:
>> ...
>>
>>>>
>>>> Does this address your concern?
>>>
>>> So the 'snp_msg_seqno()' call in 'enc_payload' will not increment the
>>> counter, its only incremented on 'snp_gen_msg_seqno()'? If thats
>>> correct, that addresses my first concern.
>>>
>>
>> Yes, that is goal.
>>
>>>>>
>>>>
>>>> So far, the only user for the snp_msg_seqno() is the attestation driver.
>>>> And the driver is designed to serialize the vmgexit request and thus we
>>>> should not run into concurrence issue.
>>>
>>> That seems a little dangerous as any module new code or out-of-tree
>>> module could use this function thus revealing this race condition
>>> right? Could we at least have a comment on these functions
>>> (snp_msg_seqno and snp_gen_msg_seqno) noting this?
>>>
>>
>> Yes, if the driver is not performing the serialization then we will get
>> into race condition.
>>
>> One way to avoid this requirement is to do all the crypto inside the
>> snp_issue_guest_request() and eliminate the need to export the
>> snp_msg_seqno().
>>
>> I will add the comment about it in the function.
> 
> Actually I forgot that the sequence number is the only component of
> the AES-GCM IV. Seen in 'enc_payload'. Given the AES-GCM spec requires
> uniqueness of the IV. I think we should try a little harder than a
> comment to guarantee we never expose 2 requests encrypted with the
> same sequence number / IV. It's more than just a DOS against the
> guest's PSP request ability but also could be a guest security issue,
> thoughts?
> 

Ah good point, we should avoid a request with same IV. May be move the 
sequence number increment and save in sevguest drv. Then driver can do 
the sequence get, vmgexit and increment with a protected lock.

thanks

> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fnvlpubs.nist.gov%2Fnistpubs%2FLegacy%2FSP%2Fnistspecialpublication800-38d.pdf&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C46a05f4713834307706608d973ade616%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637668013461202204%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=KCsi5rTQX6L%2BqY07VdBtF8IH0TLNyHn6wTyidgWvXf4%3D&amp;reserved=0
> (Section 8 page 18)
> 
>>
>> thanks
> 
