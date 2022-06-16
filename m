Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D854E6C6
	for <lists+linux-efi@lfdr.de>; Thu, 16 Jun 2022 18:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiFPQRt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Jun 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377942AbiFPQRs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Jun 2022 12:17:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C0C101EA;
        Thu, 16 Jun 2022 09:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCwDusHxafSsEbWFbnp4TNf+fMj2q6lAhW9WwpTlEIe66X6eT7n2AGAg/sEQUKfp3l/FxTXaXm0Pd40pKZi7/yxN+7qNUqfn7fsT+R13qJri+5KTAYGa1fgDfPin1j85rpSKIBb0EK/qQQMT1LiizOZlrzrRU+9SjlNR/dm+kV6wYPd92v0EL8oLCQ5FenFbPzYSa40UrgSzZCPKyxUp82Ym2XkoKosrx7cEaA6//zsNXLEAlOuNd3T03hE09dEngTX6w1eitCzyzpHu70OEJBl7SYMFM0iwdzQeqNzDWDi/MPjumrQMV90QWUG6Va4l7ew57Xdw3gcXdjDN5eTWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5f/A4/w1CF5W41XE1/U29arwX/qDUrW4880TenYATY=;
 b=FR7X571+JTn2USybawmYJ6KRwfrJv6eP+e9H0JCuuJv69VjiXlxYpivlztm+fQ+tvMDBk3cQA8oVfX2pTZl2Io/otnxrrhT2BS0DzeBXTQ1nfmaKaz6ibEdNSzJZ3Ch2Ar+Tr2OFNjg1z3sETFrvzBFC4Bfo3Po1hhRduziqvB/aFYdbniDXMNbfyAS9KZwuL7DqydlLKSk8az/kS/cYSnhXRdP+o6n8bJfNk6vTC/7i0YQ0e4EWtJvplmjrIZGLUj121WCTNr5kIEp6/L8Coi/SkOgXY1YKa13OLXuwvyAHH2ZSjyi5MUmv0P25A5vUCqVJH/6139U1zd87sDOiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5f/A4/w1CF5W41XE1/U29arwX/qDUrW4880TenYATY=;
 b=0HEOwhG/OTbYGQ3nRcTEqsFBDZELzL3Cotwc8zkNFwK6PSKXq1/UaIPSCXd7VaZ3XiEn06f1u/RxyD8UNnsZu0FmaMD0yePc3PjaQxovYdl8OcjBCGlNMpLt0krQA2teoxV+lLgPjOqarjPWfD+DCmTWMcLvZAB+utB8gULFOT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MWHPR1201MB2477.namprd12.prod.outlook.com (2603:10b6:300:e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 16:17:43 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::db8:5b23:acf0:6f9a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::db8:5b23:acf0:6f9a%4]) with mapi id 15.20.5332.023; Thu, 16 Jun 2022
 16:17:43 +0000
