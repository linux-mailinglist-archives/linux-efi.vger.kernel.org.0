Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F553FFF8C
	for <lists+linux-efi@lfdr.de>; Fri,  3 Sep 2021 14:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348576AbhICMJO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Sep 2021 08:09:14 -0400
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com ([40.107.93.80]:8960
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348265AbhICMJN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Sep 2021 08:09:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iqt4MceP1730montdzBkxrZ5GOggPVva7O0Vwe2TLu/0au36Wdn4E3u4RtjbCS9OdUD/drMHfak1lQeX+jW3nujgf7FXqkmxoOBJmflMs5Ataiez5NfH3c035Jh8PMdN2+MvNp1NhCn2s1UvTbY4nvB4iRUEZ/ur3g96Iwp2L2HHYmy2YhfSs+BQNmTpDHCwsAmdSIZ73N8PQ5KurPLKcSzd0HMCzDpWovFV1EG+slL9kldaKppR/GojsG/O8A3YeSuQkullu4N++cZTW0issFR6qaRMuUafT/LPewg6jwhG0RWkuHpz9a+OfcPO1fe7SlDFqvz+d60t8HtyK+FFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bneLOLThWC+MYdJPDsERPwwBE/lRHAXqxiY8hlJoOOo=;
 b=Y/H2LCcLWNfdr28fPzHeluIs1SwAnW42oov3HXiFwSaoKSOhbbGvlWBxNaLxJGMPZMb/Cz5IG+LfGdhDjJXCFxAh7YXMaDyCJzP2xywB7vfnVIyTiZ8GdVOklHEfQYJKfv14kGaDTDv6q0W30Y8rQIhqSDDncSEO9mxxmAa27ltaiCi7asmKTCna2gcS6WdGNssUg9ha6Gl2XforOY3Uk6iLPirCpYlllaRHqUwM+2hZJlU+/Bv1Sye4TZBSZsw8+wKvwItKizpcMsiRlyqT3f59dSlCn4JqtpsW2kDIdxcV147ag/B4XSOukKP6mJ93mRycguKF/htX/Sj/dwr2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bneLOLThWC+MYdJPDsERPwwBE/lRHAXqxiY8hlJoOOo=;
 b=5oIHjlVgrTWAz57FWeOCXqBxKRljjvIvc1WUKqGvi5lAInki/fqy4WhkSjyEqFxQOz+Trjf+d/qnMBk4T/cX6TAoigWDZOIZXFRY04FkP6rk+05LGXrgw4vwPyKroKlsPT/64gTvFMS491huu8fkjBcw0qgNqZf8BG4PvYVsZCk=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 12:08:09 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4478.021; Fri, 3 Sep 2021
 12:08:09 +0000
Subject: Re: [PATCH Part1 v5 35/38] x86/sev: Register SNP guest request
 platform device
To:     Dov Murik <dovmurik@linux.ibm.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-36-brijesh.singh@amd.com> <YTD+go747TIU6k9g@zn.tnic>
 <5428d654-a24d-7d8b-489c-b666d72043c1@amd.com>
 <287db163-aaac-4cc1-522f-380f97197b3d@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a42c782c-1de4-6c9f-4e97-cc4e1e48b358@amd.com>
Date:   Fri, 3 Sep 2021 07:08:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <287db163-aaac-4cc1-522f-380f97197b3d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0201CA0014.namprd02.prod.outlook.com
 (2603:10b6:803:2b::24) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0201CA0014.namprd02.prod.outlook.com (2603:10b6:803:2b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 12:08:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6588ae69-cfdf-4bb0-88c5-08d96ed37ecf
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4446BFF596381FC4AD925C4EE5CF9@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgRFo+R00yXFS88/J1lN9ciaw+1ulmuk59vFsc6gqEoMcQK+V97OM/sZrACm069uOKM6EzhFq7su3TWHhDD1ShACwMl/hJ24S2Lm4D9KSqG00VjO7xYtGT9bGN1+wYrlHBEtXUEZ1A9dF5ly3iIc7YpHGB/weXG0NQF+xpw09PGPM8hR8g8WTJWe4mdXsD0wT7PO9BsGmy9qB2OJHOJs0aoAi/vSC3JF7eZdoVLUIb3yXvBu3jgiiZ/FvI2s3d3gV9ib4FzyUCpW619Q7QrTC0dwD7Go29NIUUiAKcZiyQfcwUidK0yUJslecRzHRdpSlgZ5N9ut7TNfIURDe2IcRZBaoO0wmgGr1d9pLx6yYEDgdB0LNlLcdaBBucDj/T+IqQPmeoYdn68Thuk2ipGbE92QkiQggiQHtf5ZGSVP+oeD73z01AYEq9qUzaSk+eg2AbXMXl3TDk2bJxs9XHePABo/p7SG6QYBCpO/rSM9O0M7n4Y4k5C7gQhzTdNxx1EkVPaDO/6Hnh3R/Ieqm5Eb1qvCmwt4RLtlBbSOYs5JLSwsYCWZLQiB/tLewT0qKWVA6lTSeTRXW01v0dVWEqNvrBQACV0+plxzFOow4D2wmK6mV2WoWVOcgqm0xXkL3OvrQHWR3kzCcBxHmTqC3iigcS6w3+g5wO9uXfBggeFj/Tb5qRvk55cgUFU/xEEEcCyVEpFtvymqnjWR5NmDhbMycI2LjNu0NMwseC0yLFu3BJLoSskDMDBI7PbIzlDDGXPvRcgorAtrYshUgfFCR55yhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(53546011)(44832011)(26005)(2906002)(5660300002)(52116002)(86362001)(956004)(7406005)(83380400001)(2616005)(6506007)(6486002)(8936002)(7416002)(66946007)(4744005)(4326008)(6512007)(54906003)(110136005)(186003)(8676002)(31696002)(316002)(66476007)(478600001)(31686004)(38350700002)(66556008)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VElEM3p5ZDJZaGswMnUzWGJxajBtd0p3UTYvbGFJbXBlSHlPQVpaN0lhREx0?=
 =?utf-8?B?eFBLMERPQkhhZGFqRjliQnIrd05MWUh6V2VzQWVzYnJGSFJFZzRhcHFVWWM1?=
 =?utf-8?B?Y3dZZitMelNiQnNBMnZGYkxic1IyNDF4VDlrQnFvbzFESlZacUgxVG5OMHlQ?=
 =?utf-8?B?RG1QeStFanBPVWhNYllqVjFTbnZGQ2xkUWgvRVpJN2pBbUxJb0F1dUh5YzBr?=
 =?utf-8?B?SzJzaHZrNjZDeUdxSG4wb2N1ZG9tSDNJbWx5SFgxMm8wYUthdGZTeXhXRC9m?=
 =?utf-8?B?Z1RmWWdnUy9XRzRxMmVPaUhLeDdtMGhzZThyTVJIU0JJdDUxUUFaUFhVd21h?=
 =?utf-8?B?cnNoU0taMnhhQ3ZyQ3U2Q1Ntb3pxMEh4d3QwTTkzMUhaZDZ4WFdIb2dURkRx?=
 =?utf-8?B?SldJbXBKWElQYjlWR00zbmhhVXQ3TDB4djZyUkl6MVRKbWNyN3U4bVhMWUZK?=
 =?utf-8?B?aTBaS3R6MHFheDVBcTJGVHRrdS9rMXRrTy9UTE16QU00RlBBNUR3bjhHUGJX?=
 =?utf-8?B?ajZqUythMXFlbWpUZkZRQlpSdTJMOE1kb3haWnp1Ulk5bWRNT2VWbWJLUDZP?=
 =?utf-8?B?R0pHVzRmTW5aMytKWklEemZjSVRTR0J5L0JhQUlRak1FVFJoeGRKZlRyTlRv?=
 =?utf-8?B?YzdGcTBJQ1hYTmd6U1o4bUYvSVRPUVVEdGZWMHdUNVh5cnN2MHluc3k0bmlF?=
 =?utf-8?B?L0xLYUJqWDlvSGdNQzUxRERSQjBjQnhTZjlScVlPR295aE15K2hCeWF0UmZI?=
 =?utf-8?B?S2tlV1lOdFdyQmlzbjlhd0RCamZQYit5a3hmNkdzVnlHUmlCQzhLVlZ4cExL?=
 =?utf-8?B?czllY1hCNXFKZklUVVBsemd5YjFsT0xNTm92bkRWWE1obGVNb0FqRW0xSXZG?=
 =?utf-8?B?Q1hQNElkVHFwMHZ0b2Z1U2ZsT2szZE5wL2lwVmFZbmlFSGsvRmdvZS92RXJN?=
 =?utf-8?B?YzFIRklZU2gxWm13VFVhWmdLY2FPKzFoemZWaVR3REY4MnRDYXk4ZU9qblFu?=
 =?utf-8?B?Mk9ySFd1YWZ4N2JUdER3aHZ0TWE2M0t3cXJNcTh5M1M5dDEwYStYcEM2OFNP?=
 =?utf-8?B?UHhiaUFiRlRmN1ZFOGVSdlo2VnhTRzYxeWE2NnhZT2l0bmxBdkd1Z1BXWTdr?=
 =?utf-8?B?bGM5ZVp4K1RGRjhFTlV6WVhsMFRBTFJBOXhudjdCaUFpUW8xN3pMK0hraHh6?=
 =?utf-8?B?SU9zbFhnTmpHMUVzRlZiNGhKSUlHcmJrSFVkMFdDZEhoeVEzWjAxY0c0eEx3?=
 =?utf-8?B?dXlabXhHWjRTNGN0UXAzZmtobVM4bUpqelY3RG5TT2RZQTBVYll1NjdDUWo1?=
 =?utf-8?B?ZHlDV3E0U21hK1FxNlVhWUJjUjZ3UCtTSW1wQm1HUk9rVHJKRXB0TUEvaXlk?=
 =?utf-8?B?V2poSSt3bm9nTS9QdUxBY2UrNFA4N1R6VUNzRjd2Z1NiM1VRa2VibllPT25v?=
 =?utf-8?B?UEtuNko4dzVCWXZ3T0dFNFVERWNDWSttYVNOU005aU82Vjl5QlhObWwwTTMx?=
 =?utf-8?B?UU0yT2Q5SFp1Q0tZdytmOEJJNkJRMWJ4RXNrYStuL0VBaklwYy9iM1BBbDAz?=
 =?utf-8?B?VWY3WkdKM0l4bllHa1hPbXE2N3c2RGhUaGYvMVNWaVJ0Z21DemRxNkhzWFRL?=
 =?utf-8?B?QmJQWkE5YUFlOEJ1c2R6ZlBFbXR2eFI4L290aDdiUWdCbStWMC8wamVPU2Nk?=
 =?utf-8?B?VEozWTFsclRHcUxhWTgxUTgzc3d1Wml4bHlkTURXVFA2NU5EQWJEQngrMng2?=
 =?utf-8?Q?fL3h1wbwkk7LO6I8NT9qrR/zvkxeLIqwXB7rTFM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6588ae69-cfdf-4bb0-88c5-08d96ed37ecf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 12:08:09.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsLLWfIuhX7BAoaozSkURIPI5H0rZPPpq4LTyCkldvKI8r3w47ONPFeBMLFO+g1wqGQSl99CTTESgNvu2hqOUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 9/3/21 3:15 AM, Dov Murik wrote:
>> Unfortunately, the secrets page does not contain a magic header or uuid
>> which a guest can read to verify that the page is actually populated by
>> the PSP. 
> In the SNP FW ABI document section 8.14.2.5 there's a Table 61 titled
> Secrets Page Format, which states that the first field in that page is a
> u32 VERSION field which should equal 2h.
>
> While not as strict as GUID header, this can help detect early that the
> content of the SNP secrets page is invalid.

The description indicates that the field is a version number of the
secrets page format; it will get bumped every time the spec steals the
reserved bytes for something new. IMHO, we should not depend on the
version number.

thanks

