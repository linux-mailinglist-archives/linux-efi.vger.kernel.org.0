Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A83FB8C8
	for <lists+linux-efi@lfdr.de>; Mon, 30 Aug 2021 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhH3PIu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Aug 2021 11:08:50 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:24289
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229553AbhH3PIt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Aug 2021 11:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS5NJ9+Pc6NddcGYhGhBS1abce3XxUeFTDqFcx+1bvpPC9iOyYcXh9qBi3qyN7rVyD5WI2RtvELT/pssxzZEZoqz6uz9ZobPU3AEkp1JBS0Qz0AZzW4EmXAT7UQu5P5yoEGBG80XXtqY0rI/4cSKUphmFfrr/vAa9mAo5kPhzClo3tmHfQai94i4MCSnrQcfsjdBEMHS6/maY9gyedZhEnJsa4pRx8YIJVNNEti/IajEj0itcMmyjMwkc6jemgITKfqsAQybxg4rPdu0pkGP0E8zFeNLNDui1sCSAsSM30iBjYXkTyU8sT7uckJsLpayoJGABCHoL48fPryIeChumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RLAaGo/c6bwy3S7IuQCFq50Vr6FeUA41tybikJJwcA=;
 b=ORj9ZhAdUbm0gaoi9qj37uFvvOvwuNZPIGcndkGqQcOx4md/0hJiE1fZmIJPHmhlMLPCfW2uxhAiy5SuaHyoaJpgHjNp6S/XwaQgMQE87LGErZumETRlk86x0gducETRmPFqBwrwUOwP3Lc4xihVFss5sPfmm+rhsE7Yj5AIRZo8a204ZbfSDgIQLsFegwx9RnsLmwPuNFQmsrvcOxUlM/hg7JsAwsrd/HDINLUt0fwdF7r6umhzliQSicnQOO+Yzy1P+s4+9WiSeLj9ZoiD6SxswBItBUTg+L71vQ3rt5BSxKyZgbChhDzlD5C/anpvzfyyuZXsiwc76z4Rx4GaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RLAaGo/c6bwy3S7IuQCFq50Vr6FeUA41tybikJJwcA=;
 b=AkBiete7HwV6scmIoeaXRzUVqX1B8T23qUTKQ5tJ+BzFo0NyrvbdWf11a0xEBULmpSbiflWWe32AEYREcubEjh0fT4wZ4S9TAoOpS7qbd/ILixcNc1OzBk8jxSJY9gnNpNb2V0ZJdKW/jQe14hvEly0IkldXlYCTzzNIGf87Z+E=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 15:07:42 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 15:07:42 +0000
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
Subject: Re: [PATCH Part1 v5 34/38] x86/sev: Add snp_msg_seqno() helper
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-35-brijesh.singh@amd.com> <YSkxxkVdupkyxAJi@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9e0e734d-7d2f-4703-b9ce-8362f0c740f4@amd.com>
Date:   Mon, 30 Aug 2021 10:07:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YSkxxkVdupkyxAJi@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:806:24::25) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA9PR13CA0110.namprd13.prod.outlook.com (2603:10b6:806:24::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.6 via Frontend Transport; Mon, 30 Aug 2021 15:07:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73355295-ad2f-49b6-4d62-08d96bc7ea02
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB455706853F20E40D2412F098E5CB9@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nP8g6C7XOkWB/c9bM+IwcWOWz0phNGXTPppvQc8PnKs4BaTB/+7l3EP0mLjVLdo9yIkUfCcopKDznAWKt/9B2VyPCkNXEx3Op3d9YRJjOGmux8bxDuOP3PaL2GcvSIs4gMcBGFSROJs5mj72mv+YbYFm20VBUpojtsKoJZdFvOD2OLJyHumhSyUcom2TF+s1lQL/v1ukMuXXMiGA6RjEhSt1iAk2lIDgURm5vfFTkaQV6pJ1RQLr0+MAAW6ViEnIz1i90CsU2P+dKXJoblVA06+1owYi/vJkBfW7GP82AjE/th3PKTS1ExkpRec2uWpdDPRVkaog/sMweKmdYP8LozlF4RRxr6LODRXFtBLJql/XWenA9X6lJCFuWLLaurSstKWYB5DuPRRP+zZBTFCUpkGxW6PIZSoqWDS06TD1o9hGqVT7dw57pj1dlWVxsCHb4kiWWE551Rg0JkmTvL5NSfAQK82K6onTjawA4sGPHr7N/6Kj40ALH/uQ1GtrmZuDhNWNWGXDbFYlnM4l1lYSr4p7soQH6+z3vuF24HklGTMkJHXP0I0A+cclvENOyAaQTahh1673Y5yaM0OT90dKJMPmkHohPgWdxISOQM37KJN4sVFqsH1pWmIikJv419BRKE8uNQPa2nUqPnvDWXX1FA7uvaAvovd9bjKzui4CLyXiHf37CteGZgSUwEc4S6y/uHDUGFUthYHFtJQKmZ2ves8+VkcDus40H1yEglYdYIYjm/mm5fGueaQegKunE4prZV8lz00TJz9F5fXi75VfbQGPmKtovwVHpqZsgBDa18aGcenOo+GTBQ85yyGDhrhMUpGLykAaZZ6IkNXe4kjUh9nxID90lRbDEI6BeEnAbDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(38350700002)(52116002)(38100700002)(478600001)(8676002)(6486002)(53546011)(8936002)(66476007)(6916009)(54906003)(31696002)(26005)(186003)(36756003)(44832011)(66946007)(956004)(2616005)(66556008)(7416002)(86362001)(7406005)(2906002)(31686004)(316002)(16576012)(5660300002)(966005)(4326008)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3J4UnFvZUFqSE1GR0twNk8wR2hGTkMwcjZlZzVHNGhKWjc3MEtXYmo1L2th?=
 =?utf-8?B?UmZTaVhqdGVhODJDbXJJdk8xTVI4Z1h1T1pnYnBUR24vQUMrUW1MNEwwa3Yy?=
 =?utf-8?B?d0V0eFljQ3YxUVh6N2ZCcXZRK0xwVjl1RC83QkJxYmd6YTVra1M5aGZwZXpU?=
 =?utf-8?B?eXJQMjVzQllrWUlFZkFFVFVpN3ZqeUllYjBBUm1LYkxoVC8wVitROS9RV3Qx?=
 =?utf-8?B?MlVwY0JaTzc5aGNSTWJNWjBGUllEcXd2bWFsZ3NyUXAxRS9QaHpJL2hwNDBM?=
 =?utf-8?B?YlVYaDREVDhWM3FhQVdnTTJ3SXFzOVRad01GRGUva0tmanY1TW9VNTNGbXRV?=
 =?utf-8?B?dlFpaktvZ1hEZW0rVW4yVXdIYW55OHV2U0hqeWg0eDNwSC9JSnFibGMzZUs4?=
 =?utf-8?B?dEY0dDRkLzlrWWt3T0IwTHlTRXdCRmlRSDcxbms0elc1L0M0aHNLdzViSHNi?=
 =?utf-8?B?NThyVmZBcVp3bVBlNzFEdytvUlFRU2ExdkRIRjE0QksvREdvUjZGSnFTZzhm?=
 =?utf-8?B?RzM0TTdFUDUrSjRaeVZOQUl6WDZWTCtkbk9ZTXhyZTZNVUtwNmZjTko2T0pJ?=
 =?utf-8?B?dFFmVmg1U1RiSFNSb3orZjE3c3hBYStRaHFtYTVuUlE3VE9ZVnkxcFU0SFda?=
 =?utf-8?B?d1lqQ21LU3pkRXlHa3l6amFkV3pucVY2TjVXV0hiUEVMMHYxS1dCSEozaEds?=
 =?utf-8?B?ZXowKzFyMnFNMEtpak1ZcDU2QlRCOXM0L1hmN0V3amw0U0RxVm1VaUk2OUlP?=
 =?utf-8?B?ZGFWRSttY1c2aVZ2WlNMWkZyYXllTDE4YWxpa1o4VGl1V3ZiUWdONHQ3QzVz?=
 =?utf-8?B?bnpyalBQejEvczNSd1RxU3YvTG96TzRGclZOSlU3dHFqVW9IYnV2NGkxb3FH?=
 =?utf-8?B?TG9qYkJyMUUrREdJZlhpWWpVM0x6QmFvd2dRUDlBVXV0elFtcE9OVkZKTHc0?=
 =?utf-8?B?VlZIcmZpY0E3UVV3V1lCejZTbWJZeFVvMW1pZTArWHU2TmJ5Q3ErQUxRWU9z?=
 =?utf-8?B?MWt6NVlJYkRCSnFYd0RESlZEazVmYlRkdEVmZTRHWSt2b2wzTGlWNjduK2JG?=
 =?utf-8?B?My8xZG80ZHZtbW1jeGZzUkY3b05mb0ZXMXI5dDg3ZVFqYjVVMlhFV1ZRZ2I5?=
 =?utf-8?B?TU1TWmYrTTk0L1Ivc041WUdrS3NTZkU0WSsyNUJXQTVJWWZqZ0dQQ1ZsYXNK?=
 =?utf-8?B?ckpFTUVvMk5jNldoZXYzUnRLZGdudnBYM2ZEL0FXR2hoZXV6VVdTMDBUbmxv?=
 =?utf-8?B?bFRZRTdQVDg3YUhHb2h6amxYdllJWlI4ZGxtTUdPdk9RazdiR3VZNU5KOHZl?=
 =?utf-8?B?cGlPMERHWjY3SkdSWVlqVm5wZHNKYUNJeVRJR0UzWi9GWFNWd0FueWRzRVBZ?=
 =?utf-8?B?ZE1PV1BuYndwVmcraTBsdEhpWFBMOGQxTVNnOEF4WmZOWitsMWdTWUU4YWx0?=
 =?utf-8?B?Uzd4SUlFQk1pc0w4ckp6d0NxYzZuQW43dnYvVEdqR1I4YTI5YkhPR2FQeXNF?=
 =?utf-8?B?Q2xFSm0zZUxiTzcxZnFTVXE3ZEFCRkp4c3NIM1RZdUYzb1lSZVhzTGdWYkNQ?=
 =?utf-8?B?TDZseStmSmxycU1aaGFtZmVjWEJ6NWtwbjNyTjlnYmpvMk5VdWlnNUUxOHVn?=
 =?utf-8?B?WU5Hd2pGaDdVRlJrdDgvYS9Ga1NtSU0yeGlVSjJTSEk0U0YyVkF5N3NTYXpL?=
 =?utf-8?B?bWlnT2ZwNWVLUDZRN3F1RVZjelVnKy8zVlJzaWsyWVVBY2dxTzNCOURHZ1dh?=
 =?utf-8?Q?HrwOQc7gt0E8wh2zHbHP6/uPebs9o6Jk9G+4dBq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73355295-ad2f-49b6-4d62-08d96bc7ea02
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 15:07:42.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYI46wSX0ST9LQEiPsY/F9pVduyyvopcYbw5/e8p8P/2b3liU/XHi8eof8AynIQGYBs25oPgP3bdVhj0d7Ul/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/27/21 1:41 PM, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:29AM -0500, Brijesh Singh wrote:
>> The SNP guest request message header contains a message count. The
>> message count is used while building the IV. The PSP firmware increments
>> the message count by 1, and expects that next message will be using the
>> incremented count. The snp_msg_seqno() helper will be used by driver to
>> get the message sequence counter used in the request message header,
>> and it will be automatically incremented after the request is successful.
>> The incremented value is saved in the secrets page so that the kexec'ed
>> kernel knows from where to begin.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/kernel/sev.c     | 79 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/sev-guest.h | 37 ++++++++++++++++++
>>   2 files changed, 116 insertions(+)
>>
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 319a40fc57ce..f42cd5a8e7bb 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -51,6 +51,8 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>>    */
>>   static struct ghcb __initdata *boot_ghcb;
>>   
> 
> Explain what that is in a comment above it.
> 
>> +static u64 snp_secrets_phys;
> 
> snp_secrets_pa;
> 
> is the usual convention when a variable is supposed to contain a
> physical address.
> 

Noted.

>> +
>>   /* #VC handler runtime per-CPU data */
>>   struct sev_es_runtime_data {
>>   	struct ghcb ghcb_page;
>> @@ -2030,6 +2032,80 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>>   		halt();
>>   }
>>   
>> +static struct snp_secrets_page_layout *snp_map_secrets_page(void)
>> +{
>> +	u16 __iomem *secrets;
>> +
>> +	if (!snp_secrets_phys || !sev_feature_enabled(SEV_SNP))
>> +		return NULL;
>> +
>> +	secrets = ioremap_encrypted(snp_secrets_phys, PAGE_SIZE);
>> +	if (!secrets)
>> +		return NULL;
>> +
>> +	return (struct snp_secrets_page_layout *)secrets;
>> +}
> 
> Or simply:
> 
> static struct snp_secrets_page_layout *map_secrets_page(void)
> {
>          if (!snp_secrets_phys || !sev_feature_enabled(SEV_SNP))
>                  return NULL;
>                  
>          return ioremap_encrypted(snp_secrets_phys, PAGE_SIZE);
> }
> 
> ?
> 

Yes that also works.

>> +
>> +static inline u64 snp_read_msg_seqno(void)
> 
> Drop that "snp_" prefix from all those static function names. This one
> is even inline, which means its name doesn't matter at all.
> 
>> +{
>> +	struct snp_secrets_page_layout *layout;
>> +	u64 count;
>> +
>> +	layout = snp_map_secrets_page();
>> +	if (!layout)
>> +		return 0;
>> +
>> +	/* Read the current message sequence counter from secrets pages */
>> +	count = readl(&layout->os_area.msg_seqno_0);
>> +
>> +	iounmap(layout);
>> +
>> +	/* The sequence counter must begin with 1 */
> 
> That sounds weird. Why? 0 is special?

The SNP firmware spec says that counter must begin with the 1.

> 
>> +	if (!count)
>> +		return 1;
>> +
>> +	return count + 1;
>> +}
>> +
>> +u64 snp_msg_seqno(void)
> 
> Function name needs a verb. I.e.,
> 
> 	 snp_get_msg_seqno()
> 
Ok.

>> +{
>> +	u64 count = snp_read_msg_seqno();
>> +
>> +	if (unlikely(!count))
> 
> That looks like a left-over from a previous version as it can't happen.
> 
> Or are you handling the case where the u64 count will wraparound to 0?
> 
> But "The sequence counter must begin with 1" so that read function above
> needs more love.
> 

Yes, I will cleanup a bit more.

>> +		return 0;
> 
> 
>> +
>> +	/*
>> +	 * The message sequence counter for the SNP guest request is a
>> +	 * 64-bit value but the version 2 of GHCB specification defines a
>> +	 * 32-bit storage for the it.
>> +	 */
>> +	if (count >= UINT_MAX)
>> +		return 0;
> 
> Huh, WTF? So when the internal counter goes over u32, this function will
> return 0 only? More weird.
>

During the GHCB writing the seqno use to be 32-bit value and hence the 
GHCB spec choose the 32-bit value but recently the SNP firmware changed 
it from the 32 to 64. So, now we are left with the option of limiting 
the sequence number to 32-bit. If we go beyond 32-bit then all we can do 
is fail the call. If we pass the value of zero then FW will fail the call.



>> +
>> +	return count;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_msg_seqno);
>> +
>> +static void snp_gen_msg_seqno(void)
> 
> That's not "gen" - that's "inc" what this function does. IOW,
> 
> 	snp_inc_msg_seqno
> 

I agree. I will update it.

>> +{
>> +	struct snp_secrets_page_layout *layout;
>> +	u64 count;
>> +
>> +	layout = snp_map_secrets_page();
>> +	if (!layout)
>> +		return;
>> +
>> +	/*
>> +	 * The counter is also incremented by the PSP, so increment it by 2
>> +	 * and save in secrets page.
>> +	 */
>> +	count = readl(&layout->os_area.msg_seqno_0);
>> +	count += 2;
>> +
>> +	writel(count, &layout->os_area.msg_seqno_0);
>> +	iounmap(layout);
> 
> Why does this need to constantly map and unmap the secrets page? Why
> don't you map it once on init and unmap it on exit?
> 

Yes, I can remove that with:

secrets_va = (__force void *)ioremap_encrypted(pa...)

And then use secrets_va instead of doing readl/writel.

>> +}
>> +
>>   int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsigned long *fw_err)
>>   {
>>   	struct ghcb_state state;
>> @@ -2077,6 +2153,9 @@ int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsi
>>   		ret = -EIO;
>>   	}
>>   
>> +	/* The command was successful, increment the sequence counter */
>> +	snp_gen_msg_seqno();
>> +
>>   e_put:
>>   	__sev_put_ghcb(&state);
>>   e_restore_irq:
>> diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
>> index 24dd17507789..16b6af24fda7 100644
>> --- a/include/linux/sev-guest.h
>> +++ b/include/linux/sev-guest.h
>> @@ -20,6 +20,41 @@ enum vmgexit_type {
>>   	GUEST_REQUEST_MAX
>>   };
>>   
>> +/*
>> + * The secrets page contains 96-bytes of reserved field that can be used by
>> + * the guest OS. The guest OS uses the area to save the message sequence
>> + * number for each VMPCK.
>> + *
>> + * See the GHCB spec section Secret page layout for the format for this area.
>> + */
>> +struct secrets_os_area {
>> +	u32 msg_seqno_0;
>> +	u32 msg_seqno_1;
>> +	u32 msg_seqno_2;
>> +	u32 msg_seqno_3;
>> +	u64 ap_jump_table_pa;
>> +	u8 rsvd[40];
>> +	u8 guest_usage[32];
>> +} __packed;
> 
> So those are differently named there:
> 
> struct secrets_page_os_area {
> 	uint32 vmpl0_message_seq_num;
> 	uint32 vmpl1_message_seq_num;
> 	...
> 
> and they have "vmpl" in there which makes a lot more sense for that
> they're used than msg_seqno_* does.
> 

I just choose the smaller name but I have no issues matching with the 
spec. Also those keys does not have anything to do with the VMPL level. 
The secrets page provides 4 different keys and they are referred as 
vmpck0..3 and each of them have a sequence numbers associated with it.

In GHCB v3 we probably need to rework the structure name.

>> +
>> +#define VMPCK_KEY_LEN		32
>> +
>> +/* See the SNP spec for secrets page format */
>> +struct snp_secrets_page_layout {
> 
> Simply
> 
> 	struct snp_secrets
> 
> That name says all you need to know about what that struct represents.
> 
>> +	u32 version;
>> +	u32 imien	: 1,
>> +	    rsvd1	: 31;
>> +	u32 fms;
>> +	u32 rsvd2;
>> +	u8 gosvw[16];
>> +	u8 vmpck0[VMPCK_KEY_LEN];
>> +	u8 vmpck1[VMPCK_KEY_LEN];
>> +	u8 vmpck2[VMPCK_KEY_LEN];
>> +	u8 vmpck3[VMPCK_KEY_LEN];
>> +	struct secrets_os_area os_area;
> 
> My SNP spec copy has here
> 
> 0A0h–FFFh	Reserved.
> 
> and no os area. I guess
> 
> SEV Secure Nested Paging Firmware ABI Specification 56860 Rev. 0.8 August 2020
> 
> needs updating...

The latest SNP spec here:

https://www.amd.com/system/files/TechDocs/56860.pdf

We are at spec 0.9.

> 
>> +	u8 rsvd3[3840];
>> +} __packed;
>> +
>>   /*
>>    * The error code when the data_npages is too small. The error code
>>    * is defined in the GHCB specification.
>> @@ -36,6 +71,7 @@ struct snp_guest_request_data {
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>   int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
>>   			    unsigned long *fw_err);
>> +u64 snp_msg_seqno(void);
>>   #else
>>   
>>   static inline int snp_issue_guest_request(int type, struct snp_guest_request_data *input,
>> @@ -43,6 +79,7 @@ static inline int snp_issue_guest_request(int type, struct snp_guest_request_dat
>>   {
>>   	return -ENODEV;
>>   }
>> +static inline u64 snp_msg_seqno(void) { return 0; }
>>   
>>   #endif /* CONFIG_AMD_MEM_ENCRYPT */
>>   #endif /* __LINUX_SEV_GUEST_H__ */
>> -- 
>> 2.17.1
>>
> 
