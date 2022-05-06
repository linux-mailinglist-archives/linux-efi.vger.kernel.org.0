Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2003151DCB9
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443307AbiEFQE4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443270AbiEFQEz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 12:04:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB4469CCB
        for <linux-efi@vger.kernel.org>; Fri,  6 May 2022 09:01:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o69so7394687pjo.3
        for <linux-efi@vger.kernel.org>; Fri, 06 May 2022 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJQuHSIAlHGIpor5c5dPdkEnVxEx8DbE7jmudCub3d4=;
        b=jQ7xZaZTB7N7rBpIHs/0CElGn01l9AQXdNaX6k8jXrAaJqQ25NEB9BM5bbodgfv0cZ
         o8v4laiuonAI3gk+YGqelG0OD+DVySSMRg63uSIqREDRrPhJMR3KSuT35wwaUS8YFYch
         rOrxpkfD5RuaAn4QY/2lg91WF1zOptOKzMP2JKXphcGymjOcFefW0nQQh9kP7UJMY1GG
         OiLAM9wX+KmK/RtQGaobXp58jVCwVZnXJF4OhYZCQMkQfwBS7mr1AOvo0j7jY7pfCkbU
         dUVjbhAvhfetI4VuQjiWvUUR2qZuZOW3KhYQrFs63jjEkTtnpgJAig8xUxU2zRQZBPk2
         my1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJQuHSIAlHGIpor5c5dPdkEnVxEx8DbE7jmudCub3d4=;
        b=2xyEgJWqw1XRX9kKQKamA/nZRg3Qeac9TqT2fEgAe7A3oLVxdp7WdUfu78hCCyA4ZC
         1jDlqbVAtxCLH/IJzIPF2b8wUqgTXIZWN8C4XanaboEgzHVeWL0W6y4qzBNXRhkewbHK
         OjaRiHQ/NKv05S+euO8dSlcOgrXIiaWB/ixYg9f/u5yEza1AqnReDOU1EGMwjgCVWsya
         wPLUzQuX8lzrNGy/dci5DC3/68qOcb9JcRuCxt+5IsH1wgRUOB408WD5RYuS7oRU9Cjh
         4SaJatq9s6quYXzHaYjijdAe1SslIyryqnrs2cBWqyqWdVEx6RklOoc7YOpwrL590wXz
         5mxw==
X-Gm-Message-State: AOAM53154WMsWd34kcj41PUTzzR45ssnN2ALw77VExvEK+RxMx/NwEtQ
        E9/sYca3SrhWxQ6l7307imz2DSrZaa26v7uYevAa2A==
X-Google-Smtp-Source: ABdhPJzetNCcmtdzsuA7MVysj4PUmFLJT04ZeXbzfGR3fv4T/RqwwNln8yT470KW1ll1x94sH07JlabaHewBC2MmUDk=
X-Received: by 2002:a17:902:da8b:b0:15e:c0e8:d846 with SMTP id
 j11-20020a170902da8b00b0015ec0e8d846mr4360481plx.34.1651852868602; Fri, 06
 May 2022 09:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
 <YnKr+aMf4PspDpHZ@zn.tnic> <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic> <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
In-Reply-To: <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 6 May 2022 09:00:57 -0700
Message-ID: <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do encryption
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 6, 2022 at 8:32 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/6/22 05:44, Borislav Petkov wrote:
> >> Dave Hansen pointed those out in a previuos patch serie, here is the
> >> quote:
> >>
> >>> CXL devices will have normal RAM on them, be exposed as "System RAM" and
> >>> they won't have encryption capabilities.  I think these devices were
> >>> probably the main motivation for EFI_MEMORY_CPU_CRYPTO.
> > So this would mean that if a system doesn't have CXL devices and has
> > TME/SME/SEV-* enabled, then it is running with encrypted memory.
> >
> > Which would then also mean, you don't need any of that code - you only
> > need to enumerate CXL devices which, it seems, do not support memory
> > encryption, and then state that memory encryption is enabled on the
> > whole system, except for the memory of those devices.
>
> CXL devices are just the easiest example to explain, but they are not
> the only problem.
>
> For example, Intel NVDIMMs don't support TDX (or MKTME with integrity)
> since TDX requires integrity protection and NVDIMMs don't have metadata
> space available.
>
> Also, if this were purely a CXL problem, I would have expected this to
> have been dealt with in the CXL spec alone.  But, this series is
> actually driven by an ACPI spec.  That tells me that we'll see these
> mismatched encryption capabilities in many more places than just CXL
> devices.

Yes, the problem is that encryption capabilities cut across multiple
specifications. For example, you might need to consult a CPU
vendor-specific manual, ACPI, EFI, PCI, and CXL specifications for a
single security feature.
