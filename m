Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1408111F423
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLNVIA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 16:08:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36552 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNVIA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 16:08:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so1173026qkc.3;
        Sat, 14 Dec 2019 13:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h4m24kjjVELGBf67T3Sqeabi8zZPBxcF9/3vyN0xZq0=;
        b=IryrQR+IH5+iX7wsZIFOqz9y2HqsFeXaIoOVLELOlnEgNyooteQJdC9TRfUUNNgWne
         bD0X6AjoGH/nn4WGKE/mX/qubAFXjoCl/W88bLoXVECIkBSAxXVDfZ28tafXUADV81aD
         qgmLXZWNRRkTFJosyOLegs5Z44uCXPKIlzRKLoyOR0NQW7qYUFdXyG2dYYtlJdEF0AVX
         jpgjC7xQv3EairSpifNjQ1ftHCt9Mt6bP2W6+gMVA/hiYqlSoW51UBZqf/uvR5Myh25l
         fjGN0KtaTjFy0AVtEMZugcaf/PFBKOjsiDBuOoKyCJCSGXCReRYmXJfjg63I7WZ7sPu0
         JglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h4m24kjjVELGBf67T3Sqeabi8zZPBxcF9/3vyN0xZq0=;
        b=gEdQj2EgCx6NolwQPFvslBNiQgZWoxLcNDHIOIFOmg66xG6oliNnAhVsJ+tokRP7iL
         cRR1Cgm9rdtIG9ltkEfzoqiCfuxAjNLhKZWRc05A6feC7DrcOVUT9li675h2spEeSwNq
         zZEUKA7WqWFmGD3Bdu1EvZuBORcV3q84ljUIDHCGH7AT4P72X0ZdmvcIOhGW/FEnYERz
         z6Oqct71GBmIQpH+5fRTlg5pDXrAUfKtZ9dxKBV+GbkioqeSg9PAt1c5rmRRFzFlWqqm
         rhxqoK/tNdMrRoYqwzZ3lwgu7srTB8ONbns9djc3tP/YuFqYV93fUeUt++uZpbdnGown
         jAFQ==
X-Gm-Message-State: APjAAAWlKwr82OhepUjLTaJMJxr4cIfAjruFxPDdO4AyEtPXKzpTLmuk
        hUay2She/Ssr17qsvfUFmWM=
X-Google-Smtp-Source: APXvYqz5hstfVo4TxonMN7wsU9XAM/lVdgfmOfTiyfXsMl/6wLscnNnvt5a9rx9E9AhWlzi33/NcaQ==
X-Received: by 2002:a05:620a:149b:: with SMTP id w27mr19561271qkj.229.1576357679354;
        Sat, 14 Dec 2019 13:07:59 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v125sm4252515qka.47.2019.12.14.13.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 13:07:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 14 Dec 2019 16:07:57 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/10] efi/libstub: use a helper to iterate over a EFI
 handle array
Message-ID: <20191214210756.GE140998@rani.riverdale.lan>
References: <20191214175735.22518-1-ardb@kernel.org>
 <20191214175735.22518-4-ardb@kernel.org>
 <20191214203257.GD140998@rani.riverdale.lan>
 <CAKv+Gu-XAvYf8G+7Oi-XVM+DvR89_zkmETmou-2ftgC41tnvMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-XAvYf8G+7Oi-XVM+DvR89_zkmETmou-2ftgC41tnvMw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 14, 2019 at 08:40:57PM +0000, Ard Biesheuvel wrote:
> On Sat, 14 Dec 2019 at 21:33, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sat, Dec 14, 2019 at 06:57:28PM +0100, Ard Biesheuvel wrote:
> > > Iterating over a EFI handle array is a bit finicky, since we have
> > > to take mixed mode into account, where handles are only 32-bit
> > > while the native efi_handle_t type is 64-bit.
> > >
> > > So introduce a helper, and replace the various occurrences of
> > > this pattern.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >
> > > +#define for_each_efi_handle(handle, array, size, i)                  \
> > > +     for (i = 1, handle = efi_is_64bit()                             \
> > > +             ? (efi_handle_t)(unsigned long)((u64 *)(array))[0]      \
> > > +             : (efi_handle_t)(unsigned long)((u32 *)(array))[0];     \
> > > +         i++ <= (size) / (efi_is_64bit() ? sizeof(efi_handle_t)      \
> > > +                                          : sizeof(u32));            \
> > > +         handle = efi_is_64bit()                                     \
> > > +             ? (efi_handle_t)(unsigned long)((u64 *)(array))[i]      \
> > > +             : (efi_handle_t)(unsigned long)((u32 *)(array))[i])
> > > +
> > >  /*
> > >   * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
> > >   * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
> > > --
> > > 2.17.1
> > >
> >
> > This would access one past the array, no? Eg if the array has one
> > handle, i is incremented to 2 the first time the condition is checked,
> > then the loop increment will access array[2] before the condition is
> > checked again. There seem to be at least a couple of other for_each
> > macros that might have similar issues.
> >
> 
> Indeed.
> 
> > How about the below instead?
> >
> > #define for_each_efi_handle(handle, array, size, i)                     \
> >         for (i = 0;                                                     \
> >             (i < (size) / (efi_is_64bit() ? sizeof(efi_handle_t)        \
> >                                           : sizeof(u32))) &&            \
> >             ((handle = efi_is_64bit()                                   \
> >                 ? ((efi_handle_t *)(array))[i]                          \
> >                 : (efi_handle_t)(unsigned long)((u32 *)(array))[i]), 1);\
> >             i++)
> >
> 
> Yeah, that looks correct to me, but perhaps we can come up with
> something slightly more readable? :-)
> (Not saying my code was better in that respect)

:) The idiom of the && with , operator is copied from for_each_bvec in bvec.h.

Perhaps more readable with helper macros:

#define __efi_handle_size (efi_is_64bit() ? sizeof(efi_handle_t)	\
					  : sizeof(u32))
#define __efi_handle_elem(array, i)					\
	(efi_is_64bit() ? ((efi_handle_t *)(array))[i]			\
			: (efi_handle_t)(uintptr_t)((u32 *)(array))[i])

#define for_each_efi_handle(handle, array, size, i)			\
	for (i = 0; i < (size) / __efi_handle_size &&			\
		    (handle = __efi_handle_elem(array, i), 1); i++)
