Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B5812DFE6
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jan 2020 19:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgAASNo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jan 2020 13:13:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40774 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgAASNo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jan 2020 13:13:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so37400939wrn.7
        for <linux-efi@vger.kernel.org>; Wed, 01 Jan 2020 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+/DO4FNysq7nXm8UImwLEcdseWnNEf/v3cwI78GeaI=;
        b=EgSgXnqu/ZsuoYmwH1sqzbQ9EG49TUn1wOe4zBv06C7HHDzto4BaGFvdltChTbYZ+R
         Yq4KIDfncEzLwkcQHP+sl+lL3fgGaXAQAYcVi9BUs7m1XeAIYPFRIamed/QM600s0noX
         Vtw+GC/iJIQdc3Wlt3pyp+ZBgSHZ4qAJLqpln1MGBJ4ojN/BUBfgD85NWoV1jKf4JTyN
         VQMeI0yjsQZbuJGzHZwBlHeaRq1zrnLlMR48lRTWJuIkwXaKux+uHufVHcaSj45wTctY
         wLYdoSZ7mxnFVvYgvYa0LbYwXAqRgcSsrtnMPRU17FkRgjEqE2PFbTeDVAvrOhuAfEM9
         Ervw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+/DO4FNysq7nXm8UImwLEcdseWnNEf/v3cwI78GeaI=;
        b=KKmgdKnNRPo+qcF+bvJL+MJS3f/7C0/xrN4mc+zID3eXIHk9V+HiB8SZF8Ty3gf4St
         cw+bLTlQe7LiWbR9y9dcF0Rci1YZNU6ixx+LtFHXn2JCINu1mV3IUlbdBkWE5MJPLaUK
         YnGMswZUU2qQmcfoOu4O/R2rVB+HPHsZDFSDPOzT5dcTyJciFdGStDlxRrVsPHemu7wS
         sE3/4eVMDn+DrlmxnjJrbn2xh/+Zcdwn4l32kaagKi2VndYPxsYQbgEEWo1dko7MYlgl
         I7Rc3p6J5xtUzVrvX/fhTSZznSO9vSe9Inzld5AUuOVsGgzdg/Ma2a5LfSP7EhROTU7B
         +28g==
X-Gm-Message-State: APjAAAWsbm5IPb/qm6FgwjQrZW+jS+i31lcayEXrdmTI6h72zQjs2hxv
        4tBexe7//alDDJjQsTem1jYoHrbfTiSLg5HHPysrXw==
X-Google-Smtp-Source: APXvYqyIDmRkXF01NwkTJ0S5TQjQp2MdGlgKY/9Y6rDYCKTEP76DEW6+YbX9HRqNm4LUaAzM9jZzD/+qyHeg0u6IJXc=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr67331122wrj.325.1577902422033;
 Wed, 01 Jan 2020 10:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-14-ardb@kernel.org>
 <20191231230436.GA78532@rani.riverdale.lan>
In-Reply-To: <20191231230436.GA78532@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 1 Jan 2020 19:13:45 +0100
Message-ID: <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 1 Jan 2020 at 00:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Dec 18, 2019 at 07:01:31PM +0200, Ard Biesheuvel wrote:
> > The various pointers we stash in the efi_config struct which we
> > retrieve using __efi_early() are simply copies of the ones in
> > the EFI system table, which we have started accessing directly
> > in the previous patch. So drop all the __efi_early() related
> > plumbing, except for the access to a boolean which tells us
> > whether the firmware is 64-bit or not.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/eboot.c   | 36 ++++++++------------
> >  arch/x86/boot/compressed/head_32.S |  2 +-
> >  arch/x86/boot/compressed/head_64.S |  4 +--
> >  arch/x86/include/asm/efi.h         | 23 +++++--------
> >  4 files changed, 26 insertions(+), 39 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > index 2bcab1ef5a56..53e67334c4c3 100644
> > --- a/arch/x86/boot/compressed/eboot.c
> > +++ b/arch/x86/boot/compressed/eboot.c
> > @@ -20,11 +20,17 @@
> >
> >  static efi_system_table_t *sys_table;
> >
> > -static struct efi_config *efi_early;
> > +struct efi_config {
> > +     u64 image_handle;
> > +     u64 table;
> > +     bool is64;
> > +} __packed;
> >
> > -__pure const struct efi_config *__efi_early(void)
> > +static bool is64;
> > +
> > +__pure bool __efi_early_is64(void)
> >  {
> > -     return efi_early;
> > +     return is64;
> >  }
> >
> >  __pure efi_system_table_t *efi_system_table(void)
>
> This predates your series, but looking at the generated code I noticed
> that pure isn't enough to let gcc optimize out repeated calls to is64
> and system_table. Declaring them as __attribute_const__ would allow
> optimization. They don't quite meet gcc's requirements for that as they
> access global non-const variables, but it seems like it ought to be
> safe, especially if we stop using the functions within eboot.c itself?

The GCC documentation mentions that it does not make sense for a
function annotated as const not to take any arguments, so I'd rather
avoid it here.
