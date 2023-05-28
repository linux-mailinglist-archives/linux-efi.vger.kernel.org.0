Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FCB71383E
	for <lists+linux-efi@lfdr.de>; Sun, 28 May 2023 09:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjE1HCy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 May 2023 03:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjE1HCx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 May 2023 03:02:53 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576ED9;
        Sun, 28 May 2023 00:02:52 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-561a41db2c0so32786917b3.3;
        Sun, 28 May 2023 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685257371; x=1687849371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRkqudkgMQ49oMc1gbKQdMb2w50Dkd1fBeJ/gvJ6yX8=;
        b=qmMTFrt8uoytygO19Oob0VRjf+V9CWhsO4qE9F78KrSta+nabHhX11re+hazJIZlPX
         TzJeNTBNwbB/qCGJaFc6B34OW2Khw8CWOyne6MGJy7DOi8STTwy4Lyel3LWUwAzb74sG
         mEwxjcmeyArXXCEa77HqYNLRXy+MU5Amtw8TuAHLJ3I4JXpnqJRFwSYO3T7NhYQZ0N40
         9AMiK7zVcPZZt8n1p8u/NL/fk5VKFoGWY/dtTIpExxZD/B6ygrOc2dipwboWZmXU/qmt
         fmbXQGA0vg8g+l7EDAdUXj4eQYJZn5mY3WS03aAvA2h0h0SqU28km1LxCmAwMTqtuK32
         Uglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685257371; x=1687849371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRkqudkgMQ49oMc1gbKQdMb2w50Dkd1fBeJ/gvJ6yX8=;
        b=F+sR9eYAGKkbElXTrjUAswhrV7Omw/SFp0w2gtw7qe5sEUB3lXT5GgrZnfAnpUY24o
         78NMWAgFKm1FhE54TDfm9LYYKinLRYFGHtipcy9BoFWxAH0wlWstYBGK61pJ2+ksRXBb
         q0tfYnqMblU74eZGvv3k/UwmANFTaiHMGjy6zZezFO8RmRRqEkHLcZWcR4JxsT/KvaVf
         9plYE10vHN4CIqGvAXM924SS3kFvjYmg3q1n69qDXwCj0DUBn9cZCOLicAX9yisfKUm4
         aFV26+gdDXHu03440AH0ANsbQMYrf7j3Gbj0wboZTMgWtykr+6D96Y16RYZvu/Jg3zb5
         WkIQ==
X-Gm-Message-State: AC+VfDwEEc23F7LjGLzdFxodow1ocwI0ImBLgVogrewceT74vrmzHqQM
        X1g3eMKk4Fm/RvfT70MDkzHL7JHTAvZgsnTzy2U=
X-Google-Smtp-Source: ACHHUZ5QnHgzGna8A0ict5YGfhiUK1/FyXdi06p0MjmNBDyw5tltLHDzYhcCm1SX6aeGhqMyx+OQ3MmemowirLDgF2Y=
X-Received: by 2002:a0d:cc0c:0:b0:55a:5870:3d47 with SMTP id
 o12-20020a0dcc0c000000b0055a58703d47mr7603574ywd.26.1685257371475; Sun, 28
 May 2023 00:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
 <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
 <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
 <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com>
 <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
 <CAHk-=whKJoDVuUNhf3U7gPXKu4EeZRv-iwwhL0prQ=U3n8PHiw@mail.gmail.com> <CAMj1kXHmRYkmJyfW5+B74dPyA1+yHvt9majpZ9Ut1p0i8zM+DA@mail.gmail.com>
