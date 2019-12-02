Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6EA10EA0E
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2019 13:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLBM3g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Dec 2019 07:29:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33830 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBM3e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Dec 2019 07:29:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so43981562wrr.1
        for <linux-efi@vger.kernel.org>; Mon, 02 Dec 2019 04:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m1gJFoxmvPjutyLqW6gwKw+LefgYzc+HHd4YVNJtFa4=;
        b=VndfOFFMw1L/rmuAHJ6jsXalfXg2a3CmIxhSSc606nhVmBTPvovbR3NUrurVVdK3+W
         E44+UttwXNH+0MxtQCXPLB8OiNanW+qSedpbrnWe9oQwqFucaNAQFIjpuaw89wOr9obQ
         k0GCmcbMZk07b54nPsC/Wu55iei83BFsi1ci2YGe1U1KCx+WfIz8TaJQqQysqUH1/o1L
         wtI5WOt0+zMNneclxZ7mMTgiFMk9GnqC44YtMjkUSoag6KZasDDHmvYom6ygNf2udlI2
         BaJse3K4+wKFBwjw60hmQDUgvnai2FTppz18uwNeK7qTXNnqS/Ia6WWOY3aYW8mtXHrj
         sYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m1gJFoxmvPjutyLqW6gwKw+LefgYzc+HHd4YVNJtFa4=;
        b=Z6QWBoU0ux1uf1m/qwCcQ/KtA/L4PUOZgsXFIKl4uSgj8NZ8RGev6erDngHBwlvM9W
         sp4MT8QFTzjtrAykXE6Apu++p1T0oHSToYVBE3B8zEyvRVuImqLgdupJK8ZybhgD8OPI
         BdjcIZxuqoLEjkZB3XTek2jOpVA3lp3CTbnhUG+HluiF5mSXaf1kujAjh+ai6gVPGmMf
         ywQc3jCeeucn1ZrFInymm2JRLCSw+K5gKfN8oR+02Imz6f+WOVcy6h/ZR+zLJ3tOgBtv
         o7pEdWvX1ALaDBGgALTioM+J2DFvaB2Ly1kqS/ulxDJCX0BHJ9IcKe/WXoSA2vjCOfSx
         fQKg==
X-Gm-Message-State: APjAAAVSeaJA17MfrQDJg5ldmsCn4BWJsM/RniZlWMB4nIbwNk//a9OS
        Lls9wmpfHWDt5aiEdtAJuElqiQ==
X-Google-Smtp-Source: APXvYqwd3UxC6c3DYGT/u/UuFJrPiuTjk+YcI3ZageRxW8ixm+PJ796D/NoYSrhFUN4lmKDGhjxM3w==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr4235243wrr.252.1575289772174;
        Mon, 02 Dec 2019 04:29:32 -0800 (PST)
Received: from bivouac.eciton.net (bivouac.eciton.net. [2a00:1098:0:86:1000:23:0:2])
        by smtp.gmail.com with ESMTPSA id a14sm6471505wrx.81.2019.12.02.04.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 04:29:31 -0800 (PST)
Date:   Mon, 2 Dec 2019 12:29:29 +0000
From:   Leif Lindholm <leif.lindholm@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kairui Song <kasong@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" 
        <linux-efi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/fdt: install new fdt config table
Message-ID: <20191202122929.GC7359@bivouac.eciton.net>
References: <20191130195045.2005835-1-robdclark@gmail.com>
 <CAKv+Gu_HXD=59q9zeK6-WoEEngHPrEJpPTyT8U4TZZ3AOs=TcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_HXD=59q9zeK6-WoEEngHPrEJpPTyT8U4TZZ3AOs=TcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 02, 2019 at 10:35:05 +0100, Ard Biesheuvel wrote:
> On Sat, 30 Nov 2019 at 20:51, Rob Clark <robdclark@gmail.com> wrote:
>
> I understand what you are trying to do here, but this is not the right solution.
> 
> I have rejected patches in the past where config tables are used to
> communicate information back to the firmware, as creating reverse
> dependencies like this is a recipe for disaster.

This isn't *technically* communicating information back to the
firmware, since the agent that ends up being invoked is a driver that
has been explicitly installed in order to permit running Linux without
hacking about with GRUB. (But it's certainly communicating it back to
the firmware context.)

> IIUC, the problem is that the DtbLoader attempts to be smart about
> whether to install the DT config table, and to only do so if the OS is
> going to boot in DT mode. This is based on the principle that we
> should not expose both ACPI and DT tables, and make it the OS's
> problem to reason about which one is the preferred description.
> 
> I agree with that approach in general, but in this particular case, I
> don't think it makes sense. Windows only cares about ACPI, and Linux
> only cares about DT unless you instruct it specifically to prioritize
> ACPI over DT.

I guess it's worth pointing out here that this approach (DtbLoader)
predates the finding out that these devices use PEP instead of ACPI
for power management (which I guess makes it ACI) - so ACPI can never
be usefully supported.

> So the problem that this solves does not exist in
> practice, and we're much better off just exposing the DT alongside the
> ACPI tables, and let the OS use whichever one it wants.

Wo-hoo...

> Also, the stub always reallocates the FDT, and so the CRC check is
> only detecting whether the DT is being touched by GRUB or not.

So does GRUB.

DtbLoader looks up the DT through the system table again as part of
the ExitBootservices hook. An address change *or* a CRC change
triggers the ACPI deletion.

This was the problem Rob was trying to address - ensuring the hook
gets invoked even where the stub was the one that updated the DT.

But given the situation we're in, I don't really disagree with you
anyway.

Let's just be clear that this isn't a free-for-all - this is because
the abstraction of power management on this family of machines is
broken by design.

> So removing the ACPI tables like this is not something I think we
> should be doing at all. As a compromise, you might add 'acpi=off' to
> /chosen/cmdline so that GRUBless boot into Linux does not
> inadvertently ends up booting in ACPI mode.

If so, some form of (out-of-tree) sanity check would be needed on
distros carrying out-of-tree patches that disable DT boot.

It *is* possible to boot these machines using only ACPI. It's just not
a very great user experience with all cores running at minimum
frequency.

/
    Leif
