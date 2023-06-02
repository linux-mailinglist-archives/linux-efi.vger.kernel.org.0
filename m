Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C4F720324
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 15:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjFBNWt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbjFBNWr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 09:22:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35001B3;
        Fri,  2 Jun 2023 06:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLEIZeQ9LZEPQou7/8PAN2ckuWPOrlWFn9zlI6+qCQ18FhqIILZnzfJQq7xvoLJwVhd1Hv25aFTBBwOQt1/wDD44F9sh/lv2U9TCUyYYoFHH/zn0nWKrepOeSnCscOnWZ30Btrxwwn6+OCu9d9i7pLBNEpOE76o7os+aCrinXfxN9/Xbut5MyoUzTYcCJE+thxE2jDU0r/L3OmND9ZUtwdvv0g3N+Hq4xbyuUabzuXviXHGUUu3C9hKVf8qpEvMaB8YA8Li0hYCL1q8llAqWTviUyEfVnGvwEJO1QxLKOWs6qn0cYKVrawNhVvn6pCH0Se1d9chXfNqrFRhKNiUoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUcdsWUkJlzIffh+SI2DASfLgk3SmkkjrwJlioT2YP8=;
 b=ke6MlyQv49Y8MaCYMb1ZmLja4gmh0yh3ek/1WqKrsRFtyg6EF8flCE2V/siQrY2G9liHAbDHky747JUgjVl6aG+k14VBkuRj3UUdlgsj95aiI6rPIeIskOtaEwPiDJmFHAu1AcfLOTmHzEUO8eWuRFXL8HTSN85YKtOB7kBy7wjhm7TOCrPe4ZoldmXeEBT/4eYAxFskogTsbU+PjTSMIrVx6XXvNDQ2rtbDyLDcImZMPq82xfbx7obQXFTvFr7lkw1LB8eOpP5OleYRrX/I8rfpce9JKwBTRxEygjpwp4uELQexejouCn7QVhJc9D9tgrXh+hLio+Hm4qBRhKJ5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUcdsWUkJlzIffh+SI2DASfLgk3SmkkjrwJlioT2YP8=;
 b=tUiAbvk/PGBGcCTwYFAcawBgRS2FIDg5V6tl/FJVkX2cbnY7DoSYBxz372dvNJmQ/ZhCSw27reTwh7pbU3UxGhOnpIeyvgIcmBie573qF9lyqA8gCd9h1FQUBw41ctrfVRRcJZKs30bD3PoZttTh1JkwVqm2wakeVHo1DXn2u24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 13:22:40 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.026; Fri, 2 Jun 2023
 13:22:39 +0000
