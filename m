Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92AE3CBB19
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhGPRZh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 13:25:37 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:43681
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230287AbhGPRZf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 13:25:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YItYGFnLAnl57nQYLlFC+905yXUuNYjMBAEOiOzPdj/VUnd3wZUsDUjtnxc8da7Gz1GTz37UP8vQ2hdkMuUmiv43Iw8PrkCeIRrjQRKX1oC+WHKnCa1d8zL7I30YEPq+/OvnaDCJa1734+39aK5+s3RxQAgCWsWMLotDT5an0DKetxW4QRyMUN6QYtfnczIwGxlabatPZHd+O1es9RjeoOIu0ECJe9qaYVESL3pkmkWWeW9WpKXHa38qp6Js1JjYHNyldtNyBdJyBCK8F9CigoS6FIqi4El8vPUmi5l5yLhhqsXuEUf2Ia2mR+3pv2vGUyyDBcnCy4qwC4RGZiyUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFP7vFjgw6iYl4EJA/C0qAQvK20VZCiBlPIjGdOlh0Q=;
 b=ZVEw0wfNN7o5KoDntLoKCJPOFDQAWrcRlLlUSyr/y8vSG8FX8GA9XNUR8pUwCstEAXBRtv8tm89n/riALCci/xt3GyGpYiJ47pN1B1zQ9NvyFOjZ1Klpv/7ioTSbnY5cYpm3IgJovZAKFGO/bu0gynh/D+fSjK5QYcskaYEPmqXNDIWspTFnVAZNhJ/G5xWJUoe3tBI/JVwOWHe4t0ESXld/PMyFXI3kvDkFFS+p2mdaKzknNSftpMmZZ/2+ZZfX0kSJWbofWqI3ATbx13m6a6XrEZdUyGjX4ndTgnaS/G3q3391hdF2EXnZo5kzZ50pr3O4pz7lBwJXYcKD9iRXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFP7vFjgw6iYl4EJA/C0qAQvK20VZCiBlPIjGdOlh0Q=;
 b=jXuWhI8txWL4mhzuISVvyyVv4kUS2Vbyp2cWay1KXURMHyqJo7/XsGoX06BoPKAqpiVPKwbAn2dHkbAp4nx8C87a3WGIBkc0hy/BTI+O+eVZGTdcruEWE0RlxPOmk7vlFE0lddaxKrRPHaHY46zlDQIfTDhUwRzL/hKWEGxhIR0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Fri, 16 Jul
 2021 17:22:38 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 17:22:38 +0000
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
Subject: Re: [PATCH Part2 RFC v4 05/40] x86/sev: Add RMP entry lookup helpers
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-6-brijesh.singh@amd.com> <YPCAZaROOHNskGlO@google.com>
 <437a5230-64fc-64ab-9378-612c34e1b641@amd.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <39be0f79-e8e4-fd4a-5c4a-47731c61740d@amd.com>
