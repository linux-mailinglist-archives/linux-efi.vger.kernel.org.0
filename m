Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46C71760A4
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCBRCL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 12:02:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43284 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBRCL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Mar 2020 12:02:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id q18so313213qki.10;
        Mon, 02 Mar 2020 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z/s0AFZ+XxkV+eI3XGK5Ud6Mh7RjzKiJ4qxWDIVLNhw=;
        b=qSAe/B1iUQEWVYG5vamIa+kD1MuBB+e7dR6ZdhDrv7YLSNdUtwOzCcRGM4C+LPDZG/
         SvBTRXTs1lsSjSC7JgFfwUFoxHfqp6OuI3UNZXen2J3nPz7G+JaGDXkW7wLClC+959W6
         lI0x5YwClURyDKxIXNp6awsrzAfHPOwmDINXg23NfYZQoyHiIxU/QunL3YTVo/h2IBuc
         C24ldEYVq/zBTgu+4B1yLCDrh3ewThjZ8kioNsHzHSqiUgS2Vh0vrxQ4KlP04v0m2MPC
         r0FwRAkBZtlk8kVGGuLueKcBCFrLza677jAwm+hjxViDJqf9LtxcZ/fi7tewgiECG3e4
         dzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/s0AFZ+XxkV+eI3XGK5Ud6Mh7RjzKiJ4qxWDIVLNhw=;
        b=VmgheZLZQEJcIrleGjk4qwj52vdHDbZXub6QpUGvCyVvbjmFey1Lv9yar8aIxqargF
         iEVGzZYNWI/dZJXy2bO3gEozWvNSPIMEE1dxLfwesUx5yWHy7xO6c44J7ag40IjIFpsf
         qu9hM2/0SHOz05VJSD/UD6CaCAZuy3ylXiOZMXkIVgJ3xTQ/3oYdF65xeDqMnotdcdWc
         972sJtuK4XT6H608+NHtO12A/uFUWOZhio68A0wQs/gvqtnfrtIKKgXw6yMOYkLPrGw5
         PJ6aUSbKi0eqm5GF39kf79EJv8nv2WVZEv23yiu+QhiBmmks5lpVs27WqCxkltmF4k5E
         gHxA==
X-Gm-Message-State: ANhLgQ0SKTzZNQiJnfl2X+pEKFvErpo7n8rNlO+VYVb4KDj+B8BoDecK
        8tg2ZEEwvXtboM0p5wx+ntI=
X-Google-Smtp-Source: ADFU+vs831cPPOh0W5Sh1ogClVB6oEBZpozuz0OmLqf0zY+BbS5tLVtNjeG7Zu0atrmkfUA5nv2JMg==
X-Received: by 2002:a05:620a:1647:: with SMTP id c7mr259994qko.20.1583168527508;
        Mon, 02 Mar 2020 09:02:07 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w2sm10554175qto.73.2020.03.02.09.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:02:06 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 2 Mar 2020 12:02:05 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] efi/x86: Make efi32_pe_entry more readable
Message-ID: <20200302170205.GA2937123@rani.riverdale.lan>
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
 <20200301230436.2246909-4-nivedita@alum.mit.edu>
 <CAKv+Gu9RRDidiJ8WAnSta1kZoioFU_ZLxwGPQuhepd9N23HUJw@mail.gmail.com>
 <20200302165359.GA2599505@rani.riverdale.lan>
 <CAKv+Gu-8HeNaRYZNtTHr1_VF1aH=BRKF4CaeyP-PPfHNQN2paA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-8HeNaRYZNtTHr1_VF1aH=BRKF4CaeyP-PPfHNQN2paA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 02, 2020 at 05:57:04PM +0100, Ard Biesheuvel wrote:
> On Mon, 2 Mar 2020 at 17:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Mon, Mar 02, 2020 at 08:49:17AM +0100, Ard Biesheuvel wrote:
> > > On Mon, 2 Mar 2020 at 00:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > ...
> > > >         call    1f
> > > > -1:     pop     %ebp
> > > > -       subl    $1b, %ebp
> > > > +1:     pop     %ebx
> > > > +       subl    $1b, %ebx
> > ...
> > > >
> > > > +       movl    %ebx, %ebp                      // startup_32 for efi32_pe_stub_entry
> > >
> > > The code that follows efi32_pe_stub_entry still expects the runtime
> > > displacement in %ebp, so we'll need to pass that in another way here.
> > >
> > > >         jmp     efi32_pe_stub_entry
> >
> > Didn't follow -- what do you mean by runtime displacement?
> >
> > efi32_pe_stub_entry expects the runtime address of startup_32 to be in
> > %ebp, but with the changes for keeping the frame pointer in %ebp, I
> > changed the runtime address to be in %ebx instead. Hence I added that
> > movl %ebx, %ebp to put it in %ebp just before calling efi32_pe_stub_entry.
> > That should be fine, no?
> 
> But how does that work with:
> 
> SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
>     movl %ecx, efi32_boot_args(%ebp)
>     movl %edx, efi32_boot_args+4(%ebp)
>     movb $0, efi_is64(%ebp)
> 
> 
> ?

Why wouldn't it work? Before this change, efi32_pe_entry set %ebp to
startup_32 (via the call/pop/sub sequence), so efi32_pe_stub_entry was
entered with %ebp == startup_32.

After this change, the call/pop/sub sequence puts startup_32 into %ebx,
and then I copy it into %ebp just before branching to efi32_pe_stub_entry.
So everything should continue to work the same way as before?