Message-ID: <9abe9a71-242d-91d5-444a-b56c8b9b6d90@amd.com>
Date:   Thu, 16 Jun 2022 11:17:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v12 19/46] x86/kernel: Make the .bss..decrypted section
 shared in RMP table
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Michael Roth <michael.roth@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-20-brijesh.singh@amd.com>
 <YqfabnTRxFSM+LoX@google.com> <YqistMvngNKEJu2o@google.com>
 <daaf7a84-4204-48ca-e40c-7ba296b4789c@amd.com> <YqizrTCk460kov/X@google.com>
 <6db51d45-e17a-38dd-131d-e43132c55dfb@amd.com> <Yqjm/b3deMlxxePh@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Yqjm/b3deMlxxePh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0026.namprd05.prod.outlook.com
 (2603:10b6:803:40::39) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f4e2be2-e0a7-4b20-1617-08da4fb3be0f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2477:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2477EB3FEA94271FA098E53FECAC9@MWHPR1201MB2477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4hldHdQcVIPe1qB9lT+EblRuW0ptxjyUSt35i7YhnQtJpTJxMSZQ9v5sk5W3BLRAcAttcjcDVqHJpPofhEz/U88wDD8ynd5WP7iWc5tmOuy9DagXYLCPSwFTtj3kOb12BDgyjRKmDVFxyiEYF1QQMZM0OMIqPg7puvgKoioh2BaDyC62TcRK8aU9SgV3lLqSg3eyiajuaPCtcCLFB1SdktRq+IpKx7ZMFBOy3Peyu8Udxtn9pmqyps6gZO++GIHJ6sAm5do/Y1z5OJ7RByYXu6pqlkn6ZDI2KlndfwwtKLz+VpH7qCpxCKzCCm7mz9PzcIDakbDPI3R0WUNMUSFxceE6UpPhZJzFaofYYhhbSRKaa0yIIXNm6SLJVxFBy5D2sHRGeKjEnFmYybBZGlVt6TwXg1PyFtwZl9d6WopaY8OUY3jePK4VhrTlwomephvbM/T0W1PU9dLq3jIWCP4zWG1/OkG/R+JwEyUfA7WNAULQJxDA+XbJPmLAT9OXTKtz44n0kJk66ZxfhgpxyGOnK8l6RkAyhlVoEcw9xLmbqGr6cnMQp2JOwF9s2GbsH+GQT1eLdsxKq0NgpbbuV01wH4F8hepbUUfsWB1N9PSFxOZWEvzodnPtHG00YsVRDeWwIZeGLQCvEQGdfxoKCQh9ORj7pdJT4Qlo9bbncImnlIwQy0m2Up06fO+rA1VZHX70wSJkaQx0zcNQrYWfAb+nuLIWN8bsOQD9SrfuUZzniuYpr6zzZlq4XoCEwsXUPVfqmkiPv1bOWixRHEaNKKPEFxshZKLNahqd/1ZQTphFkqRpVx9vaOnTfR2UUocRcxm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(53546011)(31696002)(316002)(186003)(6506007)(8936002)(38100700002)(6512007)(26005)(83380400001)(2616005)(54906003)(6916009)(5660300002)(7406005)(7416002)(36756003)(8676002)(86362001)(31686004)(2906002)(66556008)(6486002)(508600001)(66946007)(4326008)(66476007)(142923001)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUVwZmtwS3Rxd3ZGR1JEbU1Ualgwb0dxZXQ3MjZEUkRsMWVadFhvTDlzcjcr?=
 =?utf-8?B?aFNaWGxnMSt1MlJ2d3BLQXVLLzdDa0JRN0VCMGVJZTRIcHkyS0dLdTBuTWFa?=
 =?utf-8?B?bnU4VmRQelJ2RThpRGZSUzlVMGtKT3kxWWhDN1hqa2tPUWRyWVE3ODQyV1Bj?=
 =?utf-8?B?YVN2Y3Q2TG9wdGVYNURia2pzYXNPNWI0Rm1wOTdyMkxZNWE2TFhsT2pXRDZE?=
 =?utf-8?B?SFNQMWpEWVlkWXYrbEJHZUdQaXpSN25BZkdveXNpVU8xVE1XSWJyYzB6MDVG?=
 =?utf-8?B?RStBY0gzOFd5QlJwWDRxaXNSNEpwK2JyRktNVHJDWUxOdnN3STZLdksyT3N0?=
 =?utf-8?B?YUloak5MazZybk96cDRvdlNoakhWdkZvRm9zTEVVYXgwa0FWZGF1TWFISEYr?=
 =?utf-8?B?aENXNThJdTJibnZIbEVOSnFIdDNmMDNUejNaNTdtcThDVzJmK05FRHRkUWU3?=
 =?utf-8?B?TW1nMWlNcHB3cHdFUGIyR1dPaW1oek5RUmM1N1NQUmMxQlc5ZEJ2Rzk2V2lx?=
 =?utf-8?B?bG1OMlJTTnlBMG1NVklqeVgzQlp5OU53VTBEZ0ppeTg4MUV2bDVPRDhZN1o5?=
 =?utf-8?B?N0Roc1pVOS9UQ2FYNk9aQndzM3VLcVZtREVUUlA4K0dTNGJXV05DWUpjUHhH?=
 =?utf-8?B?czdUeCtmaDVGWkN0UzQwUmFaQ2FJQVR4aVZzVitzTW9sUFZ0R0J4NmJqNW1r?=
 =?utf-8?B?WXRxa2xIZ3g3VFBhUnNSZE1ZejE1bjVDcExGSnErbHhJa05RVW44RFlBMk9n?=
 =?utf-8?B?b2EvUTEvbWNOdS9hV01qSnZoaVJ4VGRxNTlITmhNK21xU0FUN0Fvc0IzcnBn?=
 =?utf-8?B?cjd6Y2F2L1d2MDJ3b1FiM2t5RSswOElEQUE4QkVlMlZoQldwS3ozODhFUmMv?=
 =?utf-8?B?dGgwbnBVenpzZWE2aDlhbjQ3ampUcG5URE9vK0g4czdxRU9wcnNWVXdhMXZV?=
 =?utf-8?B?RVprb3dCTjVvWkdKcUZxZXMrMDJ1UlNBZW5US0ZRUEh5clNKMWVrOWlOWFFC?=
 =?utf-8?B?ZzFMQ3hVSTdYMGpUWGhlSlUxdGRwbXhucEkxQWVBUW9LZWxicU03MWJ2djV6?=
 =?utf-8?B?QmVyMXVuU1dsYjRCTWk3dWpLcTJvT2ZwMlNDYjAvRDc1UldXWEpBWktVMzBI?=
 =?utf-8?B?aytPMTNMYkhVSjVPSTgyRE1zTmZvM3BEOUJHbE1zZ3pCdnRXcENrTjBkbWtB?=
 =?utf-8?B?Yi9RbDJaU0pXZVIzR2dzenRhSFFyQ0txQkdYL0JCTnlSd2lmS3FzZGhnVHNE?=
 =?utf-8?B?Y3NzL2tsNDVwZUcrbVJwQ2ZIcmpGTFBsY0RPRks1dytlVmdPdkcyT2RjUUVn?=
 =?utf-8?B?UXlVbWRDcFoyb25RVTFWSkZ5TDdPS3VYU1gxRFo4RTBOQzNFSWdDU3FFU2E2?=
 =?utf-8?B?L3FENUJhdmZHOXUyYXZYS29VNml5eG9ZRk1td1N6WldqcWZ3d2tpS2g4OUQr?=
 =?utf-8?B?dE1jWHNZK00zSUMrTlM4cVp6aWt1Z3duTGpvbFE3YTY2a2JIWlBRSEg4VG1U?=
 =?utf-8?B?QXkzKzF6c3RvSGZ2c1dsN2dKU25pQ00veGFwd1lpbldMWUtoajRPU2tqVFY1?=
 =?utf-8?B?eHBVcVVWbFg2TzNPZ0t3aFFta3lnNHQ0OTBGTFh0NGplSUNuZTR0dnQwcUNI?=
 =?utf-8?B?cFJCVmJ5YzZDTzN2c05WL2QyZFMrazFJU212MC9QK3hyaDViY3psZy9FZUg2?=
 =?utf-8?B?b0tjNzh4ZnljL1JkVTVVbXJnNTNzRDdibVVQN1p1UHR4Z3IwcWc1MGVGdnpu?=
 =?utf-8?B?MHkzL0k1Q3NzSnNuRVVzUFZWSHg1VlBTZnRPbVRlKy93SnJNWldBYjI3TC9n?=
 =?utf-8?B?ZXR3cEpES3Jzd1l1WDJPcXZKOVczN29BOTBLdjBoWlM4WDZVZTRxc0c3NGI1?=
 =?utf-8?B?U3B2Y3NyR2ZxNEtwWGlWWUd4aVFPR3pzSjZpK1VScGdUdEZtMUpwR1gvMzVK?=
 =?utf-8?B?RmJFT1pLR1hIakw0anVPdHNOei9rMW5kUXdLaVBtZlZLdW9seTJZZTdvcmJi?=
 =?utf-8?B?M3pFZ3VBRTJoL3pzNllxYnkvMWFBWmpZWmZ5VVBwM0tIbmVRbXV3V2RNM28y?=
 =?utf-8?B?bFF6WERYdWF5TjNpOFoxV1pkdWNZcE5TT0ZSNXBqdFlJdnhySVdUV2VSV212?=
 =?utf-8?B?aWs5UE50SGlnNmJNK2FHNHpMNDcvekJ4bW5SWERLRTUxWmFoY3hKOTZzZndT?=
 =?utf-8?B?S1JVb2hzVWtuTHpGcm5peWhndjZBNkExbHVOK2djd2V6RzVMelE3NW1PSnk1?=
 =?utf-8?B?Rm9pMXlUTWhLNTBRNE5hT0lpeXVUTms4R1RidWdaYlZTTEtFSFFXS3BJSlJ5?=
 =?utf-8?B?SmFRNHFqVGJnandWeTE5OHhJK0FaT25EWjUycW0vYmNoZW4wOGJuUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4e2be2-e0a7-4b20-1617-08da4fb3be0f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:17:43.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0X6LF0NpmqrLAaqNC048s7Lx74AwZQaqjgaFCrFRgEH9c0iS6SYFlpBGkiEOSSGOSSzeTZXgEPDr/SohB+ejw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2477
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/14/22 14:52, Sean Christopherson wrote:
> On Tue, Jun 14, 2022, Tom Lendacky wrote:
>> On 6/14/22 11:13, Sean Christopherson wrote:
>>>>>> This breaks SME on Rome and Milan when compiling with clang-13.  I haven't been
>>>>>> able to figure out exactly what goes wrong.  printk isn't functional at this point,
>>>>>> and interactive debug during boot on our test systems is beyond me.  I can't even
>>>>>> verify that the bug is specific to clang because the draconian build system for our
>>>>>> test systems apparently is stuck pointing at gcc-4.9.
>>>>>>
>>>>>> I suspect the issue is related to relocation and/or encrypting memory, as skipping
>>>>>> the call to early_snp_set_memory_shared() if SNP isn't active masks the issue.
>>>>>> I've dug through the assembly and haven't spotted a smoking gun, e.g. no obvious
>>>>>> use of absolute addresses.
>>>>>>
>>>>>> Forcing a VM through the same path doesn't fail.  I can't test an SEV guest at the
>>>>>> moment because INIT_EX is also broken.
>>>>>

