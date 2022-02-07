Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C84ACA22
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 21:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbiBGULM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 15:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbiBGUIZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 15:08:25 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41743C0401DA;
        Mon,  7 Feb 2022 12:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAWxoFz5dJCMR/c/UKfYUz+vtpIyTyKjFTIEgVMd3Bx5MdyjNGNenT+7RAbSSbHM7Z5sZ1Ein4OPcVtGyoTKEgLXGmhDzP47yaC/xXRaUZyP/aY0vp2yO9LzfptadxOvgcFXdhD5860sNVF+DRTyZfLaVy6FG6ljnKSzYGwtjccYCUH0y1d4mz5+xXsSzhMYZh1A5hW5qj51lnrcEtVI855vSIzwIV+3dfyi3Z8PaiQEMbBZ6cMnGIuchLSvwULJFd/8iyjA++0/ZLoPzVzm0/UK2WvgFySHMxYaXxgf4p3MO7OrRCxtmv8HnpmPgIsDSwEM7Qf7P8Nhqn4LvURQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI/y7R/zPvuD+YoEFR7bb8ff/zjT72VcB2nkfMTIuqQ=;
 b=Z+p+KudYXha38QIo755JNIPiwzeJkl5PPQistVumZ2nF/MHs3Vv8wR5B5j7HX4sPVjs4wzafKaqAi2XNzz/TyQRTYa5s8qBszMTXTy6vD23QJmp6GyVaMpL+/5vUrdmQOZrvpBloarVKsgvZMGUGfQMokOFdPi5Bq4xl/efClkL6o0mbZhAGWSAeWG4sCJjK6eOFxvvXNvUfFWN7LyVnnX9uLvjh43hjyYrhEpfcwE+MF7hWGVxrJEeG2trBGckIQ5fsuj2WDEarXwzcVvai22rB05aGA+USzOwLiPqrgtA1g6HejlV8377P1kNVffpGNvdIdFf9ZfKbgjoGk9sGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI/y7R/zPvuD+YoEFR7bb8ff/zjT72VcB2nkfMTIuqQ=;
 b=CrrC8X4ymB+MZGO1JtdOgLFLcEALAcH+HYjPuVspJEZ8VmJaIkCMDCvhJitM8RvtjgmRykXqTmdU6C68WR03CDGTk5NJyiQSpd04EqzP2KULRpfuvmAPVRVhXs0TBoq0hhUfhvtPY5x5lAn7gXxCOahSzKxIUQVB0foV8VQjxww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.11; Mon, 7 Feb 2022 20:08:22 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 20:08:22 +0000
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
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH v9 42/43] virt: sevguest: Add support to derive key
To:     Dov Murik <dovmurik@linux.ibm.com>, Borislav Petkov <bp@alien8.de>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-43-brijesh.singh@amd.com> <YgDduR0mrptX5arB@zn.tnic>
 <1cb4fdf5-7c1e-6c8f-1db6-8c976d6437c2@amd.com>
 <ae1644a3-bd2c-6966-4ae3-e26abd77b77b@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <20ba1ac2-83d1-6766-7821-c9c8184fb59b@amd.com>
