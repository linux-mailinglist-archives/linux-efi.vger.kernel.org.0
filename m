Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9775846BBCA
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 13:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhLGMzg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 07:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhLGMzf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 07:55:35 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82E1C061574;
        Tue,  7 Dec 2021 04:52:05 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k4so9352853plx.8;
        Tue, 07 Dec 2021 04:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yQ8z6GgJ1CPWJpplUiIwwoMcxyJy+6LqjCNR6FhsoGM=;
        b=PD89hTGZPgD8afBHnQbrFPV4uGV7UnDygTI6vWAdz+E9HiVIXWzwua8gc4P/D+AaVe
         W2R5OCgidEnKMzT2U+KwDDcO2VwwacSmcDrI+ndh5KDcVkQZBM/zF5LoGW5wVvpTdnKl
         C0hRAxQvJSusSGUmx4QISOH6H6NL0l8tPgIAIxI+S29uic2aaqG+NPEDqUUatoSrG24O
         J1RoKTI2i6zNZPW4ul7yzfHARMhEtc9L5YfgWkUf55PYOks0x54naa5dcJf76H2BW/7N
         pjPgt50iidbio14Bb/oYUjnYCMDubNdtWf/8pBXcSrA45YZ45XxB6OapB78obwimNvPM
         vO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yQ8z6GgJ1CPWJpplUiIwwoMcxyJy+6LqjCNR6FhsoGM=;
        b=nE7oE30j5Jwst/wKgJv9UQ7fenN0Ur9oyURloGGAoeXSEstxLeTjpIeHR8mQXvLSwn
         aSEpbEa/TJN9capQzXxz2hQE5P+nYcVY62XM0lxcUj5JyA6WbQrQpTvU4REGPsYVJMoZ
         cwtnDnnhqO4cNYM8m7gxDBc1u2p8J6ecxJ4dvF1thb+qkDhfIg2gx/ooraW4xs0MzBEK
         iO/E9ar7afiOEGIpddtUjM5PDlVE7BnJIXdMB0TVoDELGqhpPWJeyutH7v7sEbAG5Xo0
         dT1Ii7r12dzEZeQ9ke0kMaE4kmh/PqmxCRMUmqQyWcciQ0jrmdviafjGIqyaOSl3Tl0r
         wyKQ==
X-Gm-Message-State: AOAM530u/Exr6MqdF6behJxdgcNH43JW09kzN8Y1zn9KXrGwlp4/pie1
        3cEq6GBgSLky9rT1MFYaLjc=
X-Google-Smtp-Source: ABdhPJzv6L8Hk7CDThqwvXqsaQnnWGzNLVLt18C4+/mYIlG86nNUBWesp/fJdMw0NFdGZ6+o3lVxiw==
X-Received: by 2002:a17:902:dac7:b0:141:e931:3aff with SMTP id q7-20020a170902dac700b00141e9313affmr51845592plx.50.1638881525240;
        Tue, 07 Dec 2021 04:52:05 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
        by smtp.gmail.com with ESMTPSA id d10sm15867857pfl.139.2021.12.07.04.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 04:52:04 -0800 (PST)
Message-ID: <5b1c348a-fc26-e257-7bc2-82d1326de321@gmail.com>
Date:   Tue, 7 Dec 2021 20:51:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v7 09/45] x86/sev: Save the negotiated GHCB version
Content-Language: en-US
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-10-brijesh.singh@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20211110220731.2396491-10-brijesh.singh@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Brijesh:
      We find this patch breaks AMD SEV support in the Hyper-V Isolation
VM. Hyper-V code also uses sev_es_ghcb_hv_call() to read or write msr
value. The sev_es_check_cpu_features() isn't called in the Hyper-V code
and so the ghcb_version is always 0. Could you add a new parameter 
ghcb_version for sev_es_ghcb_hv_call() and then caller may input 
ghcb_version?

Thanks.

On 11/11/2021 6:06 AM, Brijesh Singh wrote:
> The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
> GHCB protocol version before establishing the GHCB. Cache the negotiated
> GHCB version so that it can be used later.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>   arch/x86/include/asm/sev.h   |  2 +-
>   arch/x86/kernel/sev-shared.c | 17 ++++++++++++++---
>   2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ec060c433589..9b9c190e8c3b 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -12,7 +12,7 @@
>   #include <asm/insn.h>
>   #include <asm/sev-common.h>
>   
> -#define GHCB_PROTO_OUR		0x0001UL
> +#define GHCB_PROTOCOL_MIN	1ULL
>   #define GHCB_PROTOCOL_MAX	1ULL
>   #define GHCB_DEFAULT_USAGE	0ULL
>   
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 2abf8a7d75e5..91105f5a02a8 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -14,6 +14,15 @@
>   #define has_cpuflag(f)	boot_cpu_has(f)
>   #endif
>   
> +/*
> + * Since feature negotiation related variables are set early in the boot
> + * process they must reside in the .data section so as not to be zeroed
> + * out when the .bss section is later cleared.
> + *
> + * GHCB protocol version negotiated with the hypervisor.
> + */
> +static u16 ghcb_version __ro_after_init;
> +
>   static bool __init sev_es_check_cpu_features(void)
>   {
>   	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
> @@ -51,10 +60,12 @@ static bool sev_es_negotiate_protocol(void)
>   	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
>   		return false;
>   
> -	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTO_OUR ||
> -	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTO_OUR)
> +	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
> +	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
>   		return false;
>   
> +	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
> +
>   	return true;
>   }
>   
> @@ -127,7 +138,7 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
>   				   u64 exit_info_1, u64 exit_info_2)
>   {
>   	/* Fill in protocol and format specifiers */
> -	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
> +	ghcb->protocol_version = ghcb_version;
>   	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
>   
>   	ghcb_set_sw_exit_code(ghcb, exit_code);
> 