In-Reply-To: <CAMj1kXHmRYkmJyfW5+B74dPyA1+yHvt9majpZ9Ut1p0i8zM+DA@mail.gmail.com>
From:   Akihiro Suda <suda.kyoto@gmail.com>
Date:   Sun, 28 May 2023 16:02:40 +0900
Message-ID: <CAG8fp8Teu4G9JuenQrqGndFt2Gy+V4YgJ=hN1xX7AD940YKf3A@mail.gmail.com>
Subject: Re: mix of ACPICA regression and EFISTUB regression (Was: kernel >=
 v6.2 no longer boots on Apple's Virtualization.framework (x86_64); likely to
 be related to ACPICA)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux x86 <x86@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux ACPICA <acpica-devel@lists.linuxfoundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> Fair enough. Or we could try bumping it from v1.1 to v2.0 (or v3.0 if
> we make it a bit mask).
>
> Akihiro, would you mind checking if changing the major/minor to any of
> these values results in the same problem?

Surprisingly, v2.0 and v3.0 boot, although v1.1, v2.1, v2.2, v3.1,
etc. do not boot.

Looks like Apple's vmlinuz loader only requires
LINUX_EFISTUB_MINOR_VERSION to be 0x0
and does not care about LINUX_EFISTUB_MAJOR_VERSION.

2023=E5=B9=B45=E6=9C=8828=E6=97=A5(=E6=97=A5) 6:48 Ard Biesheuvel <ardb@ker=
nel.org>:
>
> On Sat, 27 May 2023 at 21:40, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sat, May 27, 2023 at 11:42=E2=80=AFAM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > >
> > > Yes, that makes the most sense. If the existing virtual machine BIOS
> > > has a hardcoded check that the EFI stub version is 1.0 even if it doe=
s
> > > not boot via EFI to begin with, I don't see how we can reasonably
> > > treat this as a regression that needs fixing on the Linux side.
> >
> > Well, we consider firmware issues to be the same as any hardware
> > issue. If firmware has a bug that requires us to do things certain
> > ways, that's really no different from hardware that requires some
> > insane init sequence.
> >
> > So why not just say that LINUX_EFISTUB_MINOR_VERSION should be 0, and
> > just add the comment that versioning doesn't work?
> >
>
> Fair enough. Or we could try bumping it from v1.1 to v2.0 (or v3.0 if
> we make it a bit mask).
>
> Akihiro, would you mind checking if changing the major/minor to any of
> these values results in the same problem?
>
> Unfortunately, the only data point we have is that a non-EFI
> bootloader (which is unlikely to carry a PE/COFF loader) needs the
> byte at that specific offset to be 0x0, and we really have no idea
> why, or whether we could hit this in other ways (i.e., by changing the
> PE/COFF header to comply with new MS requirements for secure boot,
> which is another thing that is in progress)
>
> > I'm not sure why this was tied into always enabling the initrd command
> > line loader.
> >
>
> For x86, it doesn't actually make a difference, but on other
> architectures, the command line initrd=3D loader could be disabled, but
> that possibility was removed. The idea was that by bumping the version
> to v1.1 at the same time, generic EFI loaders would be able to
> identify this capability without arch specific conditionals in the
> logic.
>
> Currently, GRUB and systemd-stub check this version field, but only
> for v1.0 or higher. Upstream GRUB  switched to this generic version of
> the EFI loader just this week, but does not actually use initrd=3D at
> all for EFI boot (on any architecture).
>
> > Numbered version checks are a fundamentally broken and stupid concept
> > anyway. Don't do them. Just leave it at zero, and maybe some day there
> > is a sane model that actually has a bitfield of capabilities and
> > requirements.
> >
>
> Yeah, maybe you're right. Currently, only a single feature is tied to
> LINUX_EFISTUB_MAJOR_VERSION=3D=3D1 (LoadFile2 support for initrd loading)=
,
> and this PE/COFF version field has no meaning to UEFI firmware itself,
> so we could simply treat these fields as bit masks if we wanted to
> (and setting the initrd command line loader bit for x86 would be
> redundant anyway)
>
> But not being able to freely set such a bit because some rarely used
> non-EFI BIOS implementation imposes requirements on the contents of
> the EFI specific image header is rather disappointing.
