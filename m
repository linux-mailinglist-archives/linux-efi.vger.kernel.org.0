Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0FF4536B3
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 17:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbhKPQGW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 11:06:22 -0500
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:46113
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238744AbhKPQGN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Nov 2021 11:06:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRS8o4socwULaGDwxo7eba262gGj0PPC3S5X75+smG0m8TZSkuTCmgea/Ggw0xUJ339MdIskMHEnadCJO08e1ZFpIkUnXAWdU4SYWvTksRcWaOunyqX0/0mpcQyNxY/JB2+4ZaWCrkXlxIo3K7mPXoqbPkuAtHR1l5dVbaV9yI4rLJ1/D6Dv8IXal+P39pWLBHJDxh5sCcIWA8jAIvcqm2A0HRuB17QX0S3KNM8t13w+P6KOyZVXX3mfVmkW0WfARecHp4da0gtEFuAxriuUYehR3iNZSkmJQ1mcglBNBH3gTtsNxv+0AALQ/+e1S4cQQJhaPwEXmhOQb/VBhL9K7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xog9J4J97BAFZGoYcavuLSQBCDG7n1ieGmduIflrE8=;
 b=UcalXS7FCw3a+08QkC4Z6UxGQVstDOfm6ZDts30TE0TDLKezH39YrZTeZ+dwSci3NT1I7mxJR6TMTMHsaCmOBOdJtmSAPGsYcGNjK2l28OmsQJH5D8+aOlvezQ4kOAo1AxB4rA4KCroTLVct0CYYMoStGSB+rBxTTnyGyqQ9/YgJkPZpheLlpwE2yoKLJJWknoEPt9sHUvEQVend66OlGlGIfwP/6lGgn0+eQzkuBVWs8d92M1Z0cRgcW3xU7DPd1mQkoLGc9R4Mu2CW22l7dxijwtmrv+BMvr84iwhNs8B8IHbgKbMsLXDChua3JyeJ+6a1WPEkS7/iUaVHJQPwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xog9J4J97BAFZGoYcavuLSQBCDG7n1ieGmduIflrE8=;
 b=dntmcj2uvdxAWw9oWxDCJifUbJBo6Htemi0/8WXzwulptmAKuGihJoFQ75WPaAatfQw7WoiO7Uj5IP/WkYbio6KMsP7y27c3TLArVgZ0zfiBwbXehXJ+iHpG068dvOP5QWkrpX3mwYFq7TDMS66+gPCGIEP3U+EgVB9APlaZ0mE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 16:03:13 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 16:03:13 +0000
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 00/45] Add AMD Secure Nested Paging (SEV-SNP) Guest
 Support
To:     Venu Busireddy <venu.busireddy@oracle.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <YZKDGKOgHKNWq8s2@dt> <a631d02a-c99e-a0d6-444a-3574609c7a25@amd.com>
 <YZKMvjEIGarn8RrR@dt> <88aa149c-5fbe-b5c4-5979-6b01d4e79bee@amd.com>
 <YZKRBOl9UkTJE4jx@dt> <YZPSN1Ctl6H8lxsR@dt>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3ab027b9-9a9a-119d-7fc2-3551bffe6811@amd.com>
