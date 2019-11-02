Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF26ECD7E
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2019 06:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKBFl1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 2 Nov 2019 01:41:27 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:33618 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKBFl1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 2 Nov 2019 01:41:27 -0400
Received: by mail-io1-f49.google.com with SMTP id n17so13147180ioa.0;
        Fri, 01 Nov 2019 22:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QBDErql//TWf4HGFiZIRJL9D655gxzXFYHFbWHCEoP8=;
        b=Cpc155Al/oQP+f9V7NRSIzj10uR6wo7G1+ARsUsJZlhkqVkg6aaxyyasyAKZy7LIEO
         L74ZISmWEhxEgH0t1Sf7pPC0o6fbSOn1Wmu39b1bSgMsZB9CSDCSLK4EU/bs1VmudPvt
         JWXZcRr5xxONHTiP+Yf1BMDqxwrdnO1yaZRq5isdNiKE1zfFG+uqxySYGQIlTBJuwcky
         gKO+jtkBvufdaCeHAILxcz0F3+YrOwpYujepsvqvAl6xA7Mp/yC4TrDngBxGLqVFAP5t
         EGo3GKTP8/qAjD75it7eIBVxILc7jjubFOnJnwXpABSgAV1GsSTeWglLGCuAweyO7Gjm
         db8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=QBDErql//TWf4HGFiZIRJL9D655gxzXFYHFbWHCEoP8=;
        b=GvdreWuAEiUYCzvSgIR8QEZZiQfS2Q+oil9Fz3oES6X9EJVWcx9bJ4AYJTI93Zk+gH
         jGOiCihPlDEh2TkM4C9ncFCxqx65ipaopJZU+FFhCz2aF3SnoVaQbwHQ4IBzAkfi7jJr
         p8fMXD98xxHH9n03tePyAwNCRGQiVF1shj/XsWN5ORNCvAcx33AP9SuhXdjvOI1ujONt
         1rT65TFJFIvF00Vtricc6QC30NJZX+RUKXBYhYyB9j8YdF2NafjXt56/N3aqyLVuAWhv
         r3AsuY26/yehnVjFIWltSYmS7pUePhd/dmgRuIctNwjMame8aP1/yEDhoaW6qXDrFwit
         9qFw==
X-Gm-Message-State: APjAAAV6zn0Apbyy2Nakzb7gSNsT+jetcezeJvgMIVqaXk879bP9NxSh
        7KsAWRCfI+Vo9s4qGXr6mJRe115huP+/ru1DHG00MxSC
X-Google-Smtp-Source: APXvYqx7G+KPCLOJaoIc56cJKepKN7LB8qxj7Muv4L2UHxT5LV+z0akTqIn7ECLMR5A7Q28Q276XoyrfIdMXyO2r9/M=
X-Received: by 2002:a02:1948:: with SMTP id b69mr11490135jab.30.1572673284276;
 Fri, 01 Nov 2019 22:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOzgRdbjf7AkxXtgQ_ZxWU_QW2XqT+=CpSTBt0_T10+gynXtTw@mail.gmail.com>
 <CAOzgRdYLYB5eB2aNiGL7wuS5tvF7M8cEWiOqLFKcnMsWOe=zNA@mail.gmail.com> <CAOzgRdbhSwY3GY8V-w3b41eA-vz7MatkCSX2RbOL5Lk-06ZtSg@mail.gmail.com>
In-Reply-To: <CAOzgRdbhSwY3GY8V-w3b41eA-vz7MatkCSX2RbOL5Lk-06ZtSg@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Sat, 2 Nov 2019 13:41:08 +0800
Message-ID: <CAOzgRdaBukdDtCuYQe3wvAgtXmRrbtXcj6yD4bJvqO2xQmO+tA@mail.gmail.com>
Subject: Re: x86/boot: add ramoops.mem_size=1048576 boot parameter cause can't boot
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On my v891w, i add "memmap=3D1M!2047M ramoops.mem_size=3D1048576
ramoops.ecc=3D1 ramoops.mem_address=3D0x7ff00000
ramoops.console_size=3D16384 ramoops.ftrace_size=3D16384
ramoops.pmsg_size=3D16384 ramoops.record_size=3D32768" boot parameter,
[ 0.483935] printk: console [pstore-1] enabled
[ 0.484034] pstore: Registered ramoops as persistent store backend
[ 0.484121] ramoops: using 0x100000@0x7ff00000, ecc: 16

But on my ezpad 6 m4, i add "memmap=3D1M!4095M ramoops.mem_size=3D1048576
ramoops.ecc=3D1 ramoops.mem_address=3D0xfff00000
ramoops.console_size=3D16384 ramoops.ftrace_size=3D16384
ramoops.pmsg_size=3D16384 ramoops.record_size=3D32768" boot parameter, it
can't boot, stop at "boot command list", no anyting happen, no dmesg.
I test boot parameter one by one, just add ramoops.mem_size=3D1048576,
will cause can't boot.

youling 257 <youling257@gmail.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=882=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8810:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Ram map
>
> [ 0.000000] BIOS-provided physical RAM map:
> [ 0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
> [ 0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI N=
VS
> [ 0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
> [ 0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001effffff] usable
> [ 0.000000] BIOS-e820: [mem 0x000000001f000000-0x00000000201fffff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x0000000020200000-0x00000000b6de7fff] usable
> [ 0.000000] BIOS-e820: [mem 0x00000000b6de8000-0x00000000b6e08fff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000b6e09000-0x00000000ba608fff] usable
> [ 0.000000] BIOS-e820: [mem 0x00000000ba609000-0x00000000ba698fff] type 2=
0
> [ 0.000000] BIOS-e820: [mem 0x00000000ba699000-0x00000000baf18fff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000baf19000-0x00000000bb018fff] ACPI N=
VS
> [ 0.000000] BIOS-e820: [mem 0x00000000bb019000-0x00000000bb058fff] ACPI d=
ata
> [ 0.000000] BIOS-e820: [mem 0x00000000bb059000-0x00000000bbffffff] usable
> [ 0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e3ffffff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000feafffff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000fed03000-0x00000000fed03fff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000fed06000-0x00000000fed06fff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed09fff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1cfff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fedbffff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserv=
ed
> [ 0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
> [ 0.000000] NX (Execute Disable) protection: active
> [ 0.000000] efi: EFI v2.40 by INSYDE Corp.
> [ 0.000000] efi: ACPI 2.0=3D0xbb058014 SMBIOS=3D0xba6a9000 ESRT=3D0xba6ac=
918
> [ 0.000000] SMBIOS 2.8 present.
> [ 0.000000] DMI: jumper EZpad/EZpad, BIOS Jumper8.S106x.A00C.1066 12/22/2=
015
> [ 0.000000] tsc: Detected 1440.000 MHz processor
> [ 0.000298] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> reser=
ved
> [ 0.000302] e820: remove [mem 0x000a0000-0x000fffff] usable
>
> youling 257 <youling257@gmail.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=882=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8810:23=E5=86=99=E9=81=93=EF=BC=9A
> >
> > only add ramoops.mem_size=3D1048576 boot parameter cause can't boot on
> > my device, stop at booting command list, no anyting happen, no dmesg.
> >
> >
