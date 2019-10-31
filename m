Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73909EB180
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 14:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfJaNsH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 09:48:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44211 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJaNsH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 09:48:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id i22so1123503wrb.11
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2019 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QksVvRkxEC/Fbmw0ixK2EWKntOYb1CjKsU27i/CLKQ8=;
        b=nl4MS2a1kfU8kAKWpuvJLyCivDaGmr9zyq1KInHFqBvTA1HRD4TqoMNN40KezpcHtr
         ERoMUn54CqTNLROl+2LJoGvngj+2cbuGQ21Yi8clJubBSY4GQzbRFlu/GK/JLTazCoAQ
         AsZfZRPgEfRlSbsLidVg04cqTRWRmDAAfYa4nxOTwGd/76+br42fNuhQcl0JbITdzHKo
         mWip9oVWlLU8LheD6xU33kv64UeSrVHOdGvTuoJ+Hg1kqlLFx3b/bPB/DcQ7glNw3np2
         HZYBO7/QDDqTR/KygjoruiafycjN01DG9jisud/hlZsdmQ9WuTxiXSAfsU7vrX8qwRAy
         FQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QksVvRkxEC/Fbmw0ixK2EWKntOYb1CjKsU27i/CLKQ8=;
        b=IEQCVBT9FziRAtw4Xl0X7AOMgPneBSCtbmmDCBdse+2JieOgi5BeSnXmPJXL67eLLT
         vG5UOMgfDS8tXQjI6KWdWqgTuVp4MXvcF8Awldhch1vus7iXoGbx/RDR1ueNEwgCZfn1
         6MeCYEsbOQZXiYZKR05UjeTeHRVTJExDHrjYmkcY5CgnpT0IX8necghvb0XuYX5340Zf
         E+kinn9o6/36GyP6Pn8qakd3v9oESSN3qY5DRsHCCWilJ2OqwNPYX47krKWpsYxVcoep
         Kym9fss1wX4ozGIYqPSVghMKVzEn6ZHvd6FP1gYtRsuI/11YaYOD4YlXQoD16dHPUwmb
         QDjw==
X-Gm-Message-State: APjAAAWsePcKYACyYg8mA7m4yfXZB/RHNL3Wx0Bc0mabcI7I9aBmWPhg
        Kx3vuzWzQir2hqxBUCiULa90CkhVsmKfzJrbugmlmQ==
X-Google-Smtp-Source: APXvYqw7fXK428FamCSNbDLwZ5YfXyMWJpGq2TSe1+1tdihbiys5tLPxlhHWAoeYJsedRdsuhWgMsQnEhMJb+dyFN84=
X-Received: by 2002:adf:8289:: with SMTP id 9mr6112282wrc.0.1572529685061;
 Thu, 31 Oct 2019 06:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191029173755.27149-1-ardb@kernel.org> <20191029173755.27149-4-ardb@kernel.org>
 <CACi5LpMAagnn_yEmqRBGfxJFZcAUzohU30NACeGvdXaHFZwAMA@mail.gmail.com>
 <CAKv+Gu_zMMeRSBYk_tBX4UA+v1r+Kntrxe3xurLd1Q2_+HkbWw@mail.gmail.com> <20191031084126.GB107774@gmail.com>
In-Reply-To: <20191031084126.GB107774@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 31 Oct 2019 14:47:53 +0100
Message-ID: <CAKv+Gu-Gf1vtrGVT2m7Y7XWkK=zE3J0Xf50obEbJT5x94TJGSQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] efi/random: treat EFI_RNG_PROTOCOL output as
 bootloader randomness
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 31 Oct 2019 at 09:41, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > On Tue, 29 Oct 2019 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Tue, Oct 29, 2019 at 11:10 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > From: Dominik Brodowski <linux@dominikbrodowski.net>
> > > >
> > > > Commit 428826f5358c ("fdt: add support for rng-seed") introduced
> > > > add_bootloader_randomness(), permitting randomness provided by the
> > > > bootloader or firmware to be credited as entropy. However, the fact
> > > > that the UEFI support code was already wired into the RNG subsystem
> > > > via a call to add_device_randomness() was overlooked, and so it was
> > > > not converted at the same time.
> > > >
> > > > Note that this UEFI (v2.4 or newer) feature is currently only
> > > > implemented for EFI stub booting on ARM, and further note that
> > > > CONFIG_RANDOM_TRUST_BOOTLOADER must be enabled, and this should be
> > > > done only if there indeed is sufficient trust in the bootloader
> > > > _and_ its source of randomness.
> > > >
> > > > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > > > [ardb: update commit log]
> > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >
> > > Seems my Tested-by was dropped which I provide for the RFC version of
> > > this patch.
> > > See <https://www.mail-archive.com/linux-efi@vger.kernel.org/msg12281.html>
> > > for details.
> > >
> > > I can provide a similar Tested-by for this version as well.
> > >
> >
> > Thanks Bhupesh
>
> I've added Bhupesh's Tested-by to the commit - no need to resend.
>
> I've picked up all 6 EFI fixes, will push them out after a bit of testing
> - sorry about the delay!
>

No worries, thanks for picking them up.
