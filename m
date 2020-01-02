Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2300E12E70D
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 15:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgABOG6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 09:06:58 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37353 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgABOG6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 09:06:58 -0500
Received: by mail-qv1-f66.google.com with SMTP id f16so15028145qvi.4
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 06:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OO32iy87GkstOg5fUJjrD0glrCMtjzwV8FO0ox2Hxhw=;
        b=I1HarxjdYJxk1L4KKAuz1AAx4LLELEaPbJiYHYACsFjQX8ykOvEdLBATeZqzAXTSlT
         mVaFb5YPrsLcmsMQYsdFp/hmydBKk/tR6cB5x6KNQZ6I7f5aYseRP0CRtw86ZuX43+Sb
         gG4TjRdxuce4Lc7W03IrfuTY7TPfSqKW/g0jguoW2GMKxQ+gQ2Ku9T/Ct1XWWsa9hx+z
         uetpZrH/ExvjyDSjdT25brQ1bajXlfR1PW+trgkofCUrzTJlO01ESD9h5PLEJ9lN2m24
         N5RlrFDWZKVzj4DzvvWklwRJfeJIgYWcImKRJQ5S63oQGu50UsD/Kn19mj3YyGT9cTNq
         GJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OO32iy87GkstOg5fUJjrD0glrCMtjzwV8FO0ox2Hxhw=;
        b=L5gv69UOGfPCErd9cr4JOmwx3ZZfwWhU/tMzW67Pdtth6BwzAnICZAaHWrkZbAPV4d
         2CjTq6+/VaJOR65Zr+DBE7d4FRW4ZCqrsqHImoo3taaePN4fKI9fYCN1ToQzDXV3ounV
         EZMi2JsUvQb4coyStrWbVyfe1mMIdCQ1hhz1stGFPKgeBpj5ehHcYgmx8DZyBESWVgpR
         svNDi6miBZPp4JAFctBCayR6qtTLmMf4NsTMmbKvVvE8RAhqoGsvMwSmKTDEjruypFUC
         pwsDK8z4iAxuXAZkGmWREl416LUjsq7iuFAhulmIcBbk7LiXoEijAjRG9h6bbSrXnKRe
         0THA==
X-Gm-Message-State: APjAAAXBrL1t98RCOfoaGKOF6CfBKGSIKU/tr4fZ3cpySBUefAGhO3bj
        LJgaTOI/QqHDi9AfktW/VrE=
X-Google-Smtp-Source: APXvYqyJN7eBy1tgeANu281hajbljKAZoxqt0l3deTeCM2H/xUfW596nvnmsmdKBXSy7seypIQ+T9g==
X-Received: by 2002:a05:6214:154b:: with SMTP id t11mr63801464qvw.175.1577974016686;
        Thu, 02 Jan 2020 06:06:56 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b42sm10741166qtb.36.2020.01.02.06.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:06:56 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 2 Jan 2020 09:06:54 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
Message-ID: <20200102140653.GA626673@rani.riverdale.lan>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-14-ardb@kernel.org>
 <20191231230436.GA78532@rani.riverdale.lan>
 <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan>
 <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 08:33:54AM +0100, Ard Biesheuvel wrote:
> On Wed, 1 Jan 2020 at 20:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Jan 01, 2020 at 07:13:45PM +0100, Ard Biesheuvel wrote:
> > > The GCC documentation mentions that it does not make sense for a
> > > function annotated as const not to take any arguments, so I'd rather
> > > avoid it here.
> >
> > Where does it say that? I only see it saying it doesn't make sense for
> > it to return void.
> >
> 
> You're right. I looked into this in the past, and I misremembered, and
> paraphrased it incorrectly.
> 
> The documentation does mention that const functions are not permitted
> to read global memory.
> 

What it says is that "[the const attribute] tells GCC that subsequent
calls to function square with the same argument value can be replaced by
the result of the first call regardless of the statements in between"
and "The const attribute prohibits a function from reading objects that
affect its return value between successive invocations. However,
functions declared with the attribute can safely read objects that do
not change their return value, such as non-volatile constants."

In this case since the globals in question never change after being set,
it should be safe -- every call to these functions does return the same
value.

> > Currently if we call 5 EFI services in the same function, it has to
> > re-evaluate systemtable and is64 for each call, which seems wasteful,
> > though of course this is not exactly performance-critical code.
> 
> The alternative would be to use globals with external linkage in a way
> that is guaranteed not to rely on GOT entries, since we'll end up with
> absolute addresses that need to be fixed up first. This has caused
> breakage in the past, and is the reason we use this scheme with
> globals with static linkage and __pure getters.
> 
> However, hidden visibility should yield the same results so we should
> be able to make it work with that instead. However, given the breakage
> in the past, I don't think it's worth it since the performance gain
> will be negligible.

This only saves the overhead of the function call, but the compiler
would still have to re-read the variables and re-test them, since so far
as it knows the firmware call could change them. With the const function
attribute, it will only load them once. To make it work with just the
variables, they'd have to be declared const and initialized in the
assembly entry code.
