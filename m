Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DB91A8974
	for <lists+linux-efi@lfdr.de>; Tue, 14 Apr 2020 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503942AbgDNS11 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 14:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503916AbgDNS1Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Apr 2020 14:27:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE4C061A0C
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 11:27:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m2so555755lfo.6
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39725/N1RjmePGAGcC5L2gkhHxlD8TbK9gL3md/ZFx8=;
        b=CklwolPhhQ8hL0pe0esgaXAWhzOphc+1ipdU/gtsCdbnIN8BptD7ncJ7Ip2B+9ZNIz
         vFn/n2SF727a3t5AeH8HNVUtkc4iDjzx7d4aFtPu1v6a4Pj2VtCbnLyg/RmKavbz+gss
         DDIxPHkXG5BPEFZw9Xl5Mv4iABaWzzjBotJ0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39725/N1RjmePGAGcC5L2gkhHxlD8TbK9gL3md/ZFx8=;
        b=oEY6NyUwbtqgroaf9HHavsxyAPPECHbSSgOfbAklIVJuYFFac+2vNnu/ojoQXp4XbY
         v16C1fTCYuANmzJg7RRp0kDOoUtyaz6flNyBZd8jIdyNpIWYrzlp8y62Cf/gU8euJ9Yx
         8XrE/SErlqnKCvVWk0fB/19iqUqKe958mj49kOZrG3R9L8KnEdC6ugt05TVf8+WSVONX
         RBKiOouYb+bL5OipjqFRjlXBzPSFue8Mk+ZZjuDfEJUA3D1VWIQ6BP65JWmrXaRjpEmx
         P/XlFhzevDgmckv2roQRa3goRoqbP6raEMzigWo/Cz2F1gFtvJXgln4gdnMw5FXFogqo
         HyoQ==
X-Gm-Message-State: AGi0PubnQNsi7kMQjBfBgEEHuiMu2ZZQRRiCvSAWSVR2PtD+n791n5oo
        lKgIwGYxxWFjYt0GjDiuSjm2zBIHMI8=
X-Google-Smtp-Source: APiQypLurLhqpOuwx5B55D6hthyJhXuVyHGq8edIGTIb8FPm94Gzxa4JApRMVYlovQWj5JtvXasGmQ==
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr688469lfe.154.1586888841518;
        Tue, 14 Apr 2020 11:27:21 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x80sm10767583lff.23.2020.04.14.11.27.20
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 11:27:20 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id j3so443248ljg.8
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 11:27:20 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr859604ljp.204.1586888840289;
 Tue, 14 Apr 2020 11:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
 <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Apr 2020 11:27:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-s0mmLAVg-aSmNU55=cE8ES7mC=Mc3Wn62P8W9VjY-A@mail.gmail.com>
Message-ID: <CAHk-=wi-s0mmLAVg-aSmNU55=cE8ES7mC=Mc3Wn62P8W9VjY-A@mail.gmail.com>
Subject: Re: Kernel V5.7-rc1 doesn't boot (EFI?)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 14, 2020 at 3:50 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> [*] GRUB on x86 turns out not to zero initialize BSS when it invokes
> the EFI stub as a PE/COFF executable

The fix seems to be to put all globals in the .data section, even if
they don't have initializers.

That seems very fragile. Very easy to forget to not declare some
static variable with __efistub_global.

Could we not make the EFI stub code zero out the BSS itself? Perhaps
setting a warning flag (for a later printout) if it wasn't already
zero, so that people could point fingers are buggy loaders..

             Linus
