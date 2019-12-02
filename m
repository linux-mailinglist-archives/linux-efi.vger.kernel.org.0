Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADDCE10ECB5
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2019 16:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLBP5w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Dec 2019 10:57:52 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47042 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfLBP5w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Dec 2019 10:57:52 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so9936763edi.13;
        Mon, 02 Dec 2019 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xiKHRsLDcrKCkoTPQ4cXh2n9DxXl/CJ4KW/4aj6WAE=;
        b=GKNf9NPiAxnkVn3US2bCoLb76TDeAMSu+HvI/JGk8tBTkt8RZaX1lhdsmsdWdK9+k0
         sU3A1pGU6C0XuAFQuARmglwvuroak1b+m3wzjJE28TsgpQLacMeF4wn2o8ch+laawMov
         CGYoe7DHr3rDG3TH1c4rkxafckTq/wJwWaYajFLjEX86om4mlGfk/ud/RazblC/6P+Pv
         9+f4+PEEHc6RMtnSdzJs4O5iGZnFGHcfSIE6aHr+BhgsaJOgEkASQUBPD5AubcsA0/WA
         9jiKHARdKl0XDj7tH/atG4xT1/f4lsBBzRTt32jj4wvj9I4v2FM9hIdoaTokXGS0ayxU
         5ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xiKHRsLDcrKCkoTPQ4cXh2n9DxXl/CJ4KW/4aj6WAE=;
        b=AD92V67I+QsX602DwnzuK1R6LFshZKeJjM4ENgj5QegOYLGuwTA8Jls0dT1VVIzFh3
         FEvZPNjV8PFQKgnO4FN8DCRxQXCzWaBzc6OiiPs9DY4PDXxbfsLGnF+98OlxpO5zM75x
         QsXH3x1NOcsATgqbCr9r4sbfGW9ZkcnOg3j9r6Nn6KzqTSSZImB8i+BCqtbhc6oqFKVo
         6DJ8RvVSq7KYKtHupZyI3Q2L4ki10vSmqN3A7FjFgzSoUqNOycWgVEedZoEnvZrbqcbK
         mjf9ddtg4OI55AO8/pmnOli3UgJJJT4UgSadbSGhPZuMjO6/U390B4990SOWYJHIsMtg
         HfCg==
X-Gm-Message-State: APjAAAUJNl7zIt41KDzJLfpxrRDr96IQKi8mnbjzd9cUw6qDfbWJzIK2
        dqX1gS2EZqv+V3Nt8m5seewQNSISO5ijb3JKwm8=
X-Google-Smtp-Source: APXvYqwjfEKeEexNOy0NO/E4wHkDPAUvEcHz2A4YERwPTOAhmnW5mGkiWxP70WrGLCKlx+j1UpRL8pbhCwPPzmJ56io=
X-Received: by 2002:a17:906:34d7:: with SMTP id h23mr20809804ejb.90.1575302269170;
 Mon, 02 Dec 2019 07:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20191130195045.2005835-1-robdclark@gmail.com> <CAKv+Gu_HXD=59q9zeK6-WoEEngHPrEJpPTyT8U4TZZ3AOs=TcA@mail.gmail.com>
 <20191202122929.GC7359@bivouac.eciton.net>
In-Reply-To: <20191202122929.GC7359@bivouac.eciton.net>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 2 Dec 2019 07:57:37 -0800
Message-ID: <CAF6AEGsrTuZk0KZDWGN4m+7dFWo62zeHmFj_0-r87Q-3rwg0hw@mail.gmail.com>
Subject: Re: [PATCH] efi/fdt: install new fdt config table
To:     Leif Lindholm <leif.lindholm@linaro.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kairui Song <kasong@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" 
        <linux-efi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 2, 2019 at 4:29 AM Leif Lindholm <leif.lindholm@linaro.org> wrote:
