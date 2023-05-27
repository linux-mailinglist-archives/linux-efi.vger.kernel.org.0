Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D08171363F
	for <lists+linux-efi@lfdr.de>; Sat, 27 May 2023 21:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjE0Tkw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 May 2023 15:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjE0Tkv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 May 2023 15:40:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833ACEA
        for <linux-efi@vger.kernel.org>; Sat, 27 May 2023 12:40:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so2709802a12.0
        for <linux-efi@vger.kernel.org>; Sat, 27 May 2023 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685216447; x=1687808447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JcPeHx5b/Toh4k4OiN1qju08d1gnox4XXe9rs4ZJHI=;
        b=HS85D+fa8En0kAfgbIdtZbnJWVN+pLW/RsaR6iiYL9zYMAISN/x7diI/1QKaMpt5b4
         AiwiYg9Ra9YLQH46Y0SB2a585HHUjboNwyuKVqrR3JJcuptVR5UcOwuLteekmYRgeBF0
         iZiKr9tbTVoblVg3Jaaqb82n83cFmiu0oxvz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685216447; x=1687808447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JcPeHx5b/Toh4k4OiN1qju08d1gnox4XXe9rs4ZJHI=;
        b=JXSAEZyZQf25Rqwf90OXqXg3C+RXLiPTn/RPGH1a5vL7Qpnv0M0/QeTPsNjm3gBzTx
         kbEXPKrHsVLNE4X8uh4OdMbmDkB98qT92MxhFIEzCszDRoUwLgOrbupg6+Wa40dfReCD
         DDUbBViyY4EhJdeh7bZGw6ilB4XfPVufZX9jOzWueF4a5IGQlf2KNkA+ilC2z0Vrh2FY
         S4ducZ6FyqqWpEZmEoukSP6FRu3De/e6nMZKimFSo3kvCUek2qEOuGHvBOVQYqDPfQd2
         mBOYq0AZ23IyrDZCQxipxGqd53Qyqli7v6/3/H4ORYYyCB28PillqsYO2T3EHrjX+X7S
         4cMA==
X-Gm-Message-State: AC+VfDzZo43kYHPlx1qLRbK08q6YswIlCOF7aop+WbpRchiv+/s+c3WQ
        3SMZFQOU1HG8hFJxn5263yFUOPX4bBIMV/+n5S/bde4y
X-Google-Smtp-Source: ACHHUZ7/inarkt43OfdMP4sxQdN2CxKeOdlykn8rm3mYg82RKt6z4r7Ti+1yZSbAFiM/zqmdNoGw+g==
X-Received: by 2002:a17:906:fe4e:b0:953:291a:6705 with SMTP id wz14-20020a170906fe4e00b00953291a6705mr5345792ejb.17.1685216446694;
        Sat, 27 May 2023 12:40:46 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906410b00b0096f689848desm3720988ejk.195.2023.05.27.12.40.45
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 12:40:46 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso2918984a12.1
        for <linux-efi@vger.kernel.org>; Sat, 27 May 2023 12:40:45 -0700 (PDT)
X-Received: by 2002:a17:907:36cd:b0:953:37eb:7727 with SMTP id
 bj13-20020a17090736cd00b0095337eb7727mr6716027ejc.43.1685216445655; Sat, 27
 May 2023 12:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
 <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
 <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
 <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com> <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
In-Reply-To: <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 May 2023 12:40:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKJoDVuUNhf3U7gPXKu4EeZRv-iwwhL0prQ=U3n8PHiw@mail.gmail.com>
Message-ID: <CAHk-=whKJoDVuUNhf3U7gPXKu4EeZRv-iwwhL0prQ=U3n8PHiw@mail.gmail.com>
Subject: Re: mix of ACPICA regression and EFISTUB regression (Was: kernel >=
 v6.2 no longer boots on Apple's Virtualization.framework (x86_64); likely to
 be related to ACPICA)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Akihiro Suda <suda.kyoto@gmail.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, May 27, 2023 at 11:42=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> Yes, that makes the most sense. If the existing virtual machine BIOS
> has a hardcoded check that the EFI stub version is 1.0 even if it does
> not boot via EFI to begin with, I don't see how we can reasonably
> treat this as a regression that needs fixing on the Linux side.

Well, we consider firmware issues to be the same as any hardware
issue. If firmware has a bug that requires us to do things certain
ways, that's really no different from hardware that requires some
insane init sequence.

So why not just say that LINUX_EFISTUB_MINOR_VERSION should be 0, and
just add the comment that versioning doesn't work?

I'm not sure why this was tied into always enabling the initrd command
line loader.

Numbered version checks are a fundamentally broken and stupid concept
anyway. Don't do them. Just leave it at zero, and maybe some day there
is a sane model that actually has a bitfield of capabilities and
requirements.

              Linus
