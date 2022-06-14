Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9154BA05
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 21:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357706AbiFNTCP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 15:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiFNTBl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 15:01:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42439FD4;
        Tue, 14 Jun 2022 12:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apUeJJzZDD4yp1q21DbXANuT8wbZ2tVsTmPBqBhzg0fLF4OAk2rRdnkpV5DJgEYKkkaCeT2EPP60zirkuYbLyXKP47/Ueety/Lp6EO1Ys67cb9MhwM+8vp+DYexmb98/ntTJz/RFd8JR5qlBCi2/JKFLLHH/KGuiPn1qNbA4+zCxHkTgit1hT0Mxz1a1I1Ac58Hn9OPJkPXXTQFVZgcCwXV5JUWqgBYt881SPdMD95fqFrcxSImmvDWqqOVLzz2/9p4oTW3sbeGb7r6nPlLygU1ojp8rff4DNYH/E+Y2q8Xar4g4++dLyV2XSgbHn3J+JMYsQv0q3f/z2Uj/Ew1Pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xzt5dyeeF4h7WU84c9LolRlJxxfKAUtx3Xq/okCshFk=;
 b=YYSlHFS27pHeRrMwofJpeAKKmJw4TTPj5XFcRAgJuNAtQPrv1mXHsgjdCxyE0lXTQTanJ06a9OfZZVyCI0mcCuAEzWmG6cc1OB1KBxGtCrDrc5e1vguDFx4xMpl1CoiEoZbnjDYrvvNGBwNXWKSohKAXa3C/RXgAhwdCzNnt8Snj0EV+bTve5KLyzJRyJsHlgy2L2CDmpvgeXDS3t4U9dCRsVbwHrSHzd7MOwPrL9kAhx75lj4CVMTEt7QJt1yAAssISihVhxHOsNGGBZyHRCBHAjlecuM9BZ1VqxYQdW+QkZsuOA/O81V0ak7qvZtU6HITGZzRsNDDm1B9EmNtQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzt5dyeeF4h7WU84c9LolRlJxxfKAUtx3Xq/okCshFk=;
 b=sKTUS/m9eWY1vT13IwIZX9f0yUXQXIplIRFLtZtUUncuHAC8tomXVLvo2G9feOpW7Repkkg+BXgiMm5LXp/lOV8HjM/9bMzZLLMFBtem5Urca35XgO3zjAu/4q2/Q10cVZrhujdmzk4fRDT+2UZlTB3qLFl1Z3LpHFWKH7iA6NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 19:01:01 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::db8:5b23:acf0:6f9a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::db8:5b23:acf0:6f9a%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 19:01:01 +0000
