Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED53CAEFB
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 00:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhGOWOf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 18:14:35 -0400
Received: from mail-dm6nam08on2074.outbound.protection.outlook.com ([40.107.102.74]:14689
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229810AbhGOWOe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 15 Jul 2021 18:14:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4d6C+XbGJvru7CBB1nZRH99I79pEZCYZhaADCV6ERCShwXcejqnwTdbs+NbxDcJHLPrktklllstlONuZ0N9HEqWMToaaC9kluxlfTC4nim/l9hnPJeUFTcKGEQ1zlHrQ/aOwWhg9rf4/R4i3Nj68xhqHiPAOFtFq3guzC4cmDwdUxC0LRFHrRrLXpQFDwPmhwyS2WPYZDC5ZS5HYblxTaWo6t7UBodIrw4JW5CaLuw8t5mDVazyUer9wiRumdPsxwK/VuI6GG2Y3wQvdKEcHKPyn6jtqZRFoiZAtsRk0yCGgCheAO8Sy3ijQaJVZApt80tVeRR4APg+FtNPMMdD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIC6BWl/enZU7LXuaeNcAh/DM1YWmSxiBcgxMEsgUik=;
 b=QPwl77Bet8Zmmtx5xcrqjq47hMc6JfI5Ubr6jO4W9fNgt+mlchC7ylO8Z3ftBFKHQKBzReW9Hf11xrbXJxQDGsd7DhpY0n2Lbq8nd/KuAJD9FTWM97MexVhArGJ9oK/nj659QWCWFrVuv+qXeJWuhX40C/+MTERT5HFMl0zENuawCtq1b09qMTubh1bksa3DRR6dZYqVXxmr3GsDRypkjqK1rIWFAf/o6Ts8Yzjt2LSr+bFGA0Y0AnPIHfW2u3b4ZbKzBml9Y/GgS/1ok3T8OCaQGG/k+C5bfSm+Wlz07vo5kI1gSPGKMuPzBPWjUhsBzkzYG79Kwz87KB5vzG+YuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIC6BWl/enZU7LXuaeNcAh/DM1YWmSxiBcgxMEsgUik=;
 b=PLe5ffB6m4kLjGQMqMdmaspx6S1T9kGV9hKepLQOvCmnL1gKb3XvJtngsFWiSO1JEn+7jbXE/HOp8UJUDNgUd9/og3585Gs6fXG04Ter/R4IQKsu9lt69o0RAj1dV/ZSWLYh44MNN6/olOIdS4r/C2+al4n4dGkT0uSjnHQCiaY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 22:11:39 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 22:11:38 +0000
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
Subject: Re: [PATCH Part2 RFC v4 07/40] x86/sev: Split the physmap when adding
 the page in RMP table
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-8-brijesh.singh@amd.com> <YO9kP1v0TAFXISHD@google.com>
 <d486a008-8340-66b0-9667-11c8a50974e4@amd.com> <YPB1n0+G+0EoyEvE@google.com>
 <41f83ddf-a8a5-daf3-dc77-15fc164f77c6@amd.com> <YPCA0A+Z3RKfdsa3@google.com>
 <8da808d6-162f-bbaf-fa15-683f8636694f@amd.com> <YPCwPd2OzbBPs9DH@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c4b137b5-76f7-fe92-cfe0-d0f7ec72cc36@amd.com>
Date:   Thu, 15 Jul 2021 17:11:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YPCwPd2OzbBPs9DH@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA9PR11CA0024.namprd11.prod.outlook.com (2603:10b6:806:6e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 22:11:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6b8b9d0-0992-4a52-414a-08d947dd8467
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45097C3B2C0CD71D1277D077E5129@SA0PR12MB4509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojdRwIlw1nHJ+D3doQDLUbq9HvhOvPjAWd7MJjChX0jq9E/pVnACNerxfb2LU9KW7sVZJ7mbwI8wLSJOjWUNAjEQadDlBGvB2zycloxkzG5pk9hzwGQmwUJIgtt8i2X0/PlvXFOwrWRvXEUjB24QEhZTlcTtJXmIDRAfJHviydVmyhDI2Opp+9TM82/+kbeinKdxvgyRelCcZdwcBcMlt6F/4EkRO3fUkT6LKXyedQ43/TQGCXTU4ST2tRg2mzspX7wb+XTzhJoyTHWqGq73/zkCE3ZCilcT8rJj9c4zloWXWLOjOBz1apRa7EDW1atwsPALItFJNWos+U2lE2o3A6teDXwW+m7jT9KFOSPS+RgW1G10+RZqn7B84zhJTvr0HSjy7X20MuYNWk9tjfSVL2lcDG2p2VGHekAdzk4BEjYlKsLCxhS4bABusJ3sHDDbtlAs4qatfvlPEh+WIXZDGii2iXuKF20wrGCs9kIUhgP+yJk2VeI0x1J8asEkkw/graF/Z+5EnEJEgFJ4UqhgjgDA1f3uPrrZyDsyWgz0fasbv1GfUJCJqvIliPoPlAUf3WTGPpLOLawogtNHqOfvgqvmmtQJgczgdWwYszoE4giMePE0Bs93yzFSzEcUcYxKnLpjXsLFbANlyuQ10vf6PeXCVemEtOqiSsuU2K0H2xGsTqcDn9W8ggtGpyYCBZJCyeNf8ENVoejKNS9dxf2zFs6QCCbIudogUyz4l38ms2xyAQ0SbsBZkWOzlt4dAdBlyGRjTOjXyXfmUVur7T2org==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(186003)(6916009)(478600001)(31696002)(6486002)(8936002)(6512007)(83380400001)(31686004)(5660300002)(66476007)(66556008)(8676002)(66946007)(956004)(52116002)(44832011)(4326008)(2616005)(86362001)(2906002)(38350700002)(316002)(36756003)(38100700002)(53546011)(7406005)(7416002)(54906003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3E2ek8zNU1aYzFQdXFRSHFlbFFSRFE5NWxaSXBiQzVmdEd0dGtWM29tbEZJ?=
 =?utf-8?B?NkdORXdqL1E1M1ZQTFRyaS9ZNHY2UVdzOU5wSWdmTjZOcDM1dHlwbCsrNHR5?=
 =?utf-8?B?d0hLY0wyTlowajVqNHdOc0JtSVZ6RWdVZmN6SHFLS0pnUnExQmFETGMzN1Fh?=
 =?utf-8?B?QVYveWRoYTFvOVhFcEkrc2FXejdkcm9WeG0rL1E5RUFyRHc2b25ibGU5TVhr?=
 =?utf-8?B?Mi80SllBUTBGNnExZTQ0YTB6azM4cC9GeG9NaG54Sm5GcHY0d015NnpZTXpF?=
 =?utf-8?B?b0FCNUxRN2ZQT0dWQ0VoYVBHbjFaWHNKZnpVTXY2ek42VXFmWTBrQjUxd3dY?=
 =?utf-8?B?bUlEdklOUERCRkJ3VTdsUjl3TFlZczU3amxkU0U4ZXhLWTNaV2U3cU5Wbm1K?=
 =?utf-8?B?OXpVeTAwbXk3ZW1YSEE5UUc0ajd2dHBkc08wTTVrY3BwU0VuN1o1aDQxRmw5?=
 =?utf-8?B?WTJEZUNrZEJ6SnJnb3NMUzNLZUhtM3U1N1V2RzQyeFJHV0NtRy9iSHhUa05o?=
 =?utf-8?B?NHAwV3o4SW9DcDN4emJmemJ4N3dzdUhsYVBDdFBvMDJtRTdTeEZ6VlJBREZr?=
 =?utf-8?B?R2ZDSUFTa0F3bGM2ZnhjalFRdGZoTVloQ3ZCQ1J3bzdZSWZ1Qy91d2ZpUFU5?=
 =?utf-8?B?S2dDOWpzV1VaNWtEQm9oNFhIOWRlaE9RUm9HaHQ0Rmx3Mi9qRTJ3SUU5MEx6?=
 =?utf-8?B?bHMrNFVubENUUWlNYVRsK200bzAvWG11bGNFYW9yOGVYTzJYb2NudWRoQUlR?=
 =?utf-8?B?eFpLczZ4cVExYkFLaDkyUXNiWmRaa3FkcXY0empTR0pLbHdBQlJCNDBVcjQw?=
 =?utf-8?B?dktVNnVwaFo0aFdiRkp0OGQveUNQWFJaV3dmNXlKb1lBL3pwejZQa0JqVllv?=
 =?utf-8?B?L2lqZnhaUnF0MzdZdVRRS3Qzd2dGbUdtSjdxVTluZ0VPbmZaQkN4R1RpWEw4?=
 =?utf-8?B?UFJidE5OWm1jN0lhTWNoZVRYeGdzYjZXVURmVlhFMDE1OEkxTWZDTWQzRS9E?=
 =?utf-8?B?aVF2aUtHakkzc0lHZHZKQ2ExZHY3alp3eWFheHptSERoUnMwbTg5WUQ3YVlI?=
 =?utf-8?B?Yko1UTNXbUYrMC9DaXRlTUZ4Nzc4OUlDYnhtNy9Hc1pxK0pEQlJTK2RSN0I0?=
 =?utf-8?B?c29jU3FXcU03dWk2b1RoNS9sMmVSVlFkUjRSbC9uakhRY1o0MnFWRUZLQkJ1?=
 =?utf-8?B?U2RrUnh2c1RSa3ZZMlYwd1BRVW5pZXROc3EyM0xnenBNTnBtR0FTclV3a0hS?=
 =?utf-8?B?RkpHU0srUHBYNC95QmhSMldDcWNYS2thVnhiNVY1a3FtVmhRL1YwcUtPSVpi?=
 =?utf-8?B?K0h6NjR5MmFEUW5pWHVQQVZMNFl5S3BnUll3VlFFcjNzL1Q0VkNXcEZaZVJs?=
 =?utf-8?B?TXpZUDZndXd1Q1JMRVJqWURiOEM1a0pkQzVxR3FLMWxGcngxL2k1ajVNVGdu?=
 =?utf-8?B?NmFuMmlaakxja3pvM0hUN3ZVUU9vM2FHdTA5a1EvQ3lmeUp0cVhjbStydlRS?=
 =?utf-8?B?WFBpYkJWa1p4RmhqVTJZSThHa1dLemtNRjJkOGcyWnJHdklaT1hKUEpkR21k?=
 =?utf-8?B?d24xenJGOXlHWm9mcVVqZXdNMDZZdzNMUGhDaFZ5SlhqOGdNbEloMktDbzBJ?=
 =?utf-8?B?ZWtpZmJjQnRxbFU3SkJrbmg1S0ZjOGhNbGpCSlhUak1WRDVydWhQd2I5YWhY?=
 =?utf-8?B?UURScWM0bWpRUE9BV1VFUzRqVS9ZV3FmQTVMUWs1cjh4QVhuNnhzZDRTZFVu?=
 =?utf-8?Q?5pzco1cHH075DTBBBsmAw2FzvV79rs4PWRZ1bD/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b8b9d0-0992-4a52-414a-08d947dd8467
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 22:11:38.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9NqgOTaRNnP+l2pfq4MCA5QIF242wJoji2aHrtxeGmIFxtr3bE2LjMyJK2MA5v8OygiueAJ0T+oP4gT2kxBiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/15/21 5:01 PM, Sean Christopherson wrote:
> On Thu, Jul 15, 2021, Brijesh Singh wrote:
>>
>> On 7/15/21 1:39 PM, Sean Christopherson wrote:
>>> On Thu, Jul 15, 2021, Brijesh Singh wrote:
>>>> The memfd_secrets uses the set_direct_map_{invalid,default}_noflush() and it
>>>> is designed to remove/add the present bit in the direct map. We can't use
>>>> them, because in our case the page may get accessed by the KVM (e.g
>>>> kvm_guest_write, kvm_guest_map etc).
>>> But KVM should never access a guest private page, i.e. the direct map should
>>> always be restored to PRESENT before KVM attempts to access the page.
>>>
>> Yes, KVM should *never* access the guest private pages. So, we could
>> potentially enhance the RMPUPDATE() to check for the assigned and act
>> accordingly.
>>
>> Are you thinking something along the line of this:
>>
>> int rmpupdate(struct page *page, struct rmpupdate *val)
>> {
>> 	...
>> 	
>> 	/*
>> 	 * If page is getting assigned in the RMP entry then unmap
>> 	 * it from the direct map before its added in the RMP table.
>> 	 */
>> 	if (val.assigned)
>> 		set_direct_map_invalid_noflush(page_to_virt(page), 1);
>>
>> 	...
>>
>> 	/*
>> 	 * If the page is getting unassigned then restore the mapping
>> 	 * in the direct map after its removed from the RMP table.
>> 	 */
>> 	if (!val.assigned)
>> 		set_direct_map_default_noflush(page_to_virt(page), 1);
>> 	
>> 	...
>> }
> Yep.
>
> However, looking at the KVM usage, rmpupdate() appears to be broken.  When
> handling a page state change, the guest can specify a 2mb page.  In that case,
> rmpupdate() will be called once for a 2mb page, but this flow assumes a single
> 4kb page.  The current code works because set_memory_4k() will cause the entire
> 2mb page to be shattered, but it's technically wrong and switching to the above
> would cause problems.


Yep, this was just an example to make sure I am able to follow you
correctly. In the actual patch I am going to read the pagesize from the
RMPUPDATE structure and  calculated npages for the
set_direct_map_default(...). As you said it was not needed in the case
of set_memory_4k() because the function force splits the large page.
Whereas with set_direct_map_default(), it first checks whether the split
is required, if not, then skip and update the attributes.

-Brijesh

