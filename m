Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696493CA533
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 20:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhGOSRe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 14:17:34 -0400
Received: from mail-bn1nam07on2074.outbound.protection.outlook.com ([40.107.212.74]:4578
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230209AbhGOSRe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 15 Jul 2021 14:17:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVCZut8aRjduI5qVGEq92P8PNx1PpUmi9+ylNR4IqJmC9L2Eh9hT3zqslIl1FboaGkFX9JkDXP8zoroe7ovpl8ckCw5/aOka/I3qJojmp1veXo4Dv0Oi5uYP8/Lc0Czc0HD19HZXFoZc6ZfAsQnn3Vk7DxXszDCOSXLxgwdkl9BP4CkQlpN3+lbDFaon6b6Fhcc5gfaZynQQNViHgv9i7nwKIVGGG2A8Pw95RmUQrQ8rPE9NeAPrmC4ngTpfBU9K7Oug4lmMLkDMbl4JKBAtqdNJh3Ew6Ez1HIvRYeIoTjbQUwHrsxu8oUpw0zfpCiWCMpW3Gca91J9LoW+/zrcvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQMWe5t0oceNmeM3eZ5rYuHx1k5IUgz3utHGID+XNls=;
 b=jQDX7b5zHKgHHkEetgPLkSOO87IENqPkM4XgRHuYUlvktzzDzLGvmQJQPHL4r8TY8n/b7siZZyaWOGa2+FxkseoNRxeaQAoV1ssqBUuyjVJD/OCeesxmQfmk2z2peWJPa0zdu9PcCmQX+uMQawXg7kBmYtU9cBOMuCih0UbTRZhkBiI0RiUdNk2XrRPQuKYQyAXPgGKP8uMxfNeF+Er3XRkEZ23vPq3hOYa0Q4oeRBUJSS6Yo87K6igV4yrfXMNs1qam3HQfsaFb+VVvFS60soc3LghBCej+7VsNFTNu8TxbH5LjIYKlzqwdWNjjZxWok7RO7sfVw8p4oJro3gCT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQMWe5t0oceNmeM3eZ5rYuHx1k5IUgz3utHGID+XNls=;
 b=Z/gMv6RJvEe6SzPA14o7uBUePD80AVfoYj4kJFqrb107XXHGMgtMguzfOrOaAXkbK53+VpMhRKlqnm5tYf6XkopIj+wT8YtZmUXpRUb/5C/lTGFrOs0uIs2KXq1bNIH5NMx7TqBxl398If42wmJ8HLvBO8WVc+HfqcivwEGmW+Y=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2543.namprd12.prod.outlook.com (2603:10b6:802:2a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 18:14:38 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 18:14:37 +0000
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
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <41f83ddf-a8a5-daf3-dc77-15fc164f77c6@amd.com>
Date:   Thu, 15 Jul 2021 13:14:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPB1n0+G+0EoyEvE@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:806:28::32) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA9PR13CA0177.namprd13.prod.outlook.com (2603:10b6:806:28::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend Transport; Thu, 15 Jul 2021 18:14:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 522770d7-e9a0-45d3-c786-08d947bc6813
X-MS-TrafficTypeDiagnostic: SN1PR12MB2543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2543B4C4AEF60D207C686FC4E5129@SN1PR12MB2543.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjG8AcOMTXMwCreu/Se0rzqa/SFXvcHAG3rqQMoUUc6UaTz83S684UKH+mKEvNamfjKsgSZp42wQ35RvVttaRj5x/IQiENShoiS+vr/BdCOKtluXNQZQXxijo1Gx7YuomCJAC8FP7cgUkRqWQxwIiO85feLaKJl4L3dNyR5A7/3SLwEBVfJti2gq/ByPYM9Pcpimri8EVnfpIQY+Zj0zCLrin+s4+nHt07XluzWN27sLMVo3iUYZgawj5Ho03AW5aBc/NNv/kyI6sgXQLg+Q4ghVUcu6Co3Y1y3zk2n+mmVFsl65Uj/2qbh5mRktI7nx2y5VX5KWJ2t5d0gWXQk3N1NkX711UVklscKaAYjcgFXAVy3Gmq+TXLB+EEOFd2PgVVGxS/CTatObLIPY80BVd6WIiIBA0F7KQR13mnxnzrFwBPJDxfd8+Ba96D3QLpJ9OBroXfkXYbHJY5NIFsONeKLzJP7OvnH+NISX/qd18oiMMMYPKWY98rR/hYeJ/UdYw5y2RGsmrBH1+dnAMNtKGBMW+T0+Zi8nzgJiVptFN2bT4f3+6CBVroOLISuPFvm9bjHPfhu/Aqf9QDEehd1wXsMJzMm1SlqZwn9axRwBLR+i1X0eDIEpnFr2CI40kV3TUjGjVrGF68o7ZLrTE54CKtwHp3N4AxLtwdW8obnwjxNKVajjXu2ohLmkvpY11VSHpD9Lr9r956JAZG6X1tkEdF4gPFCpzDhFnjcaoput5zsJ2QIMC9pQNyjYrf+BsO7pnqSdjeAtrulBCJDcRe6oiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(2906002)(7406005)(8936002)(26005)(31686004)(6486002)(44832011)(66556008)(4326008)(66476007)(7416002)(316002)(54906003)(36756003)(16576012)(52116002)(31696002)(478600001)(8676002)(186003)(5660300002)(956004)(66946007)(2616005)(53546011)(83380400001)(38350700002)(6916009)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU9sWUxsblhoR0tITEpEVjNWSzQwOCtNR1FBUGpmSUVEWUZ1azNUUmgxcmhs?=
 =?utf-8?B?TkNUL0kzWGZRNXlJUEoyK2hDZ3psNnplcFhVcEpCYVRpbzk0TFZvZHJwcllX?=
 =?utf-8?B?REhtclY0QXZqMy9PRGJ5YTRVMENRTTQzQldzVEVvYWl1Z3FaS0lBc2pxazBK?=
 =?utf-8?B?RUpqd1Z1TGtxL2hXN3RIMGNhV2JVQk9Jc3owRkhmWDZVVVdFTm1HSDF4R2tO?=
 =?utf-8?B?SStTTER1dUgzN0ZvRFdvV2lROVQyZzdFcVZTVWpKRkYzKzdHQzlRcXM5c0Yv?=
 =?utf-8?B?aS9LS1RUUm5QeFkwWkNwVlJnTUU3eFNqR25WU0x0dyticDZ1YnVZb3BEZFZY?=
 =?utf-8?B?T1BGbi9WY0xreDJsenRKVHBESm9RQnF5NGUvdkthaW5PVzdZdmVyd25qUDJm?=
 =?utf-8?B?Ny9PS3B1dnZyUU9KMGdZRkJMUkZJVElleVprVUFGditXMU9MUkhLaXRRVXgx?=
 =?utf-8?B?RHNiN20yck5ac2FwWmR1OVpJQmFnUm81empwaTNkaHBvcm8vREF4ZU1TRWNC?=
 =?utf-8?B?UU15bnZOZGs1T25vN0VBRi9zYzdSK1krWTVGcmZ0d01UT0RhT2FLc2VHbmt5?=
 =?utf-8?B?RTZHVy8yeEtNL1JMOWdTbWZuT1RrQzBxQmtnY0xYUFlWM0xXbzZBQklqeCtB?=
 =?utf-8?B?R1BWc0VDcWd2eFJJNVdycWV0RDBHUlo4TmY0eE05eUlsbTBZN2lFR2o5VUFF?=
 =?utf-8?B?NzBIWmxOWUp6TkxQajRQT01tSGN1K1dTMTJCZU9kRmx5VUJFS3hYNllob042?=
 =?utf-8?B?WEZKOUFPTlRoV2duRmdBa3p5MGVDbm9KbG9tZGQyRXYyZ1ArYjBNZUtqdkRK?=
 =?utf-8?B?QmdLdmRCTmFvOWF4TGNic2JPeTVQcWprSllWdmk2RmY1U0hOMW1RRys4cmc0?=
 =?utf-8?B?a3BPQUZhRVpnS1lSVG8ydm9CZVJHVCt3ZTFtQ2Y0NTlPV3I0c09uem5UQito?=
 =?utf-8?B?Q01jVDFKdUx4dC82SUxvZlBFcUFCdUJtMjE0aWZnbldDaWowZWJWOFo2bm1n?=
 =?utf-8?B?a2g4TUd6QjRBalBoUWx4KzI4UjI4SmxySjFtZlBzMzdpSE8wVEI0dzdhR0Vi?=
 =?utf-8?B?TmRVOEoxcytmNmlpUk1Cbm5PY1c4N0VabFhzdHovbFBoQmQ5dk4vZUJ1NXpH?=
 =?utf-8?B?TG10QVcvdVNUbzIvbmdCeWpiUWFPUUhiMmVINXVzVTlLK0M2NCtFOWZUODNj?=
 =?utf-8?B?VXRNaXFtZFB1WmFFam0wbnZzMy9wVkpIYlFONUx5ZE03b2tkenVqWHZWZHQz?=
 =?utf-8?B?dkJFT212L3pSbklpb2JCMVphamZqWmorV0ovWTNpZXY1eUdzVnA5WFQ3a2pD?=
 =?utf-8?B?UWhJV1NEWWZ6MXFvTHRoc3llUWNnSUFGRWxhd0FVUFdXNVpkZHdQb29sWUo2?=
 =?utf-8?B?Mm5CQUxydmFCdm94QVZGbmhqc1cwTnFOWTBIbW9CM1IydEhiNkpzdnhhOVFL?=
 =?utf-8?B?UDhNcUlaMi9rL25pRnUwV0FoLzUrN1lsQWw4RHFaK2pidDEvdzRzS3Q3M3Q4?=
 =?utf-8?B?WkZacmkyOUNQeWVkM3R0NjJkZm4ybkxzbW9ZZy85aGpDN254R1p3SjFJNlJF?=
 =?utf-8?B?Mlk1Y0xMV2FMUW12WkM2SWJ4KzRTZHRvVTRvTVZncVFJSU15WlJCZ2liOS9a?=
 =?utf-8?B?bXlMZkZPaDZQYzJCNFZYVFkwbjdUdG9ZbTJzdzBlelZXRW0wZ1pXdDBNU3BO?=
 =?utf-8?B?a1hQYXlHWFh0MlYyU2daKzlZblIzTmJTOWFwZW9NVFplR0k0cmtrb1lMTk96?=
 =?utf-8?Q?5bjFhdxhXpER6RTguStoBbt2XOKMpSXTmfsckwg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522770d7-e9a0-45d3-c786-08d947bc6813
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 18:14:37.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ROH1jlO/eObhp6wu8i3WoBqWx5uwvH75uvmTL6i4mnwU8+5D/me7D2eVD/UfuuRId7Tw8XKzEWcM1FWV6+emA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2543
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/15/21 12:51 PM, Sean Christopherson wrote:
> On Thu, Jul 15, 2021, Brijesh Singh wrote:
>>
>> On 7/14/21 5:25 PM, Sean Christopherson wrote:
>>>> @@ -2375,6 +2375,12 @@ int rmpupdate(struct page *page, struct rmpupdate *val)
>>>>    	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
>>>>    		return -ENXIO;
>>>> +	ret = set_memory_4k((unsigned long)page_to_virt(page), 1);
>>>
>>> IIUC, this shatters the direct map for page that's assigned to an SNP guest, and
>>> the large pages are never recovered?
>>>
>>> I believe a better approach would be to do something similar to memfd_secret[*],
>>> which encountered a similar problem with the direct map.  Instead of forcing the
>>> direct map to be forever 4k, unmap the direct map when making a page guest private,
>>> and restore the direct map when it's made shared (or freed).
>>>
>>> I thought memfd_secret had also solved the problem of restoring large pages in
>>> the direct map, but at a glance I can't tell if that's actually implemented
>>> anywhere.  But, even if it's not currently implemented, I think it makes sense
>>> to mimic the memfd_secret approach so that both features can benefit if large
>>> page preservation/restoration is ever added.
>>>
>>
>> thanks for the memfd_secrets pointer. At the lowest level it shares the
>> same logic to split the physmap. We both end up calling to
>> change_page_attrs_set_clr() which split the page and updates the page
>> table attributes.
>>
>> Given this, I believe in future if the change_page_attrs_set_clr() is
>> enhanced to track the splitting of the pages and restore it later then it
>> should work transparently.
> 
> But something actually needs to initiate the restore.  If the RMPUDATE path just
> force 4k pages then there will never be a restore.  And zapping the direct map
> for private pages is a good thing, e.g. prevents the kernel from reading garbage,
> which IIUC isn't enforced by the RMP?
> 

Yes, something need to initiated the restore. Since the restore support 
is not present today so its difficult to say how it will be look. I am 
thinking that restore thread may use some kind of notifier to check with 
the caller whether its safe to restore the page ranges. In case of the 
SEV-SNP, the SNP registered notifier will reject if the guest is running.

The memfd_secrets uses the set_direct_map_{invalid,default}_noflush() 
and it is designed to remove/add the present bit in the direct map. We 
can't use them, because in our case the page may get accessed by the KVM 
(e.g kvm_guest_write, kvm_guest_map etc).

thanks
