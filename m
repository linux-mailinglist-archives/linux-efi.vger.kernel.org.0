Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B632128DEF
	for <lists+linux-efi@lfdr.de>; Sun, 22 Dec 2019 13:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLVMhT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 22 Dec 2019 07:37:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40765 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfLVMhT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 22 Dec 2019 07:37:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so13791262wrn.7
        for <linux-efi@vger.kernel.org>; Sun, 22 Dec 2019 04:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tjAgNakFUyHBN+fuabFEXJ4Cc1Kt7eeMlrEkUnmKPk=;
        b=Zo0kt/A9fptodKHH5zKTycVc+k+lI0vxS3XHJgjGksxt7e48s9AtSIeCPjkCo5Ubcr
         9nHlnMHkv07JWTiBfii+/ZQL3D6f/fB7ZJzzsokze1EZA7o/9aV41I56n8eEaAVq5DRF
         f5ruC0sgbwV99Epi9riIDlvD9RMlEvPocezi3Fs6FGIE2FMmdsqj1sA3sFMA+MfcaEHQ
         IHbdvu428nonOtkZQqxNLi6mzO6To6zcVEruwdPgjVHpMVOUuB6KIFewtHD/isLyxiCe
         riWCCZ90YUXSmN8BsiKcfBg04yaXU+zUPjzAdRLmL7ED9dnD0InIyvYv3xq8mnVhi0ee
         X/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tjAgNakFUyHBN+fuabFEXJ4Cc1Kt7eeMlrEkUnmKPk=;
        b=IjOXKayb1IE/AA1qT+RBIXfM+imqHPpgIVJhBZa+jlhZheI2DLChmvBY3JY1TbBaLd
         wGzoaHoe+Qwm/Q4xiZC/qPvF2bZReWd+8dhVORBbn+DBoHS60aGIPFF30Fe80Rolssyv
         Atv9xAzroiVqBrc2kVuBnZGjzIUqiVU+f6NwuByv8RjNXzwsnTcP7VQTYudFbQ8v3jMX
         sE04q7Ijvy6Xbtu7ycnzl6wlvCLfILa+PRPHlxDwhF7mJWkgUqIMjyMP0J0Kvs4S8U7Y
         gt0ylYMsGVqBuosbSHpyIBIwTgCJ2P/pHTyKaKxS9BYtyhcWIm/UqCk1hkDi3CEiOVoq
         rmeA==
X-Gm-Message-State: APjAAAWaUPog+ylTkCO7UzmWq5w3SjbltF6onYFm2Z/cvSoNHo0sJz2+
        RLThdkpoqN7y5nSadLinbHRex8vnzDIVx1qoWN1YKw==
X-Google-Smtp-Source: APXvYqzfnXkFvkpu1f+pv6dtsH2aj0lLDgu3RZya7Pt4m874RKq2euL3MrqdGZM18LSI+eX3j4b07MLZ+Qv/TDu5Xo8=
X-Received: by 2002:a5d:5345:: with SMTP id t5mr26425845wrv.0.1577018236602;
 Sun, 22 Dec 2019 04:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-11-ardb@kernel.org>
 <e7fc88c6-6281-f69b-ef9b-71572e40d6b9@redhat.com> <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 22 Dec 2019 13:37:14 +0100
Message-ID: <CAKv+Gu8MrFpSHJOnJkDt-jig4nLxXStTrMKTMj2377xwr4DM7w@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] efi/libstub/x86: avoid thunking for native
 firmware calls
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

On Sun, 22 Dec 2019 at 13:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 21 Dec 2019 at 22:22, Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi Ard,
> >
> > On 18-12-2019 18:01, Ard Biesheuvel wrote:
> > > We use special wrapper routines to invoke firmware services in the
> > > native case as well as the mixed mode case. For mixed mode, the need
> > > is obvious, but for the native cases, we can simply rely on the
> > > compiler to generate the indirect call, given that GCC now has
> > > support for the MS calling convention (and has had it for quite some
> > > time now). Note that on i386, the decompressor and the EFI stub are not
> > > built with -mregparm=3 like the rest of the i386 kernel, so we can
> > > safely allow the compiler to emit the indirect calls here as well.
> > >
> > > So drop all the wrappers and indirection, and switch to either native
> > > calls, or direct calls into the thunk routine for mixed mode.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > I'm afraid that this patch breaks the boot on one of my machines.
> >
> > Specifically this patch breaks my GDP pocket machine. This is a Cherry
> > Trail device with a 64 UEFI running a 64 bit kernel build.
> >
> > As soon as I cherry pick this patch into my personal 5.5.0-rc2 based
> > tree, the GPD pocket stops booting and it stop so early on that I get 0
> > debug output. I guess I could try adding a few pr_efi_err calls
> > and see if those still do something.
> >
> > I noticed that you have made some changes to this patch, I've
> > tried updating it to the version from your efistub-x86-cleanup-v3
> > branch, commit id a37d90a2c570a25926fd1645482cb9f3c1d042a0
> > and I have also cherry-picked the latest version of all preceding
> > commits, unfortunately even with the new version, the GPD pocket
> > still hangs at boot.
> >
> > Unfortunately the nature of this patch makes it hard to figure
> > out the root cause of this issue...
> >
> > I've also tried another Cherry Trail device with 64 bit UEFI and
> > that does not suffer from this problem.
> >
>
> Thanks Hans.
>
> There are a number of things that change in the way the calls are
> made, but the most obvious thing to check is whether the stack needs
> to be aligned, since that is no longer being done.
>
> If you have time to experiment a bit more, could you check whether
> doing 'and $~0xf %rsp' before 'call efi_main' in the .S stub code for
> x86_64 makes a difference?

... or in case that does not help, I have updated my -v3 branch to
split the removal of the thunking sequence for x86_64 in several
discrete steps.
