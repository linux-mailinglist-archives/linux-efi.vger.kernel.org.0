Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1AF3D01A7
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhGTRqR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 13:46:17 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:64770
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232712AbhGTRnA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 13:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgXHkWtceAUkaihY2GgB1E9GUY4Ou234TmWL5jyR9MHM9GY135Rzqpz1D4siofn0qBN6Gsaw/tPLhtcTOEjz1m0HeAWT76LK4kKUxauySus28yRGmFVdATbCNSRZ8W+LH8BDVkO1BdRbi/H3OGuAd3pBMaqJaa45+10M6NA248VaO/tmxfQYy7eSoKJTEq4ZjlG5C7BXhGOS0r77KqtidkrQeSzMnZVuANrPejvJ9IM0I1/zcZQqyayMv0zVBmjcIAaF7zKgoZQ77Df6Rc3I7oyRIkKbQk2bR7MWCve6p6V0HUpng7aNzi/b6EeZ+oL4WomgIJyZA6IHDsgR43uClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a0/cKIDyMRzYX5tDAnUYR5KSNbdQ8LxgbQ1puTkxf0=;
 b=V+cdumQqwx+2ioq+f2epiqcf1wbj1Gr+HyOG3ZrA4PVqo1j+IiVRQptHrpIZLMyS5NC64TgiHi6XPPrsfqG9kXAZNAefr04JVNlwUsWTw6iYkBkOgC5NIPyZmb+bBZdyrRS4XQGB2FQqe9LB4tQmA1L7oOjrzpCoiQGU4sAqE+fdWG4R+4X/Opiq9nxHXny0v+p8yZYsskp/Zph2jMmyZrlVv0AmPplIhHLvlsgX2c5gDeUsvMUpTckZCuXPXGN+7p7RBx7ZBhLPWJCs2+SWTsh7qCm9U3o5KP2TocrrEf7b0usqoxocVlAMkgqJN+4NsxRSjJXFZ97t52vKttUTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a0/cKIDyMRzYX5tDAnUYR5KSNbdQ8LxgbQ1puTkxf0=;
 b=Xb1IzUiPyQdV5h9fPXNSFDtmCEcO3j8ZGtq9TSc7Az27doFcqKpmS9S1S4Vh/LZ6WcWISrPiDGCX94auC35BFOfoY92XXQ5M90NJ6HC9atLa3Fm1JiPcyddIoUt7HMn+C66S2nkkhIwKAV5W3Nfn4SW8hY4cdhl6ZbI+T8KsLNw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2768.namprd12.prod.outlook.com (2603:10b6:805:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 18:23:36 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 18:23:36 +0000
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
Subject: Re: [PATCH Part2 RFC v4 25/40] KVM: SVM: Reclaim the guest pages when
 SEV-SNP VM terminates
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-26-brijesh.singh@amd.com> <YPHnb5pW9IoTcwWU@google.com>
 <2711d9f9-21a0-7baa-d0ff-2c0f69ca6949@amd.com> <YPIoaoDCjNVzn2ZM@google.com>
 <e1cc1e21-e7b7-5930-1c01-8f4bb6e43b3a@amd.com> <YPWz6YwjDZcla5/+@google.com>
 <912c929c-06ba-a391-36bb-050384907d81@amd.com> <YPXMas+9O1Y5910b@google.com>
 <96154428-4c18-9e5f-3742-d0446a8d9848@amd.com> <YPb8c5qlZ6JuDR05@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <1e9ea39d-ed68-ad91-63f8-661245b62dfe@amd.com>
Date:   Tue, 20 Jul 2021 13:23:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPb8c5qlZ6JuDR05@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:806:d2::20) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0075.namprd11.prod.outlook.com (2603:10b6:806:d2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend Transport; Tue, 20 Jul 2021 18:23:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54a19ea7-506a-4436-5ae7-08d94bab7ce6
X-MS-TrafficTypeDiagnostic: SN6PR12MB2768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2768E879D8D979825B71501EE5E29@SN6PR12MB2768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiLMB738Lw5cn3x8mXUCMVEmGIhyfkiydVfADvOF2HJfRZtqu8Gk5LP7iQkAPqXzSqdAM3YhW1tKR5RAwq2mdidh/oN5598iFfspJLrIk7yMTV7BRixb2qRhCudTxIdG2B+bnG+8o1u6veS09ts5zsGvKWsprzehqK5ePio7+7XtBFeuZxcCll5JarUkQuvkamQYTXsvNIBNs42tbV7LryG7tFfr8Zjj8wIWt2FMGTV5JapusDJ3A06Aa8T1Z1OxOXMqRY4+n2M+ToJB8hg3q8N876tNu/SZi9Whv0pW02lua/yPB7HyxHZXfrxWoctFnkGb6izH662fIoWlSoU/oWUayHjgwuKdSfdsGJO3wZLE393vMdLQ4ofEBPTTj4Kmwhq069PjzJNDJERPQwg6Zro2w04hTH1Lm0yI0bkrz//bSCryVvo/azPSXigbjImFb+6eVsRNAz+0IoKK03rDf5myshhE82VLCesTohGnEmZ3uP7x8Xt0HIZtYq5EoLe6lWUFWdy8CzsaweTgBJj2PGgrCeJeOjtN/aO73NjuCnKocE7WpxpqR9Fiv0lyNxQkG11UUDLecPuYgOqYIVGftDkNdxcTS5kWAHDHVlVMsQS/WmcGQ0rdqz5P+CDWgTwElUrz9gM1WxPR161U09nygw+AI0MoP1HhlQJ0aQGQtxgGeA5+7Knw3/B4KslG7e3sFK/HMcHhCLHZGJxLjzbha3W519JAsqLYMV2PFaW4/tPW6idOiqHdHtP6fcdFdy4G/e+gvgQSk3K7twxQCNHAxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(2616005)(8936002)(66946007)(83380400001)(53546011)(956004)(5660300002)(26005)(31696002)(4326008)(66556008)(86362001)(2906002)(36756003)(66476007)(52116002)(44832011)(7406005)(16576012)(38350700002)(6916009)(38100700002)(54906003)(8676002)(316002)(31686004)(6486002)(478600001)(7416002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUs3YmtZMWVhTjNVYkVwL0NnMFBSQS9uUWhXOVFaRVFmSEkyRlYzNFE1Rzg5?=
 =?utf-8?B?NVB1dDBMaHR0N3QvL05lZFcxQ2ZyOEloS2RvRWlmU0l6YzE2cHhuU3c5Qjgv?=
 =?utf-8?B?bFN5cUk4R0FNMGw1QkVPTU5JbVpadkN4ZVVuQm9uUnJoYkJFb2hWelZOckZk?=
 =?utf-8?B?eG02azcvRG1VYVIwQXRVdFp4U0ZNMGpTSGtOMUxldWxTUGtoQW1YSXdqQ2dk?=
 =?utf-8?B?U1lrUUMzTWxjbjhuelBQTU1OS01IVWYvS2E3MXRONFZHbXM5dWo5V0lUbnJK?=
 =?utf-8?B?OExyTmloWGR3VlowUTFkd3grc0F0aWhvSU1qRlUxcGpHVHc3SmViU0x5RGkx?=
 =?utf-8?B?d1kxUjdTQ1dMWkNVMDhLRU90d3VxRkljNitkWmk1RXhsM3lXejhxOTdrYTdD?=
 =?utf-8?B?eERnbytWSk9ZWkdhZXgzWmJDd0w1NXZLTkdVdXFFK3ZPZEdEaVArSzVxYzFO?=
 =?utf-8?B?L1VPV2FMdnNOMnlBc3BCM1RxSzgwdjFPb1VKdFhybWNhNTZuaU44eE5rUlBy?=
 =?utf-8?B?SGNqamtDdmY4QnBYV0lBUjZ2RUhseDVqWEdRWWNzbmtwQ3MzSWtjbGxZTFVk?=
 =?utf-8?B?SFlld2MxVGFHK1RsckJ0N29OK0Q5Qk5HU2JObVJ4dGVmbjMrN3JqZ2duelRs?=
 =?utf-8?B?TlJ6OU1DUURybnFaYVB0UzdHU0g3eGgxMGNBZzVrS1B5cXN4ZEpMbndBTkNL?=
 =?utf-8?B?RENxYS9GeWh0NWJpeS8vZlVWUDVyME4zclBlVjBEdVd6TTlGMUxNOUFCZlFw?=
 =?utf-8?B?Y0J1YjR6bUxWVWRycUN5MEZkRCtvMlB1NHY2clBXU1RUWllJanBXS1BvdlFx?=
 =?utf-8?B?c2ZFcWZ6eHV2L3dXNTNjMkYxZ2RCNUtNemRTVGJUWFBtZTJabjdENFZRMHQ2?=
 =?utf-8?B?MmxaeTJxQ0hWaEFKMjBIelZ2cGQ1bkZNM0NhOHoxNGFaNHV1NlNMZHJUSVJU?=
 =?utf-8?B?SElwbGtBbnR5a24vMUl5N3JURFZOWUhUdUo2ZnN3RVIraklaVEFZM01IaTF2?=
 =?utf-8?B?RUpIZjVZNlZ0MUQyNmVYV3ZXZUxJclVXeTVXK0wvNEIrU2I1WHpTL0NwR21B?=
 =?utf-8?B?VkYrRC95TlhlQjFGL3RxQ2c3cVhCVGxXRHNSWEZ5SkE2VjlYeFhvS3kyRDh3?=
 =?utf-8?B?UHFrY25ONTlOSHFBcnFSNDN6Si9VbG5JakQzZUpESnRIZW1MenBsL1RhWUYw?=
 =?utf-8?B?cE50T0RJV0JlaWNBUlN4R2F1dDU5dXdCL05kNWJTSG92aFhjTFNyU1M2ejBv?=
 =?utf-8?B?Vi9HOTBaM3RJMXBwbEtEM3RpN2NVdFAxYjdKZ0MwUDNOdDhPWXBqT2kxUmo5?=
 =?utf-8?B?MVl2aUZwdk5mOEU5MDhWN3BIQlJ6RC9sZjZVdDBwK0VpanA3MTlMdEg5bWJw?=
 =?utf-8?B?QVUwQjJjVk1keDRxTTFSNzdMTjQyNWdTSEEzSWFDQVQyTjA2RWxQQlVadDFp?=
 =?utf-8?B?cDc2eVJIYWk5dW1NYWFHanp3V1JVbXdoOWJQSHlSTjMrTm1pYjBUVUtNZ1Ja?=
 =?utf-8?B?aUJZajlJd3lDOFNXckp2SE1EVmtIRXo2ME1wU0F0c2J3aUxsVW9uRWtqRExq?=
 =?utf-8?B?NlhIaU1OM080Y01nZlVIT2RPaVJIQkxEOUdFY2VHRFhMTGdkaWZUNkNSV2M3?=
 =?utf-8?B?akl1WFFOYzJGVnplNUtkaFdiWGI1QzRxQjQwTkM2UE8wc2l0QlFiam9OTW9V?=
 =?utf-8?B?ZGxhQWtydW9TMkFnS2pyWDlBS1c1aHhvTDNrODdJT2k4ZmlvZlBBcFduU0Jp?=
 =?utf-8?Q?PDAmwWPkBplEAanHhXWvJmE6CTrtUQLbtOx6aqZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a19ea7-506a-4436-5ae7-08d94bab7ce6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 18:23:35.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izex9SjX89OUWCAeXD78qQiGwHH/b8O4uZN2GDI5WsNU1HFkLAA3ICZHMsu5RdRtx7a7/mD6VC+a5N1WJ57Bew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/20/21 11:40 AM, Sean Christopherson wrote:
> On Mon, Jul 19, 2021, Brijesh Singh wrote:
>>
>> On 7/19/21 2:03 PM, Sean Christopherson wrote:
>>> On Mon, Jul 19, 2021, Brijesh Singh wrote:
>>> Ah, not firmwrare, gotcha.  But we can still use a helper, e.g. an inner
>>> double-underscore helper, __rmp_make_private().
>>
>> In that case we are basically passing the all the fields defined in the
>> 'struct rmpupdate' as individual arguments.
> 
> Yes, but (a) not _all_ fields, (b) it would allow hiding "struct rmpupdate", and
> (c) this is much friendlier to readers:
> 
> 	__rmp_make_private(pfn, gpa, PG_LEVEL_4K, svm->asid, true);
> 
> than:
> 
> 	rmpupdate(&rmpupdate);
> 

Ok.

> For the former, I can see in a single line of code that KVM is creating a 4k
> private, immutable guest page.  With the latter, I need to go hunt down all code
> that modifies rmpupdate to understand what the code is doing.
> 
>> How about something like this:
>>
>> * core kernel exports the rmpupdate()
>> * the include/linux/sev.h header file defines the helper functions
>>
>>    int rmp_make_private(u64 pfn, u64 gpa, int psize, int asid)
> 
> I think we'll want s/psize/level, i.e. make it more obvious clear that the input
> is PG_LEVEL_*.
> 

ok, I will stick to x86 PG_LEVEL_*

thanks