Date:   Fri, 16 Jul 2021 12:22:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <437a5230-64fc-64ab-9378-612c34e1b641@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:806:122::14) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SN7PR04CA0099.namprd04.prod.outlook.com (2603:10b6:806:122::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 17:22:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63165c54-f8c3-4732-4b38-08d9487e4ef1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB441378B4D2189E09E7C6B264E5119@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P987/WCDiH/x1xH6cdSLgZKelC4wfOtg8N+rT8t0EKB81wLs7vv9OB3oB46hjqkBoqfkFjn/u3bh285lxzHWUrbJNzfyuGkMfrc0Oen+6GzbbwHYm0vtQ3dHnXPhSM7VthCsLreA/vBJaA5VquKVKhNTykFc64fBsX37Wzlm5c1cFw9y78Wg9ZCVhU2OvhaH8v27LKwl9pl4Qg2lxhmUOeEOwOiD5tSUNU25jZe2S4gmeSKWihZij95YaJ7dy93R+pAHK+W4thhUHm4TmNDCKNvRmH1DzxsM7Tc9HVqn2cyzPmvirQkkXBGs48BwSdDfSd5uY/rQSxnNV+bWCDnK1rYFm758iQKu46uH96LHDuyT+H4K7fPvkEMXY7bL8hbfQHZv3//QuSnUBjcB5yw2FT0zvInMroxrrNU5xDFdDs0zdzfq9jwZYFAO9B/eCBLFogNzdsi35tcxoD2Qzwj/282hIVeimA26a5hxCRcxd2/QySotlPF+6CvJszir0OapqSnkpg6PwVTqX8Ms4Cymn2JnFtJIcSl6L57ufw4b1MfUVLEaCbbjPICiBkJasSVQJPsfkBDiolX6qYGXCrAm4uhnlGK1G7UAcY/GwSoRQdkr8f6Tb+QtuxOmPooXsnWzrHp1vuZisKtWglw1eNm3Wi73zxhQRhLzCCDaFx503vDEPAgrnQMH+S6Pm21RUaW6XTEVlvysqYpF04+oa3voELbKsZsbS2ug7O6dXnGJ0esGZQ7mfK7lwM98FkpcuMmX/fBzQbV3iW8HO/cQhmiSr4NFFZZL8zMFW1s1TLEwSeDaY1VM9QPhhPIzjaYJO6ZFXubowUX4NgkSIvaXm5gSY7QFNpF1ix4AfM/AAGjudMZP9eDzfVyTLf3iMwExPA/C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(66556008)(83380400001)(186003)(66946007)(66476007)(8936002)(54906003)(6512007)(45080400002)(53546011)(6506007)(6916009)(478600001)(52116002)(5660300002)(38100700002)(966005)(2616005)(956004)(26005)(6486002)(8676002)(44832011)(36756003)(7406005)(4326008)(31696002)(7416002)(86362001)(316002)(2906002)(31686004)(38350700002)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVRHRnhlQ254cFM0R0UvenZ2U2JyYXNINFg5eVBMeXY1OHcvc3JVbkRQUFNQ?=
 =?utf-8?B?b3hsZmlUcjdjbVRzZGx2ekt3SG5WeEFuUVRCcU9EK1YxVC9hSDk1TTBLazJ6?=
 =?utf-8?B?Z1RXSitqclFKQm02azVWdVFaUEhONWxaUS9tUDhXSy9aYXpmbG1IYUsvc0hM?=
 =?utf-8?B?Q2Rpbm5sZEg1cHN3YWsvUW11Nkhqa2ZaNkVQWW9sanBiMTYxelo5YWlDT2RN?=
 =?utf-8?B?aTdMUGRtcllFSE04dXdpS0xrR014K0svV3kyRHQ4b1B2N1lCNm5lTlIrcEhN?=
 =?utf-8?B?NDViSXY1R292azV5UWdBQ2pRU1JnK01LYTRoYkh2N3Y1TXQ1c3lPVlBPTUxT?=
 =?utf-8?B?VmVhZjVCRVpVcUwvdDJVWndqWEd5Z1Y3VmMvRGUyMUlEV212TEoyTmFXOEo2?=
 =?utf-8?B?VnBrNk1neUhNT0RJbXBTZFdpL3FPMTJXb0NoUTJqcnAwbjR6R0piR2tJV1dz?=
 =?utf-8?B?cjNFekQvekxDN3FodGNtUk03a2RlZVBQc3p2cmNJbDQwYUNNUWkwRzlKaERD?=
 =?utf-8?B?eUl4cFlPSG9IbUZjSk1PV1k5VVpVS0wvYW5oaDFpa0xQc2NNcGJlYW9CbTFK?=
 =?utf-8?B?enMyQzh6eStqeUpBRWlnWVFpV0ZINm92TVhqWFZFR0tpQUdTbUFGZWJxY2dh?=
 =?utf-8?B?bjk3QnBRV3JmRFl2eFNSWExQRExMUUFad09aRHVOVVE2NVpVWlo0K1hBL1dG?=
 =?utf-8?B?aWdvR2dSRXBNcFV0Rld2N29PM1ZqbldjUXRjd2llYmIrdktjUklNZVhqTE5s?=
 =?utf-8?B?VUFxMTd1bkxWd1UzNEdJVFYyY3FjNG1tandndk5ZNnJ4d1dJNUJUd1czc2RT?=
 =?utf-8?B?bFg4WDgvbWp2a0hlVVlTc3N3N0YyM2h3UFN6UkpxdzkzOXU4d3BDR0U0Syt2?=
 =?utf-8?B?V2JFTjZ3WmVQc0E4VXU1Tlh5V0NxNkhPQUhyUVgyUkJhNXc2d0RYR3ArM2pU?=
 =?utf-8?B?WXoyZzJwajJnMnFseE8ycDZ5SVR0SG1SMW5PYUlvaGx5aWErakoyQnJPd1gv?=
 =?utf-8?B?a0dwWGlVczZvTFRBUnNvSm53Y3BUSXdXS3VmZlU2SFM0eUxEOGlGR0dEVktX?=
 =?utf-8?B?bmhLZlNMRk5XcW1DY3JGL0VZaGtUMjkzdmk4YUMvdU1Ra3FNYjJjck5ZdXkw?=
 =?utf-8?B?VjNJTVhWS1cyVHVRWE14WXo0S2Y3bmpRSXduMWowT0ZoaVNHaXNGWWZqQXVr?=
 =?utf-8?B?RCtEcWxrMFgyZSt3WE9xenkzVW1DMlphNHVrcnVhUExwS3ZDRzh0VzQyVEFa?=
 =?utf-8?B?ZU90aTFtdXltNGV3b3k0cDRzVC82MHBCSlpTQTVBblR3MTBlcVJ4VUNUYk03?=
 =?utf-8?B?ZFRMQjkrdDlLNWQ3cWtZSVgrQ0I2WEZZVDJ5NVRuSnBPbExVWjZscDN5Rkl4?=
 =?utf-8?B?cGRaelVjSWRZUEV0dkR2N2xkOXRBSmdzd0Z3d0NibitWYmEwcG5keFJtWThZ?=
 =?utf-8?B?YXBTL0E2WmRQWXZ3VVIxcjYyMWxmaFR0RzdzQUduckcyM3JVa3duZElPUncy?=
 =?utf-8?B?SWtkalpqQytZdDJpODhLSmUxQnZPc1FtKzdwY3h6ZkV0aStBd0FOcFlYSzhG?=
 =?utf-8?B?TWpsazV5MmFwT3JZcDFHMkxOZXowQkdJZCtLbjlkMUladmlCdysveUVUWmR5?=
 =?utf-8?B?YzZVZnVvS29SWE9JVnpkVGE3MlZrZ3ltQmwyK1BWL1NsR08rUVZSQUtLQlhY?=
 =?utf-8?B?OGdsWDVPWXVvR2htNU5EV0w4dlhuR3g5Y00wdXJmMlMzNmM1dng4MjNBSW53?=
 =?utf-8?Q?WhZba0s8CaJzi33l5pIWeddu/XmHNXBtAypycUe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63165c54-f8c3-4732-4b38-08d9487e4ef1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 17:22:38.0069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ve+qYPrDGCDu7MuLm+C2jwreeIxeQir8QFOuhEVH/YVg6nmASf4Z3ATbFsXCTRS/DY4MB0NxspDQX39D21zN+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/15/21 2:28 PM, Brijesh Singh wrote:
>
>
> On 7/15/21 1:37 PM, Sean Christopherson wrote:
>> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>>> The snp_lookup_page_in_rmptable() can be used by the host to read
>>> the RMP
>>> entry for a given page. The RMP entry format is documented in AMD
>>> PPR, see
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fattachment.cgi%3Fid%3D296015&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C2140214b3fbd4a71617008d947bf9ae7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619710568694335%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=AkCyolw0P%2BrRFF%2FAnRozld4GkegQ0hR%2F523DI48jB4g%3D&amp;reserved=0.
>>>
>>
>> Ewwwwww, the RMP format isn't architectural!?
>>
>>    Architecturally the format of RMP entries are not specified in
>> APM. In order
>>    to assist software, the following table specifies select portions
>> of the RMP
>>    entry format for this specific product.
>>
>
> Unfortunately yes.
>
> But the documented fields in the RMP entry is architectural. The entry
> fields are documented in the APM section 15.36. So, in future we are
> guaranteed to have those fields available. If we are reading the RMP
> table directly, then architecture should provide some other means to
> get to fields from the RMP entry.
>
>
>> I know we generally don't want to add infrastructure without good
>> reason, but on
>> the other hand exposing a microarchitectural data structure to the
>> kernel at large
>> is going to be a disaster if the format does change on a future
>> processor.
>>
>> Looking at the future patches, dump_rmpentry() is the only power
>> user, e.g.
>> everything else mostly looks at "assigned" and "level" (and one
>> ratelimited warn
>> on "validated" in snp_make_page_shared(), but I suspect that
>> particular check
>> can and should be dropped).
>>
>
> Yes, we need "assigned" and "level" and other entries are mainly for
> the debug purposes.
>
For the debug purposes, we would like to dump additional RMP entries. If
we go with your proposed function then how do we get those information
in the dump_rmpentry()? How about if we provide two functions; the first
function provides architectural format and second provides the raw
values which can be used by the dump_rmpentry() helper.

struct rmpentry *snp_lookup_rmpentry(unsigned long paddr, int *level);

The 'struct rmpentry' uses the format defined in APM Table 15-36.

struct _rmpentry *_snp_lookup_rmpentry(unsigned long paddr, int *level);

The 'struct _rmpentry' will use include the PPR definition (basically
what we have today in this patch).

Thoughts ?


>> So, what about hiding "struct rmpentry" and possibly renaming it to
>> something
>> scary/microarchitectural, e.g. something like
>>
>
> Yes, it will work fine.
>
>> /*
>>   * Returns 1 if the RMP entry is assigned, 0 if it exists but is not
>> assigned,
>>   * and -errno if there is no corresponding RMP entry.
>>   */
>> int snp_lookup_rmpentry(struct page *page, int *level)
>> {
>>     unsigned long phys = page_to_pfn(page) << PAGE_SHIFT;
>>     struct rmpentry *entry, *large_entry;
>>     unsigned long vaddr;
>>
>>     if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
>>         return -ENXIO;
>>
>>     vaddr = rmptable_start + rmptable_page_offset(phys);
>>     if (unlikely(vaddr > rmptable_end))
>>         return -EXNIO;
>>
>>     entry = (struct rmpentry *)vaddr;
>>
>>     /* Read a large RMP entry to get the correct page level used in
>> RMP entry. */
>>     vaddr = rmptable_start + rmptable_page_offset(phys & PMD_MASK);
>>     large_entry = (struct rmpentry *)vaddr;
>>     *level = RMP_TO_X86_PG_LEVEL(rmpentry_pagesize(large_entry));
>>
>>     return !!entry->assigned;
>> }
>>
>>
>> And then move dump_rmpentry() (or add a helper) in sev.c so that
>> "struct rmpentry"
>> can be declared in sev.c.
>>
>
