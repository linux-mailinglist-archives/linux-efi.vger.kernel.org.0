Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7327A54B542
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiFNQCF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbiFNQCE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 12:02:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7C4093F;
        Tue, 14 Jun 2022 09:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQavUavfGd1GBO+lnei2LdGD0GCOAx9dsA6/YbiF25QzR6JST2YNa1SvGUBsqMtGOWld/gtBtv+NSW/WIjfL3/BXH3u7GtM2sQRcw9Vqt5SGS8gpquQiMsBJ71vC9eTkpSEDR3QxvAcnHb5tUjzsaWYzmmmgDJIAPF4VBmwwwNHHnhF8rx84t2jgmx/oR32bhnRxLh6frUEHxd71PhTDqnx6gquOwmEI/QppoFXQDRmQV3ekcIsxEFiIWT61AsTypY4fw1CTFsv6M1n5pUu8Ho1C9GtoorVlhorc5QY6zcPgcAbRK4esY5ecOlYYvW06OrMdHE3hKjZGTNoFNCiVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/RANoTxb9KmFDR18Qq2oYqm3NAO0S+81frSunhari8=;
 b=EtLYoM5eEraAPWoXlV4PaSfFd3s8PgvJDxZF7OmhTjIgHa5mY9s0e823Om3iisDQbQgvGEEZXPDhY91qWyXUlvCarlzYq+NEhB2sUyvw+ZD5WCJdDc0in2PPqwXCv7g5G7TypDEogUIlnTmG0bGi+rE1SQSzX6JAqwZR+fyPxV02L1z144G+doyzlRvNDUjV8lFHeoB9m6FsZtM6VsYjMxb6TMQ9/MNAc9JfQmxNZafFLrOcS7tGKKLdMYbPvcbq+EsGL3XMI6T69aLq58giX/9ZSpYBZYuvh5goMzUkJ7jiNaPwfp4HSJAcNm3e1qQEo26g0CayKjAv2IFsJYcOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/RANoTxb9KmFDR18Qq2oYqm3NAO0S+81frSunhari8=;
 b=en09Z/9IuWKYYlZ+QA0Qnuzt7cqmCQ0LL30CZCJX3VgfPCdFL6V8asGhplyvptVp5/NfCqguQvGmfr/mo4N07XuCvjHhG7jawA8eYt8LzM/7kEDUeDw6FUTvUAZOasAdD6sXNz+cDCi/Z3tI1ANXh8AQkIcMVJ8Z0OKz00KSKlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 16:02:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::db8:5b23:acf0:6f9a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::db8:5b23:acf0:6f9a%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 16:02:00 +0000
