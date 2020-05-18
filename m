Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A851D73AF
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 11:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgERJPT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 05:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgERJPR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 May 2020 05:15:17 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2965720829;
        Mon, 18 May 2020 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589793317;
        bh=sNUlztveAJmm2fG/0q/M4GeYZ6rBhLJUQL5DhHVZvK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r5tppO3WttYFqmI/6cAYpnHh/CB7jLrjAuoFpekIdwtZjUlgdWxkGYoeau60MVckb
         MKh8qAINrYZ75mPxTwngXfHrBeyouZMkl387o0bZjw/YOIH1ytd7gRNRig9xcCy2Bd
         S/bViTImsCWu+9R97Rfrm3MfsKKHD8yvC9529sLE=
Received: by mail-il1-f182.google.com with SMTP id 18so184228iln.9;
        Mon, 18 May 2020 02:15:17 -0700 (PDT)
X-Gm-Message-State: AOAM532Sn2almpxnWIjlaZ0HzJlM40/U1+3RMxwbP+MF5WNubomZ/zQq
        KJXLTTbeX62WUPP0oslCxPRzDJwebBB0M3vr3qQ=
X-Google-Smtp-Source: ABdhPJw0Jj+zCyjLeSB2lkHXVRYCqJYNFRmf+fCB5ep87YsnuouFjIitXVOzsn92D0RXZ2WlhL8KQ+OuPoyOfADrS2Q=
X-Received: by 2002:a92:a312:: with SMTP id a18mr15414538ili.80.1589793316534;
 Mon, 18 May 2020 02:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200517125754.8934-1-ardb@kernel.org> <20200518090727.GB25034@zn.tnic>
In-Reply-To: <20200518090727.GB25034@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 18 May 2020 11:15:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGArZihaTkq49vSi0=3UWQrtsCDMeBbuK=EO9R1ik5AcQ@mail.gmail.com>
Message-ID: <CAMj1kXGArZihaTkq49vSi0=3UWQrtsCDMeBbuK=EO9R1ik5AcQ@mail.gmail.com>
Subject: Re: [GIT PULL 0/7] EFI fixes for v5.7
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 18 May 2020 at 11:07, Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> On Sun, May 17, 2020 at 02:57:47PM +0200, Ard Biesheuvel wrote:
> > The following changes since commit a088b858f16af85e3db359b6c6aaa92dd3bc0921:
> >
> >   efi/x86: Revert struct layout change to fix kexec boot regression (2020-04-14 08:32:17 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent
>
> can you please make your tags unique? For example call this one:
>
> efi-urgent-for-v5.7-rc6
>
> or so so that the git history can show for which -rc that urgent tag was
> meant?
>
> I mean, technically one can do that already with git but it would be
> easier if it had the rc in the name. We do that already in tip - either
> -rc name or the date of the tag.
>
> Also, using the same tag gives:
>
> From git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi
>  ! [rejected]                  efi-next           -> efi-next  (would clobber existing tag)
>  ! [rejected]                  efi-urgent         -> efi-urgent  (would clobber existing tag)
>
> when I try to fetch from you and I can delete the old tag but having
> unique tag names makes the history more user-friendly, I'd say.
>

Sure
