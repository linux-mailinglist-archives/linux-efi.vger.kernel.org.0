Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432FE4585F3
	for <lists+linux-efi@lfdr.de>; Sun, 21 Nov 2021 19:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbhKUSkd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 21 Nov 2021 13:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbhKUSkd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 21 Nov 2021 13:40:33 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2433C061574
        for <linux-efi@vger.kernel.org>; Sun, 21 Nov 2021 10:37:27 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id q74so43776177ybq.11
        for <linux-efi@vger.kernel.org>; Sun, 21 Nov 2021 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hls2Kgfy6jzTAI7S62sH9Uq9xTqMBZ1lWWGkyIprUr8=;
        b=GlWGHjvDA/9hYQ/cuCHXdre9grptnSgrPCNGMOQZiE8J/eXPYRew+Z8SkxZQjf1pLY
         mg1hrdG/T0XYmKi+oV/dm+NchyWuBkds7dTXOQReuuIoUbyPO3JxVQr4Vw966zeLdYIw
         DL7WGVKSTJ+XXiDs+9wxFPnCCahVGmijykTPWen4GjcMXjx1IxaV4ZcGJdDcqH3e+3xZ
         YGLkzD7UTbv9eGDR4A3t6X7q3WSue7QlAarbsAjt5oN6LgDbYP42Y5x2iqB4Wu/9F3V8
         LVzBdPGbOA/VyffrB+Y0r4oIynKqDaxLgp5eXyG9pbxO+V6j8mrvpJcwOV1R4RZbqbMV
         JMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hls2Kgfy6jzTAI7S62sH9Uq9xTqMBZ1lWWGkyIprUr8=;
        b=FA6MAcvJcRlgpKXjEZl5KDEZtgrriKCGxbZXpYkz+SvUPpejyOqq8gxLIRcS1nRZKz
         EXeLuvL/Kzx3wT553NfSZSw5nWqt0hYVNaeRT+o0RSgs1Obs6ow8t9RaMpk3wdbWZnFb
         YjFhcPdnRluN2ejVss2Vt/guUMWMeCq/y7acaSWEH6OGBytmm0+GWx1aMsSGcsGmn8PY
         e2bTT/bI0HGgkjwCQBHu7t7SyD1HS73chTCvRSo4jfHWWJekyzgaEWouiGOogVjyIl++
         unP+aDAxGMwS2G2zbOwpqPjVcHQMlZIEm/3wnBpVTltRqfQHihv8zRJamqOGcHUd2BBI
         V6Mg==
X-Gm-Message-State: AOAM532zHd2RH0GLtn4j6J2UKyvo0w8A1A17ysfx/4Xeejq2KhTCk2uR
        ChKVqszpeYeqyTvT/HlRt2C/9u9856YkvsesAhImCQ==
X-Google-Smtp-Source: ABdhPJxVPImepDFqKkJ/J5ONuYqY+kz81VHx6tbsfNKAnMzF6qMNxnGpwKq7kjQLs5GESS/khzyZ9AhktB5xZoheYJ4=
X-Received: by 2002:a25:bacd:: with SMTP id a13mr59998241ybk.216.1637519845817;
 Sun, 21 Nov 2021 10:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20211119114745.1560453-1-ilias.apalodimas@linaro.org> <CAMj1kXHfFyUePGHbuQx_hVeL7YhRF4jZW0RD2k-zqtfNeDZF3w@mail.gmail.com>
In-Reply-To: <CAMj1kXHfFyUePGHbuQx_hVeL7YhRF4jZW0RD2k-zqtfNeDZF3w@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Sun, 21 Nov 2021 20:36:49 +0200
Message-ID: <CAC_iWjLdjkRzH6jxTrurtyVs4aD4qTGwH4+-sW-8K_pdB1wccQ@mail.gmail.com>
Subject: Re: [PATCH 0/4 v3] measure initrd data loaded by the EFI stub
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Sun, Nov 21, 2021 at 05:12:00PM +0100, Ard Biesheuvel wrote:
> On Fri, 19 Nov 2021 at 12:48, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi!
> >
> > This is a respin of [1].
> > This enables initrd measuring when loaded directly by the kernel EFI stub.
> > It ensures that the initrd observed and used by the OS is the same one that
> > got measured into the TPM, which is difficult to guarantee in the current
> > otherwise.
> >
> > There's a couple of changes compared to the original RFC:
> > - Ard fixed the x86 assembly for providing the extra arguments needed and I
> >   rebased it on top of
> >   commit 22aa45cb465b ("x86/efi: Restore Firmware IDT before calling ExitBootServices()")
> > - Instead of EV_IPL we are now using EV_EVENT_TAG. EV_IPL was marked
> >   as deprecated up until the latest PC client spec [2] (and deprecated  in
> >   older revisions [3]).  It's current description is:
> >   "It may be used by Boot Manager Code to measure events."
> >
> >   EV_EVENT_TAG on the other hand seems more appropriate as it's defined as:
> >   "Used for PCRs defined for OS and application usage.  Defined for use by
> >   Host Platform Operating System or Software."
> > - We are only measuring the initrd if it was loaded using the LOAD_FILE2
> >   protocol.  This is not what we probably want in the long run, but let's
> >   only enforce the measurement on the new way of loading an initrd for now.
> >
> > Questions:
> > - Since GRUB seems to be using PCRs 8/9 for it's EV_IPL events, maybe we should
> >   use something completely different?
> >
>
> Thanks for continuing to work on this.

