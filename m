Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9D3D0284
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 22:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhGTTZi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 15:25:38 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:60768
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhGTTZ1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 15:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2Tg41tTwexHWhLxvgT1KuurmLIe+BeOdHRbtCvhYqzS5MHP6FIYexuQcGjYszmlud0vODK4e9l/bgiIhaF8Mwmr1mgsYIP1IqVnuv+PT/ZDGvidjunBjk4aA1JTJtJKiDk75kLz+zUVYGvMkluvRc0nG7rM1ixBCE+X+N9mOs2JdZoB3AXPc9KmyGGKEXunBZ1DIGI1KkP7QKa3GbubKZmaLBLDNqErq450fmHQZQA2Vi1RMahj0tFyHALhoM6mPLpiCQhL6wcBjz9Mdf3iIT/npdu74ijVw34QaTn8EXtGKL8jG2igSu/Q+QoAcuDUjF16bnFBo0Z0A5eBsqPt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+SeTQNPSG5lVB6kD2qA1GHg+mKjGMSM1+9wnMYn2Fg=;
 b=bJQxPeg4vM4bFVaonrgMtnqmiyXwjjH3tKiV5stSGc86x1TAwtVozbVmcq+9qeJdKbJWWP2OtzoTmutJLm1FveB0Y+VT4DVMpEvY70DF1Q1uoLv1hVijqnO8mSkYoXwvpdEP6rgmb/jjb7mDroWuh2C+pYIkR5jLEr0ohj5y6nV7G7C8sqJM1N1JYLoSLDdM8Mo/FSgAIBN09j/oNMALDad9drQdgs0DHXS6kxWnxSLYP4POkg/FUdD+bqPA/Tqb2d1E1/jKq+9JEjQW0F/3GxvBCMUrIdhsLM/Lq+KPhXjLSllKlnJzyukDg5jDNsLpU7eik2W4joDZmzIE7Umtpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+SeTQNPSG5lVB6kD2qA1GHg+mKjGMSM1+9wnMYn2Fg=;
 b=UREJsggq2CgYH8wJI1SeBPEJvB6Jjg3fEyPuRvZgRXs+7QP1lUjDWvot31rIU6kijmYK2o0kfE8e62/q4fBRzLubgJMBXsaoolJkeajOHm2LYQZQAcxD9Mwz2ilU0LrXQNBoJwfv/CsGh/XGLE+WgFKEOkYL/m1SIvhex4jC1aE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 20:06:02 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 20:06:02 +0000
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
Subject: Re: [PATCH Part2 RFC v4 27/40] KVM: X86: Add kvm_x86_ops to get the
 max page level for the TDP
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-28-brijesh.singh@amd.com> <YPHbxAVbuFk6Xtkj@google.com>
 <1ed3c439-a02c-7182-b140-32cddd5e4f34@amd.com> <YPcmJuKHFYjCgpqd@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <afa7bd42-ce18-c89e-3f54-cbf197143678@amd.com>
