Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F9911F433
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 22:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLNVR2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 16:17:28 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43725 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLNVR2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 16:17:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so570370qke.10;
        Sat, 14 Dec 2019 13:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=opNBpfOCbogBEmAxjbR25Oz77lqzusp30GC5ksnepaA=;
        b=Qg/OPLfglLe6u7GZbHLoKdLazqMyLwj3enpv3X4HXRphrg9JJ5QEeUS1tQ2dgzRa53
         wx1mRst7iVk6MqYvEmR9TIj71gk1lcfvCR356PSX9vI/2NHBYIjODhIZRVBhTD0n0tiF
         dexOfix/1L3ZV4/caYEgvQkoEJIq+ESlst4OgPZLfgokwWhNQGZXBaCsJ3ZpRTPbqi1A
         qUxCrCOSafdAsQ6YVUXWddgZGdw3sW542LEy/Hh8Lt4pOcD3lUym2YIKzl4ZMaumWzGx
         VOGGGz6kyPl0qDVKkAjKnbUWkqvlFJcg/23hEefxb6DHVKa8p5kGX24UkevUdqVbAcK+
         ijMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=opNBpfOCbogBEmAxjbR25Oz77lqzusp30GC5ksnepaA=;
        b=A/qWA7z98svmeq5UxCVt9E8GeNnhE4RngNNzSX5ScIzj0YqRTzzUrg4SmgVTnAnhwN
         S7KgXy208ErakXGk9KJitTEJJzdGneteXOxP5JfPXW63vAScOPUAOmT7d1NpLxtnJjBj
         QPuypwZiHXN1L1wT5N87zlwQkiplW+3MB0ZyI4Wz1+VlL1iGgI0MxBJkLfBJeDHHDBHf
         eqPk/oWgeZlnJfVaZvy7pTCzXoZiKJJHUZpcCT6XGAH/dlqu8XJ5QO5A1K0zcefUAHDU
         O0JefwBeZMMjP4JCvmZnowU51Fp6Q5G921EfZxWLUEBpmh9UiOT3EzpP1FYUitH6GqUr
         EzLQ==
X-Gm-Message-State: APjAAAU++PY/IARJuhAbIFcb2pOB0QJQxr9ORy0y3xN1wRwJEFpoLoo7
        rie2Q18yxrVkKV1DwBsdYog=
X-Google-Smtp-Source: APXvYqyIzvwmmxEIaG09FD1+Ge1oBvhsg/rEmZ7gwVojAVpdvcFLwkjq/RdckrkjobOdovZDdf99rA==
X-Received: by 2002:a37:684a:: with SMTP id d71mr18478570qkc.201.1576358247360;
        Sat, 14 Dec 2019 13:17:27 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n129sm2704809qkf.64.2019.12.14.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 13:17:27 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 14 Dec 2019 16:17:25 -0500
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
Subject: Re: [PATCH 05/10] efi/libstub: distinguish between native/mixed not
 32/64 bit
Message-ID: <20191214211725.GG140998@rani.riverdale.lan>
References: <20191214175735.22518-1-ardb@kernel.org>
 <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan>
 <20191214194936.GB140998@rani.riverdale.lan>
 <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com>
 <20191214201334.GC140998@rani.riverdale.lan>
 <CAKv+Gu-A4bE0DM96-dNjtsYG=a3g-X4f-y=NcJ5ZCvZHaDJZmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-A4bE0DM96-dNjtsYG=a3g-X4f-y=NcJ5ZCvZHaDJZmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 14, 2019 at 08:27:50PM +0000, Ard Biesheuvel wrote:
> On Sat, 14 Dec 2019 at 21:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sat, Dec 14, 2019 at 07:54:25PM +0000, Ard Biesheuvel wrote:
> > > On Sat, 14 Dec 2019 at 20:49, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Sat, Dec 14, 2019 at 02:46:27PM -0500, Arvind Sankar wrote:
> > > > > On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> > > > > > +
> > > > > > +#define efi_table_attr(table, attr, instance) ({                   \
> > > > > > +   __typeof__(((table##_t *)0)->attr) __ret;                       \
> > > > > > +   if (efi_is_native()) {                                          \
> > > > > > +           __ret = ((table##_t *)instance)->attr;                  \
> > > > > > +   } else {                                                        \
> > > > > > +           __typeof__(((table##_32_t *)0)->attr) at;               \
> > > > > > +           at = (((table##_32_t *)(unsigned long)instance)->attr); \
> > > > > > +           __ret = (__typeof__(__ret))(unsigned long)at;           \
> > > > > > +   }                                                               \
> > > > > > +   __ret;                                                          \
> > > > > > +})
> > > > >
> Yes. I'm open to suggestions on how to improve this, but mixed mode is
> somewhat of a maintenance burden, so if new future functionality needs
> to leave mixed mode behind, I'm not too bothered.
> 

Maybe just do
	if (sizeof(at) < sizeof(__ret))
		__ret = (__typeof__(__ret))(uintptr_t)at;
	else
		__ret = (__typeof__(__ret))at;
That should cover most of the cases.
