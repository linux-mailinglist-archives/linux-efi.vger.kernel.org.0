Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8684AF49F
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 16:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiBIPCV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 10:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiBIPCU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 10:02:20 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28677C06157B;
        Wed,  9 Feb 2022 07:02:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZBWzu5K7ijYrbUU50AQxKXosYTlLwLq/S0xp4oXJGSXCDokFKj7ec+Ohb548AX3kQZdVBUnQ8Xo21iogs+UBtY8RqnXak8o5rA0hZTjBmCAL7QX4h87+qyKl8KiHIMaQHMrp88YVc5RS7QnSRf2GH1rUpgHvG9WGNZ53uRN4+OC8/BaYpmw1hDAV7bnhkNpx0l5+FMY7CMoeNtrA/udWYCzxWLYWHnPXvDY1TkbqRIXCrhFjARHQn3CzjTHO64IQ8UNzwyDfFp2Spo2YgkrmdXpYHDMqhP04GIUbpDsoo62hLz4XD5kVSJ9EjpEghewzMSItXGzGL9sDzDF8TwDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOakBaZT51q+xP3NfPHyn9u2jOfdTHiBRaI4vTwuCgg=;
 b=nZdphYa6wIzZ0FIm9k1/7aD6IEHTnC+GJK6x1oX8T79Bclpo8Cx271AsL6QJmt7K+FmX6es2QV6KgsnCqVOOb3CsBMNKgFkRKqm7tezWHWawEF0LBBlDF+m8srw8qps4U+IVu06gyTSgoAVmuoYTtJzTRJFknlpHfUYp4ctDbA9gXYRYD5Yd9GHB7WVtoSgNMmCe+JveSMK3Qz8Dun0iKNUXIhWMxb0T0fGfX/cM1D903dt2XXpKh8XxON3sMm83J6dpUZF/sJjdURxUmpEM4QJWDKwDtMK7w34veLafcm2zt7Ic37jCOtpV5MrLVTe888yryrj4kUprjQ45GnR2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOakBaZT51q+xP3NfPHyn9u2jOfdTHiBRaI4vTwuCgg=;
 b=P50BL4Icq3mOvpCe5LT+Glb4M0qhkGSj3Hu/pL9O+3UnPyRyC+6yiSmvDB3yDQgrtTcZfyWagwRe292dAFo/9tF1i5d4uwIrGFlJ5MvRzLJEBBtU0tusYiajJ9+jaMhMSDEt1YqB4fNytrn4SRldPYJQ+5WdRTJHD/0syYkkrd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by DM5PR1201MB0252.namprd12.prod.outlook.com (2603:10b6:4:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 15:02:20 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 15:02:20 +0000
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: Re: [PATCH v9 02/43] KVM: SVM: Create a separate mapping for the
 SEV-ES save area
To:     Borislav Petkov <bp@alien8.de>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-3-brijesh.singh@amd.com> <YfkvchuxmkHgnPWT@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <8fe6224f-3051-8cbd-13d6-5baf888643b6@amd.com>
Date:   Wed, 9 Feb 2022 09:02:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YfkvchuxmkHgnPWT@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:610:e5::35) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3781f300-173b-4ef5-fdfa-08d9ebdd2b61
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0252:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02522F09B2EB11401D999548E52E9@DM5PR1201MB0252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNbyoEmTeW5fIZbgVkN3QrZIy4GRkUMU6Jm3j1IKWevcU3ie9Mdu0Qr3blyluFWkCL4o7MaoiXaWmLtCiiRMfgjkkyB+3xsYy6PRJbNsqeDsp8zgWwoKpx9whhS6QAvXlW5zOfUNKrY3Cq71lwXGffZHuQ5svU6rnsw1CDo03j03+YlDvyUzwOzkTU459RY2xBc5tqFsnyQUEHzS6TAwfS2RXBvQLrot4XYGusApVtMntVQU26JiZK2cNUM4ZXHzLC2i57JQo5ZEW3y9RKht5rIg7wEOX04I7QfVsXpIixQfhxdfAy9G9w4MnLd1yP7mDznsDKHun1vYHBmr0ZiyKCTKad8l67TZhHLoIhlub9lWY+QElhG/YHktaSsN3jS8wb4NG2Ow14ga/2m7sfKoFR9jmvyJ0M9KY+YNBiXaMUHO7Cte0brje1U9QsLvZu1SV/KQKxON3cyOdHlhzLSOWgHqR1xGOUARPWFT4+TiuQdls1wJBsBdJ9L0z4J4wZ/NAkOTbLWCxoYyZNqps/1yRKcf8J6tYhN12F3JudfZpzU0V2aTJOIKHVc1aiBJ5Ctwpd4eAuxB3E1UCBxo0owFlqZ+hanIW+JyhOB0ne3Y7yRmGX538LMLlGDK2A1XMu48uF/WDJKCdR90zq9aDPtT3LzT8dmy883epQXQC04vAPQaBB6cIriI1C6aqSZfYChfQzR1HAyyirf4um42N6wU1OKvGEhPEyWNwsaepoEBbC1tuF/+3NCRIzxmVcmGU5m33YrKCUZmFYv8v9z7X79cGeGQtrvey731jOEaZKdu6W5RN/LMSGH6tIvctvs961+Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(83380400001)(6486002)(508600001)(7416002)(31686004)(966005)(2906002)(36756003)(2616005)(6666004)(5660300002)(66556008)(53546011)(66476007)(8936002)(54906003)(6916009)(26005)(6512007)(31696002)(7406005)(86362001)(66946007)(45080400002)(316002)(4326008)(186003)(8676002)(44832011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXFUTmpieXR6Q0diYzBuTGZkcnFMNThSMGFUQlJyZUJndzNTWXRkTTlIcmZS?=
 =?utf-8?B?NnJVbFAxU1puclVEVjliSzBhWTdIUlFtOWI3SDlmU1RHaFhJVVc4VUo4K0ZP?=
 =?utf-8?B?ZWNDNlhhV2Vla3dacDIzNWQ5S3B0Lzh1NEhHdXVraWFQOUNrNkxNek0rT2VI?=
 =?utf-8?B?QURKSWdrakc5ZWFBY0p5eEN3c0RWYnRmUDFENkZVVU9xcjhQYkpMS1FDZGdy?=
 =?utf-8?B?UFhqd1ByeW5KbGRrZkJqVVhNTFpuNndTQm1hN3l4SWVFYlc5VEJkU2hkdmVm?=
 =?utf-8?B?T1lWNXFnTnA2SGxDTVM2ZTFCdnNEdEkrY3FVSkhMMGVHVlltQjNwV3BCZXU2?=
 =?utf-8?B?eFhlRnRBK3o1Vzc5UkVzSlhtc3FGY1ZNTDhtdldGMHhteEJ5UWNMZUt5eUFP?=
 =?utf-8?B?eWhMVnVucll1c2lpdDBSd2V0enFMTG8zVWpDbFJqRERSdVZpbkhWUHNyQm5B?=
 =?utf-8?B?eUU4aytJNUE2dCsxaXFEVG4wSTVWMzNCdWF3ZDhmQitpb0owZDJmcEJDWjEz?=
 =?utf-8?B?ZFlpZ3dWSmNvdks5QThoR0orOXVjK3E5Zk96M0VlVGpEWFZIdlRqcFhmMkdL?=
 =?utf-8?B?czBkN0h0cmp1aCtKdDJhc1hHdlEwTGxKdDNZRUV5MlJ2S3dmWWRnWTl2RS9G?=
 =?utf-8?B?SlViQVl4UU5IbkJiSXFlemVOL3RkeE9nWGZEcUQ1a1lmdy81M3ZmeG9XSVJ3?=
 =?utf-8?B?ZklLcG11SUpwTUIwYXovYlRGbkdyUEV0WGxtSjB0YzZIall5Ums1UldoWWts?=
 =?utf-8?B?MzBTVmJSQldvaGdLZHQ3RkZsckw5ZURYeE04d1ZLNjI4K0hHaFRWekNCZzRT?=
 =?utf-8?B?Mi91RmEyWUIwbW1nMWM3VVI5WFNMVWJiNkRQaEVrNVcvYk9kWTlLQWx5UnBp?=
 =?utf-8?B?RlNKVVp6bHZlM1dwMngzYlBvcFdVYzBCUnAxUmc5bWZrRkZ3QTAyY0kzQ0F4?=
 =?utf-8?B?VnVtSHRHVVNKeitxdmF1bEtkdEQ5QklMZUhMUi9XSHdISHFReFRydHpjdGww?=
 =?utf-8?B?SFJSSGFFaFAwbUFUUXM2NkV4a1lsait1OTFCeFBaRFM3b1ErUGxBS2VLdXRM?=
 =?utf-8?B?NUxpTTdDOHR5YWNHMER4aHBaODFhVDYxcTVwOUE3dUQvd056WEhlcVQ0NUtS?=
 =?utf-8?B?V0puNUJzMHh1ZkhzdkRMWHJTRmVSNDQrTytia3NoSHhMNysxclJVYW9vZVBV?=
 =?utf-8?B?YVhCeHZ2WTlsdWNXazVVT2lvNlR1Q3doT2l4TkZXc2RVOGRlc1U4dHVzdloy?=
 =?utf-8?B?STQ2K0hIcWRqZzNrTWZwWW1UVjU1V0Z4SDJGZ1hrUmNadzNCWXR1ZXJ0bU53?=
 =?utf-8?B?QzI3SXNqMHh5TFZzaUQrWlc5eE9KaEZVTFRNdWxiWkErTzFxOVF6NGJaemgr?=
 =?utf-8?B?QmEzVXl0SGV4WCtzRjFYaVZMYUNabzc0ZWw0VXhiM2Zpb2kydURGU3hFbkx6?=
 =?utf-8?B?ZzBQYzN4QkxuTHJiYjEvM3pOSW5JN21lWE9uZUFpWXVOalRwS3VzNUtDaHpG?=
 =?utf-8?B?ZVRGdFAydGFlb3B1MDFjNnVFOFBHWlplUTNCWmFiNklPWHVweHg5bVkycm1x?=
 =?utf-8?B?RXFDYXFNdUROcDg3a0dma01BanNsVm9OTGZLRjlidElNQmwvWnlUblN0K2lr?=
 =?utf-8?B?a3VHK1gyVnhxRTNLQ01jZ0puZmxSbGw1bUd4RDI3bmYzaWhKUkR0a0dKY2dV?=
 =?utf-8?B?VmFWYnUwdGpyeVFsaWNuLzB5dS9hMUhKSUFjaDFBZUpnK0dxSFlaTmJaYnVr?=
 =?utf-8?B?Tmk1UGtacGJMRDQrTUxoRzZENGhLZGtmYm0wcFVsV1hFaUFNMGZ5TDlaMk9X?=
 =?utf-8?B?YzRHZ0pVTHo1dXc0b3h3VkNtQXVDMzhPUGZrQ0VmdkhrRHZQRjdISDMwVDdI?=
 =?utf-8?B?Ym04OHVNR1dWVW9RMXd6RnZ0ZTlwVXhqRXNDMW5sZ2FlRHQvM0hJa05LZUZh?=
 =?utf-8?B?UFBJUXVCeHVLcjFsLzc0REdXOHhObEkxTm81WE00T2hNV0l5ZTJ0NlZjQ2Ux?=
 =?utf-8?B?ZEdrMzM3elhnelNTNUtLQyt4VFhGZWlzeUszVVdIUWFabFp4QVZSZ2lKODVJ?=
 =?utf-8?B?Mndxa2JDaFdwdDNWdGxFUFJSR1Jjb0cyK243MWZzQi9JY01UcUZDblBQeDBU?=
 =?utf-8?B?SE9QK0dWMll6OTlTV3JaRm5CQkUyNVQ2eDZNYWN2bW1IR3kwL0FvNTZreTF5?=
 =?utf-8?Q?4j/osD1Yho8iyT5NvAZmfb4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3781f300-173b-4ef5-fdfa-08d9ebdd2b61
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:02:20.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVnSz+fMIgWOFPhReaY92GqrMXe7ClVduqhFjR9WQGP29xpkXLKcH8JPuhCpvXRJTMyxjrwEc+B6mWqisn20Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/1/22 7:02 AM, Borislav Petkov wrote:
> On Fri, Jan 28, 2022 at 11:17:23AM -0600, Brijesh Singh wrote:
>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> The save area for SEV-ES/SEV-SNP guests, as used by the hardware, is
>> different from the save area of a non SEV-ES/SEV-SNP guest.
>>
>> This is the first step in defining the multiple save areas to keep them
>> separate and ensuring proper operation amongst the different types of
>> guests. Create an SEV-ES/SEV-SNP save area and adjust usage to the new
>> save area definition where needed.
>>
>> Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/include/asm/svm.h | 87 +++++++++++++++++++++++++++++---------
>>   arch/x86/kvm/svm/sev.c     | 24 +++++------
>>   arch/x86/kvm/svm/svm.h     |  2 +-
>>   3 files changed, 80 insertions(+), 33 deletions(-)
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2FYc2jzOunYej4vwSc%40zn.tnic&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C909b88bb6fb14010859508d9e583268e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637793173738404187%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=uOR2wyzO1%2B6K%2B%2FhZCkwlRrfQutFqpSzXKh8RVbub9cA%3D&amp;reserved=0
> 

The rename may touch more files in KVM subsystem, so, I'll work on this 
feedback while adding the SNP host support, and will submit it as a 
per-requisite for the host support.

-Brijesh
