Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2044712B9CE
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 19:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfL0SI6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 13:08:58 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33355 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfL0SI6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Dec 2019 13:08:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so25104051qto.0
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 10:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6nPpSGSrws35RYyaDp/gp5qfyTakKU8mvsOkEMoHtuo=;
        b=bOLlro43h2CtpDj/KUkHoaGZzJilySHHp9DDdU7oA3ROzkm1dGnURhzxnWcgWwOXXV
         cHex2S/djYOCmHi2ggzTF7BAu0zPnc3FqTC/5aIec168ecPON5XQEeSVCkSOlaXvOKIh
         Nh/0PaIaIsIZupwzcuH2FFQNNUp7EQvY3H3erC/lNKnpqUEOSYXzN7DszlDdx3qh7z5N
         Y55BpaelO9anAwqtFqTmaBw0rwlVQVsth680PV3ayrn1N5SAhOsJLdHWC0zA5BRMMtW1
         j650I4DqInh+e5UvI1Chx+IRHB1GvU071XbLwDBKeKMtk3OS0eVg1t4a0kahCurjWJVx
         IiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6nPpSGSrws35RYyaDp/gp5qfyTakKU8mvsOkEMoHtuo=;
        b=Pr3xc0EDlxybaCHS5u57rWN4YtBT+PXH9T75R3ZfCVSvEzDgDD0K4Y9/wzB4fNQmsz
         piobjC4IpEGjT9zlYIa7XaIzb1oWhbgUcsdZtggmSvGJRjfnUSPWRvfdxXohG7/g5PdP
         Uod1kwl2jocgfd/Iva0e6Ku0RBNXm/nI/s5GcNfW+xMCPi4zZ4JUw5T0D5luyv/csfeA
         W9ZKubpVMMSI4YvD7iMTbsg4nnVho6VLqj87yT4nJ7BE12GJV/d6VRrd8KrcpfbUO3r8
         KvkAsQYjbA7WV8tR0PBWJK3pQ1ncNyNALAzF9bcKnnyfELZx5kjm/Kplt6hD3VWhoVlK
         kQsA==
X-Gm-Message-State: APjAAAUFUW/hpaskcY2DJs8nHAk8bAKuD0nj6Q2xRYcP8zmCYlsl5uqs
        gHmNTmELcVvDMv+PatGOZLQ=
X-Google-Smtp-Source: APXvYqwjinNThqKOYYcayhNLA1R1M8Zml4sr5ezXtsZ6I/bKEcLrumR3p277E/kzoD49WCcaxfVdiQ==
X-Received: by 2002:ac8:3463:: with SMTP id v32mr37990547qtb.8.1577470137257;
        Fri, 27 Dec 2019 10:08:57 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r41sm10940923qtc.6.2019.12.27.10.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 10:08:57 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 27 Dec 2019 13:08:55 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        hdegoede@redhat.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
Message-ID: <20191227180855.GB584323@rani.riverdale.lan>
References: <20191226151407.29716-1-ardb@kernel.org>
 <20191226151407.29716-2-ardb@kernel.org>
 <20191227175155.GA584323@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191227175155.GA584323@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 27, 2019 at 12:51:56PM -0500, Arvind Sankar wrote:
> On Thu, Dec 26, 2019 at 04:14:05PM +0100, Ard Biesheuvel wrote:
> > The efi_call() wrapper used to invoke EFI runtime services serves
> > a number of purposes:
> > - realign the stack to 16 bytes
> > - preserve FP register state
> > - translate from SysV to MS calling convention.
> > 
> > Preserving the FP register state is redundant in most cases, since
> > efi_call() is almost always used from within the scope of a pair of
> > kernel_fpu_begin()/_end() calls, with the exception of the early
> > call to SetVirtualAddressMap() and the SGI UV support code. So let's
> > add a pair of kernel_fpu_begin()/_end() calls there as well, and
> > remove the unnecessary code from the assembly implementation of
> > efi_call(), and only keep the pieces that deal with the stack
> > alignment and the ABI translation.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/platform/efi/efi_64.c      |  4 +++
> >  arch/x86/platform/efi/efi_stub_64.S | 36 ++------------------
> >  arch/x86/platform/uv/bios_uv.c      |  7 ++--
> >  3 files changed, 11 insertions(+), 36 deletions(-)
> > 
> > diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> > index 03c2ed3c645c..3690df1d31c6 100644
> > --- a/arch/x86/platform/efi/efi_64.c
> > +++ b/arch/x86/platform/efi/efi_64.c
> > @@ -84,6 +84,7 @@ pgd_t * __init efi_call_phys_prolog(void)
> >  
> >  	if (!efi_enabled(EFI_OLD_MEMMAP)) {
> >  		efi_switch_mm(&efi_mm);
> > +		kernel_fpu_begin();
> >  		return efi_mm.pgd;
> >  	}
> >  
> > @@ -141,6 +142,7 @@ pgd_t * __init efi_call_phys_prolog(void)
> >  	}
> >  
> >  	__flush_tlb_all();
> > +	kernel_fpu_begin();
> >  	return save_pgd;
> >  out:
> >  	efi_call_phys_epilog(save_pgd);
> > @@ -158,6 +160,8 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
> >  	p4d_t *p4d;
> >  	pud_t *pud;
> >  
> > +	kernel_fpu_end();
> > +
> >  	if (!efi_enabled(EFI_OLD_MEMMAP)) {
> >  		efi_switch_mm(efi_scratch.prev_mm);
> >  		return;
> 
> Does kernel_fpu_begin/kernel_fpu_end need to be outside the efi_switch_mm?
> 
> If there's an error in efi_call_phys_prolog during the old memmap code,
> it will call efi_call_phys_epilog without having called
> kernel_fpu_begin, which will cause an unbalanced kernel_fpu_end. Looks
> like the next step will be a panic anyway though.

Do we even need to save/restore the fpu state at this point in boot? The
mixed-mode code path doesn't appear to be saving/restoring the XMM
registers during SetVirtualAddressMap.