Date:   Tue, 20 Jul 2021 15:06:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPcmJuKHFYjCgpqd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:806:6e::22) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA9PR11CA0017.namprd11.prod.outlook.com (2603:10b6:806:6e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 20:06:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59c0da7f-26e9-45e8-b7ba-08d94bb9cc76
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2368AA507D75DABEBFAE8349E5E29@SN1PR12MB2368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqtE5AB1POCPOaQZ3bFRMae/5mC+yByn6wrfaMoZ+19Hqe+orM3RXC6kn8JlEosucKFttdTmBVT2YmvMT8kKIJNf3n+vrv641YQfZjSQrHUia0cEpfiK5PS69k3MRVLL52mtsGJYvNbcJJebTqg1CJ9EW4sTtG27DJfsgmazEYoYMUZtnc+xAOoLqzcIRu3bhZelesqY+9pV1+HRxKay4RxXhY/OWWIad/fZx5kV5V1tyQuxywOF8DwRE+rLwK3IZNUAla8uwtIPj44mrYyLRVzKrpY6yO3KnP5C1z734hzILKnWu1+TVreq0NPfkgOoKAdupo6Dz+lMPtgj8JapAlMJ3AdHi5WMT/0LHTdMuVYhOhnXVPPA/bTvP0mkJn+H66UMpZdMi9iZS4VwmcRw5iGpqe0HGvBnhkMkX1z45pfYYxL77VrebyBFVQ3UMjcQdZ2XEoNL8YE1/8xVz8isu2IzZuFFiDXGBs25CGQZzDutuM0PIqRlPAaz5rB+M3ZJHUgWU8C0DWDNBluTRbRMCHgTOMKVwsw0MakPdu/k9ok5SwnT9f4gBGWpzBiG/jfOzx8qXmIRi2AE/xAShtBFH5GiKp51cHUL+7+H3jW/OOAVnogQ2dRG6jp6nMUxeCrYm08D3pyXwIQcL2VnelcrhJ4qpJEjqLegZaniFjMhuDAssnb3P/xMm9mOercgkbTv8o2Z1lUfr5EEErfJCCvSmoxYKlWnQrkqVirFXrq7sDyvthWxj6nQEd4lnh1z7AdN/RkoUf8ohhdUJOaOTbxtoB9udvmhxCHNjxyAQenwMkQ0Dip1KGZXAhyYLpE7LcX383knreUWnFK1x1/Efub8dULhk1cNVWQC9+ShemjOssENZxV7dxZr65/hk4zse0Ub
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(54906003)(31686004)(956004)(186003)(26005)(66556008)(86362001)(44832011)(66476007)(7406005)(31696002)(66946007)(8676002)(966005)(52116002)(2616005)(53546011)(7416002)(6486002)(4326008)(478600001)(16576012)(83380400001)(36756003)(38100700002)(5660300002)(316002)(45080400002)(2906002)(8936002)(38350700002)(6916009)(15583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3dyUHBmdWJBTWE2Wkk3SEU2djZOVzZNd0FxSitJVkpZR3g4azB1STFhRlRP?=
 =?utf-8?B?OUdDVDIyUldmbXZIOVhzVUFQbUcyTFlrakhUa0Y4bVVIOW1iZ2FEcEdxbW85?=
 =?utf-8?B?S0UySmxNeXYwVWptNDFIQ2hibG9tYm1qZlBEaEFmS1RZVExzbE55RGliOENU?=
 =?utf-8?B?L2xlaXBHa3RtazBVd3ZyamViWjAya2oxRmRCTkF0RUdoTzlhUjZEYjV2ZXZZ?=
 =?utf-8?B?SVZHODVCREwyNXNyanVqVzdvR3NoSXJlQnBvUkRSMmlWOEFOL2NyWk9GVWFM?=
 =?utf-8?B?Y2xlYzBXOVVSbm0rb1QrVHRCazVIbEs4b3dub0dTOFEwMG9UZndFWE5Yc0h0?=
 =?utf-8?B?MTd6WTcrbk1RcEUyRmJhK3ZCVGgwTkxKZ3ZuaWpGYkx5d1FaRlg5RmxFVVRF?=
 =?utf-8?B?a3ByWUhITEJXbGRPTjJ5YURvMVFncXJXM3F1Wkl5NDEzNDZPK2tBdHZTNDFU?=
 =?utf-8?B?ZmJaaG1kcGY3N0dOc1RHNHh6SjJrb2E1R3c5TW4xdmx6SExrOGNUd2laakEy?=
 =?utf-8?B?QXlrcW5YcHQ2a0x3VkJWbjhVZUhwTTZranhYVkdJSFhYeVZUOTdoNTJoQ29n?=
 =?utf-8?B?dEFSb0NYZjdrVWZhTWM3bHJmdEx1SFlIakM5RkQ1dmhZWVBZeHg2dFNYd2dk?=
 =?utf-8?B?bDkxMm1kODZldW5uUG5DaUdMdFFzdktuSExOMVVCSEtBTS95cnFhbXVza1Z4?=
 =?utf-8?B?RU1hRzJSdDE0VFBwWEthZ21IY3hCakwwSHF6NzZPU1RjaTU2ekpOc1FiVXM5?=
 =?utf-8?B?Wkdzb042OFJwd0grekJ0d00rd3IzbTBsQzV3aFpUS1B5VEZWWjZ4TVdkRFZP?=
 =?utf-8?B?Y1dSUmFycFgzRVBSdmhpczVxUUIxWHplWTJIMVUzZ2VXdUFqOGpIRFI3UWNx?=
 =?utf-8?B?TEd4TDFhTHhPSGxKVTFYaGdWeWswTTdEQzdzRjBWREdSWjNUSkdXL0tBSHlq?=
 =?utf-8?B?aVJYVVFyVnphcjk4S3VpVWZwZHBjS0grVWVxbjRJTkdXcHB4YWFBN0ZrRmlS?=
 =?utf-8?B?ZHNBaGlCeG9MdHhQcTEvOWRLWHdJYmhyTmtKV2txK2JBZEhIaVJGSnJYZFF6?=
 =?utf-8?B?ajRGNXkvay9xOTFudHVZQTRTMFlVYVpmclJXTmdHcEJBZWxTTGttUDZGVnU2?=
 =?utf-8?B?ZE1Wcy9mV2Zmbzd1YXBVTlBRRWhFa0NFSXFieVhLOXNvb25iUWVUMXRqdUM2?=
 =?utf-8?B?OUdlNFowaGJ3NTM1T0xod1dSRldobmVlRVdFekhNZ1dpQkVUSUNxL2NXU0w1?=
 =?utf-8?B?U0pxNG9aZFl6TkxFZkdQRmpVZ0sxZm1UWjQxdlRZTVpQa3J3bVE3SHJLMzVv?=
 =?utf-8?B?OW9LV2ZtVVo5aitDRHlGUDVjZEVuMEZKNlZPRTNuM01mVG1NUWlMcGZuU0lK?=
 =?utf-8?B?K1U1U2w3M2gxVXl1MzBCWXlrSzIzRnozQVRPM1UybWNXVUlXQzV6UUw4VGEy?=
 =?utf-8?B?Ull1WXdMTEhKV0JMbWRVWWRwdVZYR3BBOWNlQTg4Y2dEYmM4ZWMza21NL2xl?=
 =?utf-8?B?REczVklxZitnL2d2UEg4RTIzODExZXI5SFdnYVlDUEF5UVhZeFJVS2hQNU5T?=
 =?utf-8?B?U0hzZUs0ZlBaUktsa1Y1WWNsQnl4UVNBVjVkaW1RZ3A3aUtQSHJaZ29PYlRC?=
 =?utf-8?B?ZmtyanRiQVhBZU85M1kzaUV2Um1hTXc0MDhVVi9JcVo2YzBWTnZpTlJRQ0E2?=
 =?utf-8?B?ZUdpMVpMekR1ZXladWlWdW9ON1ZQWWlsZUc1SUh4SCtGd2l6c3RDSDZJMUhm?=
 =?utf-8?Q?qRM1v3YMvGKcqifWHzBa5yQ0i2sHO1WG/cSKc7P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c0da7f-26e9-45e8-b7ba-08d94bb9cc76
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 20:06:02.4539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQxtMvWqoHP6oU+UcxhCsHxlE2b7XCgXXQo6SAmkw02/YWQrUKqdJs6lJjBZNDdjcCcvkWTjRwSa4uRvCVioeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2368
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/20/21 2:38 PM, Sean Christopherson wrote:
...

> 
> The other option is to use vm_type, which TDX is already planning on leveraging.
> Paolo raised the question of whether or not the TDX type could be reused for SNP.
> We should definitely sort that out before merging either series.  I'm personally
> in favor of separating TDX and SNP, it seems inevitable that common code will
> want to differentiate between the two.

Yes, I did saw that and it seems much better.

> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F8eb87cd52a89d957af03f93a9ece5634426a7757.1625186503.git.isaku.yamahata%40intel.com&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7Cb658fcf339234fd9030d08d94bb5edf1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637624067039647374%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tdVALNsQGer0Z69%2FyYaRqWYZvH27k%2BmgHdslQlJ7qlU%3D&amp;reserved=0
> 

...

>>
>> There is yet another reason why we can't avoid the PSMASH after doing
>> everything to ensure that NPT and RMP are in sync. e.g if NPT and RMP
>> are programmed with 2mb size but the guest tries to PVALIDATE the page
>> as a 4k. In that case, we will see #NPF with page size mismatch and have
>> to perform psmash.
> 
> Boo, there's no way to communicate to the guest that it's doing PVALIDATE wrong
> is there?
> 

if the guest chooses smaller page-size then we don't have any means to 
notify the guest; the hardware will cause an #NPF and its up to the 
hypervisor to resolve the fault.

However, if the guest attempts to validate with the larger page-level 
(e.g guest using 2mb and RMP entry was 4k) then PVALIDATE will return 
SIZEMISMATCH error to the guest.

thanks
