Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B803C1758
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jul 2021 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGHQvO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jul 2021 12:51:14 -0400
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:60512
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229489AbhGHQvO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 8 Jul 2021 12:51:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7f4AqckEAJqlKLe2m0BW2HXJlQVVp5Z0BSP5ZpUbb2TwvyGYkdt4KZJuAVH28TI6gMbu4gOcGoGLU6OKorCiqB8JGjxAgvOzN19M9BvW+pxKf+uNwq7hZnW5jHkJEa0FChj+kLtgiupTGJ+ZFgsfS7qVDPmEo3Yf/UM5/42GC3jukk7ZNMeJ8clWJtIdDNuFu7Zhu7Y6r8wzMoaf8inn/lxhKMHw8MY08146KXqX1kXWQ/mQPn4Z8+FM5V7OIVD2NVGHPVWvSz58ZmwneFyi63Fl7yfp4bEJMLGQzoHAV3TwevCQ6rhpnWOqD4tUiwgcHBRea5+FSJJDSMCWMTKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbBUSi4OXTUy4EV4/gnkSO6e39eYO1YxtH3Vl4K8tAE=;
 b=JM/gVrFE8CEEUpWwAIK0A6f8xU9NfGvLw3qJkGnMzIZGHThjmhB7FyrDHeijI6804jyxuf4FHON8LybGqWTh8qpTp9zBGUISfduKIRI35Q58PXzXrOLXTIaJKKbBx7s7VITwgtDt8K6w+SK7YIvmRAMOVfrS0E1dAYptA19Lc+Q7t/FCA6tMd6khGJtJPcM1O9VNpRgBGVx3mKgP9SI3cY41uxf5p38vDqujIYCT/AkYllG5e7bEuM4nrLq658SLg1Zhi8zHziWDFWt7brxHmd8km01EYjnIPco3d093YQEyG0nk9Xm+fCWkk6LDxa6nDQGdL2Lg5/Zt9fPQ+htJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbBUSi4OXTUy4EV4/gnkSO6e39eYO1YxtH3Vl4K8tAE=;
 b=idAgOskwQlgZvAnyMQNecKXQkffJNwhZxfoYSg4ggjnTtsGt+0P5ieZl6o+L5IQSXrnFv3TQhCIDB4NZd4+ippJxaxzytkT4BglUXPqqrFF1gK2DdhQt2ExKqneVxcuiXSuAK/5ZmK7LTlpkQCJWX7VgGuGQhtWSj4YSU6UIVlg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.32; Thu, 8 Jul
 2021 16:48:29 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.022; Thu, 8 Jul 2021
 16:48:28 +0000
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
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <23dbe0da-581e-2444-7126-428e79514614@amd.com>
Date:   Thu, 8 Jul 2021 11:48:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <15d5e954-0383-fe0e-e8c1-3e9f8b0ef8ff@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:806:28::27) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA9PR13CA0172.namprd13.prod.outlook.com (2603:10b6:806:28::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.10 via Frontend Transport; Thu, 8 Jul 2021 16:48:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81da37be-97e8-4ec8-1ff8-08d942303641
X-MS-TrafficTypeDiagnostic: SN6PR12MB2782:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB278260326E34F4CBFD863FD2E5199@SN6PR12MB2782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xm3HOtPGAe95m3V5Q9Xhcnd+ZuNN/3t189W9v7KaE5W1Pw8oN2yhBjfON4zP00YYMSXWxHm7eM9sQqhO3ajpAGh8tTS7pQmRb9DZwMCx4qmCx115B8Wuya8Vn5N7xachfdej60jhp+xWmXvSS9FnSURfhJCwO+enqoqTZpB8RlZ8ehB1059HKyVKqVKXWeQnHLqPw7CzuhcNqv/mCX9EfWs0OUvdo2gxiDEEIunmzlmlGumAaxfJubcdfm/JE+8spkJwyu4Q8QV7hwxVxBBziWQKm9hJg1tfxK+ycNVC1rMVjV05Xf9iS0958StoCmI0Ko6H0r9kXBdnNR+kdYtnC0K78IJR7TFJI9nolXlmP5oGo93mfEFUNpICk6BLyege5vjcCQGaNDiaqnleu79escaYFgM0TEEARRSUjjp7LXLghnyt2bXkx2StdSHMfaNRVMqnDKKRhfqmOD9drh8KKAGmKV8gt0Ine9IjGNyjEMKWaQwogSke6xB3RVuZYz4LnJ+Qu9yl/RjlNOQZIo6NjLQK7OuBMLJmXgXjH7R1uSibzClUY9Q840h3DE9TnbL9+dcdNdZk01Qnuy1x/HTo6BjSUe7v9TdIEAJOGmnW3JWXP/1pEqOz3Bl8XQl+F06X7+Ok9VX5rGCgE2zm3RJmNkl8pYmsC1+DoIOGANgyim6O6oIBN/XtHJrGVqMg58DgkOslGUGLmhPDUUDdYF/lV502KEwBxVXvBk0yf7I/MJq3wPqq1VpoZxGosG98aQGv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(31696002)(186003)(38100700002)(6486002)(66556008)(38350700002)(7416002)(66946007)(66476007)(316002)(5660300002)(956004)(7406005)(86362001)(16576012)(478600001)(44832011)(54906003)(2616005)(2906002)(8936002)(83380400001)(31686004)(8676002)(4326008)(36756003)(53546011)(52116002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEg4anhIekU3TjFGWnhMUEgyTjg5blh3UFhhekpXdGpaNGtFemhnUmcrdFo3?=
 =?utf-8?B?THQrV0xiYm03c1JKVnRudzZZUnZ6RVNvd0pTeG1iVmdOZEtVbXVhN2FYMlc1?=
 =?utf-8?B?RW9UOVdncUJUaS9mRkRVY2JMckdxNGUzamZVY0NjQjN5Z05wN1JHSCttRzRJ?=
 =?utf-8?B?NHBBaDZ5a09IQVI2TkIwaEpGNGxMREw5dVR3QWZVMGxvMXZib3E0TzZLNDN6?=
 =?utf-8?B?T3ZoUUVQcDRNZWEyUEVjeEROdTdrdC9Pd0R0eUJHdWo2OFRGNjgwSVRnd0FU?=
 =?utf-8?B?bzBSdzZURDBDRWNwY2l1UWhXQTNaUGI0N2JyYVJic2ZxUlIxeXZIRFZtaFJZ?=
 =?utf-8?B?elBOMEpaaDhPdVdpTHdZSFVyK1g2TCthSkRGOVd4azdqWFEwRU5hdlZZOExZ?=
 =?utf-8?B?Nlg0UkdkZWkzZW83a3VHUUs5aEhSYytDUGpHMWpLNWIvWW1sakNpTGM3Qk5X?=
 =?utf-8?B?V3lTZUJPV2k4ck9QQU1wNjloeGRTRGl3Qkx4SlpxUEgydHFyclMxZWNuYVQ0?=
 =?utf-8?B?L25KemYzQlF2VS9ZOFpuT0dwZy9kb29PakZ0K0x3a29KcHoxc0ZJWmtIcnpW?=
 =?utf-8?B?U05QL1VIcStOTFVQWnpweG9mVC80MzlEbS9KUkZyTWt2azV5cFlLVm9ZQ1ll?=
 =?utf-8?B?by9QWGo3RjZZOVNhUjE4ZnNtTCtQUTQwWmVvRjd5ZUtQcDNORzg1YWw2U1RQ?=
 =?utf-8?B?V3FFTUIreFQ3dHgwWmZYeUpnZUI4VUJ4T1BZaGRWemQ5U2lVWDJUenBoOTRn?=
 =?utf-8?B?ZUNjS2dkTmY2Z1lSN1h1MVVVRTVPdnhaQ1ZCWkxTSGJ1ay9BZW5WYmpnOGdz?=
 =?utf-8?B?R0NSKzhLQU1hNDVmbk5YVGVPLzNxZjdYei9iWDNBTHFTRkFWY1l0VDV4MnlS?=
 =?utf-8?B?K0IxWEFGRzRIb0pHaEt3YzBGNVpCd1ZFUzZGZWtLTC9WcHdrQ2tRWVU2T3Ux?=
 =?utf-8?B?WDdYcjVhV08vRXVJOFc5d1hqZUdCblVVUDBEL1paUm8xWTF6UmtuN2F0WHhT?=
 =?utf-8?B?ajRRemcxaElRWk1sRCsyT3ZaYkxZcUNlcHlvTUxFWTBGMTRYRjl1dkhQUHcv?=
 =?utf-8?B?SUdZNTRGUk5EcjVOSW1hSDlxK0QvenNpbnRoT1BIMFFsN3hFMGhPVVByUEhB?=
 =?utf-8?B?RFhhaXJyNWQ5TVBkS3ZvL1pGKzRDaTZRWDhnUURJOFFmU1RTVVB2SkJCK2Fl?=
 =?utf-8?B?TFNlU1lqMWpvOHAzTlIyVlJWOU91RXp4R2xOWEZWaTlvOVlvbXJ1MUIwbndJ?=
 =?utf-8?B?dU1oZ1VtNHBPOEk0RlJiT09CVTVWbk1aVTBvWk44bGxhenhpR0w5bGRNNTZu?=
 =?utf-8?B?NTdsa25TRjNYNjdLcFNMTUZhWVVoT1R5TnBWa0c3aWFXc0lTM1Ztb2RWZ1dj?=
 =?utf-8?B?cXNMck11S3czVlg2WEV3bDVCRVZIN3lUNE9rZzdhV1U4VUl5ck9EQmUwNEpt?=
 =?utf-8?B?Q2x5T2pRVmQyVHJ2VlhrYWhVTDNEaUlkeitvRDgzREZVRWFXRHhjZVlQQVNY?=
 =?utf-8?B?ZTlGb3FaVU1RaXYrYVNYekdkMHVUZlFTSW5wTG5xNm1qRFFjL1pRV0NiWHhz?=
 =?utf-8?B?ek0zUTd6MnhZWVNFWFdQVGNuWGNKZWdITXRtWEhWOGsyR2hoSitmK3JzaTJR?=
 =?utf-8?B?UnIrbnhQOVdXeWZ4ck80SjdrRkR1ZzY1VEVkdXcrdkx4WlVNdC9ocngvS1ZM?=
 =?utf-8?B?ZFFiaTVRLy9TaVFKRmNRdEZjei9LYk9hOTV4dWZ3QUlOalo5ZnpRS21JcG8w?=
 =?utf-8?Q?R6I32OTxMF7xRVQka9mLBUo01Vsk4YWCgRt+zcA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81da37be-97e8-4ec8-1ff8-08d942303641
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 16:48:28.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ql7XglSEPtjVGwWKDHLYEwEg9Azq20dupWJoJII48rTqsb/rCQazgaVQcirDSbpdgy43uEzWkApBZbev4jvwTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/8/21 10:30 AM, Dave Hansen wrote:
> I was even thinking that you could use the pmd/pte entries that come
> from the walk in dump_pagetable().
> 
> BTW, I think the snp_lookup_page_in_rmptable() interface is probably
> wrong.  It takes a 'struct page':
> 

In some cases the caller already have 'struct page' so it was easier on 
them. I can change it to snp_lookup_pfn_in_rmptable() to simplify the 
things. In the cases where the caller already have 'struct page' will 
simply do page_to_pfn().


> +struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level)
> 
> but then immediately converts it to a paddr:
> 
>> +	unsigned long phys = page_to_pfn(page) << PAGE_SHIFT;
> 
> If you just had it take a paddr, you wouldn't have to mess with all of
> this pfn_valid() and phys_to_page() error checking.

Noted.

> 
> Or fix the snp_lookup_page_in_rmptable() interface, please.

Yes.

> 
> Let's capitalize "RMP" here, please.

Noted.

> 
>> PGD 304b201067 P4D 304b201067 PUD 20c7f06063 PMD 20c8976063 PTE
>> 80000020cee00163
>> RMPEntry paddr 0x20cee00000 [assigned=1 immutable=1 pagesize=0 gpa=0x0
                                 ^^^^^^^^^^

>> asid=0 vmsa=0 validated=0]
>> RMPEntry paddr 0x20cee00000 000000000000000f 8000000000000ffd
> 
> That's a good example, thanks!
> 
> But, it does make me think that we shouldn't be spitting out
> "immutable".  Should we call it "readonly" or something so that folks
> have a better chance of figuring out what's wrong?  Even better, should
> we be looking specifically for X86_PF_RMP *and* immutable=1 and spitting
> out something in english about it?
> 

A write to an assigned page will cause the RMP violation. In this case, 
the page happen to be firmware page hence the immutable bit was also 
set. I am trying to use the field name as documented in the APM and 
SEV-SNP firmware spec.


> This also *looks* to be spitting out the same "RMPEntry paddr
> 0x20cee00000" more than once.  Maybe we should just indent the extra
> entries instead of repeating things.  The high/low are missing a "0x"
> prefix, they also don't have any kind of text label.
> 
Noted, I will fix it.

> 
> I actually really like processing the fields.  I think it's a good
> investment to make the error messages as self-documenting as possible
> and not require the poor souls who are decoding oopses to also keep each
> vendor's architecture manuals at hand.
> 
Sounds good, I will keep it as-is.


>>
>> The reason for iterating through 2MB region is; if the faulting address
>> is not assigned in the RMP table, and page table walk level is 2MB then
>> one of entry within the large page is the root cause of the fault. Since
>> we don't know which entry hence I dump all the non-zero entries.
> 
> Logically you can figure this out though, right?  Why throw 511 entries
> at the console when we *know* they're useless?

Logically its going to be tricky to figure out which exact entry caused 
the fault, hence I dump any non-zero entry. I understand it may dump 
some useless.


>> There are two cases which we need to consider:
>>
>> 1) the faulting page is a guest private (aka assigned)
>> 2) the faulting page is a hypervisor (aka shared)
>>
>> We will be primarily seeing #1. In this case, we know its a assigned
>> page, and we can decode the fields.
>>
>> The #2 will happen in rare conditions,
> 
> What rare conditions?
> 

One such condition is RMP "in-use" bit is set; see the patch 20/40. 
After applying the patch we should not see "in-use" bit set. If we run 
into similar issues, a full RMP dump will greatly help debug.


>> if it happens, one of the undocumented bit in the RMP entry can
>> provide us some useful information hence we dump the raw values.
> You're saying that there are things that can cause RMP faults that
> aren't documented?  That's rather nasty for your users, don't you think?
> 

The "in-use" bit in the RMP entry caught me off guard. The AMD APM does 
says that hardware sets in-use bit but it *never* explained in the 
detail on how to check if the fault was due to in-use bit in the RMP 
table. As I said, the documentation folks will be updating the RMP entry 
to document the in-use bit. I hope we will not see any other 
undocumented surprises, I am keeping my finger cross :)


> I'd be fine if you want to define a mask of unknown bits and spit out to
> the users that some unknown bits are set.
> 