> 
>> I'm not sure if there's a way to remove the jump table optimization for
>> the arch/x86/coco/core.c file when retpolines aren't configured.
> 
> And for post-boot I don't think we'd want to disable any such optimizations.
> 
> A possibled "fix" would be to do what sme_encrypt_kernel() does and just query
> sev_status directly.  But even that works, the fragility of the boot code is
> terrifying :-(  I can't think of any clever solutions though.

I worry that another use of cc_platform_has() could creep in at some point 
and cause the same issue. Not sure how bad it would be, performance-wise, 
to remove the jump table optimization for arch/x86/coco/core.c.

I guess we can wait for Boris to get back and chime in.

> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index bd4a34100ed0..5efab0d8e49d 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -127,7 +127,9 @@ static bool __head check_la57_support(unsigned long physaddr)
>   }
>   #endif
> 
> -static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
> +static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
> +						    pmdval_t *pmd,
> +						    unsigned long physaddr)

I noticed that you added the physaddr parameter but never use it...

Thanks,
Tom

>   {
>   	unsigned long vaddr, vaddr_end;
>   	int i;
> @@ -156,7 +158,9 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>   			 * address but the kernel is currently running off of the identity
>   			 * mapping so use __pa() to get a *currently* valid virtual address.
>   			 */
> -			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
> +			if (sev_status & MSR_AMD64_SEV_SNP_ENABLED_BIT)
> +				__early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr),
> +							      PTRS_PER_PMD);
> 
>   			i = pmd_index(vaddr);
>   			pmd[i] -= sme_get_me_mask();
> @@ -316,7 +320,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	 */
>   	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
> 
> -	return sme_postprocess_startup(bp, pmd);
> +	return sme_postprocess_startup(bp, pmd, physaddr);
>   }
> 
>   /* Wipe all early page tables except for the kernel symbol map */
