Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC0E11ECD5
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 22:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLMVYs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 16:24:48 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36399 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMVYs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 16:24:48 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so631478iln.3
        for <linux-efi@vger.kernel.org>; Fri, 13 Dec 2019 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWRSxey7el74QZ+Ei/DzotdKJzpYoB0015GuoC7vpOI=;
        b=ACUakujhnGW2MtAPIdsq2dzxITzFJAyUw4n1m3wvSShsTuvSKj9O0/gmzx3CgPtOwJ
         /eSBPWw/gKFFBq3gV59Y2CnL9oIMb+Qy8DQEF/evgpiCnhodb+DWZhYu9YoZWCtfaJfM
         Unlrkn4OCs3BQ9uXhVmzB7oePCKL2PI8t38qnQX1vwmogdlGEYVYpLLs9oJH+HNpNewa
         sXu6oO8tje/uQ2WAgXBQcCzI9PYrsgkF3Tp6NHdg1/JmUieGZ+k4gLTixIGhGZkvuXQM
         AUkAWstF8CZ9+uj0Onthy4T6UgUgqMxnv3uVM8/RAJBFUrPdrdr24+6KZqnZS6CBhe18
         Xc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWRSxey7el74QZ+Ei/DzotdKJzpYoB0015GuoC7vpOI=;
        b=WnEWvhh3IHaTSz+z//gLBVLL9xK4KP3p5u7nzgiVT/rtbYSlq+up7cIUeKClBNzgxV
         72KMq0P5QKGDtg5Wl7lgdc30EkAquEkR29gBWbqABAZ0aEbQ+hR29b5voZbYPU3Cg1fs
         NEglETVtzM69rKFhnHdVHwMfrwxviXlr2BXyXfffpMmrztb5I3cYD+W3CYbW8ai9b+nK
         1AL+RjKLKVAYiu+5Mr83qlXCdGyYxU9sEOPXsms/7qkhM8YXTGUIHAvT84w1HOomg9nR
         J0nAxH7O5IBBDPYREHKCcodbjlBRO+lqMulu/T5Kl8x+vGzZ7Lu4oC5qZY+PMoNrGjxb
         WK1w==
X-Gm-Message-State: APjAAAVx+D+1BHZOVdxz66i9gPS2H+o75sjgPcYIsZc/CxaWY6lAXndm
        CSQs6fFd+0PzjFpw+oiGJJYm1rCBnpU9PPtVvtTMdSXM
X-Google-Smtp-Source: APXvYqwIzVeukD8LzwUl8iMfZRpFwMOjy7QmLdnsIausShWO+cioF/FIl85yMZH7DvrWp85eraNEnoTLGmn7uA9aBs4=
X-Received: by 2002:a92:3bc7:: with SMTP id n68mr1443685ilh.84.1576272287148;
 Fri, 13 Dec 2019 13:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
 <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com>
 <CALCETrWZwN-R=He2s1DLet8iOxB_AbuSGOJ3y7zW=qUmx33C=A@mail.gmail.com>
 <CACdnJuvTR2r_myJX2bQ8XTDw_HxM-EgqhVLaUJVCa+VQS+6Qrg@mail.gmail.com> <CAKv+Gu-7H7AmMGk8_safU83KZZiJJpQ4X+o7V9Pv24AOh3g5ug@mail.gmail.com>
In-Reply-To: <CAKv+Gu-7H7AmMGk8_safU83KZZiJJpQ4X+o7V9Pv24AOh3g5ug@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 13 Dec 2019 13:24:35 -0800
Message-ID: <CACdnJusMV4k0mjQ=gtdgFHR82tr2QBomoSa6Ca3LoMHzD3r7iQ@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 12, 2019 at 7:46 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 4 Dec 2019 at 20:56, Matthew Garrett <mjg59@google.com> wrote:
> > We already handle this case - the kernel doesn't activate busmastering
> > until after it does IOMMU setup.
>
> Build issues aside (which we already handled off list), I think we
> should consider the following concerns I have about this patch:
> - make it work on ARM (already done)
> - make the cmdline option an efi=xxx one, this makes it obvious which
> context this is active in

Ok.

> - I would prefer it if we could make it more obvious that this affects
> PCI DMA only, other masters are unaffected by any of this.

Ok - in terms of naming, or in terms of documentation?

> - What about integrated masters? On the systems I have access to,
> there are a lot of DMA capable endpoints that sit on bus 0 without any
> root port or PCI bridge in between

There's not really anything we can do about those. My gut feeling is
that if you're in a situation where you can't trust your integrated
chipset then you're going to have trouble building any real trust in
the platform.

> - Should we treat GOP producers differently? Or perhaps only if the
> efifb address is known to be carved out of system memory?

Hm, good question. Video cards are one of the most complicated devices
on the system, so I'd prefer not to leave us vulnerable to them. Maybe
try this as an opt-in thing for a while and see whether people find
graphics-related breakage?

> If we come up with a good story here in terms of policy, we may be
> able to enable this by default, which would be a win imo.

I'm pretty sure we're going to have some hardware that this just
breaks on, unfortunately - Apple's EFI driver for Broadcom wifi used
to continue DMAing over ExitBootServices(), and the "easy" fix of
disabling BME on it beforehand resulted in the card wedging on driver
load, so I think we'll see other devices that have similar behaviour.

(We "fixed" the Apple case by putting the card into S3)
