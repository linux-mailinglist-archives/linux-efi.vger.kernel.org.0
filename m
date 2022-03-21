Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859FF4E2408
	for <lists+linux-efi@lfdr.de>; Mon, 21 Mar 2022 11:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbiCUKL3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Mar 2022 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiCUKL3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Mar 2022 06:11:29 -0400
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 03:10:04 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A14E694B0
        for <linux-efi@vger.kernel.org>; Mon, 21 Mar 2022 03:10:03 -0700 (PDT)
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M7s1M-1nSPQK0PmE-0050Iu; Mon, 21 Mar 2022 11:04:54 +0100
Received: by mail-wm1-f49.google.com with SMTP id j13-20020a05600c1c0d00b0038c8f94aac2so3793118wms.3;
        Mon, 21 Mar 2022 03:04:53 -0700 (PDT)
X-Gm-Message-State: AOAM532x53b4mI0pNF8Qfs3glIUYpZjGPMil69+jK+hRMkCEHhC9Ui54
        FGuwoGmQOzwiZ/LDOIDxy+bswmMl9c5/4tpALOs=
X-Google-Smtp-Source: ABdhPJxjEc9bzYesuwCKdzUo5YCU+Maot3VI/4zz2PDoJ/C9nonejO7aSCHEJYC3ozg6TMkFNtWWtvUlXTjVI63bZYY=
X-Received: by 2002:a05:600c:4b83:b0:38c:49b5:5bfc with SMTP id
 e3-20020a05600c4b8300b0038c49b55bfcmr24295350wmp.33.1647856738182; Mon, 21
 Mar 2022 02:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-2-chenhuacai@loongson.cn>
In-Reply-To: <20220319143817.1026708-2-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 10:58:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a11-cRsFDYv-NzqWtWV3h8=xYoHGf_V33BhSRDBFPDXpA@mail.gmail.com>
Message-ID: <CAK8P3a11-cRsFDYv-NzqWtWV3h8=xYoHGf_V33BhSRDBFPDXpA@mail.gmail.com>
Subject: Re: [PATCH V8 09/22] LoongArch: Add boot and setup routines
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NTZYbBHtfGesGoqv+h7F2I5E/pFV1xoBScyg3KX17CM+0GiB9R0
 fZXoaQoX5QibEzLioznve/rxBrR/zHG1e4OTpJEgvt/63BfTGS4vkEEyRaBHT8MIa8ILEij
 j7/SOVTids1h5/FgAhguIUaBIN/KtG84ykr7I3rL8j4uFd+1OGY0e/jwRzFg+qjyKrCKTEi
 2ejdlGw/Ax+vRwSm9I1pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:96RDr76jcCU=:EZNfrE6tqcPabrz3Y5LZI4
 ygQ8Z/fa0WtTYK6dC71R5w8FKQETTuSCBXAMm9/G700ZwJwedwDApUuVpg9OwhqdEtKcmY9Wo
 BJQSBLLtjesNm0ZrZ79JUmq0Ex+k+Ch+sDIalQgouuiwETu10cFE/QMGUaeNmS9Ito+Ofd2LC
 mgew5lb8gC1dDjccsy1wPZGrN09MaRr1bX2iRplIAPAkbFY/ojBetcL208eQthWKEdReyUe7b
 Uc3FB1h1G7UCRpWDRCUl8Od4AVL2YrFSGF7DUhs3PcQ0GRgV/vu3M2VXPIhYKvnaEzsybSLV5
 ytfYwJja6t9ZlG9jvE2SkW0LVTIBsnqtmeuuoLy/SbKCISg92JXsvjBxQjOOOS48zTDGPmit+
 iL+ZX38SaO4G7U4Aagtu9Y77FYptuGnpNbDQsGmKsempyutcCbXulnRGbzXrm6XSKVrxW+Ggj
 vqB8v/QDigQVWZ9BzOe5rU+1Gv9iR3/MoDVpRovGvckfuyNRc/NkVvNsATeP++hgQFVuGtP8/
 +ZRNDV9edkO6ll1u0pA26zyVid/lJfL7/nWJ8K92P/+Wh+P5aTEvoUk/0GdITskxzBl1s7DUr
 y6Sez8GbTFdDeRSK/HgR5cYhEtk1++o/N7U32i65u6pJfRw5iq5sYB5WBGnzFo91Oa3nTqmPm
 IMA2cRNJSnq8RXKmrkBAdoppUcEEiM+SNXs911SUXA8gNuLc7i1QH14QXuxYgiKMID4NzOAq9
 Yr1BRRFPwVyV9199Eo6VrfE4IWyKeA4y58WNmDfF7nxqbAlDgrAceB6eFgXJd0guvH6xVW5K+
 qfDE5X+TDlGOpHJGgwrXsaWUGMdmYiPr5hsG6jSLznnKqHo1CA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> This patch adds basic boot, setup and reset routines for LoongArch.
> LoongArch uses UEFI-based firmware. The firmware uses ACPI and DMI/
> SMBIOS to pass configuration information to the Linux kernel.
>
> Now the boot information passed to kernel is like this:
> 1, kernel get 3 register values (a0, a1 and a2) from bootloader.
> 2, a0 is "argc", a1 is "argv", so "kernel cmdline" comes from a0/a1.
> 3, a2 is "environ", which is a pointer to the "struct boot_params".
> 4, "struct boot_params" include a "systemtable" pointer, whose type is
>    "efi_system_table_t". Most configuration information, include ACPI
>    tables and SMBIOS tables, come from here.
>
> The above interface is an internal interface between bootloader (grub,
> efistub, etc.) and the raw kernel. You can use this method to boot the
> Linux kernel in raw elf format, but it is recommend to use the standard
> UEFI boot protocol when efistub is added later.
>
> ECR for adding LoongArch support in ACPI:
> https://mantis.uefi.org/mantis/view.php?id=2203
>
> ECR for adding LoongArch support in ACPI (version update):
> https://mantis.uefi.org/mantis/view.php?id=2268
>
> ECR for adding LoongArch support in UEFI:
> https://mantis.uefi.org/mantis/view.php?id=2313
>
> ACPI changes of LoongArch have been approved in the last year, but the
> new version of ACPI SPEC hasn't been made public yet. And UEFI changes
> of LoongArch are under review now.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

I think this is still the most controversial bit of the series, and my
feeling is that it would be better to have the UEFI stub bits in place
first, so the custom entry point can be avoided completely.

Unfortunately I don't have access to mantis.uefi.org, can you
explain what the current status is? Are there still ABI relevant
decisions that need to be made about the UEFI entry point?

If the timing works out, the best approach may be to instead send
a draft version of the UEFI wrapper based boot implementation
for review now, so it can be merged once the standard has found
consensus. Having the code openly accessible should also help
with speed up the review.

         Arnd
