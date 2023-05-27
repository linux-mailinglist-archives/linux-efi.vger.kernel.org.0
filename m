Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8D713615
	for <lists+linux-efi@lfdr.de>; Sat, 27 May 2023 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjE0Sen (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 May 2023 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE0Sem (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 May 2023 14:34:42 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154BDD2;
        Sat, 27 May 2023 11:34:41 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565e6beb7aaso4323707b3.2;
        Sat, 27 May 2023 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685212480; x=1687804480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzEHMKPZ9fj/sSTbrr++Mdb6c3+qROgUK5bksEJMA/A=;
        b=R7EkvIHbW6jHBVSEZdi6c6B8Oco6L/mnlGh6SNeKvBZY5TdmZ4uOQMe+4AESV6+Fb0
         qgIEMxWUsz8b5JVcjGc0njrbo1Mz6VQFCyFYgF8jyycqmyajiRiddSEP6kZjV8Em4F9J
         PGZfidDmbXXdC60HuxaWa72oab7RbVjJeiTr9z28CWMXISaNj9y3OpcqQJiML+kotLUB
         1J7UwAXdeiFXqoEyJH/mcgJyxJZkkq6cnohLtaFAhrt8G+7+TUYUTisJeBES40VKoNFZ
         h6dwN8Fgfb2An2qRF5KLceAj/aEuR0FMEwkiSRBx7zIUeotkF+fEwrCcYZuTNJgrShQ0
         /LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685212480; x=1687804480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzEHMKPZ9fj/sSTbrr++Mdb6c3+qROgUK5bksEJMA/A=;
        b=ZkZ9ZcGa31sU9rr0fUYNSTvM3C6rSam9sIyHJqyMAw78zAN5RlpPPIlZpgJPAA1woL
         BkZLjCFlgar/QzustWNxay4nWvDjFMhwysKX/aecDkhU1bYOYVevHjvT/kSUXgtT90qL
         Qk30Bo6IB/COgoMMvJGMZXwNOdwmDFb9CtErPSo7bpNmWghmyH4on+oKEAUfM1cQIiKG
         TDyo8EAFh4WdHyC18BBUgckWume7kR7p+LmZbBR4hhrnRG7WXqlmF07Wv0Xpr7s6V4DV
         2b87gxIAQFo0NVRibgGQFYxv/sEYkRhCenwdKRlsV43Gx/qmpBX7hLDcQh+cQ+5G0aCo
         cuJQ==
X-Gm-Message-State: AC+VfDw9FqRZowFtUE4MjURTIhYobMkbL6hDPAhPUG0DkDox/CWQQpgS
        28ZdielEW+cJ5cRKKER9Y2HiAB0x/0L3XZMcIRZ6aTLdmMPlOw==
X-Google-Smtp-Source: ACHHUZ7C6QJXpq3Vg5Z4EPkDHRGpRztxNaW37dYn6pLtrPqOoi/iMCQYIgjTwz+A3iojBTjlf1sOyckIK1611B5YW5I=
X-Received: by 2002:a81:6a05:0:b0:565:5478:713a with SMTP id
 f5-20020a816a05000000b005655478713amr6377602ywc.49.1685212480200; Sat, 27 May
 2023 11:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
 <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com> <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
In-Reply-To: <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
From:   Akihiro Suda <suda.kyoto@gmail.com>
Date:   Sun, 28 May 2023 03:34:28 +0900
Message-ID: <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com>
Subject: Re: mix of ACPICA regression and EFISTUB regression (Was: kernel >=
 v6.2 no longer boots on Apple's Virtualization.framework (x86_64); likely to
 be related to ACPICA)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux x86 <x86@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux ACPICA <acpica-devel@lists.linuxfoundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

> Are you using OVMF? Which versions of qemu and OVMF are you using?

I'm using Apple's Virtualization.framework, not QEMU.

It doesn't use UEFI when it directly loads bzImage.
( dmesg: https://bugzilla.kernel.org/attachment.cgi?id=3D304323 )

Despite that, it still expects LINUX_EFISTUB_MINOR_VERSION
(include/linux/pe.h) referred from arch/x86/boot/header.S to be 0x0.
I confirmed that the kernel can boot by just setting
LINUX_EFISTUB_MINOR_VERSION to 0x0.

Would it be possible to revert the LINUX_EFISTUB_MINOR_VERSION value
(not the actual code) to 0x0?
Or will it break something else?

Anyway, I'll try to make a request to Apple to remove the
LINUX_EFISTUB_MINOR_VERSION check.

2023=E5=B9=B45=E6=9C=8828=E6=97=A5(=E6=97=A5) 3:04 Ard Biesheuvel <ardb@ker=
nel.org>:
>
> On Sat, 27 May 2023 at 20:00, Akihiro Suda <suda.kyoto@gmail.com> wrote:
> >
> > [Resending as a plain text email]
> >
> > Turned out that this is a mixture of an ACPICA issue and an EFISTUB iss=
ue.
> >
> > Kernel v6.2 can boot by reverting the *both* of the following two commi=
ts:
> > - 5c62d5aab8752e5ee7bfbe75ed6060db1c787f98 "ACPICA: Events: Support
> > fixed PCIe wake event"
> > - e346bebbd36b1576a3335331fed61bb48c6d8823 "efi: libstub: Always
> > enable initrd command line loader and bump version"
> >
> > Kernel v6.3 can boot by just reverting e346bebb, as 5c62d5a has been
> > already reverted in 8e41e0a575664d26bb87e012c39435c4c3914ed9.
> > The situation is the same for v6.4-rc3 too.
> >
> > Note that in my test I let Virtualization.framework directly load
> > bzImage without GRUB (akin to `qemu-system-x86_64 -kernel bzImage`).
> > Apparently, reverting e346bebb is not necessary for loading bzImage via=
 GRUB.
> >
>
> Are you using OVMF? Which versions of qemu and OVMF are you using?
