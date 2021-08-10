Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE33E5AD4
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 15:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbhHJNQR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 09:16:17 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:54890
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241140AbhHJNQQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 09:16:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLPpel5WKC/03XzWY3zFHi3svu7AVqsWXHynMOPT77s+j+sDPYYuqvs+hlWcdJliIqNK+z+6uCXetdk4KbdQWUAeYElokfb6FI+wV2MiRJNM+BS3JZkBIJLh6wZUC0A1Y2+C4VS8Dyj/wCP/maN4bAQ/KNjo2j0V1c/dJB/uM2OX1Di4ykWErdktlDi3Zqu/fdnETV1iCm5WM9i7urJEaUQYMtW339dORFYJVdImrnScoUjf9eaOxuTipC1E/xFdQsf1vRlPYXLynH5KZdKnOfOGXaJ+nn8+UzA+wxQODmHMc2ceEVVDJ86BOswaoHYDRHRIipR2knlxfRqCMcCPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zQHIp6qeXMl20C8ENI6THdS3vB6ZH+H1AAceaMYgoI=;
 b=Xno5zPYmc4CHs3zMZfUkSMlUm0aP/VpbbqSPdzyOVmqTV/5onwHgh5hzCkmZfovwj2FS9wIqNdlSXNeskmOrNva62t82UEYO3NPP3FkLEuY4BUB610MSwCXhYO9Tok/k+DjGsV56ZFe8uYsEjxFepDp89soEUEkOyZqukEPjp5QAW+N/WKaTKk7cZJsSD/WIOrr7UR78bzIYjlcXuBOB2rGynh6axdN/EZSK2Xq1ArbxznxfjP8IZZQ8ikqfE6MLoaQnQAs9I7cGQs8vjKich6RTHMwL+wbx178RzPP/DysoUoQcULHjTKBaBolTlVcyRGUuo35GpbjlTLH8hyxX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zQHIp6qeXMl20C8ENI6THdS3vB6ZH+H1AAceaMYgoI=;
 b=5ayQXLhsXUKp8Q1GbmDa+nm3xl/7fatROuTr2qd0GjP+FRNhwlmhJT5RhYikFlk2LLJuRJSNYD9gNFcjpC2Bx++s6iCqpLwLFUZ1L14n+dCe8tc8Hp0FbkSs4yO5Jwz2KLw170Do2TzqmSPts4ojUtSQ8IJFtXBjBSX78fpqX+w=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 13:15:52 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 13:15:52 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 02/36] x86/sev: Save the negotiated GHCB
 version
