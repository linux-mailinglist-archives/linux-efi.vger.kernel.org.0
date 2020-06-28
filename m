Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7F20C9BC
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jun 2020 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgF1S5l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Jun 2020 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgF1S5j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Jun 2020 14:57:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E3AC03E979
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 11:57:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so15655949ljm.11
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=me4EsdBDUgzOWyCfaWTKrh1/8VSX/WOOzYty4vYJbaA=;
        b=Lh1BHMQPK4pHb+0pZdaLnW04plhoseGZ9Aju792/YX26s0fWjKZj3RLGKor51B7+z7
         KqHB/Yz9hh44U6vxmt6KDnGPhf1ONIZLqAsUPSB28Iyn/+aAizAG8K9eVVQKAQY0f3lp
         dnSo693KFmnoSo48/Wq3cLLiXAKaEoTCsV5n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=me4EsdBDUgzOWyCfaWTKrh1/8VSX/WOOzYty4vYJbaA=;
        b=cyJWo21gS4K76EufXXoA3hBDjALfHLeOXj20Ezh1ySlV/dNkbyqIYYfVqO5Wt0dt91
         OmAB+wxy2CXmnbAjsdD75TWZNHA7POicNmxuUI7bIabsnGxY/BIQgKnypy++8IFoVUs4
         ev9ixp75hkSEqzDlOjfnPLebktD9WQESRkyMgXHGi26M6poCW4tzP/lrgTYVH+WCQWW9
         nsr3u3RiyVSP3wcZmbuL3ZMZ3NnCCDy66gjxXob4wwALAXTQb9DmmNEgg7QDYwQe/mMp
         HrvNeRlWREuuwCAzsRsoYjFgQbDXWNiYOW1r/tzcv8rWB77ipSRZZAcydB6S4TR44czE
         U1Zg==
X-Gm-Message-State: AOAM533PeIIPgJQUs+8QE2TTH+54u4ggxvLGxnzSDZKzRNzU1BKUd6vH
        CE3/Xg0T2VaL0o/v8ZBs4/qRIVVAG8I=
X-Google-Smtp-Source: ABdhPJxLSawVnGy7MkI1HcFvx+d/E/nj+Io8wIS7/wXk53p/vECXEVV44IGPW7A6tpqtU2ETp1DwPg==
X-Received: by 2002:a2e:9b94:: with SMTP id z20mr4619259lji.404.1593370655795;
        Sun, 28 Jun 2020 11:57:35 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id s62sm6635115lja.100.2020.06.28.11.57.34
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 11:57:34 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id s9so15655904ljm.11
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 11:57:34 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr4749702ljn.421.1593370654268;
 Sun, 28 Jun 2020 11:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200628182601.GA84577@gmail.com>
In-Reply-To: <20200628182601.GA84577@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Jun 2020 11:57:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
Message-ID: <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes
To:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jun 28, 2020 at 11:26 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> - Fix build regression on v4.8 and older

Interesting.

It's perhaps yet another reason to just skip gcc-4.8 too, since
apparently 4.9 works.

gcc-4.9 really has a lot of advantages. It's where (I think) gcc
basically supports all C11 things, including _Generic() but also
__auto_type.

So if we just say that we only care about gcc-4.9 upwards, it frees us
to clean up some (really) old constructions where we've been using
macros with sizeof and/or typeof, and make the code potentially rather
more readable and often more compact.

Yeah, I know we _just_ made the minimum compiler version be 4.8, but I
do get the feeling that we should just have bitten the bullet and gone
all the way to 4.9.

Arnd, what was the reason for 4.8 support? I'm assuming there's some
sad unfortunate distro that still uses that ancient compiler..

Ok, ok, 4.9 isn't exactly new either (4.9.0 released May 2014, and
final 4.9 release was 2016), but 4.9 really from a feature angle is a
much saner thing than 4.8.

Afaik, the main "interesting" part of gcc-4.8 was that it was when gcc
switched over to be built as C++. That's perhaps a huge milestone for
gcc itself, but not necessarily for the users..

Arnd? You're the one who tends to keep track of these things..

             Linus