>
> On Mon, Dec 02, 2019 at 10:35:05 +0100, Ard Biesheuvel wrote:
> > On Sat, 30 Nov 2019 at 20:51, Rob Clark <robdclark@gmail.com> wrote:
> >
> > I understand what you are trying to do here, but this is not the right solution.
> >
> > I have rejected patches in the past where config tables are used to
> > communicate information back to the firmware, as creating reverse
> > dependencies like this is a recipe for disaster.
>
> This isn't *technically* communicating information back to the
> firmware, since the agent that ends up being invoked is a driver that
> has been explicitly installed in order to permit running Linux without
> hacking about with GRUB. (But it's certainly communicating it back to
> the firmware context.)
>
> > IIUC, the problem is that the DtbLoader attempts to be smart about
> > whether to install the DT config table, and to only do so if the OS is
> > going to boot in DT mode. This is based on the principle that we
> > should not expose both ACPI and DT tables, and make it the OS's
> > problem to reason about which one is the preferred description.
> >
> > I agree with that approach in general, but in this particular case, I
> > don't think it makes sense. Windows only cares about ACPI, and Linux
> > only cares about DT unless you instruct it specifically to prioritize
> > ACPI over DT.

well, I don't mind too much if the patch is rejected, it doesn't
really cause a problem (at least upstream) to have both ACPI and DT
config tables.  But I figured I'd at least point out why DtbLoader
wasn't removing the ACPI tables (when grub is not involved) in the
form of a patch..

>
> I guess it's worth pointing out here that this approach (DtbLoader)
> predates the finding out that these devices use PEP instead of ACPI
> for power management (which I guess makes it ACI) - so ACPI can never
> be usefully supported.

I don't think this is necessarily true.  With ACPI boot you can still
get far enough to run an installer and get to the point where you can
install OS updates.  The experience isn't great without PEP.. but more
or less the same is true on x86 laptops, where you need to get to the
point of installing updated kernel and/or mesa to have accelerated
graphics and other nice things.  The "PEP" driver is just another
thing that needs to get installed via HLOS updates.

That said, coming up with some sort of PEP mechanism for linux is
beyond what I have weekend hacking bandwidth for, so I'll leave that
for someone else.  Right now I'd be happy to get the various patchsets
we need to have things working landed upstream, and have some sort of
sane/standardized way to manage DT boot.  (Either DtbLoader or
something in grub picking the correct dtb file based on what we can
pull out of SMBIOS tables seems the sanest thing to me.)

Eventually if we have enough different aarch64 "ACI" laptops and users
out there, I think the DT approach will become too painful and we'll
have to tackle PEP for linux.. at least thats a problem I hope we have
eventually.

BR,
-R

>
> > So the problem that this solves does not exist in
> > practice, and we're much better off just exposing the DT alongside the
> > ACPI tables, and let the OS use whichever one it wants.
>
> Wo-hoo...
>
> > Also, the stub always reallocates the FDT, and so the CRC check is
> > only detecting whether the DT is being touched by GRUB or not.
>
> So does GRUB.
>
> DtbLoader looks up the DT through the system table again as part of
> the ExitBootservices hook. An address change *or* a CRC change
> triggers the ACPI deletion.
>
> This was the problem Rob was trying to address - ensuring the hook
> gets invoked even where the stub was the one that updated the DT.
>
> But given the situation we're in, I don't really disagree with you
> anyway.
>
> Let's just be clear that this isn't a free-for-all - this is because
> the abstraction of power management on this family of machines is
> broken by design.
>
> > So removing the ACPI tables like this is not something I think we
> > should be doing at all. As a compromise, you might add 'acpi=off' to
> > /chosen/cmdline so that GRUBless boot into Linux does not
> > inadvertently ends up booting in ACPI mode.
>
> If so, some form of (out-of-tree) sanity check would be needed on
> distros carrying out-of-tree patches that disable DT boot.
>
> It *is* possible to boot these machines using only ACPI. It's just not
> a very great user experience with all cores running at minimum
> frequency.
>
> /
>     Leif
