Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D13011EAB6
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 19:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfLMSt3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 13:49:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36758 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbfLMSt3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 13:49:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so66882wma.1
        for <linux-efi@vger.kernel.org>; Fri, 13 Dec 2019 10:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WicjH+vkYyOI63p3lG9bkD6Aq44ackhn3ZvFVkMsekc=;
        b=bDKEtejqejg+7amYdR9UZQ+nidhPzqCWCEAEPpxvUruPcZ3dxl6Gq6/QE04QnGHin8
         alvfFP44Tv14yl8SfeoNywSHNkEaDj+tYgojwuOz8DioAb7pz/ZBIEuQjoGlHIFvgeXD
         N/cB00trDMxxjXbUHFKJTPa8DOhx3/6Vd76dl94evhgSjEf3kSqETKzYIZfHYJ6qkAlw
         GS1DqTmlwaR4VWvYJvHVy8rjm3Dt5b78NjmkZJM2mO/ibgTyPgPDvBNsUmrnTQTAB+J7
         gt3r4I3WJ1BmGG8p3aBnnCVQK28JUTyt+mzC9D9wmLyNCRERO2PPhs9zEeQqskiUhobY
         /m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WicjH+vkYyOI63p3lG9bkD6Aq44ackhn3ZvFVkMsekc=;
        b=D48NOyL5TydLIXrn9K2EXL7O3xq3dk2/be4nvD3p26mcxfhMfl7wl7E4zcOEvSwVaJ
         nzBqIJkDgDchgZgnsm5ThbrNEG7HMNSnhO8BrDo/OtsqEhoZaQvuGxWbknxTuNzO8xdu
         qTzIGbetSFuwVeqpRit1YXTYTKKaULGS0lJwXxIReOs6Ty8mWP1lVBXkU3g2PbYvAFpO
         xnicA+oXc+mOokSZ7qvSn9ZEwdJAFMN5CtYnvWiwlBCerdKtRrzl7+FUlFIq3QveFM62
         T3CussIe9tn3Eg1uY5uNp83YHsE9sp0c1/S4tIzSvyLxu0z0kb3JfyXJLO5lHiooHhPV
         3RHA==
X-Gm-Message-State: APjAAAX88FfynOLeLC9zIkiL7VYwoEscD2cnI1lJTzdf+FiPgoNAPevt
        g9TOyQg9Nkk2PGTcxAuX1814ozmpU/DbueZeSs3GGw==
X-Google-Smtp-Source: APXvYqy9tg5gLQC2nqYPlPYccM0LGv1EIENKVVVMAm2a4p5EcyypgzFbzz7JEvQuVl5fmBFpor+lKigf0DiWuT8HDqE=
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr5115247wma.95.1576262967424;
 Fri, 13 Dec 2019 10:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20191213091115.567-1-ardb@kernel.org> <69f21816-6dab-5abc-25f1-b2f5faf6f9e4@redhat.com>
In-Reply-To: <69f21816-6dab-5abc-25f1-b2f5faf6f9e4@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Dec 2019 18:49:25 +0000
Message-ID: <CAKv+Gu9yFqtcbKa5RO_m=t2JQEaVyscBruQYSYMJpKE1JcAieA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: disable file loading and page deallocation
 in mixed mode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 13 Dec 2019 at 13:29, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 13-12-2019 10:11, Ard Biesheuvel wrote:
> > EFI mixed mode is a nice hack, since it allows us to run 64-bit Linux
> > on low end x86_64 machines that shipped with 32-bit UEFI as they were
> > built to run 32-bit Windows only.
> >
> > Mixed mode relies on the ability to convert calls made using the
> > 64-bit calling convention into calls using the 32-bit one. This
> > involves pushing a 32-bit word onto the stack for each argument
> > passed in a 64-bit register, relying on the fact that all quantities
> > that are the native size or smaller (including pointers) can be safely
> > truncated to 32 bits. (In the pointer case, we rely on the fact that
> > we are still executing in the firmware context, which uses a 1:1
> > mapping that can only access the lower 4 GB of the address space)
> >
> > For types that are explicitly 64 bits wide, such as EFI_PHYSICAL_ADDRESS
> > or UINT64, this assumption doesn't hold. The correct way to marshall
> > such a call would be to push two consecutive 32-bit words onto the
> > stack, but given that the naive thunking code has no knowledge
> > whatsoever of the prototype of the function it is invoking, all we can
> > do is avoid calling such functions altogether.
> >
> > The FreePages() boot service is affected by this, so we should not call
> > that at all in mixed mode. In practice, this doesn't change much, since
> > in the past, these calls would have been made with a bogus address, and
> > so we were leaking this memory already. Note that the scope of this leak
> > is the EFI execution context only, so it makes no difference for Linux.
> >
> > The other piece of functionality that we need to disable is loading files
> > passed via file=xxxx on the command line, given that the Open() method
> > takes two UINT64s as well.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Just ignoring the file= arguments is fine with me, as you say this has
> been broken on mixed-mode since forever so likely no-one is using it:
>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
>

Thanks.

Do you have any recommendations on how to test this? Are you using GRUB to boot?

I am trying to test the random.c failure using QEMU+OVMF, which
implements the EFI_RNG_PROTOCOL on top of virtio-rng-pci, but I cannot
reproduce the failure.
