Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4733ACCE4
	for <lists+linux-efi@lfdr.de>; Fri, 18 Jun 2021 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhFRN7a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Jun 2021 09:59:30 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:49003
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233754AbhFRN73 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Jun 2021 09:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJpT8D+Mit5VVUeeXfkU9q7r9HRJaXqXRldivCM9FfGf6Lne/9oP9OGhxA2IFuVFSngOwD82JAHJlK9GdDUCOhAPetsZPKLPvGyFgI2pNwWMmpYpePgbZ+ncLZH9Z+SNQtsjMN86IQlacxRrtCVt1V6yFodch0VBaYKRq+6alc/cJolLzX+XuHkWwz2FqtwirHWLCFB2YU3LHsYXzZwfV8yR9Det5tS0FZvMS0WpHTTsxsiPqWorFQA4XbFwGnh6QZovxLGNjBlzs1AW5uEbCiMXUWCGkZcxYst4AV8Z9zpjxvrlLn8eI2Q1GJLsmduAOQLaoY/8exMQy6bj6mD9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6yR7e81+fcmZ5z7QU4oCIo9QBgH6IG4LuBexB9gWPU=;
 b=MdCPUqmdxuQujqvHf1eQwLbT7rqBYsFdii4ENQ8Zz6VVt0ftVU8RnwlFFvNZuvNzlTMnm/hRHIhpMapR/jR2RmJwePyRAYsP584wr66jyMgmCDRlzI7ALb8kahkpG1tZ4/6pQq+UZ68oi7i1xUTji5ugk0r5n03/jUnzny+4/OYUwdWQVT8vQYB2R2jgvxIOppliZnXf11IVtYxiijWJrTs3TmFuANqRIbJ3BNoBeeD36ADdtAa/EaGLNItdbG2P7ta/45ousHkIMTjqfnzzB1s2Pr0PHGfRsr+rsozjVvWQ5A8ZgBm7tJIskAuqGammCO0kn77U1TcVakYrleecZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6yR7e81+fcmZ5z7QU4oCIo9QBgH6IG4LuBexB9gWPU=;
 b=wmi+/qR888PGJ5UNN5i6tkOksuzBOzy9ZzJlLqf9nNZaYay0lXigr4C6Mah8LJ/U+aT2XCu0XaiKz2LmDzzGUyy1kPfG7rpHUO/6h3sRKhbe0OUu2c7p7Lq+NklCNsT+bt9aCtGWHu987zV1xCz6qzQUmaYRr74Pf/5eTlyBmQA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16; Fri, 18 Jun 2021 13:57:15 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Fri, 18 Jun 2021
 13:57:15 +0000
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 20/22] x86/boot: Add Confidential Computing
 address to setup_header
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-21-brijesh.singh@amd.com> <YMw4UZn6AujpPSZO@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <15568c80-c9a9-5602-d940-264af87bed98@amd.com>
Date:   Fri, 18 Jun 2021 08:57:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMw4UZn6AujpPSZO@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA9PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:806:23::31) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.12] (70.112.153.56) by SA9PR13CA0086.namprd13.prod.outlook.com (2603:10b6:806:23::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Fri, 18 Jun 2021 13:57:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 784ca967-7cf0-4436-2374-08d93260faa3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4154E8FFE99CA5056DA5BA51E50D9@DM6PR12MB4154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pd/avOOgBjIWGEK0zFNVosLnC7P86pQPQK81hbkwxmKt4cbE6FsTehEbz9EQqqSplJQcOCbQqdW9PrjLrLOQVJTzP/Q9Dpp/AL8kikqLV0AXtff3Prwm0/+NBbcYXPwun62JAxw+FwhW5f9kyZubFKlYf9dIGBh3c5sBDGwEzMXQ9NlnexYzu8HBsn+svU853lZYYpU/qlXzaSDhrujwU6ZY1rz3UgzhbVbmkFOJz6XgLa6lQdv330GcxL9ibF2eI+2xBazQOsWOsESg0qFSITVnDQDZ0g75iUE69NUn9fscW5FpC7k/a4fVgeMPj6vKZLrOAiSUNrRXuuHPJqTepmxutnpSWJlUfhQauvst5gYy5v5F1MOLE5RrYUtFRSQH0dsGXVTmms2tIi6KleCuOPpNCdqFVVRC3VyEEFMf2SaXhyYl+IaC0QGdpmprHJI2Lpqqy3QtNyGe/VwvCVbToJF7WYs2E92OGoiqeOVgxobAsvCPquio3OaoPh85T2jjeUjJ3VpNaCT43/or1QJi7g7RFNAjoiRBMBKbasd1OJFcAOpNfgrFzNF/CErkqrK3dHvjwUKvbEvejrRQZrLz44AcmOh0pJVx7t+gjP7bMLWyJHAosWKTsZsdkfK8uXkl/O5iZ2o7I7cl+lEpWzzKzHouwR4jqylZ7vFuwR2zkJ11jwp8p1TcXEytasKYtsXTYkTnqWmvTn8Rdwk3/l4q5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(2906002)(54906003)(5660300002)(8936002)(31696002)(478600001)(44832011)(52116002)(4326008)(83380400001)(36756003)(8676002)(31686004)(86362001)(38350700002)(16576012)(38100700002)(66946007)(66476007)(66556008)(316002)(53546011)(2616005)(6916009)(956004)(186003)(16526019)(6486002)(26005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmpadWQ0WGJwZnJQRmJtOUUxKzI4OSs3M2Y0dkZ6T2ZXcGxvSjZxMThaQ0Zo?=
 =?utf-8?B?LzFaNDdOaG5JdVBOV2VnMnRLV092eHhLRkZrK3BXZ2NhUkJCdnNsQ3gvOVBE?=
 =?utf-8?B?WVhBcFlFYlJ1QU8zSy84ZENSTFdMend2VnRNalJGZHJReFoyRFJ5RXROdHNp?=
 =?utf-8?B?RVJaVy9hT2FJUzlaNVJzTy9yRitVMXA0Zm01NE9ZV0xnM081WDE3bmdWcHFZ?=
 =?utf-8?B?dGxvR0RFWm90T1lZTURmOGhpbms2czlRQ0tEekFTWi8wMTF2OE9pYUFJTjRp?=
 =?utf-8?B?ZVNZaGVDRGtqeFIrYlp6aVJtcmROc21YQVFsZVFOYS9WakxhVy9EY21GOExl?=
 =?utf-8?B?Zkg5bE9peU9RcE5XeE9rYUxGcFNsa3VSV0dZZTcwbmZZS29zR3JTdm05eVpI?=
 =?utf-8?B?bmd0SlAwTmFFbWZxamNBVnlXS2M4SzJ3dGpIcDBmdzBOOGNCY1JMcnlMWE5F?=
 =?utf-8?B?YytnVFFlKzRZczVmYVBzbGZYS0FNR3cyWTNTOUFNTys5TjZnNUMxN1lRcG15?=
 =?utf-8?B?TWRWZE1GeVdycGJlVVpyWkN1QVRuQ0s1bHZ2YTJOOHVCSXpvQktaTmFmejNT?=
 =?utf-8?B?U1lwaEhuNFdqeElwR3pLdjN5eUFKeVJtQWhCSEVwd01WNnYxNjF4S3pYR3Vt?=
 =?utf-8?B?NWovc09iYXNnMThFUjFucUdNRWhQMnJqSnFJaWJvWmxibGVGRFRzWUp1TEhz?=
 =?utf-8?B?SXJIZjZDNGFzeXM2UTI0UTFheTRRZXpqRllJSktNeW5yM0lEdllzM09NQll0?=
 =?utf-8?B?R0E4NW81U2QrUjJudjJrOUVrWFk0Zm15ektzV3NwcmVDdVVPRmw5V0ZiTGh1?=
 =?utf-8?B?U1czeEdleDhCd0hEa2Z2Nzh3bEtFeDYyMXBkakhpcDhTSTVXc1VVK3kwbXdE?=
 =?utf-8?B?ZGN6L0pRM0hEVmFocVRXQW5vclpycFFaSStvRkZNdTd4UDduanduVTRoa0Zo?=
 =?utf-8?B?QURkK0dwWElTd1BNS2pZYjl3YmRzTGZBRGl6SkhPU0QxTHBobkVYcmhoVTdt?=
 =?utf-8?B?RHdlRTV3T1BFN0ZtUE51NXY4SlloL2ZRaWRmcXhSb244UmFuRDkzQ1lnRmcv?=
 =?utf-8?B?WkdaTmZoZ09tQ1lwZ0FUdFhLdk1UdGF5b1FEaWRTSldHdkcvbjgvcU9zOXpI?=
 =?utf-8?B?WGRtNEI1S2s2dy9kYjQ0dHRnUWhoVk5YQ1FXYXdoMWx0Mit5eEJFMlYveWdG?=
 =?utf-8?B?dm1IaEdBaVRzenUrTzNjd3NNU0lPMndQZVRuUVVvbWEwZm1DMlZGTllMMmNx?=
 =?utf-8?B?NWVOTEE1NHF0c3p4MVVyWVFxY0RsbmRLVHUyZWp0czdSZm84eW4xcnVDWHpZ?=
 =?utf-8?B?S3NldkV4RU9vTjErTXl0ZEFTNS9Tc3czNStwYllsL0hwSmc3SHhqQ3dHWC9C?=
 =?utf-8?B?aCs1RDIycS96U1FjZTBMVWZwVFpLLzB1YWpvLzNtY3VpOHE2ZSt2RkxiTUpt?=
 =?utf-8?B?VHNtZHduNXI5UDloTFcxTW44UkFoZnJPREZzb05ES291NGx2bFN2QU5CMXBs?=
 =?utf-8?B?MllOK0NNdTlaQlQwUEdQaGFudXFtdWNlTlUrNW83aDdQVUIxbzdkNjU5NU9a?=
 =?utf-8?B?TEJxV0NwUHp0OVpGVEJQYkJUWHRqVDFBTC9NdlFMbHVoYzdFcWgyVG5oM1dR?=
 =?utf-8?B?WVpvZmltc1N4Y2NYWUlhVDh2M3NYdzBDY293WGpndE9QenpCLzlpQ3FxYzZh?=
 =?utf-8?B?V1BPTlFhMFkzeXRmTTE2MmZWTWExWktFdXZFL0ZmMXpHdzVzSlZrSmJ1b1Bh?=
 =?utf-8?Q?xmTYcFTbPBa7vu/BFfOABhApj0p+RgkIsheDHH0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784ca967-7cf0-4436-2374-08d93260faa3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 13:57:15.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hCJTRdfBHGXtPYTtjRHWpRtnIZbXrDfZ4eYvmW7c0mhYEoxsuZzmWbSaQd4Ji/qvbS2IdZ5Q2l8qtI73+aAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 6/18/2021 1:08 AM, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 09:04:14AM -0500, Brijesh Singh wrote:
>> While launching the encrypted guests, the hypervisor may need to provide
>> some additional information that will used during the guest boot. In the
>> case of AMD SEV-SNP the information includes the address of the secrets
>> and CPUID pages. The secrets page contains information such as a VM to
>> PSP communication key and CPUID page contain PSP filtered CPUID values.
>>
>> When booting under the EFI based BIOS, the EFI configuration table
>> contains an entry for the confidential computing blob. In order to support
>> booting encrypted guests on non EFI VM, the hypervisor to pass these
>> additional information to the kernel with different method.
>>
>> For this purpose expand the struct setup_header to hold the physical
>> address of the confidential computing blob location. Being zero means it
>> isn't passed.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  Documentation/x86/boot.rst            | 27 +++++++++++++++++++++++++++
>>  arch/x86/boot/header.S                |  7 ++++++-
>>  arch/x86/include/uapi/asm/bootparam.h |  1 +
>>  3 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
>> index fc844913dece..9b32805617bb 100644
>> --- a/Documentation/x86/boot.rst
>> +++ b/Documentation/x86/boot.rst
>> @@ -75,6 +75,8 @@ Protocol 2.14	BURNT BY INCORRECT COMMIT
>>  		DO NOT USE!!! ASSUME SAME AS 2.13.
>>  
>>  Protocol 2.15	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
>> +
>> +Protocol 2.16	(Kernel 5.14) Added the confidential computing blob address
>>  =============	============================================================
>>  
>>  .. note::
>> @@ -226,6 +228,7 @@ Offset/Size	Proto		Name			Meaning
>>  0260/4		2.10+		init_size		Linear memory required during initialization
>>  0264/4		2.11+		handover_offset		Offset of handover entry point
>>  0268/4		2.15+		kernel_info_offset	Offset of the kernel_info
>> +026C/4		2.16+		cc_blob_address	        Physical address of the confidential computing blob
> 
> Why is this a separate thing instead of being passed as setup_data?
> 

Don't have any strong reason to keep it separate, I can define a new type and use the
setup_data to pass this information.

-Brijesh
