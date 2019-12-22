Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73B2128FF6
	for <lists+linux-efi@lfdr.de>; Sun, 22 Dec 2019 22:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLVVNC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 22 Dec 2019 16:13:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43513 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfLVVNB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 22 Dec 2019 16:13:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so12099273qke.10
        for <linux-efi@vger.kernel.org>; Sun, 22 Dec 2019 13:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hMKhxRlnROu3bdUQrwCoUljLCZrlnl+PzprUOLURNlo=;
        b=Fj1EivSuD7HKan3n6NVQqlFalTqjLccBy7FGzIOIS4JE/6wGae27MCziXCugOrlOEs
         f1V7dkKf8kOXKXwXrm8w9I7vrPHdk5MKIzAG65RTpsYzmfEJfkKGVfwIrjfiXL6iSFZP
         FFjpya9wBAoKesXLhdkMkWgAO5u75a7NLSfkIRdYkoippg82RdXQTm/lLE6250YW3PXf
         74GpV42djKTJKRduHOo4ItKYOMdsCL71PBFQI4nFUBYi4MlLFuw9/x+Rs/RISfTZHzvM
         tLguHcbRlFtAWyL16SbAkNyHHOOHquoEppOtUVeVZ+6rbS0Wms1Hvp+6+4x+axp2+j5h
         kE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hMKhxRlnROu3bdUQrwCoUljLCZrlnl+PzprUOLURNlo=;
        b=iqD/QuHacfjKcYeYQW6A22QZeZHqKON/syDq844at+LbU/gTdZNY4ZjM+Mw8SAe46w
         0IxVql1ncnnVUaoI5Pqy8cZnkuQhJ5WfiKp/6z8zDK2ihhuzi2N6vmzapGxsoUOLSowh
         HdGhtghzfT8vaZ1OW+oHWqu3mj8u4PBHEatT/8rSokTd3VIcvjSyl6Lao6kul3guinip
         lXg77FvaS4D4vAOcxhrnemKCYdiOm01DRmMEOaVcXwYx22McZ1zAN1htDXW/MCn973rA
         0DAJM0zAAA0E9X2cwTZkAFFSgTn2sbYRB0+dQWxHX0srpR2A81OYKDEp4vnRUGQXNqAL
         JsQw==
X-Gm-Message-State: APjAAAVbunTFO4OSyrcjbnwqdngq0Lc+me2Jhn1iKeSyXIgiXh7oMCys
        GbEW4bRL7eHHrPdxJCmJjjo=
X-Google-Smtp-Source: APXvYqyCTtzG7I7SzGapg6I0qD0718HILxwTek0yJgDcaj868xBvHf8tFZRp700xKhUr06i3iS4Dvg==
X-Received: by 2002:a37:702:: with SMTP id 2mr23435233qkh.270.1577049180396;
        Sun, 22 Dec 2019 13:13:00 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d51sm3027808qtc.67.2019.12.22.13.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 13:12:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 22 Dec 2019 16:12:58 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 10/21] efi/libstub/x86: avoid thunking for native
 firmware calls
Message-ID: <20191222211257.GA23363@rani.riverdale.lan>
References: <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
 <4FEC2A1B-91A5-4357-8594-8BC8BB3D02A4@amacapital.net>
 <CAKv+Gu_3UUfJY1YsHGneR-fmr_T-o2ocQ7dtP0_EbKW2RtAsRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_3UUfJY1YsHGneR-fmr_T-o2ocQ7dtP0_EbKW2RtAsRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Dec 22, 2019 at 04:29:48PM +0100, Ard Biesheuvel wrote:
> On Sun, 22 Dec 2019 at 13:46, Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > Hmm. Most of the kernel is compiled with the stack alignment set to 8, and there a lot of asm that makes no effort to preserve alignment beyond 8 bytes.  So if EFI calls need 16 byte alignment, you may need to do something special.
> >
> > On new enough gcc (the versions that actually support the flags to set the alignment to 8), maybe you can use function attributes, or maybe you can stick a 16-byte-aligned local variable in functions that call EFI functions?  The latter would be rather fragile.
> 
> This patch replaces open coded SysV to MS calling convention
> translation to GCC generated code (using __attribute__((ms_abi)) which
> we have been using for a long time in EDK2), because the former relies
> on a wrapper function
> 
> efi_call(fn, ...)
> 
> which is type unsafe and relies on a lot of nasty casting, especially
> combined with the mixed mode support. efi_call() is implemented as
> below, and as Hans reports, omitting this sequence causes a boot
> regression on one of the platforms he has tested this on.
> 
> So the question is which of the pieces below this UEFI implementation
> is actually relying on, and the stack pointer alignment is my first
> guess, but it could be any of the other things as well. Once we
> identify what it is we are missing, I can simply stick it back in, but
> without reverting to using the efi_call() thunk.
> 
> Note that the decompressor/stub are built with the default stack
> alignment of 16 afaict, but if GRUB enters the decompressor with a
> misaligned stack, we probably wouldn't notice until we hit something
> like a movaps, right?
> 
> Thanks,
> Ard.
> 

Won't the entry code misalign the stack when efi_main is called,
assuming the stack was properly aligned at efi_stub_entry? There needs
to be a sub $8, %rsp in there, no?

arch/x86/boot/compressed/head_64.S:

#ifdef CONFIG_EFI_STUB
        .org 0x390
SYM_FUNC_START(efi64_stub_entry)
SYM_FUNC_START_ALIAS(efi_stub_entry)
        movq    $1, %rcx
handover_entry:
        call    efi_main	<--- this will enter efi_main with a misaligned stack?
        movq    %rax,%rsi
        movl    BP_code32_start(%esi), %eax
        leaq    startup_64(%rax), %rax
        jmp     *%rax
SYM_FUNC_END(efi64_stub_entry)
SYM_FUNC_END_ALIAS(efi_stub_entry)
#endif

