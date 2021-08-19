Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B433F21BF
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 22:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhHSUqL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbhHSUqK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 16:46:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBBCC061757
        for <linux-efi@vger.kernel.org>; Thu, 19 Aug 2021 13:45:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 18so6638199pfh.9
        for <linux-efi@vger.kernel.org>; Thu, 19 Aug 2021 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ciANhO2rI2yAVYRk89xhZMU4nhupjSlELscJz8Yo+Qw=;
        b=Fc7Daih9rnQh6iUId4QRiL4FivuwPAhyAMFNkO2VUAzl9fh8RJcdflKXRtvDtW22Dw
         62K1Lh5y+Qh18QpKDce59XAwAQFsi2e0hbHHmHWSE+qcn9qT3B9yFSbUFCyvttMdHGw+
         esZwVHbFPkPORlaIpJ6YSZYBtd2H0+g+bmQpEwGu2xNO8350bSN031MHRkAeb+QqSZRt
         kxhVmaya5nZ29ErR9EpIiA5i+9h+qYWjLCusY4XlNb4fu/PXgnT5K1yyQYlaSF3U2d/n
         aHGseXBbhe63iUKx2Jwwe4vKVlFrBXk9fBrak+iasFVoPH/GhT70RVjSleulYwixImdi
         1C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ciANhO2rI2yAVYRk89xhZMU4nhupjSlELscJz8Yo+Qw=;
        b=gSiwM3Bn1zicBcWjrw6JIWejjRZfUU528Y/z+7eDtd5egXs5NzNm1Q1r1xP7SKKiQL
         F94dgzycvqY36eY8Mbrt1ivQkkMAWbnwlRXD0DC8o6j+9PRNBwrZbkZivmwLblbrpH79
         06mivxm2A9bSIbnczaKu9SXkJOaXY1oAmeRU9slAqOyijGTWZWmmlzvcd9iUBm/WEuKR
         HTnUpB/PRSmnFMBkzIsUjY8ad/SZdTurpbZCJ68QVfsogwKb5OCuwOe2BymFyEGoCXNU
         bhbvLcJ1r7b2dHvHgfvQjnZMXTiMS5dttecQiuVvaU8HSBHd9D3CxKkPIWuT12BrUyxu
         HD2g==
X-Gm-Message-State: AOAM532v2nXPkgcySzpHQGpACmVgbyJRmG3ppPDSOrl2Qi7DFYg3+cjN
        NFQmB4sVdu/IRIxiBHxoqn7A3w==
X-Google-Smtp-Source: ABdhPJy/YEvyPot1aTu59VL50ZY1wh0+PMMs7LuvoXrs8FoMJhsEul2LVsCbAJktJ+VCm+UP0FBlng==
X-Received: by 2002:a62:86c4:0:b0:3e0:f216:81bc with SMTP id x187-20020a6286c4000000b003e0f21681bcmr16271484pfd.27.1629405933408;
        Thu, 19 Aug 2021 13:45:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id pj14sm3625802pjb.35.2021.08.19.13.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 13:45:32 -0700 (PDT)
Date:   Thu, 19 Aug 2021 20:45:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3 2/5] KVM: x86: invert KVM_HYPERCALL to default to
 VMMCALL
Message-ID: <YR7C56Yc+Qd256P6@google.com>
References: <cover.1623174621.git.ashish.kalra@amd.com>
 <f45c503fad62c899473b5a6fd0f2085208d6dfaf.1623174621.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f45c503fad62c899473b5a6fd0f2085208d6dfaf.1623174621.git.ashish.kalra@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Preferred shortlog prefix for KVM guest changes is "x86/kvm".  "KVM: x86" is for
host changes.

On Tue, Jun 08, 2021, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> KVM hypercall framework relies on alternative framework to patch the
> VMCALL -> VMMCALL on AMD platform. If a hypercall is made before
> apply_alternative() is called then it defaults to VMCALL. The approach
> works fine on non SEV guest. A VMCALL would causes #UD, and hypervisor
> will be able to decode the instruction and do the right things. But
> when SEV is active, guest memory is encrypted with guest key and
> hypervisor will not be able to decode the instruction bytes.
> 
> So invert KVM_HYPERCALL and X86_FEATURE_VMMCALL to default to VMMCALL
> and opt into VMCALL.

The changelog needs to explain why SEV hypercalls need to be made before
apply_alternative(), why it's ok to make Intel CPUs take #UDs on the unknown
VMMCALL, and why this is not creating the same conundrum for TDX.

Actually, I don't think making Intel CPUs take #UDs is acceptable.  This patch
breaks Linux on upstream KVM on Intel due a bug in upstream KVM.  KVM attempts
to patch the "wrong" hypercall to the "right" hypercall, but stupidly does so
via an emulated write.  I.e. KVM honors the guest page table permissions and
injects a !WRITABLE #PF on the VMMCALL RIP if the kernel code is mapped RX.

In other words, trusting the VMM to not screw up the #UD is a bad idea.  This also
makes documenting the "why does SEV need super early hypercalls" extra important.

This patch doesn't work because X86_FEATURE_VMCALL is a synthetic flag and is
only set by VMware paravirt code, which is why the patching doesn't happen as
would be expected.  The obvious solution would be to manually set X86_FEATURE_VMCALL
where appropriate, but given that defaulting to VMCALL has worked for years,
defaulting to VMMCALL makes me nervous, e.g. even if we splatter X86_FEATURE_VMCALL
into Intel, Centaur, and Zhaoxin, there's a possibility we'll break existing VMs
that run on hypervisors that do something weird with the vendor string.

Rather than look for X86_FEATURE_VMCALL, I think it makes sense to have this be
a "pure" inversion, i.e. patch in VMCALL if VMMCALL is not supported, as opposed
to patching in VMCALL if VMCALL is supproted.

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 69299878b200..61641e69cfda 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -17,7 +17,7 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 #endif /* CONFIG_KVM_GUEST */

 #define KVM_HYPERCALL \
-        ALTERNATIVE("vmcall", "vmmcall", X86_FEATURE_VMMCALL)
+        ALTERNATIVE("vmmcall", "vmcall", ALT_NOT(X86_FEATURE_VMMCALL))

 /* For KVM hypercalls, a three-byte sequence of either the vmcall or the vmmcall
  * instruction.  The hypervisor may replace it with something else but only the
 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Suggested-by: Sean Christopherson <seanjc@google.com>

> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Is Brijesh the author?  Co-developed-by for a one-line change would be odd...

> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/include/asm/kvm_para.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
> index 69299878b200..0267bebb0b0f 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -17,7 +17,7 @@ static inline bool kvm_check_and_clear_guest_paused(void)
>  #endif /* CONFIG_KVM_GUEST */
>  
>  #define KVM_HYPERCALL \
> -        ALTERNATIVE("vmcall", "vmmcall", X86_FEATURE_VMMCALL)
> +	ALTERNATIVE("vmmcall", "vmcall", X86_FEATURE_VMCALL)
>  
>  /* For KVM hypercalls, a three-byte sequence of either the vmcall or the vmmcall
>   * instruction.  The hypervisor may replace it with something else but only the
> -- 
> 2.17.1
> 
