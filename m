Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8B3FA033
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 21:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhH0T6G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 15:58:06 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:40544
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231320AbhH0T6G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 15:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWlVNnMa5m2mmiKcEmC+g4ckkmLVXyFWsLaEMEljNkgffoqn/St380bCydFojGYyHcbSgZcgggckDhw23T0CECTmIkCmFCX2i9A7WFNFYQ/Ic9tmWq1fojstKON2cbpXz5TU5fwzhN8L23+7byD0cLJNvGXuZzhtljgHzNW6z2Vt5yKek1me5wDOLT2b64D1eMD2XKGuKjdU/V4pkSGZDTiq7yg2M9nZS36FjjV77jjjO51/oQIpz5jDwV4Geg1pitxrDi9X2tncup7GVXsOfKSUaS1UGeY+5+v1UrzSpZkFu9VqoIOy7EM+A3RTTIfcmw3xfk3h1Gjev+gbFl6N5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45lorxETpuLzOCXmuT85eyDCRKXJ32uCX451Wwx2UwQ=;
 b=BRtNxYmXZJcSDvy2ERSWnbpSAhTy65XLEFi6u8Yy0U5JkdZoIMxT4Gh6nXRRQNPw/PVUW93Fl2xLJhSfpPgALnGzCHt5Z//su0ysK4Lm4Pz4zg6FRf9hrHsdX2KRMGhX9qCP1Ek5Ko+BVnZodZZcSwE7Au7UK5MKVboXe7eFqWxCWyFKO8s/PGi5v+wAorRLc53cytKdwKQLvXPt29Bz4WLZStdebI+m141/wXYfYWEyH2bac3nLuvLtrHB4DRjez7+ldSm+Ft2Yx/BpOzCTiSGd6Z2IZsqQrj7yBI9B9RHqhEfBQAhT2dc3dMGMVedJPSP/g2cyLOS9ykLzyYLQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45lorxETpuLzOCXmuT85eyDCRKXJ32uCX451Wwx2UwQ=;
 b=2KeCB5QveeEa1utbvITsTVsoyXBcEaz7WNho+/EJUlmUK0ghvauV8434GCXJVVHTwA3m4awPt3FhF0atcF2N8+viC+nF7B+ZUkEukYpEOIuUpxCiRoaAwcfYt8ocvOFvcUzpCFco+0eCOmiZZzfPcmrVfDsQJk1xoJDWy5tG70Y=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5375.namprd12.prod.outlook.com (2603:10b6:5:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 27 Aug
 2021 19:57:15 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4457.023; Fri, 27 Aug 2021
 19:57:15 +0000
Subject: Re: [PATCH Part1 v5 33/38] x86/sev: Provide support for SNP guest
 request NAEs
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-34-brijesh.singh@amd.com> <YSkkaaXrg6+cnb9+@zn.tnic>
 <4acd17bc-bdb0-c4cc-97af-8842f8836c8e@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <20005c9e-fd82-5c96-7bfb-8b072e5d66e6@amd.com>
Date:   Fri, 27 Aug 2021 14:57:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <4acd17bc-bdb0-c4cc-97af-8842f8836c8e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0030.namprd07.prod.outlook.com
 (2603:10b6:803:2d::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN4PR0701CA0030.namprd07.prod.outlook.com (2603:10b6:803:2d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Fri, 27 Aug 2021 19:57:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf6701e8-bb82-4482-0b6c-08d96994ddc2
X-MS-TrafficTypeDiagnostic: DM4PR12MB5375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5375F28EA65A3ABE872683F3ECC89@DM4PR12MB5375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+4MEAzucWBTEptvAPZXYipDhqIVeYoM6lsS8Adz2+Lbk/em72h4a6F2ruHmjbnKY5QGM1k6L7xZ/JWdLtafT5mOO+WSjqB4wTwdKDi2UL4a+phaLIiRGbIExbel2dM/RTbxpxf9lTASneDyPhybTCnwvfQNvFvIuhsuJCNaGnDsrdWYcoTBh+kh/jQGfxry3utMwpHnEKi5zEV6rMKSu+SJnNSRcLtAG7IFk71IE3KkzqZdxyKNTfCQKOGsvpaBR7Ya3U7s1eG3EiVIN35LVwS9PANExf9OdlDLo3aWBtvyZIVuTreQs8ku2j/LftSNyUdE9zEXlq6n2UOuiV2y5zDdQpDAdjDPWR9o/JaZgnbPhYQVufrCJfew6u4CW28E0shf1bCTJLtP7EdeZATg4yV7zCK5ww3mp8TMAE2UgKVOyC0CfloewaQ2SxYamEe9S1eqI+s/1pff2Ali1FzMUrBnODu48X/bMiT8S0V3OM9sH/EuHeIN0OX3pCmUItS2f7KQKRd0mvaydvVVCATyqxbUoZOWs+UMHBKIN9I/iR325Fpyuh5nFPV/0OmYv1Ot4fYl0AzrFWfzq4EAYNXsatlCTUqvIx0pNX6a/TqLoeer79WkldIYObeRebWTW73xCtYc1TqEgUrsxdFxiBRlPpd0j6qqJKX38aCOsIJdWblm7U0UVXoRG34kaz6to3s++AyMoReQHdn764UmtohpVnJsGtd2T6xY2QJltKDjyEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(36756003)(110136005)(66946007)(478600001)(66556008)(2616005)(26005)(66476007)(2906002)(4744005)(186003)(54906003)(8676002)(6486002)(38100700002)(8936002)(31696002)(6506007)(86362001)(7406005)(6512007)(83380400001)(956004)(53546011)(31686004)(5660300002)(4326008)(316002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHUvamF1V1MyOFY3MmJyeFE5c2JWQk5KbGMzNzI2bXg0eGxpbUFZbXp3RUhN?=
 =?utf-8?B?NklDb09CQk1SUTFqWXM5YjFMbFVVVkFBZW0vOHBabUxRdzBwdVRSVCtOMXNV?=
 =?utf-8?B?SE1KTU5XSnFEcE5zb3VOZks1ZVVtYW0zRHV3cEZVbmU3ZWFjZEhuMWt4T2tG?=
 =?utf-8?B?bjJFNUJyeVhKSkdKUndVRzYvVTVValFJNVlhejE4SGpUT0JSRjJJV2FkcllN?=
 =?utf-8?B?c1lRSkdpK203QVNpTzNPLzNPdkVXWmlrNi91WVpMZXo0aTZyRFUwYkJtZlFS?=
 =?utf-8?B?RWNwazlyb1NMUlNSWVVmdGowM1h4elFyTjJmRU5GQ0R5UDdhQ0lvSEt0RXda?=
 =?utf-8?B?S04wRElwOWhYeVFyRmhpNEJnZEFDdlFnQytnSnpnVE1Zc25BYmFvalNJYm40?=
 =?utf-8?B?QXR3d0FndlYvNS9PZVlsbFdhTkY5bEdLR0t6K3pPNmVPdkVlNG1EVVNoVnV1?=
 =?utf-8?B?bHcxWDFXc01hbGZaMlZqT1VlSkRtak85ODhJMHJoczlQWTM2Q2NQNms3WGFM?=
 =?utf-8?B?c296ZGozTEUvQlNJQkZ4YkcyRk1yWWt2YXV6UWRldWxpaEdCbFdTalVjR1VF?=
 =?utf-8?B?Z1U0OFZDMnE0Rkh0YnlzWC9aTlNFdVBPM05LL3d5ZEZsZFo1ZU50WlJUcHBB?=
 =?utf-8?B?VWlTU0lZbXQvZFd4c29CbXJ6SXh0azNTSW1XcFZrdUxjWEVPeWhremZHNlNM?=
 =?utf-8?B?WlZLNkQyY3Q2Ty9lTnpWaWJDOFg2MlExMzQ3aU1HNXZNdU1XVEtxemFNUWRw?=
 =?utf-8?B?bUVvUWhYbDF4RGE0SEJyeG5VVVBnd3E3eWYwODhReDRWbm9lVlc1ZXR4elBk?=
 =?utf-8?B?U0ladlViYXNZcmg0OFF3OU5Cdm1WblVPMFE0WmE4OXpoOHBNMnQxM3dvM0dn?=
 =?utf-8?B?S3FBbzE3dkQ2NHFnV1NZdll2Mm93RStOZDBaenpYb2tBRG1sbjlmclZMNzVq?=
 =?utf-8?B?ZU9HR3NqWWdRR2haRGlKYnFCWitvU1VYQTFUSzVFYkFNS3FtS21ucHk3bWVj?=
 =?utf-8?B?ZzNPMGVBaTlPUy9wOU1DOHUzTFFjdThBbjBFZi9uOXVxTGtGSE9CWW9GVWRH?=
 =?utf-8?B?SDI1VzNkdzQ2OFlPNitmY0tVZjM3dmswamJOdDVBa2kreTM2bzhON0pCcTR3?=
 =?utf-8?B?anRBZWRackpqbTIxS3E3U3haTERFNGw1MzErTG1lalhLTEFBNlV5c1RSK3FJ?=
 =?utf-8?B?aTFaRFlza0ZGcHpwMlhRVXUvc1ExVHFsVFZOME5iT1FqQVVaZUhPaWtRTm5W?=
 =?utf-8?B?SjNIRG5yMldkMlZQZFFyeHZ0WTREOEpUMlowUXRQZUhhRmZWNnRoSWtCS0J2?=
 =?utf-8?B?Wi9Bb0dBaHp2ZzA0ZGFlNEhxUlFjMTFyQ1hSNDd5U3NtWkhPVUg2Mjl6cUZq?=
 =?utf-8?B?T0NLZVZqSGpCNjVscElVblEwVi9iRWkrRm9FQTFKam1QdXQwVUVsNVltU3gv?=
 =?utf-8?B?RkZpZktqMjJkVEVGZWtLUm52dzZpUnJWVWZwRk9OTWY3dU85aUY2WUpvbVcw?=
 =?utf-8?B?d1JnRjNjeFRBc2VKT3ZsQ3FXNmovcUNBSUZkenlLeUhjeVUvTGZpNEJzbUU4?=
 =?utf-8?B?OFFIVTl3and1RnVIZ1ZPVEQ1YnBmRmFqYkQxUnRlTlJPMjdUNlJrQThwUGI2?=
 =?utf-8?B?RUZQSGQvZEtSYUxHT2p3T3NReGJKalJkc2ZROUdRaTFHR2dBRUVla2hybmJn?=
 =?utf-8?B?K3U1cWYrT2FyeUx6YzdTRk9vMEE5UTNaN0VlQjY3NUN4a0hDYnJGOTIzbTRN?=
 =?utf-8?Q?fFlQvp38R3y2BfKtSGJmQZXkEeSXcj7ucGiW1EA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6701e8-bb82-4482-0b6c-08d96994ddc2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 19:57:14.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29xwPnnqrSd3Rg8gR30P0NNqWPzHX9o1QveRU+zs/ZQB4uZOAtBFEetG8P4eMfiVvJE2BR882kmX13V1Zo+CWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5375
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/27/21 1:07 PM, Brijesh Singh wrote:
> On 8/27/21 12:44 PM, Borislav Petkov wrote:
>> On Fri, Aug 20, 2021 at 10:19:28AM -0500, Brijesh Singh wrote:

...

>>> +
>>> +/*
>>> + * The error code when the data_npages is too small. The error code
>>> + * is defined in the GHCB specification.
>>> + */
>>> +#define SNP_GUEST_REQ_INVALID_LEN	0x100000000ULL
>> so basically
>>
>> BIT_ULL(32)
> 
> Noted.

The main thing about this is that it is an error code from the HV on 
extended guest requests. The HV error code sits in the high-order 32-bits 
of the SW_EXIT_INFO_2 field. So defining it either way seems a bit 
confusing. To me, the value should just be 1ULL and then it should be 
shifted when assigning it to the SW_EXIT_INFO_2.

Thanks,
Tom

> 