You're welcome!

>
> I think using PCRs 8/9 is fine - if one upgrades to a new version of
> the kernel that implements this change, the PCRs will change in any
> case.

The reasoning here is leave distros unaffected.  Yes the PCRs will
change regardless in a kernel update.  However distros might already
have infrastructure to seal keys factoring in PCRs 8 and 9.  Keeping
in mind the initrd is likely to change without changing GRUB,  we
could allow them to opt-in on the initrd measurement using PCR10 (up
to 15).

>
> The only thing that is unclear to me is whether we should measure some
> kind of separator event if no initrd is loaded at all - IIRC, this
> came up before but I don't remember what the conclusion was in the
> end.
>

I think we ended up saying along the lines of "We need more
discussion.  Let's check what Windows is doing".  I did have a look on
that Eventlog James included,  but my windows understanding is
mediocre at best.  OTOH separators are used for PCRs 0-7 and they
either indicate errors or delimit actions during the boot process.  We
already have separators before EBS so I skipped it for the initrd.
Moreover I found nothing relevant to the spec wrt to tagged events and
separators  (apart from a mention to a Specification for Conventional
BIOS).
Delimiting actions during the boot process is useful for example when
you want a key sealed against specific PCRs extended by the firmware,
while not allowing later boot stages access it.   I can't think of
such a usage for the initrd.  Obviously if anyone can and it makes
sense I'll go add it.

Thanks!
/Ilias


>
> > I did test this on arm64 and x86_64 (incl mixed mode). Here's a snip of the
> > EventLog
> > <snip>
> >   - EventNum: 23
> >     PCRIndex: 9
> >     EventType: EV_EVENT_TAG
> >     DigestCount: 4
> >     Digests:
> >       - AlgorithmId: sha1
> >         Digest: "53fe403e0d763f6a4e3384e8112d6463e7ddf12b"
> >       - AlgorithmId: sha256
> >         Digest: "28f24eab8cb433e4b8cbce0f96b7ad0aa541a4b905f748491139e42f0adc8026"
> >       - AlgorithmId: sha384
> >         Digest: "848389ab172267dcf9a0b873c7534b3d969e915b525c9fe2b57db47f4ecd8283b18d6e0cff84099893d589447c2bea55"
> >       - AlgorithmId: sha512
> >         Digest: "438b254c92e6716a5a1ba0338f5e751f3dd27782481e5698911b4cd33a98efdd776459d56781c5ae4a8d0b9945246d04ab243d4dbe03f49542e2455ac66db584"
> >     EventSize: 21
> >     Event: "ec223b8f0d0000004c696e757820696e6974726400"
> > <snip>
> >
> > [1] https://lore.kernel.org/linux-efi/20201102170634.20575-1-ardb@kernel.org/
> > [2] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient_PFP_r1p05_v23_pub.pdf
> > [3] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientSpecPlat_TPM_2p0_1p04_pub.pdf
> >
> > Ard Biesheuvel (3):
> >   efi/libstub: add prototype of
> >     efi_tcg2_protocol::hash_log_extend_event()
> >   efi/libstub: x86/mixed: increase supported argument count
> >   efi/libstub: consolidate initrd handling across architectures
> >
> > Ilias Apalodimas (1):
> >   efi/libstub: measure loaded initrd info into the TPM
> >
> >  arch/x86/boot/compressed/efi_thunk_64.S       | 14 +++-
> >  arch/x86/include/asm/efi.h                    | 14 +++-
> >  arch/x86/platform/efi/efi_thunk_64.S          | 14 +++-
> >  .../firmware/efi/libstub/efi-stub-helper.c    | 73 ++++++++++++++++---
> >  drivers/firmware/efi/libstub/efi-stub.c       | 10 +--
> >  drivers/firmware/efi/libstub/efistub.h        | 30 +++++++-
> >  drivers/firmware/efi/libstub/x86-stub.c       | 26 +++----
> >  7 files changed, 134 insertions(+), 47 deletions(-)
> >
> > --
> > 2.33.1
> >
