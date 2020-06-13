Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FEE1F8436
	for <lists+linux-efi@lfdr.de>; Sat, 13 Jun 2020 18:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgFMQGy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Jun 2020 12:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgFMQGx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 13 Jun 2020 12:06:53 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2AFB2078A
        for <linux-efi@vger.kernel.org>; Sat, 13 Jun 2020 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592064412;
        bh=7x+6fP434Cp/JtSs3u/y8MLI5F0L1lAPbpIcfx9uB+8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XFiTkrE3zg1aX7D2ief+djG8uoRxNYfhD5D5+PSaS/LzTGDLnHkPNNXCHr2cal5kU
         XlIAiG/4mkznSM68YNSPRV6nRJT+8LcySh3/m084L/BI4KZYYxhEEPyGhXEGQf0evv
         9eG6seer/Ugl+Wkx9IGujQOT4bWf56DN+uREAgsE=
Received: by mail-oi1-f174.google.com with SMTP id a3so11767499oid.4
        for <linux-efi@vger.kernel.org>; Sat, 13 Jun 2020 09:06:52 -0700 (PDT)
X-Gm-Message-State: AOAM533UDxFoKQhAkZqzEENxj4xwTLmq75HcWRa2X64HJPZTwwLCLICn
        MUdt2IjmQsSnLDIkS5OHu34+hHkQwQgcqHiFK4k=
X-Google-Smtp-Source: ABdhPJxuvNw4zQZJZUA9LySFuiJ0k+2zLX1/ZccWllHP8JElqpFIXxl7WYUARurGGuTJAbpmUK4kZ01gyMUtpw6sXzc=
X-Received: by 2002:aca:c256:: with SMTP id s83mr3351613oif.174.1592064412186;
 Sat, 13 Jun 2020 09:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <D81D56F9-9451-4048-8484-1BEBAA07099A@oracle.com>
In-Reply-To: <D81D56F9-9451-4048-8484-1BEBAA07099A@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 13 Jun 2020 18:06:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHhnaGCQhu7+ct3dKWvht+O0gi2Ksn+FUZdNzc=vcfc6g@mail.gmail.com>
Message-ID: <CAMj1kXHhnaGCQhu7+ct3dKWvht+O0gi2Ksn+FUZdNzc=vcfc6g@mail.gmail.com>
Subject: Re: v5.8 EFI firmware driver does not compile on EL7.8-based systems
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 13 Jun 2020 at 18:04, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi-
>
> I pulled the top of Linus's repo this morning. Reporting this in case
> you are not already aware, and to ask: Is there a new minimum gcc
> version requirement for building the v5.8 kernel? v5.7 builds fine.
> If you need me to, I can bisect.
>
> [cel@manet linux]$ rebuild
> Building with 13 threads
> In file included from /home/cel/src/linux/linux/drivers/firmware/efi/libs=
tub/efi-stub-helper.c:19:0:
> /home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c:=
 In function =E2=80=98efi_char16_puts=E2=80=99:
> /home/cel/src/linux/linux/drivers/firmware/efi/libstub/efistub.h:52:51: s=
orry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args o=
r subtarget optimization implying it
>  #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
>                                                    ^
> /home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c:=
37:2: note: in expansion of macro =E2=80=98efi_call_proto=E2=80=99
>   efi_call_proto(efi_table_attr(efi_system_table, con_out),
>   ^
> /home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c:=
37: confused by earlier errors, bailing out
> Preprocessed source stored into /tmp/ccWY8q9X.out file, please attach thi=
s to your bugreport.
> make[5]: *** [drivers/firmware/efi/libstub/efi-stub-helper.o] Error 1
> make[4]: *** [drivers/firmware/efi/libstub] Error 2
> make[3]: *** [drivers/firmware/efi] Error 2
> make[2]: *** [drivers/firmware] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [drivers] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [__sub-make] Error 2
> 3132.08user 498.43system 5:08.21elapsed 1177%CPU (0avgtext+0avgdata 45151=
6maxresident)k
> 3488inputs+6959272outputs (7major+90023497minor)pagefaults 0swaps
> [cel@manet linux]$ cat /etc/redhat-release
> Red Hat Enterprise Linux Server release 7.8 (Maipo)
> [cel@manet linux]$  gcc --version
> gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.3)
> Copyright (C) 2015 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is N=
O
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
> [cel@manet ~]$
>

Hey Chuck,

A fix for this issue has been sent to the list already. It should be
going into mainline somewhere during the week.

https://lore.kernel.org/bpf/20200605150638.1011637-1-nivedita@alum.mit.edu/
