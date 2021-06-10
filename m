Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097D43A3324
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jun 2021 20:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhFJSeI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Jun 2021 14:34:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44334 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhFJSeE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 10 Jun 2021 14:34:04 -0400
Received: from zn.tnic (p200300ec2f0cf6005d9c12d1298a6408.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:5d9c:12d1:298a:6408])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C642C1EC047D;
        Thu, 10 Jun 2021 20:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623349926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kg1DiPJTYl2BXqsgfplfnnsn35GmXaEoy+kCJ/5z4g4=;
        b=SLtlTYPGWVpy4Nrv4tRPTPcGuJTr5kuvCWEwq5weYoCEBrH6Pg6ACVDeguesoQWvrMuNbX
        1KJ74lqZaYeitYsbjMcILHvLt714buKuyzBXxNqymWUPaDtShfyCDwGKz+rQ3jisOr4w7g
        IdBvqzQnZjwfN8pX9DDJvJSNU3sY5Qw=
Date:   Thu, 10 Jun 2021 20:32:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3 5/5] x86/kvm: Add guest support for detecting and
 enabling SEV Live Migration feature.
Message-ID: <YMJapUeKQ8H9gScL@zn.tnic>
References: <cover.1623174621.git.ashish.kalra@amd.com>
 <951a07f3b9e25cb7dd8fbc8d1797f216008c139a.1623174621.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <951a07f3b9e25cb7dd8fbc8d1797f216008c139a.1623174621.git.ashish.kalra@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 08, 2021 at 06:07:04PM +0000, Ashish Kalra wrote:
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 6b12620376a4..3d6a906d125c 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -411,6 +411,12 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
>  	return early_set_memory_enc_dec(vaddr, size, true);
>  }
>  
> +void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
> +					bool enc)

You don't have to break this line either.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
