Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAE23F50EE
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhHWS4z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 14:56:55 -0400
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:60225
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231207AbhHWS4z (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 23 Aug 2021 14:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es5T8XvWrQ55qXP4tF3W0S/X9YbQokHJwvK9SBiBBUBctQUbKnyAVjBfaUBNzHH9zxE3Uysm0B8Em81xJ7jbJcdlzVR3mPwcNF8U9X5joVU1w9I/OWQXwOJtRlx2xC1OgwmgGp3V9mezq3JcVgOlSGRKr5Kp7eEaiIW7FPYtI2yoOZ8RNWpWTyIm2GobuH3UiMV8hZlDCNvb+Jx7A40zW9Kl0Ab02UaciC3ins5Dh6Y6ZnR7hNPulB1jIyd8PrYunpmhzqWF6qNshWWTkVfetByZSuPc2GTqITeJPPAUwSrnwJvUBoWyuigL0KdYeMOJJvPVyJqBcRY6bfYiPUnXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvmwwBZe4F/fPevWhCUKG1dGx6rd9RXG1/t5H8RbPTQ=;
 b=P4S3pqGHYHCTrJKlGOXHizC3Q3ZNzNBsdAWAPT7VnvcZnNAPf0nXz75MjHkYkfT7+Nnu54sTSSFLLsHmP6sfRp/rVdVnjGJ70JaDU87OebK3+BT4+EXtQqgToVaQSNx8e4vilHlaUp9UzK3zqgL2ntgN/bkUuzuMc/R9+8MIt1QOJRLBpjCvewWdMR8jIWpP/b3yqNShKa5Ho9uyP9gBNSCZiqHzCKKMzdCWXFUmpdCI1PfKBtlC4d0F6csg67ALv8cbmBSetYWTgHdAKvGSwGeDXG2IUDfrmP1hN0UH3uS/H22NxkGYDr19CuADllcHgJz9dxIy18kEGWT5aBVw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvmwwBZe4F/fPevWhCUKG1dGx6rd9RXG1/t5H8RbPTQ=;
 b=WT5265C1hPVrVkvN0ObYGg5whAWY/L9TyrHl0app5NGH9wZTeldt+hak2AVI1E3MwMdh7Lbh7BjCaVG/r4gZR9tUKt0Ccm0K0DGwLmthCnogmjysLBj4vTzdg5iBoO1bRYA7myJpjf7ona//qHL1538VECYQ6/p/VF8DCT69yOg=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 23 Aug
 2021 18:56:09 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:56:09 +0000
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
Subject: Re: [PATCH Part1 v5 13/38] x86/sev: Register GHCB memory when SEV-SNP
 is active
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-14-brijesh.singh@amd.com> <YSPcck0xAohlWHyd@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <815a054a-b0a2-e549-8d1c-086540521979@amd.com>
Date:   Mon, 23 Aug 2021 13:56:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YSPcck0xAohlWHyd@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:806:f2::26) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN7PR04CA0021.namprd04.prod.outlook.com (2603:10b6:806:f2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:56:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33ee0ef2-9c2a-4417-3e11-08d96667aaf7
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2686675B311BED58B426AAB1E5C49@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FhCixVhCUUq9KtlUzGuiT9K4FbycF2JY8QEdXdixODPqS2ipy2m80MqoKlfyPhdR2noXv/qQQ0YaLF375lkRWFW06zgskU+4m0qGeoQiJnhG5meMByVpULyp640S5FXjTVeQPizGRgWiwqLJq28xI6+Y52kuS+RiSod7ilIpdXChUCYSmP9SScglh9ndAhQbJKwJ1Ia2vGzk5bN9DctNVUTOgC4DOThZor/AG6K1FtpAztDi9jtwPOAlxpgb27AB9xlf9hQug4gOzbdzHG6s0Eicc4tOpks14IWXPjultx1U3MkzXG0Y5biL9/EkeA9QioGFINvSoX9afZypysAE4rjov0PPzZGWGpVswZhdSVaAlDB5vOlHX25jGBpbctru2K8MSuFTmUzDXDoJIMgy/lS8W4i/2YfM3JcHT1XpxgssO781x9HTFbxdOmU1oiUM3E051cH3Kgp/0yKoFdgIEVGIlyjpaqcgyMh1bzYdpuo6nsqNI7JRIyFBlIqlrZsBSJFs743DalRtUvU1WXpTAI7mZxJwq1XPUDzcI0Kw3z3f6E4QJ23E4WFAfYtfhOnCzIt+EyfjYmKnFropMRk0c37iCyvUBpRIY3ogLw2+7vHl6n+0XVKHXYwx85Yhkm7nVyYPWG+if074VEz2X8M8BsVIvqEpuSuN/YW5PrQWXj0yeK1kxdbGpbJA9CopkeywA0rRhfaodBQiLDvRl3bibacRl/KcYIRZ58ARCZT4DpBSovduAaxRlFjMZ6P7REqfTJmkHaNH273GomKP3lhCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(54906003)(8676002)(8936002)(7406005)(16576012)(2906002)(31696002)(66476007)(956004)(7416002)(44832011)(316002)(36756003)(6486002)(26005)(6916009)(2616005)(38100700002)(4326008)(66946007)(53546011)(508600001)(186003)(5660300002)(86362001)(52116002)(38350700002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzFtc0V6c2tpcGlWZXpxNlZ4VXRSb1RJeDBJYWxBNmdBemk1OGhFenUwUC9P?=
 =?utf-8?B?bTZOaTFqQ3ZwTUIzNzQyZUYxSjJDdmNnRnNLZnFKUXlHR0p3U0RtRm1ldlZG?=
 =?utf-8?B?cWlWZzlFWE1lLzk3TDV3SVlWR2RXZkNDZGFOc2pJbEtRRlZxdkErL2YxZmJT?=
 =?utf-8?B?dmxmN3N1U3BJejhHVkp5V2lBQ0FxUVFzUkgyMUdaSFNmMVN3a254WUNlN1RE?=
 =?utf-8?B?RTRob0xOaWR1eUFLL1VwdmdtRitzam9TLzNIcTRFaDJSVk5VYUJZMU9PMFlG?=
 =?utf-8?B?VHpMQU1CdDF6U2hjS0JaeE9iNTJpdXhhYzBFZXV6bmczWXN5S1dxaTBFeWJB?=
 =?utf-8?B?Zy9JOFJZdWNHd1VNS0ZLQ3M1cXBncHp5MHR6cURNRGNiV3d5cC9WcGJYR1Jr?=
 =?utf-8?B?elRkSVYxNnEraTA0R0p1WWdNMVFIaFFpN0dpTnZ1U2E3K2ZVNlduMUQxWEEv?=
 =?utf-8?B?WTArZXdDeCtON0FEbDlSWEpESzEwdjdPN0ZuZGdkZnJNdEkwOTBnNmdSanM0?=
 =?utf-8?B?RDl6eEdhcHpoNktaMGprQlY4TnZmYzU4N0VaSzA0bFFBb0t0UmJPcUdwOFkv?=
 =?utf-8?B?T09rQ3V1ME9SdnZwU0tkOXh4QlpmeDd4Zk56czdkbGFxcFNkemMyYzUraWxn?=
 =?utf-8?B?Tm51aS9sTjVZTGVNblVnY25UT0tNUFFqSkMzZzh5QTEvVXlLUkYvNEh4eG1D?=
 =?utf-8?B?eXk3WlN1dE02cUVUZnNsRTdzL2ZibHg0bFg1K0kxcitJYXhBaC93dTRhcFgr?=
 =?utf-8?B?RFg3bVBQL0N4Slg4SnJqdDJtdm5BQmVEaFFob2g0WXBDZk1IQmZEU2dmNHdt?=
 =?utf-8?B?d3B5RTM1WlpCcGFYNnQrS3J0K0dQcTcyY0RSNUc3SjNvUWtuOVVJSW5BSjI4?=
 =?utf-8?B?eWplWjdQdlJEUHdXY3dENmF5ZVdDZTVZU1pPVGJKdFBhNTk0dk5TWUVaNTFJ?=
 =?utf-8?B?c1N5MnJpamx1cHEyV3B5WS81ZkJqWS9xWjBxQjRJdHpXaXhEd3BSdWJXcFNh?=
 =?utf-8?B?OGFML3ZYZGhtYmFMalBhbWUrWXZtNk9POVlvNkFucWxSb2tERkVJaFhBKzlM?=
 =?utf-8?B?NEZyL2xqOEx5M0VOWjhjeTRrYVQyemU1cUE4WlEyeE5kOXBxSUJXODZIRytk?=
 =?utf-8?B?elJ2NmVDOUtnMXV2bFRxdFkwaS91SnlTUURHd2ovbmsxeGdaNEVockhmQW1D?=
 =?utf-8?B?RkNqNnpSQm1ab3dQbVQ1S2hkRVY0QTVZMEN4d1YzR01LODZ1NU84dkV6U0l2?=
 =?utf-8?B?ajFWc21CQzNTc1Evd0wxT1NhVlVkOGlMS2JhTHRWRkFyS0k3cm1zZ0MrTzRS?=
 =?utf-8?B?NGUrcnlQcms5LzdXZTJzVk16ZmU3MXpUcDkxZzcxSml1UmV5dU9WYUo1RGQv?=
 =?utf-8?B?VGkwSE9mak5kS1RFRW4xWnlSQkRaT1BYVHVtSGQ2QnB2UFhxK1pxR0JtZlNj?=
 =?utf-8?B?UmFucXprQTlFMjZzN2FIK0VlMW9STVFyOHU1TkhVZjNpdFp0bHB0UVVqUmhL?=
 =?utf-8?B?ZVRVVnhzQlRnRVpwWXVQV0pWRzFCbG9YUmgyTnQ1aDlpaEtSbS9NdzRCbUxQ?=
 =?utf-8?B?UkR2eitTWmtOZTd3enhrNnAxU3dNekdkTTRMVTRoTzdTemhaTEg2Rmg5a202?=
 =?utf-8?B?Mm9VdldnZFdBS0VENk9xZ3h5V3pWdlZTcXVZUjRRc29jd0VOQkJhaGVHWS9L?=
 =?utf-8?B?b0pmcnQwczBoTlFwdXc1eEpiOVBrRGJaNDdLb2RzcmwxanJ6ZWVtNHFTZXlo?=
 =?utf-8?Q?CwSfvZW8goeUZshE7UpXwZd38eWsZHKHet4lHG8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ee0ef2-9c2a-4417-3e11-08d96667aaf7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:56:08.7809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uK6QHm2PXLkegJDvTg4kbWnAEMtht30JipU2rbYhHwOQIcnOYzPFcT98yFdD6cidIg97M58Kknrhb0sv70kqew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/23/21 12:35 PM, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:08AM -0500, Brijesh Singh wrote:
>> The SEV-SNP guest is required to perform GHCB GPA registration. This is
>> because the hypervisor may prefer that a guest use a consistent and/or
>> specific GPA for the GHCB associated with a vCPU. For more information,
>> see the GHCB specification section GHCB GPA Registration.
>>
>> During the boot, init_ghcb() allocates a per-cpu GHCB page. On very first
>> VC exception, the exception handler switch to using the per-cpu GHCB page
>> allocated during the init_ghcb(). The GHCB page must be registered in
>> the current vcpu context.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/kernel/sev-internal.h | 12 ++++++++++++
>>   arch/x86/kernel/sev.c          | 28 ++++++++++++++++++++++++++++
>>   2 files changed, 40 insertions(+)
>>   create mode 100644 arch/x86/kernel/sev-internal.h
>>
>> diff --git a/arch/x86/kernel/sev-internal.h b/arch/x86/kernel/sev-internal.h
>> new file mode 100644
>> index 000000000000..0fb7324803b4
>> --- /dev/null
>> +++ b/arch/x86/kernel/sev-internal.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Forward declarations for sev-shared.c
>> + *
>> + * Author: Brijesh Singh <brijesh.singh@amd.com>
>> + */
>> +
>> +#ifndef __X86_SEV_INTERNAL_H__
>> +
>> +static void snp_register_ghcb_early(unsigned long paddr);
>> +
>> +#endif	/* __X86_SEV_INTERNAL_H__ */
> 
> I believe you don't need that header if you move __sev_get_ghcb()
> and snp_register_ghcb() under the #include "sev-shared.c" so that
> snp_register_ghcb_early() is visible by then.
> 

thanks, I will merge this in next version.