Message-ID: <6db51d45-e17a-38dd-131d-e43132c55dfb@amd.com>
Date:   Tue, 14 Jun 2022 14:00:56 -0500
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <YqizrTCk460kov/X@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:208:23e::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78916fd4-c8c6-4c76-e0e8-08da4e3838f0
X-MS-TrafficTypeDiagnostic: PH7PR12MB6419:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB641929449C418054244E5F9BECAA9@PH7PR12MB6419.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GE5hDQeVeQuBDm7JQL/3xgwYgGUc/MNYjhxseexkLv0NX43v3hBwJbJSxZjylLR7OiUUaD29AQT3S5SLdXdl9oiAEI2zddbA8Ak47wFr3+XNad0dyJVgQmCBgYFW91nzaAFWiTjT/tMeQoItrkMB3UTQpxU34glBJJAV2iJnJTmAVg/P2sD1DHazU2yrR+MiDztLpqmMOnhEGOgCsiLzneD1J01E5iBvYBRJeaBIEok0hPvEQdyYyjTjxm52Y+esmIRtIsWQz5vysWgvp+H7wj3AoN7GKmeIMFox2nF0JvtLYU4BSe3hTvEo3kBG9f1u6S5HC9eCeWtxl9iSjt9l239/Ej9KOnDZVt5kNnzuknvfnNtz5zgDJmNdlZEaJwA5QAsP8SvFwO57tcGt9eBd5eCaDElKIqcgHogQySX73OvKqmUAWW3MWVoK1pSNVDQ7ASGFAvCgvMfWV1AA0oEjvAr6SEJHPBX/mneR1Dtpkt2KxdozMzS8cEhax39eo2Mahu2ea5vbdq6sEmPBGO6/FrgesBAoOqhLrcZleN+ZC/vCbzUcrx7AVrgvgszJCHRwAKHOvYfcmHZdQBnO1oslcrRKKTWVHHGXb53ye955dOmYJ8IBLUaEGizbjG+DP+t9tq3vVg/Wm1UhlhJGxZ9/jOezkrpPFtJqkMONf+W8Zo7tC2fJ+SeNQXO3koYzyDzrLAoJkw0mKE5LDIp4x+j7Ct/5oSXaLlTeAQ/0CfN8mt/ihLJVo0d5vF1NM4eMWUhatGU3p8ASsgwDriY5Pyf6JIC/ZxNH+DzY+dlHTPvE6iwGq7iQP4OCmUeYT6jgReWz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66556008)(66946007)(8676002)(4326008)(6666004)(7416002)(66476007)(508600001)(8936002)(38100700002)(7406005)(2616005)(6486002)(86362001)(26005)(31696002)(53546011)(5660300002)(6506007)(2906002)(6512007)(316002)(6916009)(54906003)(36756003)(186003)(83380400001)(31686004)(142923001)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJzYXhRNWhrYUxRUGFFd256SXdGM1QzYUJ0aytudVN0K0NwT1Rtb1JGeE11?=
 =?utf-8?B?alVEZWs3S0IzTE1HZjV0WW5MZnhGeUJsSU5TRnpSMjNqRGRINEJnZ0dxcmNJ?=
 =?utf-8?B?dHl2QTUveFNFTEYzREVMSkJZeXV3KzlhTWViR1AyUk1VZnRsK3RyU1hZUTVD?=
 =?utf-8?B?V0NUUFhWYTVNVUtweThORjRGclpUczIvNFR2WTlrSG9QYUZNakRwN1UxZzg3?=
 =?utf-8?B?dU1tc1NTK2g1M0NPTXlOSDVVa0cza1ZnbGxpNzZSWUFLVjczNzk1ZldWcm50?=
 =?utf-8?B?WXZVaDlaRHJyQm5PdmdCbkZ4ZUdQYkR0WlRrTW56WFdObHZSRnBVTi9GbzBQ?=
 =?utf-8?B?N3dKRDRLd2VSNjJpakRtQ1NiellBejhDVFBDc1plU2FzRlhONTJOL3ZnWm1m?=
 =?utf-8?B?djlXbm0zVEtQbHMyN0gyMGVBVG9wZHZ6ZGVUNzZDWkt6UWQybit5Y2J2Umwz?=
 =?utf-8?B?R0JKZEhhQXZBVXJSV3N6NHRrU1JhWnJvT0xsVHNGYVRCQm1lYXFTN3dETDlv?=
 =?utf-8?B?WDJqSmU1K1c2aHh0clArUHFaTVY4NkhmemlaeW9DUjlBclY3MTBabDBPc0NH?=
 =?utf-8?B?SDQ2aTBaQ1JERVY1Y0RvOUwrN0FnR2RaYlBSclJ2ZkcvYXFGVlZxb2l2bmJE?=
 =?utf-8?B?cUZmZ0ZSL0F1SHMzeU41RU9mSWw0alE4ZjJnYkdFbG9YVXAveE4ycjE1cjd5?=
 =?utf-8?B?TTNGbmlJTkVjZzIvYzN4M2ZMTmliRDEzTG40UmdVazBoM3RLYjZkRk1XVE0r?=
 =?utf-8?B?ckJLSVkyRzgrL2oydWFXWENrckErR0ZOYXFZRzNYZEp4YXJOZEc1b253VWRF?=
 =?utf-8?B?R2pyaGppazhMVUNnMTNuajZZMElEME9OamQ0dHl5akpHT2U5NDZhaVpUQkV5?=
 =?utf-8?B?RUJIOTlRMWVaMU5JcllXRno0emRYUUxlN2oyaFVsd216NkxPU3F4NzhrTXhp?=
 =?utf-8?B?M1FYYlIwQ05CSEtoS2wrYUZuT096c3ZTcENBaGdvSENiUW1FVE15b2NNd1dw?=
 =?utf-8?B?KzhNUVRYdUFjSXBzRG1ua3NzditHaFY3L2VFdmhSbW9Iby80MXl2Y1EvZW8x?=
 =?utf-8?B?MERjQlRMSk14Q1hXSkRnWEptRHd1YzBpSlNVQWNzUkl0OFM1WEpESVdsdXph?=
 =?utf-8?B?dDZjdUcyam1TUUdoV202enZoZkoySjBLYVltb0h3SDZqTFhNWTRTZmNudjB2?=
 =?utf-8?B?bnh5NWtodUdyeENmempsY2xQU2FlQWdFZW5CZDNWNi9wd2taOUJWa3ByQkZE?=
 =?utf-8?B?aW1jczl6RzBxM0hldW02OEVPQ3BWTnRFaGtXdHVHY0RPNHE3VXlGOS9hTHY0?=
 =?utf-8?B?SXZ6Z3FSaEt5d3ZGUXhqa3Budk9ERWJUOGpxVnJtRGx3VEY1WWd1TTVVbkpI?=
 =?utf-8?B?NGVGMHAxQUhPdVZkQ3pRTzJBWjFidVY4S1RNa2VNTTJDbHd1TzNHUktGNnQ1?=
 =?utf-8?B?SFJabHBsR2RNZ3MzNldMckVmUlJmNWRmY2RvM2o2MHI3TkJ6NHZBYUU3Ymd4?=
 =?utf-8?B?ajJGaTVTYWJkQkhDSWZ4TGJjOGNWWE1ZbkgzYW55dXZMbVVFWjlOWDZnTlk3?=
 =?utf-8?B?RjZzeFJWcjEvUGVwV09BcUJweDg2MnIrYmJKTlBKajhmZmUzYjdPTytsSE9q?=
 =?utf-8?B?WFg0Wlh4aDBieWQxc2ZTdmtoVk9waldMU3hLWldCOXlkU08rYmIzeXVIbzgy?=
 =?utf-8?B?M1Y1Z2Jpc0ZPV3hpSXpkTlpoaENJb3Q3ZEV5ekcyR1gwckhmcGI5UXE1QUcw?=
 =?utf-8?B?SEZET1g2Q2NBUU1pT3BvS2FSOURHZkJYWWxCTUpwV3p3NzExbk1BNmpyVUg2?=
 =?utf-8?B?eCtteHczSjBPSFJ1Mk5CTzBxR3NkTUtVOXZuL3FXdW1oYm9IN0N3SE5FM2h6?=
 =?utf-8?B?V1FVc2E4OHZtSWpNY3J2aGJSR1k5OUdsQXFRSStzTUttaVdIYmxSbjVIeGFW?=
 =?utf-8?B?VzdGMUpPUy9VdWVXKzdXMVRGbjBycTVib2pLSTF2S3luUG1VTXNDODJqdHY0?=
 =?utf-8?B?ZmIwSHJZNHJmUVJVSzVjR005R3Fwb2wyQWdDY3VsejV5NERMM3ZyMXR1aDNl?=
 =?utf-8?B?dHdLZ2pnTDBKeG5xVExDL2dhQWUwMFVnbXBXb3MwNEJzL0xyVVpIZ0JyU0FC?=
 =?utf-8?B?eDVPMWpUbmYwNU9pYWt1bHp5cDdPSk41UWdjUENMYS9UOGpRZUVsZmFwMHBt?=
 =?utf-8?B?TEVSRTM0Zk1vQ1JINFhWMGJlMzkzRkYyV1JsMTdHeHNPQVR6WWkxWGh6bklS?=
 =?utf-8?B?QldJcTlzUXpSbDNyQ1M5cTlEeDROSzlYazhkbXVjR014UTY4QU1KS2ROL1lS?=
 =?utf-8?B?UnZkVjRLcEhlOHRrNkFzbi94eS82dkhneE5SVWM3dDBhdmlZVE1SZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78916fd4-c8c6-4c76-e0e8-08da4e3838f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 19:01:00.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ao1mZaUDdbG1AwMC6j3PXMsz5Q6NxZ8DOXUXQet5DIaSj9DCJa6ItAyAFdFGN9V7QCduzEVdTou35gG98BfNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/14/22 11:13, Sean Christopherson wrote:
