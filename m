Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B213F9BE5
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 17:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245274AbhH0Psm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 11:48:42 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:23424
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245040AbhH0Psk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 11:48:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKJI9rPwBuXMzXP85FSMCuTSEKDiJXn7ZZxmNxkKrT+rhrY+xbF7S8FVPJ4AdA5EA3LKGYeKzXuloKpRdRUjujB48CTERcBhxoNWVfutfx0E2CR66LDWMTaxTSdIGrCaViTGevvA2OdjQKSDMyxZgUkZLqOZOy6aswqBGF11JKqu8crd4YfCqukfc4GwP1K3VYeJmvagYUuRI2wwXBCG2WHNvglnY/Rr2vHZ2T9AnWdEoc8BjFd3URQhUYxTXQwN9NqqKRfm4yMgfy+d2vGKzp3HU7QaUHLZDf56lSVp0X/Vch3RGMyd5BZWpMcrkJuSTdp0d3qA/H3JA/hAYGwOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfpjztaOqeJBEbWI9Vh8eGhK8SSM6a7VJTei7HexpFo=;
 b=bYm6VopSipCile/8YlmqI49XGixzOvOf43ZEYNMJwK2MosK5hzRbJOy1o9zXYVpQUM19NkLslnSWE+7N6ojXuoUug7B9tcQDZ2xQgWiApSsNsEhOyUEbvxmh8joZvbdnJZgitT7dlBdS51gHQv5CY9VS3vLeNKwwWraciEiB5zaT5xCU8F8YQfWo/fPD2WyW/S+BSOVDp41u7VAeHedoeIboHQRWgAc4SISzz+kkewJPse7//I5516URg2QfcF1s79lnORoDNU2pfUd9/snVnauTPGfRozpFeWK8yzlm7bFEZyiy7wcTDxR7gSbX0mJ/oI4++gMbauPRcuUW0rZOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfpjztaOqeJBEbWI9Vh8eGhK8SSM6a7VJTei7HexpFo=;
 b=SQYb4hjHOAS4EXGnghynCG2l4Y9Zc6NWCy+K0DOUdzQRZGTiPjlNDRCtYyhrnCK3gXMKaabbEBljCQSh9ToPUqZOfg4lOxseiriWsILrYVb7rnY3WQrLdpc64EooQZcabfdrctom2+vLmGlPY80N8cvclTG4cVabES4kKjLKCKg=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 15:47:47 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 15:47:46 +0000