To:     Borislav Petkov <bp@alien8.de>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-3-brijesh.singh@amd.com> <YRJEE6C/NC3Epa8G@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3b156915-3761-67f9-4256-76196bb87a7a@amd.com>
Date:   Tue, 10 Aug 2021 08:15:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRJEE6C/NC3Epa8G@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:806:120::35) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN7PR04CA0060.namprd04.prod.outlook.com (2603:10b6:806:120::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 13:15:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef002ab8-c97d-49a9-30da-08d95c00fa69
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4384520E480DBDC870983F91E5F79@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCNJGW++nUUuuJg47lNLcRag+nThIwX8HUgnoaOYmEWw1W6MxiRnp/g+HkfFM8WkBWio4wNYnoV1W6yGReYIIvLFvz5DzknSbCn75mnBDjrEOBE+SjJBtVLpBIIAb2zwnEMEf9HMUcswgPRm72VyLeKvjqTOAVWjBAyeUcsQe1pgPD7tMU47zhqfpB7AU9SuDlVy+i0azAGt7JZOhBfnpKvy36q6A1XWDrYuwyiUAVllp1et+dEhW05nEbFXkYpIiOn8NP3DAZdMsY49HVvKWsNCPZQT7Kv7icb/uxuRO+mSaBKdN9my67zmb3Cu4mp60cAV3y2I5W8yHy7R2nqGAbpYYaCgQVLuZkS6UeX7CiRx05+EMaAVfVN3BfuP4tSVRgHXClF1jBZ9vblBHJHnL1VF4NHBSoQxNJrdpVIqs8WGtkduPTH/AE9flVvMiATrQwgjHxcd0ZFmd4bdzfA+kotgX/ErFVDBPzvTe/oM9PLZWXR3ok4NFZrri9mXvDAmlW65fT4S1b79y313GUjiOWO3PUhzEmTQ2JaCTVbUURAm5xE15keEWrgiVYA8ZilFz2OjSWJcnV03pA2HooMpPMFtif7MqEPPe650MtLCbds5P7sTcPABBAD586Nw2iFl0dUasLReYdyCUkxhjnMiyFnoaN9cxVDgwTX0NM8tM3cgJt+G2Dwi2MF9Ls0vGrrfNyx+iTxMHwGe4aWLh4LggXDqEQwTUm1NhrUc4ExyL82U9zHOOPi72B/4EGLNXtUYmLCgkD4X6iciC/tu/gBm1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(2616005)(26005)(38350700002)(38100700002)(186003)(956004)(4326008)(86362001)(6486002)(44832011)(31696002)(31686004)(53546011)(66556008)(5660300002)(52116002)(4744005)(66476007)(316002)(66946007)(54906003)(16576012)(8676002)(7416002)(36756003)(8936002)(478600001)(6916009)(7406005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWtOMmErZEhPSHZtUWdsQkMvVkZQZnBxZXYwWGFXQnFZclV3SFBRVVRUS1Ev?=
 =?utf-8?B?TkNOcHkyb2xCY1BCYTVTVExxRnVrckFMUkpoMkk0Q1NPQmhhc01NYWhYWjFW?=
 =?utf-8?B?QzQ4K21JMjZjVzdaYTZVbENNdFV4SWNUWjg1bHE1NUhkenBKZndZY3BMM0RN?=
 =?utf-8?B?aUJtNGxxSzR5RCtPZnhDaFA2c29CR0JYV2dZRTgrVmozODZoOGNvU3FuVU02?=
 =?utf-8?B?blVveXBmc0E1Q2JHTzZBa3pYckppZGZoT05CQjlNWkdtNjU4RXRjWnN3VkV6?=
 =?utf-8?B?dDBlRWZYQWFsYm1JUDFGKzdFMC9SdEFVazBFcFFaZm9UenNWQldrQVg5b1B5?=
 =?utf-8?B?bS9lcDVtS1pNem4xVUNGWFFCR0pseXl2Uit2QmQ1L3NqaDZmMmVtWHdzenNX?=
 =?utf-8?B?T3RJc1gyS0lDRitvQkdvRG1jQjhKZm1yQ1hzNTB0b3ZiWVVZckI4c0dwOHVn?=
 =?utf-8?B?Z0pOYVZHT1djRmMxNFVGT1d1cjhsZGNXYmhYaXBEczBXZXBxYUpObnVoMUlL?=
 =?utf-8?B?bUxzc3R0ZzJoUHlNaHl5bjBnL1E4YjFadG0zQndXa3h6VzFWekRUOXRteThZ?=
 =?utf-8?B?VzBMYU90d2FJeUJTWkJ4SWUrOGVpK3lySDBMQkw2VnpoOXY0S3FmejdpbnpW?=
 =?utf-8?B?VStEUzhVQ2dRL210YUxrMnZYR0k0QWQxNmJQZEsralhRbjBiZ2lFVHZyZGEx?=
 =?utf-8?B?NTJxcmY4S3grZFpWQzg1N3lYQ2tSU1ZrYXlxbXAxYWVxSncveTZHMXBRVjdw?=
 =?utf-8?B?U2Y0a2xRSkEyVjdpN0ptdGptbm42cVRrT1p6QVQxQnlLbUd2a01EdTFWc2o1?=
 =?utf-8?B?NThCK2FIQzA5VjExY3hnVzJXbXJSWWF0UVZnN3hBcHI3Z0h0TG1GNGdhcm8r?=
 =?utf-8?B?TDhETmpqVi9ON1BsaE1Iby9WSHBvNldrZGFCSUlBcXlQWXFXcVFEc25wNzJw?=
 =?utf-8?B?QTZLRVZVbGcrWDkxaHJDQk1CbnBjVDZGMXlDa3NIQm10blZDVnJQTktid0hi?=
 =?utf-8?B?dmpuUXlzMkdVaG0weTNWUit5QWorMEFWQllsOHNwVWhtSXdINUVlWEZqS0RW?=
 =?utf-8?B?UWxTczZaRVNPRk1memdjVG03UFhYa1ltY21JYm5UUjVBakZ5cVBXdUhmZzYr?=
 =?utf-8?B?YWNBZ2pFZURHeUNGTERpbE5wK0Z6TjFmNllvMFZKb1V2ajlGVksvT2I2eFBC?=
 =?utf-8?B?KzVYV0V1V3Z5eU9EQWxjNHFLcGt0M1FoeVdjVEpSbEkyUER4WnRrYk5VTDBJ?=
 =?utf-8?B?Q3I1Y3ZZcVVoYlFYQU50Rms3Mk9VT2Q3eDlGb3hKbTBDM1NZMjl0aXJrWlFt?=
 =?utf-8?B?eGgvVmQrOGw0YmJVYVRYZlNsaWF6OVJaT2huS2N1azhxaFVBVzZTOXhqMGhV?=
 =?utf-8?B?d0dYcTBJUWRkeFRhQ2liR0g4QlRBRDNjbW9ReTlycjg5ZHdSTWRRR3M1c0hn?=
 =?utf-8?B?L3EzSUc4ZnptdWU3VWZHQWJXU1JtNlVCMEc5ay9XOFRHZGVUUUVHRDBKQThC?=
 =?utf-8?B?UnBXQnpya1BqWnFVNVF2dUpITk44VitBOW4zeFRSZThtYURDTWRSMnFITU5v?=
 =?utf-8?B?RGxYejUxdmFRd3psVHlJRHJRZjZpZXVLRWc4QXR0MC9CZkhYQVNpeHRQd0pG?=
 =?utf-8?B?SEJoUVhSRmY4b2d3SWZQWlZNeDh3VmFGTkdwQlE5TFVCSDc0UnovVnlmcHpZ?=
 =?utf-8?B?ZW1oUkhwZ2dleW81ZzYwTTdtRzdKNE05Q2hrazRReUNlWFAvZDJjVzJHaTFt?=
 =?utf-8?Q?UY5jgfDkZHc6flI4pFbKG3rXrZpjtpcIU3SKa8R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef002ab8-c97d-49a9-30da-08d95c00fa69
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 13:15:52.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SBnt7BlxHrDDbgfZt5rJVdKm7HJoJBudycWUeRmieGhSUcfPu9UxJtMgUDdsY1kdRIPWqhnZXXRJ9Ei8Cj4FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/10/21 4:17 AM, Borislav Petkov wrote:
> On Wed, Jul 07, 2021 at 01:14:32PM -0500, Brijesh Singh wrote:
>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>> index 114f62fe2529..19c2306ac02d 100644
>> --- a/arch/x86/kernel/sev-shared.c
>> +++ b/arch/x86/kernel/sev-shared.c
>> @@ -14,6 +14,15 @@
>>   #define has_cpuflag(f)	boot_cpu_has(f)
>>   #endif
>>   
>> +/*
>> + * Since feature negotiation related variables are set early in the boot
>> + * process they must reside in the .data section so as not to be zeroed
>> + * out when the .bss section is later cleared.
>> + *
>> + * GHCB protocol version negotiated with the hypervisor.
>> + */
>> +static u16 ghcb_version __section(".data..ro_after_init");
> 
> There's a define for that section specifier: __ro_after_init
> 

Noted.

thanks