Date:   Tue, 16 Nov 2021 10:03:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YZPSN1Ctl6H8lxsR@dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::29) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by MN2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:208:1b4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 16:03:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e0b3b73-d29a-4211-6475-08d9a91a9828
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26865AB344DD4EEF162790F6E5999@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CK8lbtlSRJ36AHceN8rNM6UCOMOcGf6fN28916snJrK6Y7KgqxdCraRL1bzpjb9D+gxrI18zqdqKeTMfEFAKksAqTDiglb0lniySdhMllWQdzRtmdIW2ZNWeHn/wi4VaMBRHcSw5QiL7rcqmjzOkaXUmiEZ2x0byAIDNoPbRZ+KNvh5oBoS5SvSVWGp6xU1ThEORTO1PPWh5GnXJDWkL/jrKEI56mxZ06UUNuiIM6lzfK9UEK47KJNv3/yU85VRxl+moiWWQ91jPybHZUMHefLimFPeQ8jjoECtdqyqhB/NVWOcyxT+ZssCzuwsfh50ljxIxZivzIvYWDt8ZieD1C107ioWi2hDP+9eQBerylCDBZ04F66LKKl6hcQPjFhwC8NVirzdP56H++d53f6W080aSOusqKIteAGFb2MSU1ISSMF1BejCNJJ1RquqEd4BD5ALJxAiOZ6LLmPHvCxKBtekDw4hkeVYg34CorRCoafNbk1UgLIHM+bkp08aK1c/+xNidLZOj2vlV419cY+p9Lk+uUVOAns1LcWA1ZwbqJYjWowDABpjmBLA9Cb42p80vH4QK04w+zZqYq9TtsKXkKZ0OosynRtWtNwpDO5SBjETPkbB73bF4Zpf3hbl3rQ3ZjgDgesXNMXLNaLK7f3k6oLZYQh3S6G0N3Zq9qIwbLzpcHRaUxiSM7E6KXIhpfsKETMxWg9b5L7F323DvVih3uj4TKJUkqZz7SYz2daIVhTkhnc8VJBErah39MBeKYWgxj/SkWmxP7eCr4Ji4Ko7xGRkI3S8groiNhEzgcpv3E7c2TMYmxqb6w7H/y+DqI/SXrafqa1gp1BV/neQ7wEPRTBG7kmNKCiQV1w593PerZQ9tx30c2TS2hesW88sVAC/v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66556008)(66476007)(66946007)(8676002)(2906002)(5660300002)(45080400002)(966005)(44832011)(16576012)(4001150100001)(2616005)(956004)(31686004)(38100700002)(508600001)(8936002)(316002)(6486002)(186003)(54906003)(7406005)(7416002)(83380400001)(6916009)(26005)(53546011)(4326008)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU0ydE1pV3N1Z3hDY1JHZWYyMDRrUHFHLzh0UzVhdTdLaUJPb0xMQ3NDTU5t?=
 =?utf-8?B?TGFiekZvb2ZqaGRIRjA1QlowdXloUmp2Mjl0bytSUTRNOVpTbVJXd3ZDK3BO?=
 =?utf-8?B?RGpXczk0MGZNa3I0dGllV2tyakJrMnc4RXBMb1orN3VXbVl3SWlMTjk0aTdI?=
 =?utf-8?B?ZDdwd2UzTk52MnBISlZ3SG94TjA4VGF2eTJZUEFUdUJLeS9Da0pGZyt0QVZj?=
 =?utf-8?B?aDJnUGc3aDRjZk9uaWpxVEJxTWlmMmp1RWpySzdNREpxNGt3dm50cW1BZ3FY?=
 =?utf-8?B?bHpIL3hpKzZZN2M5ZUFSQ3hVY1ZaeXAxZW9ReEhpVFEva3hxaTVIYURKZ3Vu?=
 =?utf-8?B?akV3LzlweFMwbFJDUWFmckVQcU9meFpOTHVQQ3RzWFR5SmE3RXhOVS94aEs1?=
 =?utf-8?B?dVVIUi9Qb042U2JmTXFWdHM0YWF6SmtpWXNieFNwamlNWUVsMlllaUxrTUx4?=
 =?utf-8?B?akNBa2xFNVo3NER2U09OSTF2ZS9ZR3N0aUxaMXpyaTRqd081V0hSWUx0cUNN?=
 =?utf-8?B?QVJlUHZORjRrRlZBYU5UbDQwcUVVRUkzbHlnbUpBN2QvNWtGdWo3NVlzL0hl?=
 =?utf-8?B?UHRvdkUxVkllUnZIN3RabDNPU2hMckRwRWVrd1BMQmZ2b2Jsdk04RHNxck1E?=
 =?utf-8?B?eDNoOTlVUGpFTGlaM1dBSmdBd2ZReDVQZEo1U0NxODN5UnJGb25VemhsdlNi?=
 =?utf-8?B?UHNVVU91c0VSZjloYjVuekN5eXlqUnFGUmpPaXRCODlvWE1kTnQ3cExmcE5n?=
 =?utf-8?B?aStIblNEc240QlN1NDlvWTh1cG91VG54TFpBbTVHWm9YOWF5eHlKRHNtZWdV?=
 =?utf-8?B?Uno0Mkt6OVpCdHl3Sjd6eit3NzRMNGNORE8vQVkybmFuTmJkNytJaGdjaU9a?=
 =?utf-8?B?VEkzQ2Rjbmp2TjR6SVl0ZFVHbUpwL0trTXd2NlpIYStWSTI3N0tXVEZzSUI5?=
 =?utf-8?B?WkVvNjRqdlFKK0NYWlVzUEhqUkFQZ1cycWx6NlY2bFE4Ti9XZWVQVE55a2k0?=
 =?utf-8?B?NlR5VFRaZm9TVExnWWlZU2J6R1ppcVZiWWhLWFhaS05rdWlzR2JVZGEvUUZM?=
 =?utf-8?B?NTFYdkJsL01WTXUrZHdCenRxQytRa3FaV25SbkpVRm1GMlpWK3VySGJnY09B?=
 =?utf-8?B?TDJYVWRMNDJzU1kyYnBXd05mbVU5SDZIakV1NjlBZ2x4L3hhZGRzOGZJMUVE?=
 =?utf-8?B?ZzNRMGhtY3lSSzBoOG8wZ3E2VFlXOEJpNGMzckxJZjdSQlhFb2dXYityZXFJ?=
 =?utf-8?B?VkIwRjI2SUJBeVhjQzhPbUU2Vm4rZmtJblAyNTRYNC94aThXQXQwWVVHZTVS?=
 =?utf-8?B?OHlTM21ma0tCRnhZYzYyODV1ZG5ZZzNWQ1IvK3FjYmNTV1ZEUHVTU05JcmhI?=
 =?utf-8?B?MEFyc3ZkamdOakpVa0ZwUkZBRXgxejlnN08vd3paY2NFTElZZi84djZMQ0pJ?=
 =?utf-8?B?a1pCZVRZVi9BUWdSUVNocDZLWWVKZGJsMkUwcmdMQVpuVXF2RUh3K2dld0U4?=
 =?utf-8?B?M2dGVEtaMGlwbEROaFBnMGo1WGZ1K0RFaWQ0bkh4NmZOR2J3QXl5ZGpjenY2?=
 =?utf-8?B?dDdrY2tTSWlKTllKYzR3YTYzdXg2OFg3RTN5d0FFcVY0emQ1VzJvMWdWNlVM?=
 =?utf-8?B?WHFiSE4vakM3YVNQckx4amZtQytuT0hCYmNleUUrZWdZRjFaaGpQMjBTTWFx?=
 =?utf-8?B?R20ySUlId0E2anRVSlBFSHNLQnJmT0FsYkxlNERmSDF2Nm9tTCtkbm9uUmRX?=
 =?utf-8?B?ZERsWmx3bFkvVXVtMGNMZTIxaDJMbGpkeUM1SDUzTElzNWZSODRiaEx3ckNT?=
 =?utf-8?B?ZlFWUkJOZFkzT1V4YmFweFdHOGZxcC9rTkdSbStBMWhNTFdZaWExUExweXh5?=
 =?utf-8?B?KytpVjRLMjQwekpLYXVFL1RSUC8yRGYvd0tjR3dSRUsrS2hJRGNZZi8zQlk2?=
 =?utf-8?B?d1BMbGFpMDZYMnRhcnUxbUJXZzA4MHJ0amVHNlJTN3ZsTHBISDhqdGd1cnFN?=
 =?utf-8?B?KzFXcUtVaUZLdTRPOUtWcjg3Y29SUXFld2R4eHkzRGF4NVprODh3TmlxZll2?=
 =?utf-8?B?RGJzQlg4L1RJMnBBeTMybDJQWjNEMkdlWXlQMTNiWnlNeUs5Q2xQUjQ1TjUr?=
 =?utf-8?B?NDM5VmVhNEcvb09zZHJtVFJHRDM4NHhSUDRrVlVvYnRMVlU3Mmw4Y1FlWlI3?=
 =?utf-8?Q?cu/QMLNIAdRAWH9T0dmWmPs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0b3b73-d29a-4211-6475-08d9a91a9828
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 16:03:13.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Sbvz33co2UfBb6izIgQFYfVYyLLJPk9/RqHMCNtVMquOBcNUsrGA0qIzWMadpL8hWTqNwZMpMp0B81X/y2ioQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/16/21 9:45 AM, Venu Busireddy wrote:
> On 2021-11-15 10:55:32 -0600, Venu Busireddy wrote:
>> On 2021-11-15 10:45:48 -0600, Brijesh Singh wrote:
>>>
>>>
>>> On 11/15/21 10:37 AM, Venu Busireddy wrote:
>>>> On 2021-11-15 10:02:24 -0600, Brijesh Singh wrote:
>>>>>
>>>>>
>>>>> On 11/15/21 9:56 AM, Venu Busireddy wrote:
>>>>> ...
>>>>>
>>>>>>> The series is based on tip/master
>>>>>>>      ea79c24a30aa (origin/master, origin/HEAD, master) Merge branch 'timers/urgent'
>>>>>>
>>>>>> I am looking at
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C527b875208904981677108d9a9183dba%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637726744508270539%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=hfqoF4d95hWAY8%2BKW4t5UyrWIPAUuHOTvzTQGXyxQik%3D&amp;reserved=0,
>>>>>> and I cannot find the commit ea79c24a30aa there. Am I looking at the
>>>>>> wrong tree?
>>>>>>
>>>>>
>>>>> Yes.
>>>>>
>>>>> You should use the tip [1] tree .
>>>>>
>>>>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git%2F&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C527b875208904981677108d9a9183dba%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637726744508270539%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=TDbL2dnzCp%2FlFHv6Tr%2Fn6QhFKL2kL3DFWj5BT6Abcms%3D&amp;reserved=0
>>>>
>>>> Same problem with tip.git too.
>>>>
>>>> bash-4.2$ git remote -v
>>>> origin  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C527b875208904981677108d9a9183dba%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637726744508270539%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=0qPjqphHSBSnpxOrPGDyJ7BF5O3fnTJtXQgnO0ZwCXY%3D&amp;reserved=0 (fetch)
>>>> origin  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C527b875208904981677108d9a9183dba%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637726744508270539%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=0qPjqphHSBSnpxOrPGDyJ7BF5O3fnTJtXQgnO0ZwCXY%3D&amp;reserved=0 (push)
>>>> bash-4.2$ git branch
>>>> * master
>>>> bash-4.2$ git log --oneline | grep ea79c24a30aa
>>>> bash-4.2$
>>>>
>>>> Still missing something?
>>>>
>>>
>>> I can see the base commit on my local clone and also on web interface
>>
>> But can you see the commit ea79c24a30aa if you clone
>> git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git?
>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git%2Fcommit%2F%3Fid%3Dea79c24a30aa27ccc4aac26be33f8b73f3f1f59c&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C527b875208904981677108d9a9183dba%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637726744508270539%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=mG4i3ZNHgyrS3Xkdxw%2BhkmfxvzFkS%2FpX0B3xHlxN0Nc%3D&amp;reserved=0
>>
>> The web interface has the weird warning "Notice: this object is not
>> reachable from any branch." Don't know what to make of that.
> 
> Just wanted to clarify. I am not interested in the commit ea79c24a30aa
> per se. I am trying to apply this patch series to a local copy of the
> tip. I tried applying to the top of the tree, and that failed. I tried
> to apply on top of commit ca7752caeaa7 (which appeared to be the closest
> commit to your description), and that also failed. I just need a commit
> on which I can successfully apply this series.
> 

At the time I pulled the tip, the said commit was valid and my entire 
series was generated against it. Its possible that commit is no longer 
valid in the recent tip (maybe due to force push). You can grab a 
staging tree from here https://github.com/AMDESE/linux/tree/snp-part1-v7.


> Thanks,
> 
> Venu
> 
>>
>> Venu
>>
>>>
>>> thanks