Subject: Re: [PATCH Part1 v5 32/38] x86/sev: enable SEV-SNP-validated CPUID in
 #VC handlers
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-33-brijesh.singh@amd.com> <YSkCWVTd0ZEvphlx@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <62e8b7f2-4e0d-5836-ea37-9e0a7a797017@amd.com>
Date:   Fri, 27 Aug 2021 10:47:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <YSkCWVTd0ZEvphlx@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0601CA0021.namprd06.prod.outlook.com
 (2603:10b6:803:2f::31) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SN4PR0601CA0021.namprd06.prod.outlook.com (2603:10b6:803:2f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 15:47:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e415cf0-4bfa-4d41-5403-08d96972041e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB263767B11FC536D614E845C9E5C89@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BElLhd1ZIUmBRsyZbWXFMNE9p8XAYl5qgUxro1/jJDzBo1yS193TooFTa9pqV9EWeRpCBsoyvQ5W0CTvRuGSV8/+UMGw5X4lYN42aSyrOHFEq+1IAYym5h+2ufJYcAJf41oezkQQnEd2mPuzmvZY6PsjpQc2C1VKtmBnOuhCqhSe9ogFFeNFmG3dVRXreXsVQgQfbfO16Y/pChiY81P/VG7tQ5KlsBi8B+kCb8N+0qsL0Wky2PrBN1gvBfurq+7LAdCIBWNwIGCBBCc0QmvWXoiLwYkrOJGFkNBfD/tDrm3d9kXN8kFsxJCB1BJrYItf//gdxnJVyQsrangKv55kghOVEuhagHAcFDbRMiPEvVaSNe2EHenkvkB160cIXkH2Zg5LpON3I4UQGzhyv24Ke1vaHCy42YryPoPNyYG5Dsd1sMe1VUMrxFcdmXPAydMHntG9YUOBN7nEGawH8NQEkJ0Z4DEb9cqb1Hnuhov3rqEtz21n+wYSnE9X3x4d42SB1d2iBTM/FHcycUfPWOW+aiPm3Mysg0t6On/Wk2Qi3u8HZORKRrhJPftHSXKA4stXyrVYrx3gRMA0IRzq0chMckmY727ubQKa/Xg6u5DCAjmoCQ9NKszvx/lt6leF7wzEjS1jXZJ5wDLhFH9d1dRX3ReCxPR6mxJXbgCJjrr4odfdJQS7e/EU0a6dv37vmRlj1+AslB+XQyQPW9FiVbz2WUs5CwEYuGqVvaDPb8e+0Mj2KlhdFqp8eQ6iOBGKXoQ8fOJplE4nNIvj1rN4Vq2Rug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(54906003)(186003)(36756003)(7416002)(83380400001)(53546011)(6506007)(15650500001)(7406005)(6916009)(8936002)(2906002)(5660300002)(26005)(52116002)(66556008)(316002)(38100700002)(86362001)(478600001)(66476007)(4326008)(8676002)(66946007)(6486002)(2616005)(6512007)(31696002)(38350700002)(956004)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW1QeFloR3BoQkRzbDJvODlsZVZ0akVycE0rZjA0VVl6STNrc1RjcGQ0aUUw?=
 =?utf-8?B?U3FnNncvUDcwQ0hSaXMra3NLVS93T0dLZzN6emRIZVVGSnV3UnFNZFFWS2po?=
 =?utf-8?B?Mi9STXRrK2IwYmNZMmU3UHI5WE5FRnZnbTlLeCs2TTZkQ2dONUptSXZLZnZZ?=
 =?utf-8?B?WlpHMWpCcFdhVys1djNzZ3ZYUWl1Rm1FRWVoYkVGbWhmeGVqbm5HcnFKR2dP?=
 =?utf-8?B?dGU4c2d5RkZacmVNakU3WTVtdkdYcTNhTWJxVExFcjdoQ2JmYVFiRUdsaC9P?=
 =?utf-8?B?aXNZRDhvN1gvemtSVmN2TS9yZ3R5bTJMc2VPeGtwVzFzTWp2anlTNFJqU1RT?=
 =?utf-8?B?SDNWUDh5L3pETXp4N2I0TmdPSWFPaFFaOTBIUkliZHZ0ZTBVNytWeittME9s?=
 =?utf-8?B?Vjc5dWNKc29TSjRkL3ZqNStRaXlVMzFJNWJIRld5SXVyMjVWTlIrNnNyMHpm?=
 =?utf-8?B?U3ZvT0xyZnhhaU0yQ0J3WmttK1luNWk3d3dVTTFOOTgzdElEWnVKZzNJTnZH?=
 =?utf-8?B?UWJpTzU4TWtlc2dNaDhURnNKUzBJQjgycUxPaC9WY2ZwMVVNOXNYbUR4ZVdI?=
 =?utf-8?B?emQxajNHZS9Hb1I3cGwxbTdIZzhnSW1wTDhEVDh1MTNGNzB5a09INU9uMmZz?=
 =?utf-8?B?MVBka083R0RUaExYY3hYNEsyN1p0TnY1RlRKY0loRCtwQXNvNkV5c0NKc0tr?=
 =?utf-8?B?YXNjT0JtS3NOcm1SYzc3bzB0UUhVSjh2TVJ0S240SlByRTZkVVFwTHp6R3JF?=
 =?utf-8?B?cG5Wb0FSbU5xQ1NJQkc0SGJhNzRNbVh0VXkvZ1ViVngraEovNU9nblplTEdi?=
 =?utf-8?B?bzdPVFdSNG9IUVVBeHJnNzc1T3FVSFBnNk9vM3ZCTXhocG1kdUwvNnNJQ3Vr?=
 =?utf-8?B?T1M1b1hBQnJkTWdCS2JCTHdLa0hjS0Y3SHo0b2dhN01oOEhKUEluOHpqN1By?=
 =?utf-8?B?MDRHWk14djVHY1dac2oyeG4zdlIzdWhMbW5uQnZ0R1lTN2oyeDRoZ1N3T1I2?=
 =?utf-8?B?dm5LRGYyOWVNTk16YkhoZ21WaE95dHFkeEt3L05ZejhGSEhPNWY0bGdJcVN6?=
 =?utf-8?B?V0piUTFBRlV3RnpQMkVKdUR3WHArK3V6clB1RWhEZ2hxMURwTFFxeHZqd0lD?=
 =?utf-8?B?UFVHTTRXeGJVeXJTZXdVYWUyaVZlYVdhMnhhWEU5UnRkTEo1Mm9yMGdQNUwr?=
 =?utf-8?B?VlZZOTIzUmMvdDRxQk5zMGRMRUV3WHAwSXZ6cWdUL3pBZkQra0M5dFA1QjF5?=
 =?utf-8?B?R3U3Z2R5K29aVmlKdUV4SnZKZ3R0VmRhaEtRSDB1dDkwbjZhYmFZVmx2V0VW?=
 =?utf-8?B?RWxMWk5MUlViSjFLTXhFc3h1azJSdjRxbjR6SWJmdHlJcUZDSEJoUEtGR0pr?=
 =?utf-8?B?NC9ZTUs4ZnlNcUtFSWJSMGovbGRNS0ZZZlRiMlNWdk9CYzFIUFJPWE5mM2FP?=
 =?utf-8?B?YVc4bmxjaUFzR3lsajRkc3VtYmFyMG85bnhyLy9NQnFGcWErMWJ2cFdRNS8z?=
 =?utf-8?B?Q2l3aHc2ZW1NZlF2dy9Lc3RGN3dmU2E3dy9Sb1JoTXp5T2k1T3dxRmRtOVFo?=
 =?utf-8?B?RDJvbGQxZUhZdGJTSTkwVmxQcjg1SUhBaG9ZaVdzKzBCM0dWU1Q3QmNzSlZS?=
 =?utf-8?B?VFpETGVFVXo0ZE1Fb04rSTFNS09hMjFFeWl3bXZxWm1GOGdPeWpWRFhEbmkz?=
 =?utf-8?B?bzcxNjFkQWlBMDR4UTI2c3B0OFJNOXZTYnEzekVSTXlWWjVqK0FrOXprK0Fs?=
 =?utf-8?Q?X6Cp7LZKcTrG4XIz9V8HoJY64hVDOASrQZWIYX1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e415cf0-4bfa-4d41-5403-08d96972041e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 15:47:46.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlRDrFVn0kek9LoIC2E48p5Ss9BfECwO+0qtEkEWxgPVjxR3vA/WTRUMu4THtnwbekk3rmtH9PosSw/RyCGodQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 8/27/21 10:18 AM, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:27AM -0500, Brijesh Singh wrote:
>> From: Michael Roth <michael.roth@amd.com>
>>
>> This adds support for utilizing the SEV-SNP-validated CPUID table in
> s/This adds support for utilizing/Utilize/
>
> Yap, it can really be that simple. :)
>
>> the various #VC handler routines used throughout boot/run-time. Mostly
>> this is handled by re-using the CPUID lookup code introduced earlier
>> for the boot/compressed kernel, but at various stages of boot some work
>> needs to be done to ensure the CPUID table is set up and remains
>> accessible throughout. The following init routines are introduced to
>> handle this:
> Do not talk about what your patch does - that should hopefully be
> visible in the diff itself. Rather, talk about *why* you're doing what
> you're doing.
>
>> sev_snp_cpuid_init():
> This one is not really introduced - it is already there.
>
> <snip all the complex rest>
>
> So this patch is making my head spin. It seems we're dancing a lot of
> dance just to have our CPUID page present at all times. Which begs the
> question: do we need it during the whole lifetime of the guest?

Mike can correct me,  we need it for entire lifetime of the guest. 
Whenever guest needs the CPUID value, the #VC handler will refer to this
page.


> Regardless, I think this can be simplified by orders of
> magnitude if we allocated statically 4K for that CPUID page in
> arch/x86/boot/compressed/mem_encrypt.S, copied the supplied CPUID page
> from the firmware to it and from now on, work with our own copy.

Actually a  VMM could populate more than one page for the CPUID. One
page can include 64 entries and I believe Mike is already running into
limits (with Qemu) and exploring the ideas to extend it more than a page.


> You probably would need to still remap it for kernel proper but it would
> get rid of all that crazy in this patch here.
>
> Hmmm?
>