Message-ID: <4d8d6fc4-99b5-29ba-7f81-12e7d57907ea@amd.com>
Date:   Fri, 2 Jun 2023 08:22:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv13 9/9] x86/tdx: Add unaccepted memory support
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-10-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230601182543.19036-10-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:806:24::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbd56f2-5984-4211-e640-08db636c7040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMa5+mGVhi1mpbNrQqlqL2Bk3j5tWuqt1xoxp0JtjyMb1wK4JiNxR95mRvTELYeN0DY+dnFZf1TMPLiGZOEa1B9wTUXVdD79yMyPBtY5MIC4ykyRfrgFmqqXHDG1M2ZkIM7PdQ0i17X4XDjGJRiRAZ4362jsnWJlAJxk2aYN/N6gntOV8DktuBU6Ci6sSmv4dSfTHa+qFZsHFiunXE4or0+neA3y7VWfZalyrwaA3Rlj5EhBshRpLX9EYIbQURIStWW44f/U3Y5RXBXpDYs9hDOATHpYRNa1OhoJZdSL4hl1Yj7z1p+CdpjEl9GcVQkSyj5e+McudHOc6ZpsrTn5z4JFLO7JfDu609QlrxaTLwm10tiXvoWtjEb/u5Y7eOMGDupNVL0PP0GXyJMSozFA0SDaKwsdEMjPXnyY/zntDuPctRQa3/gd+oZ8IBvQfifz3FF+qw1Ta3FnIm/fw7EczeIEoSAU1+62bZbTeF7fnjEfbcAQeq3tOlJ/SLE3p2ZyHd00+xt07+/nChd1aFZ6NL7o5LkY4M5OtD/oJAxsUeNThwW3MXfAScMjb6m67dgK2yGz1fMh0kC+Fh02jZVunsiqle6YfyUKH2193VRu/aB87WqUoJoapttYLUK6lzv8prU5sTzV6tJ4IfYFtw5mCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(8936002)(6506007)(53546011)(186003)(6512007)(26005)(6666004)(83380400001)(2906002)(30864003)(2616005)(41300700001)(7406005)(5660300002)(8676002)(316002)(6486002)(66556008)(478600001)(4326008)(66476007)(66946007)(110136005)(54906003)(86362001)(31696002)(36756003)(7416002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TER4NEFDSnYvenc5Q0tSVWZ6SittQTA0eXlPRUZscjVPNzFlQUdXOGtlYnhR?=
 =?utf-8?B?ZEJ1TnN2NFZ5Y2VUNGRPVG80U1l5UnNtTU9TUzZXMi9tQlpHcEV2T0ViRUl6?=
 =?utf-8?B?Q0dRNk5WN2s4Z2dTajh0ZnJaam5wUFlxVG10QVFVQmthbHlSU0sxVTJEQ005?=
 =?utf-8?B?eHVDSlQrSUdrcGQwdDVCbXhTMTJ5bG5LbGRldm1RL0RaL3ZDSUNFM0o0Z0RO?=
 =?utf-8?B?c05DTkgvQ1RWdTVxem9acU1TTWNEUHI3QytzOTZ1NW9wMGNlNi9qVUVTL2dC?=
 =?utf-8?B?ejZMR0xtaE9MS1IwdXJTbGhjL3M1U1RVUVI5OXBRZS9kTWZqaGFxSW5TMllZ?=
 =?utf-8?B?RG1STk9ZaUIyTTJBcHhYcm41dTZPSStHV3d6N0FvTng2bHZqdlhWcTU0TUla?=
 =?utf-8?B?MzVDVVZic05wVGkyMUVqNjhJSDhzeXhKaU00Qk1EbHM0dzU1cGx2MzFpdUp6?=
 =?utf-8?B?eVRqRlhaRjZZbjZSM3pSZDJjUFRDbUFGazgzejdSTnNzbm1hVWUwREZ4b25y?=
 =?utf-8?B?UDNndG8rdUVnYWo2NllMTC93SGZramhENEVwcU81ZlF0QVZPSThOTC9sODE4?=
 =?utf-8?B?bko2NzlETmVOWjhtN3VrQW1yQU5yTjl2Wmd5MmxoQnJjdUVmcDg4S3RPRFZ3?=
 =?utf-8?B?NHZiVThyMU5jTk5LVmZFQzIyWm5uVDl5WTNrdDVUS3JCRWtEVEUrdFVpYkcv?=
 =?utf-8?B?VXJmQ3ZZOXdhSU43Mk1ld3pEeWJtVzM3RmFweGV5S0F3WHo5MEcvaGdwOWhL?=
 =?utf-8?B?Z1dzckhhOWI2MzAxTzYyaC9MR2hWWnR5amh2djB1UEd2ODN6eGRFa1llak5Q?=
 =?utf-8?B?ZVFjT05rVlo3QmVBTHIzUWUxMmpUWkY0S3JtSFFCejVqUXZjMVFDcUVvQXhy?=
 =?utf-8?B?bTJFNENudjc1eGFJUDFyYnhIMlZSTGhHRE9DYWZ3VG9DZGY0bGNieVhhQWVq?=
 =?utf-8?B?bVphc2JCaVlUSElNZEJ6UFFaV1pKU1FjeDRMRXdwN0xDY1RhMVVmbDRjNkVn?=
 =?utf-8?B?Tmk2cVZIenVzU3o2blhlSWRTQmdyVk0vTk01b2syQS92S3hFb05aUVRrcWQy?=
 =?utf-8?B?NDdlbm9EbE40c0M3WTAxQTlWN3dVaWpkOStTY2lqZWJXWnp0SEFBMEd6a0V5?=
 =?utf-8?B?S0ZNT3I1M3R1VVZoOEFuaVljcEk4N2t5Z05UZHc0N0RMWlJHdnZJck1RSndZ?=
 =?utf-8?B?YVNrSmFJSk8zdlNLeEtrY3JaYk1BNjRkOStGY2NJOFRyb0dOOUtPd0l4dzEx?=
 =?utf-8?B?VndqQjlPVzNBek5MTCtLTTBsYXZ3cjcrNEs1NzV3VFFqcTQ4cFRXUVliNnI3?=
 =?utf-8?B?YmJITkhyQTAzYUJ3VzJkZXA4SlpneU1KTy9RQjUwT1ZxVzdPUjJ5RmVvVXFh?=
 =?utf-8?B?bjNtOHJJUlZmNCswZERkMHVWdlhmb0wrOHFYZXp1OEJIcHpNUnYrOXJGVlRw?=
 =?utf-8?B?VEF0ZVVZc0hPYXdCVFBVZ0t0cEFoY0sxQ01aN2VXZll1WWtxYk51dlluMTQ4?=
 =?utf-8?B?SXl6U0lWeVBSck5mdjB4ZXhpTm5GeWJzcmp3clAzWXc2MW5PenArMlFCUUtl?=
 =?utf-8?B?VUlITm1MbEM3Q2Yyb2RYYmpCZW5nQjV1VDl1QXBpd1F5QVRPa0VpeUt1QVRV?=
 =?utf-8?B?eU5ndi9HYkZSUUsySlc3VmtzOFZQcGl0QVVqcjBycFBxbEp1VjRQT05pbERY?=
 =?utf-8?B?NGNwUUtYbzJHWmhNQ0V0eVhuUndvVkVCcFVUaFM1a1ROR3hTbHdiZXpHMlNM?=
 =?utf-8?B?YXJQSGV3b1hCZ3ZXYWhjQUUzRWdMYnlxRDBuZllGMENsckJPWENkQVhNN3h4?=
 =?utf-8?B?MzZRM2VoMUM3TTlLc2ZFV0JtaVZKdWZ2MTFqOWcwREViQWxITURscUVVUlgz?=
 =?utf-8?B?dk5TbmNzQVFFOTFYNDhLQnhWVUJqME51bUhvdUhVbm0zYmlDc3JnZFEva20x?=
 =?utf-8?B?aGxJNkt6Q25hUm1rQnRZdVJnOXY4ajZHS1VmdjJtY1JsSFBHcFJ6c3B3N1F0?=
 =?utf-8?B?eE5jWmZKV0VLNVZUbnRpeDJiWjVpaGZ2SzJQZ1RBY3pBQWxYRXQyRmZqcUs0?=
 =?utf-8?B?bmZySjZvS2RqWjRqMHhwQjRTZm9OTm1tLy96OU4rd01SUnpFaEZJbSs0cUFa?=
 =?utf-8?Q?37dafOsgyT4dDhiyBRXGmdrEv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbd56f2-5984-4211-e640-08db636c7040
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 13:22:39.7405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPRKDSnTSG7Fi71JZ+SyZhfyazlrGxxV7TJpZVtEFn6fTc9ogKipiJQ0YJ1mvAU1sIyFIPaFSw3VY5y5rWd9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/1/23 13:25, Kirill A. Shutemov wrote:
> Hookup TDX-specific code to accept memory.
> 
> Accepting the memory is done with ACCEPT_PAGE module call on every page
> in the range. MAP_GPA hypercall is not required as the unaccepted memory
> is considered private already.
> 
> Extract the part of tdx_enc_status_changed() that does memory acceptance
> in a new helper. Move the helper tdx-shared.c. It is going to be used by
> both main kernel and decompressor.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/Kconfig                         |  2 +
>   arch/x86/boot/compressed/Makefile        |  2 +-
>   arch/x86/boot/compressed/error.c         | 19 +++++++
>   arch/x86/boot/compressed/error.h         |  1 +
>   arch/x86/boot/compressed/mem.c           | 35 +++++++++++-
>   arch/x86/boot/compressed/tdx-shared.c    |  2 +
>   arch/x86/coco/tdx/Makefile               |  2 +-
>   arch/x86/coco/tdx/tdx-shared.c           | 71 ++++++++++++++++++++++++
>   arch/x86/coco/tdx/tdx.c                  | 70 +----------------------
>   arch/x86/include/asm/shared/tdx.h        |  2 +
>   arch/x86/include/asm/unaccepted_memory.h | 24 ++++++++
>   11 files changed, 160 insertions(+), 70 deletions(-)
>   create mode 100644 arch/x86/boot/compressed/tdx-shared.c
>   create mode 100644 arch/x86/coco/tdx/tdx-shared.c
>   create mode 100644 arch/x86/include/asm/unaccepted_memory.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 53bab123a8ee..5c72067c06d4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -884,9 +884,11 @@ config INTEL_TDX_GUEST
>   	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
>   	depends on X86_64 && CPU_SUP_INTEL
>   	depends on X86_X2APIC
> +	depends on EFI_STUB
>   	select ARCH_HAS_CC_PLATFORM
>   	select X86_MEM_ENCRYPT
>   	select X86_MCE
> +	select UNACCEPTED_MEMORY
>   	help
>   	  Support running as a guest under Intel TDX.  Without this support,
>   	  the guest kernel can not boot or run under TDX.
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index cc4978123c30..b13a58021086 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -106,7 +106,7 @@ ifdef CONFIG_X86_64
>   endif
>   
>   vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
> -vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> +vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/tdx-shared.o
>   vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>   
>   vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> diff --git a/arch/x86/boot/compressed/error.c b/arch/x86/boot/compressed/error.c
> index c881878e56d3..5313c5cb2b80 100644
> --- a/arch/x86/boot/compressed/error.c
> +++ b/arch/x86/boot/compressed/error.c
> @@ -22,3 +22,22 @@ void error(char *m)
>   	while (1)
>   		asm("hlt");
>   }
> +
> +/* EFI libstub  provides vsnprintf() */
> +#ifdef CONFIG_EFI_STUB
> +void panic(const char *fmt, ...)
> +{
> +	static char buf[1024];
> +	va_list args;
> +	int len;
> +
> +	va_start(args, fmt);
> +	len = vsnprintf(buf, sizeof(buf), fmt, args);
> +	va_end(args);
> +
> +	if (len && buf[len - 1] == '\n')
> +		buf[len - 1] = '\0';
> +
> +	error(buf);
> +}
> +#endif
> diff --git a/arch/x86/boot/compressed/error.h b/arch/x86/boot/compressed/error.h
> index 1de5821184f1..86fe33b93715 100644
> --- a/arch/x86/boot/compressed/error.h
> +++ b/arch/x86/boot/compressed/error.h
> @@ -6,5 +6,6 @@
>   
>   void warn(char *m);
>   void error(char *m) __noreturn;
> +void panic(const char *fmt, ...) __noreturn __cold;
>   
>   #endif /* BOOT_COMPRESSED_ERROR_H */
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> index 4ecf26576a77..d2b6948a7801 100644
> --- a/arch/x86/boot/compressed/mem.c
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -2,11 +2,44 @@
>   
>   #include "error.h"
>   #include "misc.h"
> +#include "tdx.h"
> +#include <asm/shared/tdx.h>
> +
> +/*
> + * accept_memory() and process_unaccepted_memory() called from EFI stub which
> + * runs before decompresser and its early_tdx_detect().
> + *
> + * Enumerate TDX directly from the early users.
> + */
> +static bool early_is_tdx_guest(void)
> +{
> +	static bool once;
> +	static bool is_tdx;
> +
> +	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
> +		return false;
> +
> +	if (!once) {
> +		u32 eax, sig[3];
> +
> +		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
> +			    &sig[0], &sig[2],  &sig[1]);
> +		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
> +		once = true;
> +	}
> +
> +	return is_tdx;
> +}
>   
>   void arch_accept_memory(phys_addr_t start, phys_addr_t end)
>   {
>   	/* Platform-specific memory-acceptance call goes here */
> -	error("Cannot accept memory");
> +	if (early_is_tdx_guest()) {
> +		if (tdx_accept_memory(start, end))
> +			return;
> +	}
> +
> +	error("Cannot accept memory: unknown platform\n");

So this is a change in this version. If tdx_accept_memory() fails, you'll 
report unknown platform. Wouldn't it be better to have an error message 
that indicates a failure in the accept path?

Thanks,
Tom

>   }
>   
>   void init_unaccepted_memory(void)
> diff --git a/arch/x86/boot/compressed/tdx-shared.c b/arch/x86/boot/compressed/tdx-shared.c
> new file mode 100644
> index 000000000000..5ac43762fe13
> --- /dev/null
> +++ b/arch/x86/boot/compressed/tdx-shared.c
> @@ -0,0 +1,2 @@
> +#include "error.h"
> +#include "../../coco/tdx/tdx-shared.c"
> diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
> index 46c55998557d..2c7dcbf1458b 100644
> --- a/arch/x86/coco/tdx/Makefile
> +++ b/arch/x86/coco/tdx/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -obj-y += tdx.o tdcall.o
> +obj-y += tdx.o tdx-shared.o tdcall.o
> diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
> new file mode 100644
> index 000000000000..ef20ddc37b58
> --- /dev/null
> +++ b/arch/x86/coco/tdx/tdx-shared.c
> @@ -0,0 +1,71 @@
> +#include <asm/tdx.h>
> +#include <asm/pgtable.h>
> +
> +static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
> +				    enum pg_level pg_level)
> +{
> +	unsigned long accept_size = page_level_size(pg_level);
> +	u64 tdcall_rcx;
> +	u8 page_size;
> +
> +	if (!IS_ALIGNED(start, accept_size))
> +		return 0;
> +
> +	if (len < accept_size)
> +		return 0;
> +
> +	/*
> +	 * Pass the page physical address to the TDX module to accept the
> +	 * pending, private page.
> +	 *
> +	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
> +	 */
> +	switch (pg_level) {
> +	case PG_LEVEL_4K:
> +		page_size = 0;
> +		break;
> +	case PG_LEVEL_2M:
> +		page_size = 1;
> +		break;
> +	case PG_LEVEL_1G:
> +		page_size = 2;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	tdcall_rcx = start | page_size;
> +	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
> +		return 0;
> +
> +	return accept_size;
> +}
> +
> +bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	/*
> +	 * For shared->private conversion, accept the page using
> +	 * TDX_ACCEPT_PAGE TDX module call.
> +	 */
> +	while (start < end) {
> +		unsigned long len = end - start;
> +		unsigned long accept_size;
> +
> +		/*
> +		 * Try larger accepts first. It gives chance to VMM to keep
> +		 * 1G/2M Secure EPT entries where possible and speeds up
> +		 * process by cutting number of hypercalls (if successful).
> +		 */
> +
> +		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
> +		if (!accept_size)
> +			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
> +		if (!accept_size)
> +			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
> +		if (!accept_size)
> +			return false;
> +		start += accept_size;
> +	}
> +
> +	return true;
> +}
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 0d5fe6e24e45..a9c4ba6c5c5d 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -713,46 +713,6 @@ static bool tdx_cache_flush_required(void)
>   	return true;
>   }
>   
> -static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
> -				    enum pg_level pg_level)
> -{
> -	unsigned long accept_size = page_level_size(pg_level);
> -	u64 tdcall_rcx;
> -	u8 page_size;
> -
> -	if (!IS_ALIGNED(start, accept_size))
> -		return 0;
> -
> -	if (len < accept_size)
> -		return 0;
> -
> -	/*
> -	 * Pass the page physical address to the TDX module to accept the
> -	 * pending, private page.
> -	 *
> -	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
> -	 */
> -	switch (pg_level) {
> -	case PG_LEVEL_4K:
> -		page_size = 0;
> -		break;
> -	case PG_LEVEL_2M:
> -		page_size = 1;
> -		break;
> -	case PG_LEVEL_1G:
> -		page_size = 2;
> -		break;
> -	default:
> -		return 0;
> -	}
> -
> -	tdcall_rcx = start | page_size;
> -	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
> -		return 0;
> -
> -	return accept_size;
> -}
> -
>   /*
>    * Inform the VMM of the guest's intent for this physical page: shared with
>    * the VMM or private to the guest.  The VMM is expected to change its mapping
> @@ -777,33 +737,9 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>   	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
>   		return false;
>   
> -	/* private->shared conversion  requires only MapGPA call */
> -	if (!enc)
> -		return true;
> -
> -	/*
> -	 * For shared->private conversion, accept the page using
> -	 * TDX_ACCEPT_PAGE TDX module call.
> -	 */
> -	while (start < end) {
> -		unsigned long len = end - start;
> -		unsigned long accept_size;
> -
> -		/*
> -		 * Try larger accepts first. It gives chance to VMM to keep
> -		 * 1G/2M Secure EPT entries where possible and speeds up
> -		 * process by cutting number of hypercalls (if successful).
> -		 */
> -
> -		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
> -		if (!accept_size)
> -			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
> -		if (!accept_size)
> -			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
> -		if (!accept_size)
> -			return false;
> -		start += accept_size;
> -	}
> +	/* shared->private conversion requires memory to be accepted before use */
> +	if (enc)
> +		return tdx_accept_memory(start, end);
>   
>   	return true;
>   }
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 1ff0ee822961..19228beb4894 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -91,5 +91,7 @@ struct tdx_module_output {
>   u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>   		      struct tdx_module_output *out);
>   
> +bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
> +
>   #endif /* !__ASSEMBLY__ */
>   #endif /* _ASM_X86_SHARED_TDX_H */
> diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
> new file mode 100644
> index 000000000000..f0ab217b566f
> --- /dev/null
> +++ b/arch/x86/include/asm/unaccepted_memory.h
> @@ -0,0 +1,24 @@
> +#ifndef _ASM_X86_UNACCEPTED_MEMORY_H
> +#define _ASM_X86_UNACCEPTED_MEMORY_H
> +
> +#include <linux/efi.h>
> +#include <asm/tdx.h>
> +
> +static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	/* Platform-specific memory-acceptance call goes here */
> +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> +		if (tdx_accept_memory(start, end))
> +			return;
> +	}
> +
> +	panic("Cannot accept memory: unknown platform\n");
> +}
> +
> +static inline struct efi_unaccepted_memory *efi_get_unaccepted_table(void)
> +{
> +	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
> +		return NULL;
> +	return __va(efi.unaccepted);
> +}
> +#endif
