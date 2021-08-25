Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25183F7B55
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 19:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbhHYRQB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 13:16:01 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:20833
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233392AbhHYRQA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Aug 2021 13:16:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1EwZ1reRU5rF1YqtqesJx8DnN3Xnp2w1CTGNK8DMdsDkEJc9bhfuOvOI0LxE72tVX7KH9cBMV2N9hU4/BiRLnejRZSlZLdf+AE0v9732hpI2QxZm2kVUP1RvMUcLdGZNHhEnbEsYyyQSEVxYsSdmlQ06MUK5ADBpDBQe8kn0V6XBOHleVPu1WEzj+nvRloU+pMUHQ2sca2KdxPeC9H4TyhegOw5bfJXOjiVWZM2AcPp5HWXXemph/Oq+JZuWsySfyHc7+VeYjgMUw4V5xDWAwsnutzDFx/Etkh9q7PqJ6nKgo3v5vHLwz7SUpTX7stnaDK67VEWa6Z6vCKwVg03vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TNCBN9eVnSrNPIxe1AsrGA0cgt4fl+Sfainf4t/Df0=;
 b=VSarmY9svIITTcBMg9M6QQTwC7Yki5CUkdbCQEJpn4HR4uczAnk1pllMTM+tnRYIko506PfzcLRtRz7Ng8MykEiy7OhH4MFLqiFpH0KghVxMLjeWwiqKHUHE7+m9wagZFfPfyDA/bn9+Vx2TJ4shJviFNDQTinTCj7brDwainsy69gqNAHo6lVT2xLfQ0wskGPgNPbemwxKKjJMFLzwaXwnq22OCjiiXnWUXexIVsE+ECBNvkjX9cIzN/eXVk7SKSz6q9LAaaY/e12ClxWK3L166yAFnN32QskW9dfVk71p7FlpMmsiypEl6kqcaNUo5qZlrtS59Dt9Bg3nmIddzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TNCBN9eVnSrNPIxe1AsrGA0cgt4fl+Sfainf4t/Df0=;
 b=vxitHEBmPwhvOyRmzRU/HFjzQYnyJFqecIgtoVCHrsEuEOg6j1ZI6uc/PCiz+Ga7ptsImeutSuagnFl4lWN0M/3RA3nhsDKBXt92/pwHJcNQFSP63SDS7jGWMKH0N41zThOBzJD19qdTxNgpXUR5vLIYGSnQ96C1I1t3dZDURbE=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4923.namprd12.prod.outlook.com (2603:10b6:610:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 17:15:12 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Wed, 25 Aug 2021
 17:15:11 +0000
Date:   Wed, 25 Aug 2021 12:07:19 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 23/38] x86/head/64: set up a startup %gs for
 stack protector
Message-ID: <20210825170719.lygfpbhyvmenohxq@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-24-brijesh.singh@amd.com>
 <YSZcrtqExehVwvhf@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSZcrtqExehVwvhf@suse.de>
X-ClientProxiedBy: SN4PR0501CA0131.namprd05.prod.outlook.com
 (2603:10b6:803:42::48) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SN4PR0501CA0131.namprd05.prod.outlook.com (2603:10b6:803:42::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Wed, 25 Aug 2021 17:15:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0d04090-f2ee-4652-d66c-08d967ebe572
X-MS-TrafficTypeDiagnostic: CH2PR12MB4923:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4923181EE528B6C3BA937A0295C69@CH2PR12MB4923.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pirwj41rOafb/zeBF4zjtoWM6yqArALQb2hrR7e6rqfZXbAcO3Skl22D7Z44WnYjWXwmextMBC7rCrAF3Lj552oj03W8l9QrXYRhnp7sYhv5bsu7dQh9pGWD+ns/XiQh7nR5l46vsFQZOvDLyE/02pEnT6lJxkYjXtYwZ07R64x+h52t4je2gIIxyxSS0g34/fCdyUUUqzc+2EhAfzuBrPgvJJ3E6+JoAY1EhWryr+1Z0kRuheoYWBGAOANASL2VucogA6NVe5nzNyLsiFOhw+6qAJ8bhUOPykJQJfP/veDbotsCDA/BVMkNOstLY8M3Kbfl/9b7Pj8lkDEw8Xkchg1mwOpjFKhQzIdAmLg10DoeOzg/OAFFEYIX4YAz4GseuLbUDm3ZHnWD6kl7jzk6Ocaqk8mJGet1Ou0bWDOXzPTiuQ4Pk9Rc4uAztjK+Q9qNvX1Tvo9xeiNAApbl2XIUATPFTB8MkfIYndFT7p23641pR1FQJdz9pi3EdJd0nQeJC5xHf5V6KvBlhvUM7JF5c9ECf8wl/pF0b6NMpJJsZ/SAJYtZFC5AoxNplWbr/dmGWm7RxPvKFhmRJIkoTQeGZgMHNeD0r6XGX1gQxIV5Ck2wdtiZVGVGFm+R/lzpvNMhoai75FrR8gwmaiB9fOkJ8ZiJ7O+qvi8B1F6yH8HFbjKeD/m0y9zobU4cfc6GPq0inEXF1oc75thOiCx0UmUXJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(3716004)(66476007)(4326008)(5660300002)(8676002)(2906002)(44832011)(1076003)(52116002)(6486002)(83380400001)(54906003)(8936002)(38100700002)(38350700002)(7406005)(66556008)(86362001)(478600001)(6916009)(2616005)(66946007)(36756003)(186003)(26005)(956004)(7416002)(316002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2vnn0Wrcyxy8j/CpJEbJFs+hVzsE7iLtL9pKFLLmPVyCjA4O7SCWCtyw6cou?=
 =?us-ascii?Q?Xev37/k2WRmlBVWWeIuDHdO2FqHg2TW2tz1318Gb5UQ3Ig/05SftKyZS3+JM?=
 =?us-ascii?Q?L84TS2vmAWO4ZBRID8WSUPRifg43RH1pPKsqZ0CS1apz5gbzP9++hKeU65N3?=
 =?us-ascii?Q?/ZfI+YwjS/TL8OINLuML/WsB4HsMY3R98cZ1geANcewEiLMhRvcTgRXKYH3k?=
 =?us-ascii?Q?9CUuPf2sweDhjCfU/QAceu2LkcuD1encfRGp0D6pU37QYry8hc0AkCYyuFya?=
 =?us-ascii?Q?8RZ+Az2c2RasT215P1Q9ATDI8jiyD7bzmRX7I8ldDabZOqEWcSfoTRON0SKy?=
 =?us-ascii?Q?EY4ZpI+tD1hsfj11RU5Yw555LP1EZoCF88ge+E8VMTdT5phD0ClQW4R64s72?=
 =?us-ascii?Q?RxDRiLcHGnfsG9VVKL4Ucbh/WOvKLF2Keulf5X59+Fb5ZJP4h463a3VbND8I?=
 =?us-ascii?Q?HLB3SgrmxzrI5BS3uv10TK3hWkSYNEntwA8HFwwxBytTdsZ+x58bkWvD7JH/?=
 =?us-ascii?Q?qqDnudU9ybWcIzJ/4064GncvR1REEP1E2N8FXcBWLFr6ybTOsDvwW8xfLTee?=
 =?us-ascii?Q?dPOgUuSM1QhyKkSBQOl7TAQ5Mc00vOxtwRCjR5hEi3LXcuYV3Po+3PlYjD+F?=
 =?us-ascii?Q?2E3HyJusTt5I0u1gRRmnPwyERudYkntDc98es5beVwp9M/7jSns6aUBrxf9k?=
 =?us-ascii?Q?/xDJ6/35AAuobQpO1cfXulnw1ShbLnbH0TiADSsXkDYoRJy+2jgBW65CiNXf?=
 =?us-ascii?Q?Z1vmUY9qPLENmv2nWcEFWJLiVNK5+llGuwIBwd7JY1a0n0gYKYkXQVwGILSG?=
 =?us-ascii?Q?VBQdpiE87wBPVEG7Kyd+cT7R8pWXUN87StAxcvjQXllGr+af/kifEP+Q1vVH?=
 =?us-ascii?Q?u5r1isB+b2wNNFQLGC8jxjK2XcT4e/ZxZJ1q9FaSRi4ENeXAsuKUaXgQQ5TL?=
 =?us-ascii?Q?aCyK+JtmSSSaMiW5Har/y6dl+of7Vk8za9zNZ7qmOQojgmw11YDUMHabeIxF?=
 =?us-ascii?Q?N1wt+Vv0lZbFCuZ19ze3SVcoe4XTM6B1TeSgTwuWMapOGQ3owPkXU4EEWt1U?=
 =?us-ascii?Q?GplPl0kmxZ5kIKYxVvd4pPtgaUoe84dxFGBTsCLWwTWp0qxyOkV9b3t9f2Vy?=
 =?us-ascii?Q?8lCvxB8pi2MZ+vkzvz0FOY3vt7nMct2NPN30dw0DFfjJ/tLA3cbmFcB+g5Yo?=
 =?us-ascii?Q?a+a7kwm7qXSMu+4UI4NFaVg95ItVhhBVY6BmYfSS8IDMf8YptnOZYy4wd4mi?=
 =?us-ascii?Q?oTxmw8PP1y+mg0NT8knZ1EN9jFvwM01HjLZUt58B9fd1bMfCHjm2qSTu/208?=
 =?us-ascii?Q?HJULRbBtWyTczzjnJiE/uHWB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d04090-f2ee-4652-d66c-08d967ebe572
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 17:15:11.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gv8YvDulgfxQJkSwqM0kjCtv5drPl+wpmMc4lsjqmml9rmKHxn6Z2SMNIctD8fBY6OwCd5OBcytoK6U0+1z9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4923
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 25, 2021 at 05:07:26PM +0200, Joerg Roedel wrote:
> On Fri, Aug 20, 2021 at 10:19:18AM -0500, Brijesh Singh wrote:
> >  void __head startup_64_setup_env(unsigned long physbase)
> >  {
> > +	u64 gs_area = (u64)fixup_pointer(startup_gs_area, physbase);
> > +
> 
> This breaks as soon as the compiler decides that startup_64_setup_env()
> needs stack protection too.

Good point.

> 
> And the startup_gs_area is also not needed, there is initial_gs for
> that. 
> 
> What you need is something along these lines (untested):
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index d8b3ebd2bb85..3c7c59bc9903 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -65,6 +65,16 @@ SYM_CODE_START_NOALIGN(startup_64)
>  	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
>  
>  	leaq	_text(%rip), %rdi
> +
> +	movl	$MSR_GS_BASE, %ecx
> +	movq	initial_gs(%rip), %rax
> +	movq	$_text, %rdx
> +	subq	%rdx, %rax
> +	addq	%rdi, %rax
> +	movq	%rax, %rdx
> +	shrq	$32,  %rdx
> +	wrmsr
> +
>  	pushq	%rsi
>  	call	startup_64_setup_env
>  	popq	%rsi
> 
> 
> It loads the initial_gs pointer, applies the fixup on it and loads it
> into MSR_GS_BASE. 

This seems to do the trick, and is probably closer to what the 32-bit
version would look like. Thanks for the suggestion!
