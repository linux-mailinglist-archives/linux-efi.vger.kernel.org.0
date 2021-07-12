Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB13C60CC
	for <lists+linux-efi@lfdr.de>; Mon, 12 Jul 2021 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhGLQwq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Jul 2021 12:52:46 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:31009
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232710AbhGLQwp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 12 Jul 2021 12:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPkzhKRa6wWkhDyqFyCodiQnP+3MhPkQXs3Hoyoay+FmNhu9t3d14qEobGSIjtweVgJKFlEHjwuX0TDeK8O9Fk0TR/G9TJd4887suiR9FAI/d5kf63ZXrLHvVOPNnkf2vwynboBLAvS3JYPlTxUT6071/4RubxczGY+HcHbbwexeXd89qXkylSslt7FbJ1U7LT0tKBz1vBzYVchM5itMj96RpRLOzQofRa/QWGsG3nfTEDf0XfWcbUGTkESHjJqud4z6DrP05sx4+JoM8fRv4xBKHGtA9vDvQWMdmdZmicCRYcJMhWQauJZFFiMFnHWhc2zG8vvRFb+9/PCwPwRmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFC9TaFxxdrbx6dHeBO7i6Xdx0QiyZ7zHy8R8gqwGuY=;
 b=mV1INzvYGjVsa0CU5/ZBTfnjnXDLPoIz+2PJnRmaI+4LP7HOjVfVwA+aPA+qr5G7mPCZM/4sEuMtxF0d2FsBgr3ioGxlIUynIUYtdfGRiVfM33G4PlZUQvbPROzfhWffwnnc4/89n31g9LwfH3hJvxrB3cfts9zXZ1tVGlv6Jj1iM9agBBXViaXewWpyF7OLjihADdWP6zdXh8Okv5Nmckzx6W3w8Deudl0Tdp16CJPPeh8bWRivOuvXOkhGUpyc/r1S7UtDcE44Zoo22eSfk53UiB1uTBVVF5M5sieOgShCEZZh7nMxzV/jubVduuCNww5ScC21ewt58YvqLa+F3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFC9TaFxxdrbx6dHeBO7i6Xdx0QiyZ7zHy8R8gqwGuY=;
 b=FLg1ULIszTwdB8fzsz1pnSrkWdpqHEibJ8Rj3a8WKBbJwId0WNc/0HUBMcBHfPh1ULN/3Ns2esWcqI6xhzx1UEl5j6kuHVP/nGWuHU5yzBEpJCcWGsbmDGkSUzERTLA0y0PsqW7aF4nMu73r8KxsQilKRyPYawgGE96kOBf9dSQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2832.namprd12.prod.outlook.com (2603:10b6:805:eb::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 16:49:54 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 16:49:54 +0000
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
Subject: Re: [PATCH Part2 RFC v4 10/40] x86/fault: Add support to handle the
 RMP fault for user address
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-11-brijesh.singh@amd.com>
 <3c6b6fc4-05b2-8d18-2eb8-1bd1a965c632@intel.com>
 <2b4accb6-b68e-02d3-6fed-975f90558099@amd.com>
 <a249b101-87d1-2e66-d7d6-af737c045cc3@intel.com>
 <5592d8ff-e2c3-6474-4a10-96abe1962d6f@amd.com>
 <bfb857d2-8e3c-4a3b-c64e-96a16c0c6d49@intel.com>
 <aef6be8a-c93a-1aaa-57fe-116e70483542@amd.com>
 <c3c71a5b-8100-63f2-1792-d7b53731147c@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <298d2e19-566d-2e58-b639-724c10885646@amd.com>
Date:   Mon, 12 Jul 2021 11:49:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <c3c71a5b-8100-63f2-1792-d7b53731147c@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0069.prod.exchangelabs.com (2603:10b6:800::37) To
 SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN2PR01CA0069.prod.exchangelabs.com (2603:10b6:800::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 16:49:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97534bf4-1afd-481c-9755-08d9455512d6
X-MS-TrafficTypeDiagnostic: SN6PR12MB2832:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2832028058D072B1882C192DE5159@SN6PR12MB2832.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hB1euqUjcpcY8sSjFq1gZeYTZnnYuHEX1TQh4fv3qAiot09cMml1Bxgit4GaJyssChPRYBsCbriMdJgLijx39YYB2ZoeqVSJwg0DO8RwLb+jOZeMkb3VVsV8sImu6W5uJp1MOR1eawHmN+QISqbYRq8aQuINSbrNKG3zmorajrdDEaumSccgou1N5MLY0YLi/hvg0qBq3vdmpEjqYKJFBgeRIQSXLmC4OtsR6scnsClKyGlJYWb9rciTeNaPw272bj4Lwrzj5C0gmah+gY9YyNo31mG2ooYvoSDeWx/J+rFn6Rflq1YfDNNiQDXOvWFoAJdM2yQqsBxvW5DuJB4V0VDFjFpGeDo/AsPghyw3RLsaUWeATrQdsmmBZWhEqf07zpzfkYeN2kZCZ2BpTZxPUugBqKLZV1vIIZxSAXG7hljdlvmydLxKtapyA/WGtGE+qYdp5m2+N0gLQpUq49PHK2ZeJtN8zQzU1ScuPF9P8K5Zgc5T1hODk/Rnt/Wt/6ymHyl0Wa8LJ1obsdXGmmw4Sazg9Sa2ulL48jmLcrYLo8ClwtMQkxWOhzvMrq4j9OnXPO5i+6TzuVDGH/KwawEGvNb0ewEkOnGbsaeoRtZmcm0ySXXLED187+qugpntlrETdN6zQgcxC+J106+ymGVxmO3cOrvylLq1pnnbrSXzAxoibuq4qToFdstCXvjRJQReotamI74wjr4w4Xnth2XzcuFJV3Whrex+Eu4l4WInHAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(26005)(16576012)(956004)(186003)(478600001)(31686004)(2616005)(7416002)(31696002)(7406005)(38100700002)(38350700002)(66476007)(54906003)(66946007)(316002)(66556008)(2906002)(52116002)(8936002)(4326008)(36756003)(86362001)(53546011)(44832011)(6486002)(5660300002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1IrdGZON2c1TVpoRzcxRUdWQ1NQR0hBU0FqaFlpRTFoTXcwUlFhSjJwQStK?=
 =?utf-8?B?ckZDR3V5eXdaOHIxMWd2Nll1MytMcjJwMzlvWlhlcFdTV3ovWVEvS3Fubmdm?=
 =?utf-8?B?ZnpRam54TzRBcy8xU2kvckxOa3JtcDRXRkExNlp6aG5jbGJUM2wzd2NTL1Fl?=
 =?utf-8?B?STNPTEwzSE51dnFick1HYWVKbnRoaGJNbEVTVTJuUy9ZNnhiZ0Z4ZVpURjlu?=
 =?utf-8?B?Q2VKL1BYRGlORHcwTVB1QTRsM1gwdEpjdWRsaDRKQXdzbTgwUzFjTXZld0xR?=
 =?utf-8?B?ZDFRVFNlcFhlRVdRQk02czhWMTllUGJnVGRWMDE2aXNCVDBwNWhjdHJ2TjFI?=
 =?utf-8?B?YlZ3L2lKLzBBMldGQ084R2hGUkd6TWU2aEdOOTB3V29FWEdVaENVbDF5VTMr?=
 =?utf-8?B?Z3NYVTJ2SXo0dm80YTVyT0Rxak1saHBnMktEZllPMWtVaGJxOWVyN1BCUUtE?=
 =?utf-8?B?SllKVlV2bGUrY3AwVjBHM0w5MjVITmhVNlI4QXJaUVBqeHlxOVRhVmpLTHEr?=
 =?utf-8?B?djg4bXJzRDBMMTd2Mk05RUdJZlR0ZzUzMnVYNkIxVkFGMGlVd0tmUlhtSlRR?=
 =?utf-8?B?bWNUMHlUYmg2YjR2S3hOSFNoSTdhdWg0UUx2dlJXWkxvVW5iTWwrMDVHajNI?=
 =?utf-8?B?UUkwVDNxbkpMRUUvTDRnOGt2SmNNbzAyeXY3VGlJMUIyc29IS1BBeVZUa05F?=
 =?utf-8?B?OXVzeDV5dDZkaUloaU5ocHJJSUZGRXdOMmNBSzVzbUF5ajRkYWlrN1dhZ3JY?=
 =?utf-8?B?cElRVmZLQWtBRTBmV09vN2hVUU1PMS9xUjQ2YXdZZmlyUjlWMTVub3g5UFBH?=
 =?utf-8?B?eTNTN25nV25mRlRzajRoOWdpMnV6ZmVuc3VKbFg5ZjhVVnR2NUMxZXArRXhm?=
 =?utf-8?B?UEU1NlBhQzhBT0krK21YOEFMQUJhNkxJR2YyWmJNUFVlQlpFMzkrVk9yNEh6?=
 =?utf-8?B?UmFUYzRBZ2QxaXlkUXVhWEs3UDZ0OFdZdVQrY3UyOVNaNUh0OE9JQkZ2NG1l?=
 =?utf-8?B?RXpSNk5QRVFNdnM1enBDQlFhZXJTb2toMk91QUZkOHptMjdDYXdvQ2ZxQi93?=
 =?utf-8?B?U2VYYUJRZnRjSmI0ZVlvSjFmUDJoQ3h1UjFZcjVPdi9uT2xLaHBzRXBmVW5R?=
 =?utf-8?B?NlJpbHNvQWsrK1FIZzN4MDljT1pGNUlRdmZvS1pNOG4wM25LRHFXYWp2YnRj?=
 =?utf-8?B?cUZZTzRzRWlKSTVlZTZnUENGT1RYRmdhak1UbXg4Z0h3aUFDQlc1enRocDMy?=
 =?utf-8?B?MnJQV3h2dXVGUHFXd0piWE1Mb0FHbE0zNE53WUhiay9GV1NYajJHNkxqMEJH?=
 =?utf-8?B?ZlAvWXUrSTFuc3VaSmJSU2JSc3lSNkg0UlB4YVdLV1Q1RmZBMk1GV3ZScEsy?=
 =?utf-8?B?bkJDQVFSV25idnQ1SGpnKzdYWFVTa2E3Z3NuNEJnbC8yQlBCZG9LWktCRk4x?=
 =?utf-8?B?Y0d1Wmo3M044NGZVdlRIZTBMc2FoNDlXUHhsNGc2Ukc1U1grMnVxTmxNSHBD?=
 =?utf-8?B?QU9wSGZiWnFFNFY2VTZWSitmaUpneWNucFBjUHhxZFVWOWdZdVJHRXlaUE1I?=
 =?utf-8?B?ekh2ellZREVYblU3bG1PZGhteGxXcDFZMGluRmhyQ3c0cmJzWkFJSTZmS3RP?=
 =?utf-8?B?OFpjVTJqNTdQOUFuMmRqVXBGbXowVG94T0R5UTFRMUpudk9YZFNSZlJRNndy?=
 =?utf-8?B?dmtZbUJZelpqU1dVaUJwN2JxQ1NZM2YwZ2ZvbGtvK1dIRk05aGcvSUtxU3lw?=
 =?utf-8?Q?cqh/aoWIf0WJbHi4URlyLBtcoojSUWFM8kTYaNp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97534bf4-1afd-481c-9755-08d9455512d6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 16:49:54.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oClFogCTYquEYfFhvcRwiaGilfZ6AoLAG3FHUv0Bvb42wk2/76sVeRVDkuh5XgWQ0O06aIqqxRJZFx2xVYiMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2832
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/12/21 11:29 AM, Dave Hansen wrote:
> On 7/12/21 9:24 AM, Brijesh Singh wrote:
>> Apologies if I was not clear in the messaging, that's exactly what I
>> mean that we don't feed RMP entries during the page state change.
>>
>> The sequence of the operation is:
>>
>> 1. Guest issues a VMGEXIT (page state change) to add a page in the RMP
>> 2. Hyperivosr adds the page in the RMP table.
>>
>> The check will be inside the hypervisor (#2), to query the backing page
>> type, if the backing page is from the hugetlbfs, then don't add the page
>> in the RMP, and fail the page state change VMGEXIT.
> 
> Right, but *LOOOOOONG* before that, something walked the page tables and
> stuffed the PFN into the NPT (that's the AMD equivalent of EPT, right?).
>   You could also avoid this whole mess by refusing to allow hugetblfs to
> be mapped into the guest in the first place.
> 

Ah, that should be doable. For SEV stuff, we require the VMM to register 
the memory region to the hypervisor during the VM creation time. I can 
check the hugetlbfs while registering the memory region and fail much 
earlier.

thanks