Date:   Mon, 7 Feb 2022 14:08:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <ae1644a3-bd2c-6966-4ae3-e26abd77b77b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:610:53::32) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48977732-48d3-4b6e-295f-08d9ea75971b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1516C5D5BCC7A7785A469BF8E52C9@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vSbLnSwAq/0AqzYbK44uR+OmE016bx5/ti/8ICP+c5CAnRIhdMW+1TmxxuNqIFGAkVJJ4OKgM2dlrfI2yKxwniKsfKxTJIHsZCsSrZ9YtiLkhQg4MA9QIaTazN0/gEgo3kQwF/A85Du28EwpC45MTRt7awo0dn0vb2RTfd+PP26HoPTyYb4RKtvnfM/kwaB0dMJo2PGKIkCMXMPKSOjjVM3D17GbdloWQXsWf9qVZpE3o9X4jD7ykla7oaLK1ClG1NFUhRsz85siFFTLSjN07gvDytv9DFJGydiOxd29O3yYXh0JReGWuwzRUNJ3YgCucw3TAki/TKpjVAzjNlIWDBTgTTXPBxgdQok/nHtCvupn3fjl79JBG32HuDvXhO0zjoCbUQugEN7SE9Up3lFTtgjp0CU77T1i6XsHHtJUYU9fup6T5UIrahLGX9WTzMwAiRDcobYXl7sMrLg/7V0NymORZ9gPm/ITamSSaQc6T9SIO8C03Mos4sUKaKrF/IsFIS/7ERBlIonIOQ7vsKHZBABLoCxOXaRjN1VXiFaBElNAr2v2IB5jD5xJ1GGakcILTS1gHBvxpIjo7PQGCYTP3S1yYT4N8qGS42qZmtdBQtXDT+p1YAZsIVR68ORUZZi6QoRNLOCKyBZfg6tFwRnwaoYpC7dtXNJuCCLwzEWPhDO/Gjtrj20U530WDJPhQuZBhqmB8faAFC594ioUIjOIeqiK/CUZ8I1jdyJrgHjvcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(38100700002)(6666004)(2906002)(53546011)(6512007)(7416002)(6486002)(8936002)(8676002)(66946007)(66476007)(66556008)(316002)(36756003)(54906003)(110136005)(44832011)(7406005)(508600001)(26005)(5660300002)(2616005)(4326008)(186003)(86362001)(31686004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzlwWHZQQnFQaTlZd2d2bGRGcUR2VVNKeXBwMm41Q3djN3V5Tkc3bFVPSS9l?=
 =?utf-8?B?MmlzYnB2OHYwWE9wRlRBSC9sQk90WmVScmZWb0lGWGk5VzJ1YXAwcjNWaVd2?=
 =?utf-8?B?MmVXbzF5RG9KOTlDSGtlZ1JNNFQrV3ZpeUZrMGJWTERlczRyeDc5QWllYlZx?=
 =?utf-8?B?OTU2Wkh0MGg3cC8xNnlTVlQvRXUrS3ZDOXpmZ25HVUFTK3FDL1E4OVRIMkNo?=
 =?utf-8?B?MjNlcnhvSWFNTVZVU3UwSWllVCttMjBvOTdDZFplSU1Ydk9VL0FKc1kxTXhp?=
 =?utf-8?B?N2RSZytHMVMvNEJ0WGNGaXptNC9xL1ZJK3NzZy90RU1XVmQ1OGFoOENwcmRV?=
 =?utf-8?B?QTZWOG9uUndDcUFYMkFheXJkcG1yMXk4aGRUcjNBL0djdzZ2UmRWTjBZR25z?=
 =?utf-8?B?WTdWSGhmcHp4Mm05ZmYrblU1cWRhQ3kwZEFTWERBZ2JwaEtNYUVGbUdZd0Vy?=
 =?utf-8?B?RWh0WjI1Ym04RThtbnJtTmx4NFF0bFlIaUJuWGpGOEsrVWk3V3M1ejdZem9V?=
 =?utf-8?B?djdrNEFiNWVCd2FqYXk1R3FId1VrcElNZTFub0cvS2ZrVXdDd1JjMkJVM2I0?=
 =?utf-8?B?SkJvZUlpMEhvWm9ualBwSC9qem14bkRhbS9JSElud1BqcEtNWXZBTGc3Q2JN?=
 =?utf-8?B?K3ZidVRFRzRtRTVDa1p2OGV4c0Fkak81ZkFMVFk3c3cvQStPKzIyMEJJU2I1?=
 =?utf-8?B?WEFaZUlvWU1lSG8wZm9BbFNCYjBMY0JSSXpqKzB0eklDUlE3T1VDWWhUMVBz?=
 =?utf-8?B?V0VLb2pIYUd5TTFnM2pxSnJlUlozNkhZdG5Wd2tBOVppcnllakw0QVJ6ZVds?=
 =?utf-8?B?SU1QSVN5aDk0OTdoNFc0YU4zekpoZERqZTZZdXhTa0FNdUZzTThHalpScHZm?=
 =?utf-8?B?S3lxU1Z5bW1pd3V6Y2ZtV09xTnUzYnRYMnpmTjNvWjl6Sm0xeEo4a09SS2JH?=
 =?utf-8?B?T1k1RDUwRlBadjVxVkJWTUdnWTlsbFNsUkpYVGtReWxhMXVVOCtoMTBmZzd1?=
 =?utf-8?B?Zy95cmNONmxpWnpLZEFyMk5rU3pYVHp1c3NGbVBHc0RWcWhFOUZEM1oxenE1?=
 =?utf-8?B?dzBqVTV1R3pqU0gzMmNPb25YbGdiWFVzVnlzNVJEWGg3L3I5ZGxVdkc0ajlP?=
 =?utf-8?B?SGNhamhHMmRNTk1laHNFZGtQOUpuZ2xWMzNza2dBWjBXWkw5dnFhZGZzMjFo?=
 =?utf-8?B?SVBOdTZCVkIyMkRLQlVwb3g4NEpyeERscnBFVTFhc2Q3TVF4bTErZ0pXdGtD?=
 =?utf-8?B?V3hkL05ydmpXTVNoRWVHTSs0b2xOOHZkaGVwVE92TDNtajM0YndCbWM2UlY5?=
 =?utf-8?B?SmdJamhZc1J0SHJubG9zZkJOcUxHemVGUFR5S3RLaXExWXAwR1lOdFJsdUFH?=
 =?utf-8?B?cWVXMElEeXlkeGYrQzBFbFJydEpPcHpJbUZIUlNuRldiOFpScHd3WHBLTnBM?=
 =?utf-8?B?Qm4ra0UzWDNvUUJWR3NpZENRcy94NDVhNlVsUm1QSTd4MWVLc05BZEF5L0NL?=
 =?utf-8?B?NFVNSzVQc0xGU1A0WHBubms3UFBTN3FkMUNSbEg1dWVFeC9KdVlLWnJmNDkx?=
 =?utf-8?B?Qjlkb0Zwd2JGMkxxc2Z1SVByNi9QRUUrcmRYaGgraDV6SzFiM1FQSkJCb3NP?=
 =?utf-8?B?d0ttOXQ5eDZWdDhBN2U0dU9uUEVnWndkd0dTa2NqQk1VbVNmNFR4ZTREbzVT?=
 =?utf-8?B?a3htd0FPbFdrSjJZMDhoYW9ZdHFnak9rbmN1eW93T2xzYU53OE5ZTjI0dFUz?=
 =?utf-8?B?ejR3SGpiY1p5WTdSb25FRGxwNzVjY2JRNmdoTkc2YXkzTGhMMHl3REtYWkxR?=
 =?utf-8?B?SkZvOW9KNVNIRnEycUs3VUxuR0ZSUFNKQ3hVL1NDZUFhYlFRaHFUa2V5NXpy?=
 =?utf-8?B?WHF2VHprRTlOQjZqRGhpNnNzM1RlZzRBYVhwMm9FNHp5VTUvK1piWUZMZ0Ns?=
 =?utf-8?B?NmFYampKVzc3RDJOYzl1Z0xYOHJjNDVoRkIwWGE4aS9zL2I1UmxXNWNwWHpu?=
 =?utf-8?B?OHJwUksyTUprOGFIa0RPaGdXU3pycDNrTUtVazRQOUpleXhJdDRoTy9mcTli?=
 =?utf-8?B?Z1doYjhNakp4Qm9VV1NVd05aYlRNUE1VaHdFeDBtRUdSK3dhL3NuamRvM2Qx?=
 =?utf-8?B?dXBEdEdQWlFvUkZsZUx0MFo4Vlp1U0F4K0VyWi9obXpXc2wwVHlYNmYyejNZ?=
 =?utf-8?Q?q/YS/PId2AEcAsmVO9wU9YQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48977732-48d3-4b6e-295f-08d9ea75971b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 20:08:21.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbwIG5WhA9w4sRi6WUeloaqSUGhaq6CuI1kZ4jEhDFUucDagbjDpqMdoM3NKT6hhUpfiWmkuC2A2fwDq3wo4mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/7/22 1:09 PM, Dov Murik wrote:
> 
> 
> On 07/02/2022 18:23, Brijesh Singh wrote:
>>
>>
>> On 2/7/22 2:52 AM, Borislav Petkov wrote:
>>> Those are allocated on stack, why are you clearing them?
>>
>> Yep, no need to explicitly clear it. I'll take it out in next rev.
>>
> 
> Wait, this is key material generated by PSP and passed to userspace.
> Why leave copies of it floating around kernel memory?  I thought that's
> the whole reason for these memzero_explicit() calls (maybe add a comment?).
> 


Ah, now I remember I added the memzero_explicit() to address your review 
feedback :) In that patch version, we were using the kmalloc() to store 
the response data; since then, we switched to stack. We will leak the 
key outside when the stack is converted private-> shared; I don't know 
if any of these are going to happen. I can add a comment and keep the 
memzero_explicit() call.

Boris, let me know if you are okay with it?


> As an example, in arch/x86/crypto/aesni-intel_glue.c there are two calls
> to memzero_explicit(), both on stack variables; the only reason for
> these calls (as I understand it) is to avoid some future possible leak
> of this sensitive data (keys, cipher context, etc.).  I'm sure there are
> other examples in the kernel code.
> 
