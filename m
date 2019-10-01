Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C99C2F45
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2019 10:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbfJAIvv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 04:51:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41190 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfJAIvv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 04:51:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id g13so10840115otp.8;
        Tue, 01 Oct 2019 01:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvjWsAyb1mW3ZHQ5l3Ug/TQISxE7kDZyp64OCPfb4tg=;
        b=MR7kXXsOQsyfNFFivm8o5A9Y8S48RCuH4oORoJzoxHVr8l60fJRH5izMvlwuMF4zoF
         3BZZHK9YDlyWdgzXaE29r9GimSwke0EaAS4qgonJMd2FhFkvxSG/yYsELp02L7ZWpOnW
         3pt6iHB5GGJ/GG3XP2xTCxat3Lz1ZSpT3/TXc1eLI40SzO1LFk4j5xmnBtGcsvqBMb4O
         4GVUz/6xAGCXgDCFk3UmhH3bi78RRwl1nvTZ+AtzGfIYCNEB8A1mbGKCl3FhblqsPY4K
         YtkASZNCONoofdFritXo0TMYHciKlqF8hI0oR5RhAfvZGEEI4ii7143mf3ZhFowGv3sD
         slXw==
X-Gm-Message-State: APjAAAVBasRuWHNNTT2oWEAyQtVntcKeoqdIId0KOWU6X+k69e9D3uG7
        VS3GkUu+NX7n0Q5zrps5xjJjrY18oc1SiCSuYWE=
X-Google-Smtp-Source: APXvYqyZmrPht+MK46Tt7NiDZ5XKr/6fRfxeYSCXNQV3EpuN8UbJSvFfXh9be0ebAHjlfOkKMLi33g3EQStN9woWnJU=
X-Received: by 2002:a9d:7311:: with SMTP id e17mr1321582otk.107.1569919910603;
 Tue, 01 Oct 2019 01:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org> <20190812150452.27983-5-ard.biesheuvel@linaro.org>
In-Reply-To: <20190812150452.27983-5-ard.biesheuvel@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Oct 2019 10:51:39 +0200
Message-ID: <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to sysfs
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Narendra K <Narendra.K@dell.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard, Narendra,

On Mon, Aug 12, 2019 at 5:07 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> From: Narendra K <Narendra.K@dell.com>
>
> System firmware advertises the address of the 'Runtime
> Configuration Interface table version 2 (RCI2)' via
> an EFI Configuration Table entry. This code retrieves the RCI2
> table from the address and exports it to sysfs as a binary
> attribute 'rci2' under /sys/firmware/efi/tables directory.
> The approach adopted is similar to the attribute 'DMI' under
> /sys/firmware/dmi/tables.
>
> RCI2 table contains BIOS HII in XML format and is used to populate
> BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> The BIOS setup page contains BIOS tokens which can be configured.
>
> Signed-off-by: Narendra K <Narendra.K@dell.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks, this is now commit 1c5fecb61255aa12 ("efi: Export Runtime
Configuration Interface table to sysfs").

> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -180,6 +180,19 @@ config RESET_ATTACK_MITIGATION
>           have been evicted, since otherwise it will trigger even on clean
>           reboots.
>
> +config EFI_RCI2_TABLE
> +       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> +       help
> +         Displays the content of the Runtime Configuration Interface
> +         Table version 2 on Dell EMC PowerEdge systems as a binary
> +         attribute 'rci2' under /sys/firmware/efi/tables directory.
> +
> +         RCI2 table contains BIOS HII in XML format and is used to populate
> +         BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> +         The BIOS setup page contains BIOS tokens which can be configured.
> +
> +         Say Y here for Dell EMC PowerEdge systems.

A quick Google search tells me these are Intel Xeon.
Are arm/arm64/ia64 variants available, too?
If not, this should be protected by "depends on x86" ("|| COMPILE_TEST"?).

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
