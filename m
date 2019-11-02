Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFB1ECCDF
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2019 03:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKBC0T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Nov 2019 22:26:19 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:35234 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKBC0T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Nov 2019 22:26:19 -0400
Received: by mail-io1-f49.google.com with SMTP id h9so12903646ioh.2;
        Fri, 01 Nov 2019 19:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=km/bRRqzLSK+jYkK4Cv+iSycZzlFkGrMc7Hf3ZngsJQ=;
        b=SA9GgVQ2tSIzkTNSJ0i6PsQ/bNWbOcs5/Z9xR3SDkH/vqZw8SKwdlrVtQHUctvcA9F
         o8rVaPbF2ikSJNZ/riaPijDdixrl6+oMq8z6xNVOSxJpkaYpd870jUNjAT5oJ3oVPoYL
         xPJeLQekf5Rq94VfZuZYecC2aIJ/UWrFGbB17wJSro4l0a0jY/KHY/WVFO2plrtGKBhn
         0717FLIwcQ3jmcNawRowlCkuIIrL5VV1nEMb2et5eGblAbawfya6wGg55SpZKhU+aa+b
         Q6U4y/rnbhxJO8gwf9J0GMzHXtkamzlCB5b8gKfYMyOikhfk1P7rLdaCFWvi3bmPym8i
         eDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=km/bRRqzLSK+jYkK4Cv+iSycZzlFkGrMc7Hf3ZngsJQ=;
        b=pepfJcC1clE9osDufO25pgBT4wMe0EmeZPyRq9b1c6VWHYnA6a374CFMMkFtFgkcZN
         x3z0vqrvRhiKH36hzT8ZMzWW/LG3PkSaYGnZ8R36I36ht4kuu6uKQv0SD+g4grGZVuZ1
         YVk9/RpWqbyvQqs7nV5wGJwDoQJjOnYkBVcD3941LfHsEm4BQT56lfoCqJumUYlUwrQM
         iwwqxK6Zoe1rZaWNUI5hHaZSzeDpiQtNhqoHvYaHZFDlhJjcmzd9OGdLL24/BoWKD4Nb
         v3wA7oeIRONZlFhk6OlFh1GznBdoEtQAuimWhRFzHOUIxhT7KQjLFRDdxsy2XAL1HAIp
         8uwA==
X-Gm-Message-State: APjAAAUg/pUUX+phh5f8OvoFTk5GhLjad0L6oGHzW+ti5rSuYXlrStco
        n3nNZ8jq8hB9GlpHG/3yFZuFXQo6jaR4cXNYpSJYd7j9zpU=
X-Google-Smtp-Source: APXvYqwsxYiGowXq90USUBDJR75/1v4T+N1tzLJlspfc5iBedw3iuPuxluH9BJxqbCHvUfe22uvXr8AUydndzwo4KAA=
X-Received: by 2002:a6b:8b0a:: with SMTP id n10mr13154119iod.280.1572661576984;
 Fri, 01 Nov 2019 19:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOzgRdbjf7AkxXtgQ_ZxWU_QW2XqT+=CpSTBt0_T10+gynXtTw@mail.gmail.com>
 <CAOzgRdYLYB5eB2aNiGL7wuS5tvF7M8cEWiOqLFKcnMsWOe=zNA@mail.gmail.com>
In-Reply-To: <CAOzgRdYLYB5eB2aNiGL7wuS5tvF7M8cEWiOqLFKcnMsWOe=zNA@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Sat, 2 Nov 2019 10:26:03 +0800
Message-ID: <CAOzgRdbhSwY3GY8V-w3b41eA-vz7MatkCSX2RbOL5Lk-06ZtSg@mail.gmail.com>
Subject: Re: x86/boot: add ramoops.mem_size=1048576 boot parameter cause can't boot
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ram map

[ 0.000000] BIOS-provided physical RAM map:
[ 0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[ 0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[ 0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[ 0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001effffff] usable
[ 0.000000] BIOS-e820: [mem 0x000000001f000000-0x00000000201fffff] reserved
[ 0.000000] BIOS-e820: [mem 0x0000000020200000-0x00000000b6de7fff] usable
[ 0.000000] BIOS-e820: [mem 0x00000000b6de8000-0x00000000b6e08fff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000b6e09000-0x00000000ba608fff] usable
[ 0.000000] BIOS-e820: [mem 0x00000000ba609000-0x00000000ba698fff] type 20
[ 0.000000] BIOS-e820: [mem 0x00000000ba699000-0x00000000baf18fff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000baf19000-0x00000000bb018fff] ACPI NVS
[ 0.000000] BIOS-e820: [mem 0x00000000bb019000-0x00000000bb058fff] ACPI dat=
a
[ 0.000000] BIOS-e820: [mem 0x00000000bb059000-0x00000000bbffffff] usable
[ 0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e3ffffff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000feafffff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fed03000-0x00000000fed03fff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fed06000-0x00000000fed06fff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed09fff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1cfff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fedbffff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[ 0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[ 0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
[ 0.000000] NX (Execute Disable) protection: active
[ 0.000000] efi: EFI v2.40 by INSYDE Corp.
[ 0.000000] efi: ACPI 2.0=3D0xbb058014 SMBIOS=3D0xba6a9000 ESRT=3D0xba6ac91=
8
[ 0.000000] SMBIOS 2.8 present.
[ 0.000000] DMI: jumper EZpad/EZpad, BIOS Jumper8.S106x.A00C.1066 12/22/201=
5
[ 0.000000] tsc: Detected 1440.000 MHz processor
[ 0.000298] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> reserve=
d
[ 0.000302] e820: remove [mem 0x000a0000-0x000fffff] usable

youling 257 <youling257@gmail.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=882=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8810:23=E5=86=99=E9=81=93=EF=BC=9A
>
> only add ramoops.mem_size=3D1048576 boot parameter cause can't boot on
> my device, stop at booting command list, no anyting happen, no dmesg.
>
>