> On Tue, Jun 14, 2022, Tom Lendacky wrote:
>> On 6/14/22 10:43, Sean Christopherson wrote:
>>> On Tue, Jun 14, 2022, Sean Christopherson wrote:
>>>> s/Brijesh/Michael
>>>>
>>>> On Mon, Mar 07, 2022, Brijesh Singh wrote:
>>>>> The encryption attribute for the .bss..decrypted section is cleared in the
>>>>> initial page table build. This is because the section contains the data
>>>>> that need to be shared between the guest and the hypervisor.
>>>>>
>>>>> When SEV-SNP is active, just clearing the encryption attribute in the
>>>>> page table is not enough. The page state need to be updated in the RMP
>>>>> table.
>>>>>
>>>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>>>> ---
>>>>>    arch/x86/kernel/head64.c | 13 +++++++++++++
>>>>>    1 file changed, 13 insertions(+)
>>>>>
>>>>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>>>>> index 83514b9827e6..656d2f3e2cf0 100644
>>>>> --- a/arch/x86/kernel/head64.c
>>>>> +++ b/arch/x86/kernel/head64.c
>>>>> @@ -143,7 +143,20 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>>>>>    	if (sme_get_me_mask()) {
>>>>>    		vaddr = (unsigned long)__start_bss_decrypted;
>>>>>    		vaddr_end = (unsigned long)__end_bss_decrypted;
>>>>> +
>>>>>    		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>>>>> +			/*
>>>>> +			 * On SNP, transition the page to shared in the RMP table so that
>>>>> +			 * it is consistent with the page table attribute change.
>>>>> +			 *
>>>>> +			 * __start_bss_decrypted has a virtual address in the high range
>>>>> +			 * mapping (kernel .text). PVALIDATE, by way of
>>>>> +			 * early_snp_set_memory_shared(), requires a valid virtual
>>>>> +			 * address but the kernel is currently running off of the identity
>>>>> +			 * mapping so use __pa() to get a *currently* valid virtual address.
>>>>> +			 */
>>>>> +			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
>>>>
>>>> This breaks SME on Rome and Milan when compiling with clang-13.  I haven't been
>>>> able to figure out exactly what goes wrong.  printk isn't functional at this point,
>>>> and interactive debug during boot on our test systems is beyond me.  I can't even
>>>> verify that the bug is specific to clang because the draconian build system for our
>>>> test systems apparently is stuck pointing at gcc-4.9.
>>>>
>>>> I suspect the issue is related to relocation and/or encrypting memory, as skipping
>>>> the call to early_snp_set_memory_shared() if SNP isn't active masks the issue.
>>>> I've dug through the assembly and haven't spotted a smoking gun, e.g. no obvious
>>>> use of absolute addresses.
>>>>
>>>> Forcing a VM through the same path doesn't fail.  I can't test an SEV guest at the
>>>> moment because INIT_EX is also broken.
>>>
>>> The SEV INIT_EX was a PEBKAC issue.  An SEV guest boots just fine with a clang-built
>>> kernel, so either it's a finnicky relocation issue or something specific to SME.
>>
>> I just built and booted 5.19-rc2 with clang-13 and SME enabled without issue:
>>
>> [    4.118226] Memory Encryption Features active: AMD SME
> 
> Phooey.
> 
>> Maybe something with your kernel config? Can you send me your config?
> 
> Attached.  If you can't repro, I'll find someone on our end to work on this.

I was able to repro. It dies in the cc_platform_has() code, where it is
trying to do an indirect jump based on the attribute (actually in the
amd_cc_platform_has() which I think has been optimized in):

bool cc_platform_has(enum cc_attr attr)
{
ffffffff81002140:       55                      push   %rbp
ffffffff81002141:       48 89 e5                mov    %rsp,%rbp
         switch (vendor) {
ffffffff81002144:       8b 05 c6 e9 3a 01       mov    0x13ae9c6(%rip),%eax        # ffffffff823b0b10 <vendor>
ffffffff8100214a:       83 f8 03                cmp    $0x3,%eax
ffffffff8100214d:       74 25                   je     ffffffff81002174 <cc_platform_has+0x34>
ffffffff8100214f:       83 f8 02                cmp    $0x2,%eax
ffffffff81002152:       74 2f                   je     ffffffff81002183 <cc_platform_has+0x43>
ffffffff81002154:       83 f8 01                cmp    $0x1,%eax
ffffffff81002157:       75 26                   jne    ffffffff8100217f <cc_platform_has+0x3f>
         switch (attr) {
ffffffff81002159:       83 ff 05                cmp    $0x5,%edi
ffffffff8100215c:       77 21                   ja     ffffffff8100217f <cc_platform_has+0x3f>
ffffffff8100215e:       89 f8                   mov    %edi,%eax
ffffffff81002160:       ff 24 c5 c0 01 00 82    jmp    *-0x7dfffe40(,%rax,8)

This last line is what causes the reset. I'm guessing that the jump isn't
valid at this point because we are running in identity mapped mode and not
with a kernel virtual address at this point.

Trying to see what the difference was between your config and mine, the
indirect jump lead me to check the setting of CONFIG_RETPOLINE. Your config
did not have it enabled, so I set CONFIG_RETPOLINE=y, and with that, the
kernel boots successfully. With retpolines, the code is completely different
around here:

bool cc_platform_has(enum cc_attr attr)
{
ffffffff81001f30:       55                      push   %rbp
ffffffff81001f31:       48 89 e5                mov    %rsp,%rbp
         switch (vendor) {
ffffffff81001f34:       8b 05 26 8f 37 01       mov    0x1378f26(%rip),%eax        # ffffffff8237ae60 <vendor>
ffffffff81001f3a:       83 f8 03                cmp    $0x3,%eax
ffffffff81001f3d:       74 29                   je     ffffffff81001f68 <cc_platform_has+0x38>
ffffffff81001f3f:       83 f8 02                cmp    $0x2,%eax
ffffffff81001f42:       74 33                   je     ffffffff81001f77 <cc_platform_has+0x47>
ffffffff81001f44:       83 f8 01                cmp    $0x1,%eax
ffffffff81001f47:       75 2a                   jne    ffffffff81001f73 <cc_platform_has+0x43>
ffffffff81001f49:       31 c0                   xor    %eax,%eax
         switch (attr) {
ffffffff81001f4b:       83 ff 02                cmp    $0x2,%edi
ffffffff81001f4e:       7f 2f                   jg     ffffffff81001f7f <cc_platform_has+0x4f>
ffffffff81001f50:       85 ff                   test   %edi,%edi
ffffffff81001f52:       74 47                   je     ffffffff81001f9b <cc_platform_has+0x6b>
ffffffff81001f54:       83 ff 01                cmp    $0x1,%edi
ffffffff81001f57:       74 5b                   je     ffffffff81001fb4 <cc_platform_has+0x84>
ffffffff81001f59:       83 ff 02                cmp    $0x2,%edi
ffffffff81001f5c:       75 08                   jne    ffffffff81001f66 <cc_platform_has+0x36>
                 return sev_status & MSR_AMD64_SEV_ENABLED;
ffffffff81001f5e:       8a 05 44 3f 64 01       mov    0x1643f44(%rip),%al        # ffffffff82645ea8 <sev_status>
ffffffff81001f64:       24 01                   and    $0x1,%al
         case CC_VENDOR_HYPERV:
                 return hyperv_cc_platform_has(attr);
         default:
                 return false;
         }
}
ffffffff81001f66:       5d                      pop    %rbp
ffffffff81001f67:       c3                      ret
         switch (attr) {
ffffffff81001f68:       83 ff 07                cmp    $0x7,%edi
ffffffff81001f6b:       73 06                   jae    ffffffff81001f73 <cc_platform_has+0x43>
ffffffff81001f6d:       40 f6 c7 01             test   $0x1,%dil
ffffffff81001f71:       eb 07                   jmp    ffffffff81001f7a <cc_platform_has+0x4a>
ffffffff81001f73:       31 c0                   xor    %eax,%eax
}
ffffffff81001f75:       5d                      pop    %rbp
ffffffff81001f76:       c3                      ret
         return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
ffffffff81001f77:       83 ff 02                cmp    $0x2,%edi
ffffffff81001f7a:       0f 94 c0                sete   %al
}
ffffffff81001f7d:       5d                      pop    %rbp
ffffffff81001f7e:       c3                      ret
         switch (attr) {
.
.
.

I'm not sure if there's a way to remove the jump table optimization for
the arch/x86/coco/core.c file when retpolines aren't configured.

Thanks,
Tom

> 
> Thanks!
