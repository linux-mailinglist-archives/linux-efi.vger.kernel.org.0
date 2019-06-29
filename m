Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228265A9A5
	for <lists+linux-efi@lfdr.de>; Sat, 29 Jun 2019 10:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfF2IrO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Jun 2019 04:47:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45420 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfF2IrO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Jun 2019 04:47:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so8539883wre.12
        for <linux-efi@vger.kernel.org>; Sat, 29 Jun 2019 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDOQWIDbXWuRzLn0U3sjoHXyYYTke04TInDDkMQH504=;
        b=iVazhjyb+6dNX/zkA34Q2yequ44RglHkggDw/dcA76ORrForZlAHbrKc7f02e7IIGf
         ETYgrQHQvE6tO53vtNgOssOvwjpoVCeoaoA78okpMEIlvMDd35IDvXwmdzica9EQPGZf
         Y2JQFj1VIRnCZ6leldutTu4p3rXTtetb6cDPFcJ64wioCf9lLGmXvI8Ftf7jBfKpMZSL
         dzBf3SFpplGU/7rbCo8lxNF/PORULx/LB3dGowTQC1Pjeb42uhnlJP8zLFQ2zwXBBl+6
         40VBTvg4twi82d69cpNr2mDDUqaO49dxKVUQT3fhaVSIOfOi5qNKPXk494O49LqWgFb8
         wJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDOQWIDbXWuRzLn0U3sjoHXyYYTke04TInDDkMQH504=;
        b=DXLuQY5eISCA1mRQXIbH3Cy8cKRZf4ahn6Uftz7hSZST1D6XiyU52ps2FblURc8jgz
         2A/YVKbIhj77CeGK+EC7ojwZxmAKCjdKnRsfhM+GckqFzPp64bvra/4tgtgZ4aa1jqMK
         Srlb/C07BvqbR9ua8pOBwkYoqE7fii2U7QH8HTrALhPWy17v8cg+PU7H4dsxBv5ihMax
         iq+qa5gx/Bz9P0V16qf0izyu8+MOfa6XptEDn/HyERolpFhJtcKPzOnD+VoAFiXSHKpG
         PzBQ/nBiQZS3Ks4d5Lls6crMIf4GdAciKnRyu/LdYMt5i36/T+uNWB9AsnT69sRwl4W+
         myXA==
X-Gm-Message-State: APjAAAXIb5C3MOeSwJ+cZJxQtHd3DTcjpmLXniLwWIIcVpYxu4uSMeMl
        w1zynq6m9BaElV+jt6UNu0DjGu531YTtriomuaQavw==
X-Google-Smtp-Source: APXvYqwR12ferQFkJpQJr0wiW/6PZ50IvOHzKprSle6xQiNelRHqbcMQXq24OLulz3qG2be+53A2NWAppr4s3IJ02/Y=
X-Received: by 2002:adf:ee0a:: with SMTP id y10mr5793590wrn.169.1561798032311;
 Sat, 29 Jun 2019 01:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <156174726746.34985.1890238158382638220.stgit@srivatsa-ubuntu>
 <156174732219.34985.6679541271840078416.stgit@srivatsa-ubuntu> <20190629065721.GA365@kroah.com>
In-Reply-To: <20190629065721.GA365@kroah.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 29 Jun 2019 10:47:00 +0200
Message-ID: <CAKv+Gu-_senkX5Asy1ZL+0cbAJBGib7Ys1WnMgdS36YO2LOU4Q@mail.gmail.com>
Subject: Re: [4.19.y PATCH 1/3] efi/x86/Add missing error handling to
 old_memmap 1:1 mapping code
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable <stable@vger.kernel.org>,
        Gen Zhang <blackgod016574@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Bradford <robert.bradford@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, akaher@vmware.com,
        srinidhir@vmware.com, bvikas@vmware.com, amakhalov@vmware.com,
        srivatsab@vmware.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 29 Jun 2019 at 08:57, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 28, 2019 at 11:42:13AM -0700, Srivatsa S. Bhat wrote:
> > From: Gen Zhang <blackgod016574@gmail.com>
> >
> > commit 4e78921ba4dd0aca1cc89168f45039add4183f8e upstream.
> >
> > The old_memmap flow in efi_call_phys_prolog() performs numerous memory
> > allocations, and either does not check for failure at all, or it does
> > but fails to propagate it back to the caller, which may end up calling
> > into the firmware with an incomplete 1:1 mapping.
> >
> > So let's fix this by returning NULL from efi_call_phys_prolog() on
> > memory allocation failures only, and by handling this condition in the
> > caller. Also, clean up any half baked sets of page tables that we may
> > have created before returning with a NULL return value.
> >
> > Note that any failure at this level will trigger a panic() two levels
> > up, so none of this makes a huge difference, but it is a nice cleanup
> > nonetheless.
>
> With a description like this, why is this needed in a stable kernel if
> it does not really fix anything useful?
>

Because it fixes a 'CVE', remember? :-)
