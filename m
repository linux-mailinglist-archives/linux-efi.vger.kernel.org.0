Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 618F512BBB2
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 23:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfL0WvW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 17:51:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54390 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL0WvW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Dec 2019 17:51:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so9222461wmj.4
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 14:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QuzzcnuIDAm2Xdb4pGXp7LEYkHgRncuQWrbpFgWPz3o=;
        b=EaYEjjneSdA/coMc0ULfN5qNVHRzrJuYuoLq1pxeKPgpGWaTCg8111kgiwbiELG7nX
         pF7AEFDtAPQzdK80EOTOZsEb1JZi4NQPZhiQfhBZERB30dLq+7qZlfPc6/GsJfNZAWeW
         7yslbvUwlk4zt9C7kB2lX+Jlzq7TK+IcM1bnoxZt+CXfuiwAsiPWjByMrEgftW9p3+Mj
         Nod+Wo1Q6h1CjkZlykVP/zo/rzUv/KubL2q9fNk39L/vL1U+DgbRyaAgpF5+/Fn61IDB
         Q0n4xaXfTXTLdO7W2afkEzHsZjtKOhbXbLEL+5BGGWsdsemolIHQi7r/rQ9lCVey3e8c
         RWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuzzcnuIDAm2Xdb4pGXp7LEYkHgRncuQWrbpFgWPz3o=;
        b=RWl5bmY73cKZtkN29wC1jZF5hrgS4zz/MP6ubw0TIpZayXRx4y+fWqC3Z20q0bcOwb
         IPrnfkgBNgocFi4k/Pajbx4xfXohhIzrdATqWZfL+Wu9gUfXdGyR/yeXUPc/1U+g00Xq
         hPwKtOtrsk3+/Xibw7wKg967IqJ5H9mvi3kNHaPx/hf7/asniFLI2E51/hLfb6uWzQNi
         vjI4pGWaQresH4Jn0cACPs1jeFBXBjHZjynXFEj7+gnWzaUKi/WRtE3hL0Piq6c6CZdl
         5IZ5l+StQFasIPuxuzUfCHWDMvFucQ+BJ0dRrhrvnyCO6nRLVv0jCORdSOQXeK177wDR
         5qPw==
X-Gm-Message-State: APjAAAVm6ZV0AmbCXiWjw/4cgP+GVLLp/czPEHjaQLEHsPHwEXL6iDNF
        p7GD384+6iXoS2fQ9Yu2Jjay/DT/kHToV0CTmNhZSw==
X-Google-Smtp-Source: APXvYqwMqXqouS//7V3irp6ouBws6yoJp7qBquW7ANYZzXpGlPthZCWpYjdPq7R4HIKWc7jbEFj5r8hgOpcjrmmZrYc=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr21148458wme.148.1577487080408;
 Fri, 27 Dec 2019 14:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-14-ardb@kernel.org>
 <463b0b17-3be7-697e-1227-5d3df52996d6@redhat.com> <CAKv+Gu-wk5qBOGuoLx6v7Zo41dOZ5oNL3oBCnyT858DY7JCuhw@mail.gmail.com>
 <82ad1878-85e3-f893-1c8d-ade0225b2074@redhat.com>
In-Reply-To: <82ad1878-85e3-f893-1c8d-ade0225b2074@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 27 Dec 2019 23:51:22 +0100
Message-ID: <CAKv+Gu_mdLJYnk4cVqyjNE_iWYqOeYeMxYN2j4fL-vK=sDScOQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 27 Dec 2019 at 23:44, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 25-12-2019 15:42, Ard Biesheuvel wrote:
> > On Tue, 24 Dec 2019 at 20:34, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Ard,
> >>
> >> On 12/18/19 6:01 PM, Ard Biesheuvel wrote:
> >>> The various pointers we stash in the efi_config struct which we
> >>> retrieve using __efi_early() are simply copies of the ones in
> >>> the EFI system table, which we have started accessing directly
> >>> in the previous patch. So drop all the __efi_early() related
> >>> plumbing, except for the access to a boolean which tells us
> >>> whether the firmware is 64-bit or not.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> I synced my personal tree yesterday to 5.5-rc3 + the most
> >> recent version (as of yesterday afternoon) of your
> >> efistub-x86-cleanup-v3 branch on top.
> >>
> >> This has been working fine on a bunch of devices, but it fails
> >> on a Teclast X89 Bay Trail (mixed mode) device. When reverting all
> >> the commits from your efistub-x86-cleanup-v3 branch one by one, things
> >> start working again after reverting this one.
> >>
> >
> > Oops again. And thanks again for taking the time to test this stuff.
> >
> > Could you please try the branch below and check whether it fixes it?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-core-mm-fix
>
> This seems to fix the issue, the Teclast X89 boots again and I've
> also tested this on 2 other devices (one mixed mode Bay Trail one 64 bit
> Cherry Trail device).
>

Great, thanks.

> If I want to also test them, how do the 2 new series you've just posted come
> into the mix here? :
>
> "[PATCH 0/3] efi/x86: clean up and simplify runtime call wrappers"
> "[PATCH 0/3] efi/x86: righten memory protections at runtime"
>

I have accumulated a couple of more fixes in addition, and a patch
that I haven't sent out yet.
Easiest to grab them from

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next

-- 
Ard.
