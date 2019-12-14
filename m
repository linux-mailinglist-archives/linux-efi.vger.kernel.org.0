Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6AF11F4FB
	for <lists+linux-efi@lfdr.de>; Sun, 15 Dec 2019 00:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLNXCJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 18:02:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38694 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNXCI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 18:02:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so2324819qki.5;
        Sat, 14 Dec 2019 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O0EJ8z82U7cWD2uni2Q2FGfAdsBj1eTYHVZ/EPN98kk=;
        b=T6LD9sLLdWm4+nk4kvddozLORNhycxUNvOeSdNthxifkZ5juszirkY53Z9E7ma9Z6m
         F02d6lErVyywjdJ38RN8wIewaz67LKJb78E8qViYojn3o9Vi7rTxghT8tTFPwpZf2p1a
         3G2estihGTlQBQcAl4cWSnI+TnRd+2EiKSJ6xAufzLYZJuu0BG8BXO71pExYS2uvOg0k
         cJssmhj7l6ULrzCyeebkzt5xEPBkJF2sR8NVECTAFqgNr/gFYkZpxicPfNbYufjWvMfY
         XWl59sGiKvmgGTSvFXiEzhrdxNAyKHg6u21Qqah2hoTQ9PeecVwAdHqRbCrNO9X5Boqt
         4UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0EJ8z82U7cWD2uni2Q2FGfAdsBj1eTYHVZ/EPN98kk=;
        b=NW+p3YUn5qcv6QgAOPuz+1LIt7FrpZYDbd01/Qgwg3/8nhIR0Ep8hn01iRjmw1QN3m
         pKB8dPqWIhAVCq8k8tOEMV9djCUyhWbwVp2lK0m2rQvK+7ltisfvhgEXqZEfK0jh6W8k
         0vIufp1OluVPTawGnYwDqb16rBRPybIiow+v6P9uSJ8nhDTBOibXWz2uftwOaTBqbsYQ
         zmcrEOnTKFYb3Op8tMVz+iRxVRmhRoEqfFG4syubyl0eXC285/Xkw4pY5ybhWpkDgLHF
         +WE3sEVsTSU6ADSAogTlx41u4Yp8/SRITazdQo9BkjBZ6qRCarNOANUc12dJmQRu3Vi+
         3lBA==
X-Gm-Message-State: APjAAAVi8M+vOR0om0rcwCdjfKTNcu9SGeuk6bAts2ZPXKU5gh3uA9K0
        PvoBiJlvlgg+QKArXkYvbKg=
X-Google-Smtp-Source: APXvYqyerAlVCU1n3zrgbu0hsYlmSwIdzdNKXpqU1KSz5Oz4DKTWvOIwQb3DUCkhwtgLco4xVMfOVg==
X-Received: by 2002:a05:620a:150e:: with SMTP id i14mr20451749qkk.273.1576364527660;
        Sat, 14 Dec 2019 15:02:07 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l37sm5149187qtl.53.2019.12.14.15.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 15:02:07 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 14 Dec 2019 18:02:05 -0500
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
Message-ID: <20191214230204.GB314531@rani.riverdale.lan>
References: <20191214175735.22518-1-ardb@kernel.org>
 <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan>
 <20191214194936.GB140998@rani.riverdale.lan>
 <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com>
 <20191214201334.GC140998@rani.riverdale.lan>
 <CAKv+Gu-A4bE0DM96-dNjtsYG=a3g-X4f-y=NcJ5ZCvZHaDJZmw@mail.gmail.com>
 <20191214211725.GG140998@rani.riverdale.lan>
 <CAKv+Gu85yLS6cYaGPTLc=hjHjvjjYYX-E0wCwKK+1W+T9dxAcQ@mail.gmail.com>
 <CAKv+Gu8DNwWF4FfiZNStHTqNZeUP90c1_NkSLC_80YxF4smnxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8DNwWF4FfiZNStHTqNZeUP90c1_NkSLC_80YxF4smnxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 14, 2019 at 10:14:38PM +0000, Ard Biesheuvel wrote:
> On Sat, 14 Dec 2019 at 22:30, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Sat, 14 Dec 2019 at 22:17, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Sat, Dec 14, 2019 at 08:27:50PM +0000, Ard Biesheuvel wrote:
> > > > On Sat, 14 Dec 2019 at 21:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Sat, Dec 14, 2019 at 07:54:25PM +0000, Ard Biesheuvel wrote:
> > > > > > On Sat, 14 Dec 2019 at 20:49, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > > >
> > > > > > > On Sat, Dec 14, 2019 at 02:46:27PM -0500, Arvind Sankar wrote:
> > > > > > > > On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> > > > > > > > > +
> > > > > > > > > +#define efi_table_attr(table, attr, instance) ({                   \
> > > > > > > > > +   __typeof__(((table##_t *)0)->attr) __ret;                       \
> > > > > > > > > +   if (efi_is_native()) {                                          \
> > > > > > > > > +           __ret = ((table##_t *)instance)->attr;                  \
> > > > > > > > > +   } else {                                                        \
> > > > > > > > > +           __typeof__(((table##_32_t *)0)->attr) at;               \
> > > > > > > > > +           at = (((table##_32_t *)(unsigned long)instance)->attr); \
> > > > > > > > > +           __ret = (__typeof__(__ret))(unsigned long)at;           \
> > > > > > > > > +   }                                                               \
> > > > > > > > > +   __ret;                                                          \
> > > > > > > > > +})
> > > > > > > >
> > > > Yes. I'm open to suggestions on how to improve this, but mixed mode is
> > > > somewhat of a maintenance burden, so if new future functionality needs
> > > > to leave mixed mode behind, I'm not too bothered.
> > > >
> > >
> > > Maybe just do
> > >         if (sizeof(at) < sizeof(__ret))
> > >                 __ret = (__typeof__(__ret))(uintptr_t)at;
> > >         else
> > >                 __ret = (__typeof__(__ret))at;
> > > That should cover most of the cases.
> >
> > But the compiler will still be unhappy about the else clause if __ret
> > is a pointer type, since we'll be casting an u32 to a pointer,
> 
> I think the answer is to have efi_table_ptr() for pointers and
> efi_table_attr() for other types.

Using __builtin_choose_expr avoids the warning:
	__ret = (__typeof__(__ret))
		__builtin_choose_expr(sizeof(at) < sizeof(ret),
				      (uintptr_t)at, at);

But having different efi_table_ macros sounds cleaner.
