Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3974E1A89FF
	for <lists+linux-efi@lfdr.de>; Tue, 14 Apr 2020 20:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504271AbgDNSo5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 14:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504269AbgDNSoy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Apr 2020 14:44:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F9EC061A0C
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 11:44:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so966176ljd.3
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 11:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUAvoCKNNXDeCMUdwCSeLoMbMAb/KChWz9ujE+OyHCM=;
        b=ONAUHEL13p5Y/2ha0FDA/acN9wDJouk3bUIGvZBWK8Ba4OIop6w0BIFm2VTAZqpMmL
         vmVA+NzYHqIKDdUCS3JsX3CDuR4T890vJuLmkMrFfHiBagBwM4wsxv9Mwf2QW4GLIMNa
         fQiZRKHMlUbiAGRyHbsnkUsNcTq5+DXaQYNig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUAvoCKNNXDeCMUdwCSeLoMbMAb/KChWz9ujE+OyHCM=;
        b=tbu5Ezic7iST5bwRASyjJj+o9M063zh0vLkObDeHJgw3O3L7Z+41y5WY911VajvOYt
         riNU8AXGDbt3+VpqkV6KShEJTUSnM9jaEPuU4FtZSM0IZCsHJdEcDDUUexS21P6CYAiO
         h7dBbpO/0D0ndM0iAw0B53DTByqAFgBlujTn7xDA28CLdBHtdgZKIKNFgZnJN5cc4uPG
         guvoG9MPhLwcHzHhIeL2meOSjBN8zeXFDvaCh6xdbGupYgGiZGHd3MJmgxiWwkylu4K2
         a+mQ65VO7RNo2yWlF6PJzj7xbQJv+MYG5vN987QaK8Hf0JsPladuvdLSS+CZITjpHRSf
         xkrg==
X-Gm-Message-State: AGi0PubU0T+0bGA75W3fqtuQUKRpGyfkIMeWNK33xWMGeecZ+mxLdZ0g
        m57hKCT5QymTnGfJFu9nj01A0sof5OU=
X-Google-Smtp-Source: APiQypJm5NmFFt4ddJZ2unGxgcpFJSWH6h7ZrKUbhtD9I0ntyGfmvd4sijIiDJ9tA56TT3GDOShGwQ==
X-Received: by 2002:a05:651c:1064:: with SMTP id y4mr897352ljm.49.1586889891702;
        Tue, 14 Apr 2020 11:44:51 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 4sm1820603ljf.79.2020.04.14.11.44.50
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 11:44:50 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 198so594598lfo.7
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 11:44:50 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr725139lfk.30.1586889890348;
 Tue, 14 Apr 2020 11:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
 <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
 <CAHk-=wi-s0mmLAVg-aSmNU55=cE8ES7mC=Mc3Wn62P8W9VjY-A@mail.gmail.com> <CAMj1kXE9046X9EDd636Bw1A9npv0QKAuLcTAzMXAn=JVZeCN0Q@mail.gmail.com>
In-Reply-To: <CAMj1kXE9046X9EDd636Bw1A9npv0QKAuLcTAzMXAn=JVZeCN0Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Apr 2020 11:44:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNWkTPvMnhoggNOig98=YvXULnq15Z07rQw-9YyVdx+w@mail.gmail.com>
Message-ID: <CAHk-=wjNWkTPvMnhoggNOig98=YvXULnq15Z07rQw-9YyVdx+w@mail.gmail.com>
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

On Tue, Apr 14, 2020 at 11:32 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> That is the quick fix, but Arvind is working on getting rid of
> __efistub_global entirely, and use the right linker foo to put .bss in
> .data.

Oh, that sounds even better. Yeah, a linker script fix to just make
.bss be in the executable is the right thing to do if we have
unreliable loaders.

Thanks,
             Linus
