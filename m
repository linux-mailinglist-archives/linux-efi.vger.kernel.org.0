Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E12A3BC
	for <lists+linux-efi@lfdr.de>; Sat, 25 May 2019 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEYJlH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 May 2019 05:41:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37129 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfEYJlH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 May 2019 05:41:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23so6768243pff.4;
        Sat, 25 May 2019 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jiTZ2o51d/sXyhPszg2Yj4q0qpn+Df3pI4yEQ+F+CaU=;
        b=Je7TqJvXMENlCk3KNfujP2JkxLFkRJ216vC0Pn/xn9SjRXrCQTi/Wt9sIKeYqRqlG2
         05v409w0p5WS2azWc8YEdW+mBWMaJM4Z2oznxJRoxm20gwGNcVijA+CRZ4Zr5TZhBCmn
         6NhhmYFiT0UPe2jvDG4EUdX2JlVZp2bWjxwFykOxUqT7B5PKrx6uRwS1kzv8YXW9JmVu
         rtn9w592U9knYw3AEW+j/NDrp5xlYv+jOFbhj1n6wQuMHldhjkPXCFGqUnx/h8bj8UDh
         AISuuICfKbz7o9/kp3VX+oEXrj2uK6V4A9W+jFnOzDT0Ji4olXXeD7oLA7WDgeW+tnbF
         a8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jiTZ2o51d/sXyhPszg2Yj4q0qpn+Df3pI4yEQ+F+CaU=;
        b=ig+pn8o0s+PZeYhIY/LdMxPUi4AiqBmtPjJBuXq3Un+oflbU3IBm+GGb/jFkBrHVKO
         3IsthW8i3lHQnS+PBR1pP7pcnul1W03eRhydY5htQNQo+OTGTdevIsUqjqQrmSuS6b5C
         fGA75HF5c5PRI6hNumtq/dC3aC/sFbuyZwE4842hiapsk58T6ZCbaXwRHSGMQpADsYn/
         KFZvZgmctMxNiScGjMfmVMBfH7glnAcdXcWqKqTBcS3O+ZQ0qt1E4BlYxZ/w7oULrpAL
         uJ2wt3yDioomb/klHfrBsl+lfikKuvb3SvR/bW/8lMbger8BJZsaqQ8iiUTxRufyTHGM
         Xhiw==
X-Gm-Message-State: APjAAAVJJ+iAybwCwl0kq7YN5YWB9DXozZ7KmUwFmDmgoD9a7oYB2lh4
        Rw+hGY8PdVAOlW/vrWOwFT0=
X-Google-Smtp-Source: APXvYqzzWIEPodUUePFSoAYLslp64HJ+9tPcEwWIi6JyrCzBEdEYh4VWXmIHQtKNIIQ+Gu/Ecs0ujA==
X-Received: by 2002:a62:590f:: with SMTP id n15mr27824591pfb.204.1558777266747;
        Sat, 25 May 2019 02:41:06 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id k22sm4951489pfk.54.2019.05.25.02.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 02:41:05 -0700 (PDT)
Date:   Sat, 25 May 2019 17:40:52 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] efi_64: Fix a missing-check bug in
 arch/x86/platform/efi/efi_64.c
Message-ID: <20190525094052.GA13189@zhanggen-UX430UQ>
References: <20190517082633.GA3890@zhanggen-UX430UQ>
 <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
 <20190517090628.GA4162@zhanggen-UX430UQ>
 <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
 <20190523005133.GA14881@zhanggen-UX430UQ>
 <CAKv+Gu_wRYZdDYXso0B5m_BPJznGQXpCWq4_0u34bConu0V1ow@mail.gmail.com>
 <20190525023608.GA11613@zhanggen-UX430UQ>
 <CAKv+Gu-agMymoGm0G8Yj-siXwtPnqYjAHeu-wQwRT47Jqd27JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-agMymoGm0G8Yj-siXwtPnqYjAHeu-wQwRT47Jqd27JA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, May 25, 2019 at 11:18:36AM +0200, Ard Biesheuvel wrote:
> On Sat, 25 May 2019 at 04:36, Gen Zhang <blackgod016574@gmail.com> wrote:
> >
> > On Fri, May 24, 2019 at 06:07:10PM +0200, Ard Biesheuvel wrote:
> > > Apologies for only spotting this now, but I seem to have given some bad advice.
> > >
> > > efi_call_phys_prolog() in efi_64.c will also return NULL if
> > > (!efi_enabled(EFI_OLD_MEMMAP)), but this is not an error condition. So
> > > that occurrence has to be updated: please return efi_mm.pgd instead.
> > Thanks for your reply, Ard. You mean that we should return efi_mm.pgd
> > when allcoation fails? And we should delete return EFI_ABORTED on the
> > caller site, right? In that case, how should we handle the NULL pointer
> > returned by condition if(!efi_enabled(EFI_OLD_MEMMAP)) on the caller
> > site?
> >
> 
> No, the other way around. I have already updated the patch, so don't
> worry about it.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=urgent&id=d2dc2bc7b60b936b95da4b04c2912c02974c3e9f
Thanks for your reply and update, Ard! That's really nice of you.

Thanks
Gen