Message-ID: <daaf7a84-4204-48ca-e40c-7ba296b4789c@amd.com>
Date:   Tue, 14 Jun 2022 11:01:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v12 19/46] x86/kernel: Make the .bss..decrypted section
 shared in RMP table
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Michael Roth <michael.roth@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <YqistMvngNKEJu2o@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35a75ce2-192e-46fa-9f50-08da4e1f3748
X-MS-TrafficTypeDiagnostic: BL1PR12MB5221:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52210A50E7F1113EF9ECA08CECAA9@BL1PR12MB5221.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9XjVUTiAcKHE7VBxJr+sDGEx9dLnhvq9jd0onAEAvdP4kJZ4c2vk3JQHqTpEyEhqalwF5nBTbgFFx/VgL+VKWAZuO6RN9E2edUwHrwhn0ugW9nA6Vn25A9pjHQIaCWia1aB/aT8Fs8UWS2BXMxbtO9seyH7UN3r9O/ys7YZ0Qy1oJ4Q6cDKf0xsOFOwCtXIw6u9h6ytW032hrJnTqVuVNmCAuyIJu1n22kLcYC747S6bwwdMN/qgB/c/2MH0Z1FOS+U0NJWOhLRySGqGM4tklR+Q7cIjp6O5a34WsevmMQqrPuB6Iaf22y/yvOjAusHJ6M7KzrrmooWlQEy2idEZyBF8zIfNeOoyCIayboYTRZdOR8ohFN1qdtxlSPSV/QIy4Ir6Ym+g26nLih/HVxX4NuwdUmc74akHYQKyU1+SEM/zqtA3mXkuxQyYToMwe+rPVRKZY2zQD1f2Fpa4i5rhsYOGC/8ZvByHfHahVmOX0AbXWKBz00cgNlF86vACaYQbTmZ/gv2IIkcUdIW+vQdBUmAf2DaMsbmmDlXgJGIMKu3MpH3P6Q7B07HGaErRGu3UI7f3y8IsJ+z73vHx9JPXV7rbWt00WX/UcsZEGCSILi1v+j15KDxcLy/YpYfaV0dzZTWtTugvYbVZi40H7MEuSO++uG+/IhGjLEzVvXkGuUlk1ppvPqJ6I8l/9bzuFTdP953BT9sKjJ1oV4a3LoLj6HUROSM1rNtDrj+PITuksULNPumKrr9Pi+7e+Jdzx944CKPEsXvWKfdAzhdLcX80/+TPBbrlUYQKJHY2LmoD4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6666004)(186003)(53546011)(6506007)(86362001)(6512007)(26005)(2616005)(66946007)(31696002)(83380400001)(38100700002)(6486002)(7406005)(7416002)(31686004)(4326008)(36756003)(8676002)(54906003)(316002)(2906002)(110136005)(66476007)(66556008)(6636002)(8936002)(508600001)(5660300002)(142923001)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FiTG9oN0dmRldDSlBDNDJjT1g0Q3VoeFdESXVKclJ0ZUk4c0o2b3lwQXRY?=
 =?utf-8?B?TnJKSko2TlNVUHhuTG5yaGVRZk5ZcnFsZmxWZE1BaHZ0MW5sNjVnejZGM25t?=
 =?utf-8?B?QmQ3TmlwRlZsSlpjNjRNa2lsZFV0SHBHWWwxcm1nTUQxQ2d1WGNxdWhHVUN3?=
 =?utf-8?B?MFdEMldSLzh4dGxPMkUzN04wWFJsMTd1MlBSSVQ2bUp5NE1IK05QcERHSlpI?=
 =?utf-8?B?Rzc0OUd2d1pEL3greWZtQmJWOGNvTmNCNUtoUjVuMUlteXowVGFMTWtvNEpS?=
 =?utf-8?B?OUtDYklwNis4VHFoczdYU3dKN3Z0UlZTcFBXRDJia1IzRHk2NkxaeHdDVHov?=
 =?utf-8?B?NzlWNzVkWkpIOGV1KzV3YTMzQTRvQmhqbVZvb1BDcmFPaWpvejJBaC9Zakxn?=
 =?utf-8?B?bmhEVnNVekdrSzBqTEExTkJ2NWNTQ1lRa0NGbUFNNWZPeUwxeVRuZzZKQ0cz?=
 =?utf-8?B?aWV3NEZyMFVoL0Vvd3ZEM0hQRFl4a1h2Q1JsZWNVejRUbytJa29PUUdqT2My?=
 =?utf-8?B?RHJQZnhMT2Q1cHU5NWQ3VDRKWjJmZ2R6TElEakIvOHFNZjhFTkp2eGZNb1J3?=
 =?utf-8?B?Y1F1c2kzQTJFNGpIdlZVdUY0d3VDbHg2a3FQZUtEY3JIYnhzTmtuV2ZMcWp6?=
 =?utf-8?B?NUdoV2xiekJPb1NBZnlOOWZGZG1IckJjcHZiNThNQXB2MHgxNEZMb2lFZ3lZ?=
 =?utf-8?B?UUNwZ2x2WUc4TGIrdkZCaW91enZDb1RMQ0pDUUJvY2kxd2ppV1QycE9qZWxX?=
 =?utf-8?B?UUxudndwaVNVS2d1czVHc0UzTkRQQzZtT1J2ZjZJRGRidk5YNm8zMWhDZzdo?=
 =?utf-8?B?cHp0ZnV0YzVxMUxpc1Z6c0lwcklmNnlGSTl3Y0Q0akxVVlY1dC85OGZ1V01M?=
 =?utf-8?B?eUlVYzJpalVrcWlSczBSdkhGTDlDVE5MRHF2QUsrRWVjZFJCeGdEYlpwRlQv?=
 =?utf-8?B?Qml2UjVmc1hvcVpTTHZPUVduVVQzTjhGdmRrOEZOWjhBeExQdlY5Q1JiS0pT?=
 =?utf-8?B?N0dLc3AzZ1AxdS9qVmVzNkp5b2d3R3QzUDFMR2FiT2dWR0ZXV2w0WVBLTmZC?=
 =?utf-8?B?dm80UzNqbXhpMUZsTTFjSVRKTzNpa01Uek9kQkUyQStEaTZ0cERKQzR1b2ov?=
 =?utf-8?B?WEpRZE5RSUJMT2JLTkZ3QTl2cTg3aTNXYTBnTVZuaFo0dlBPcitSYVdlVGVY?=
 =?utf-8?B?Tlh4QnF3ZWZ0QjJhU0pYRnZJcEM5ekdla3NwWDQ0TXZqc1NuQmdCWHlobGg5?=
 =?utf-8?B?VnJ1TnNFNXdpWGdsb3UzL0p5SFJ2eFptUWpmcTBmc0cyZitrV0puSTZYRlh4?=
 =?utf-8?B?b2JVK1dHcEgxUWZoMUN4T2phVEVJL1A5MW9ybzBxRmFBdGFzOG5Ed1hka2R3?=
 =?utf-8?B?YUlIM3R2SkVsUFFnVUdnV3c3c2Z0MXE1UEdEV0ZHb2haaWRDYnoyNDBPazNj?=
 =?utf-8?B?S1BMTytqNVBaTnl4RkoxNmh3QWVUbmdCenM0eXIzN3dIQjBCOURtR3JiZlBp?=
 =?utf-8?B?UXBlZHZNTU94R2cyZlloajFqVEc2UFhDcVBrSlo5N3Z2UGpTcE5lQzZNNHB6?=
 =?utf-8?B?cjVHc1lEN0VRWjVjS2NjbWZHTTlmM2RUMjRNWGNZYlQrbG83aFE0S3JWYisy?=
 =?utf-8?B?NExJeHNLdjRZQXlyK080UUJveHBuV3JZT0YrUEVRalBna08xWHBPY3ZnTnls?=
 =?utf-8?B?Y1dWT0loS29QaS93TE4rdFczM3lxbDVvZ1lOTmErdFRqem1UNFkzS3VXZy9x?=
 =?utf-8?B?MEtJOHY3Qjc5Z3BVdDROelltTm9hZlJpekh4QnFwNTdEMWVBSFo2Y3hVd2xE?=
 =?utf-8?B?akxVcUlhTzd2N1dnVXVHM0g4Qk9UdElKblc2cndPOGNXbTVmL0tMLzZvUExh?=
 =?utf-8?B?WHpJMExneGFlcW80YjRicHZJMWdzU1Z0MEptc1FkV1VicU9EZ2lnS1h3Y2xD?=
 =?utf-8?B?eWIyZDlDZGpmSzhUQU1GbFlweDUzSytlNWtuV1B4V3ZKaDI2T3dBS291c21D?=
 =?utf-8?B?YURhL3FEL1FGWVFPZEcreVNLWDJNZ1pLZ0dFbDhjVkl1Q0F6OG9xZURUWFJ6?=
 =?utf-8?B?czJsRFUzeWQrWkVtdGVHUGZKTURBUHNnU3FrOGRIdFFWcWZjSHZxUEJTKy9k?=
 =?utf-8?B?VjdjUU9GNXVyV1NiTHZ4VmV3TTgxREIzekJXL0FxTDJhamdndENwa3c0VHRP?=
 =?utf-8?B?YWVkL0NML2xKVi9hanFXcEdqbHhSVDc1K0pRTFZ3clBDdDBEaW5KTTVRTzJU?=
 =?utf-8?B?UlB0Q3BKTFR2UmZxbU9SMTdyVDFJWG11NkZPUElqdGcvV0txcjJ2TTBNZzBP?=
 =?utf-8?B?Yy9laDJWcUZyS3VrQ0pVd1hlL1ZoWkIrZVNYRDdBemxlYkVoQk5VQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a75ce2-192e-46fa-9f50-08da4e1f3748
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 16:02:00.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzpN+PIMMrIGRP/h2pjnY23qVAu2OPoUInpQW54CylmNGOcISuGzkp6n8r79mDaXGlwghxMoYmb3GbfNexd/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/14/22 10:43, Sean Christopherson wrote:
> On Tue, Jun 14, 2022, Sean Christopherson wrote:
>> s/Brijesh/Michael
>>
>> On Mon, Mar 07, 2022, Brijesh Singh wrote:
>>> The encryption attribute for the .bss..decrypted section is cleared in the
>>> initial page table build. This is because the section contains the data
>>> that need to be shared between the guest and the hypervisor.
>>>
>>> When SEV-SNP is active, just clearing the encryption attribute in the
>>> page table is not enough. The page state need to be updated in the RMP
>>> table.
>>>
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> ---
>>>   arch/x86/kernel/head64.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>>> index 83514b9827e6..656d2f3e2cf0 100644
>>> --- a/arch/x86/kernel/head64.c
>>> +++ b/arch/x86/kernel/head64.c
>>> @@ -143,7 +143,20 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>>>   	if (sme_get_me_mask()) {
>>>   		vaddr = (unsigned long)__start_bss_decrypted;
>>>   		vaddr_end = (unsigned long)__end_bss_decrypted;
>>> +
>>>   		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>>> +			/*
>>> +			 * On SNP, transition the page to shared in the RMP table so that
>>> +			 * it is consistent with the page table attribute change.
>>> +			 *
>>> +			 * __start_bss_decrypted has a virtual address in the high range
>>> +			 * mapping (kernel .text). PVALIDATE, by way of
>>> +			 * early_snp_set_memory_shared(), requires a valid virtual
>>> +			 * address but the kernel is currently running off of the identity
>>> +			 * mapping so use __pa() to get a *currently* valid virtual address.
>>> +			 */
>>> +			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
>>
>> This breaks SME on Rome and Milan when compiling with clang-13.  I haven't been
>> able to figure out exactly what goes wrong.  printk isn't functional at this point,
>> and interactive debug during boot on our test systems is beyond me.  I can't even
>> verify that the bug is specific to clang because the draconian build system for our
>> test systems apparently is stuck pointing at gcc-4.9.
>>
>> I suspect the issue is related to relocation and/or encrypting memory, as skipping
>> the call to early_snp_set_memory_shared() if SNP isn't active masks the issue.
>> I've dug through the assembly and haven't spotted a smoking gun, e.g. no obvious
>> use of absolute addresses.
>>
>> Forcing a VM through the same path doesn't fail.  I can't test an SEV guest at the
>> moment because INIT_EX is also broken.
> 
> The SEV INIT_EX was a PEBKAC issue.  An SEV guest boots just fine with a clang-built
> kernel, so either it's a finnicky relocation issue or something specific to SME.

I just built and booted 5.19-rc2 with clang-13 and SME enabled without issue:

[    4.118226] Memory Encryption Features active: AMD SME

Maybe something with your kernel config? Can you send me your config?

Thanks,
Tom

> 
>> The crash incurs a very, very slow reboot, and I was out of cycles to work on this
>> about three hours ago.  If someone on the AMD side can repro, it would be much
>> appreciated.
