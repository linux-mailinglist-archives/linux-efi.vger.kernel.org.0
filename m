Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181F7D10EA
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2019 16:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfJIOLX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 10:11:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54890 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIOLT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Oct 2019 10:11:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so2800422wmp.4
        for <linux-efi@vger.kernel.org>; Wed, 09 Oct 2019 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IfzmZhp36WpTVFDJFrKg1q1OTVja9xjnVrTlka/Jkoc=;
        b=rXBWxnxtuK+619VAVXoKS+DxsBa9UqJ7nfRNBcS2Sz4XI5ZQ6Hw8QwSDlqpW05k9eA
         u9gld6jlBbewvfS51nf5OFVC/a+LQIB6CuaaXNjWixic5MnQZvut2Bv+qWHX2LVAC4k0
         fHt9MT4y8YaPU1k2ecpQ1spQAjEqNJ9n8x8fx1LKnzmuemvO+UXUJv1/TouqPyZwO+KG
         nERyMqKdNVU2hHZLDMJ/Ehy9tnUAF0umDOwh8zb8aITfSgaY8toVe4iwMQx9PSwQHa4D
         6arjQMc6CsuR3/NeKO1u3tNpuCCorVcoglK8+XO7sO2mad/ddObthg86fus9JfH2XK94
         qxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfzmZhp36WpTVFDJFrKg1q1OTVja9xjnVrTlka/Jkoc=;
        b=XqdT4lt470tOg0jDezo5nqpwM+/6fXvFtGrngbBYXjezHQqHwCyZaYcIHl20OyYzF+
         3OBFL3pdqw1jP8+OGaExAEMfGFdGQiZFMrVBVT7j4/6mxay4io7kPdUYVLZdKBXn+BaU
         hozM1GiacKzRG2j8N45BkQa18jq4dow/oXyG8SI7fk1W5Dpv+tshw/8NW57IQdygb8nb
         q6ux4XD4jEDLP7nsf6c6jLZ7OLW75Ung7QQJI05LtxcCo0hjNz3OJGG5LA7GYEys+Xll
         92d5cEf1Y4m1qWn/vna2sP3k0vhoSNbm7h6xx7ABS81VxJ1/F87PhjWuUR98rVssiucT
         2ZSA==
X-Gm-Message-State: APjAAAU+SWMuMmslRVzhieCLQ5b6umgc+jeK0x9LHvp4tQdqfXsdlr71
        36xCjwprABu8Js7rO9FEJ4vtOOeBZJjpwtEcEj8l4+EblbXqIg==
X-Google-Smtp-Source: APXvYqwDjV9Fg1lr9K+PEMuIeJ8FN7Fcu2NkkOGfxXp13qEHX+6TJYJ7EfF6XxgXCEW3E2563Mm8g5LqtpMA35qiQg0=
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr2945175wml.10.1570630276021;
 Wed, 09 Oct 2019 07:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191002194346.GA3792@localhost.localdomain>
In-Reply-To: <20191002194346.GA3792@localhost.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 9 Oct 2019 16:11:04 +0200
Message-ID: <CAKv+Gu9_xX3RgDNGB=T83vhg_snMKe0F2YPKp1S2o2toNHHZZQ@mail.gmail.com>
Subject: Re: [PATCH] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
To:     Narendra K <Narendra.K@dell.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Narendra,

On Wed, 2 Oct 2019 at 21:44, <Narendra.K@dell.com> wrote:
>
> From: Narendra K <Narendra.K@dell.com>
>
> For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
> for input as it is a new kconfig option in kernel version 5.4. This patch
> modifies the kconfig option to ask the user for input only when CONFIG_X86
> or CONFIG_COMPILE_TEST is set to y.
>
> The patch also makes EFI_RCI2_TABLE kconfig option depend on CONFIG_EFI.
>
> Signed-off-by: Narendra K <Narendra.K@dell.com>
> ---
> The patch is created on kernel version 5.4-rc1.
>
> Hi Ard, I have made following changes -
>
> - changed the prompt string from "EFI Runtime Configuration
> Interface Table Version 2 Support" to "EFI RCI Table Version 2 Support"
> as the string crossed 80 char limit.
>
> - added "depends on EFI" so that code builds only when CONFIG_EFI is
> set to y.
>
> - added 'default n' for ease of understanding though default is set to n.
>

None of these changes are necessary, tbh. 'depends on EFI' is implied
by the placement of the option, and default n is indeed the default.


>  drivers/firmware/efi/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 178ee8106828..6e4c46e8a954 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -181,7 +181,10 @@ config RESET_ATTACK_MITIGATION
>           reboots.
>
>  config EFI_RCI2_TABLE
> -       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> +       bool
> +       prompt "EFI RCI Table Version 2 Support" if X86 || COMPILE_TEST

You can drop the || COMPILE_TEST as well.
> +       depends on EFI
> +       default n
>         help
>           Displays the content of the Runtime Configuration Interface
>           Table version 2 on Dell EMC PowerEdge systems as a binary
> --
> 2.18.1
>
> --
> With regards,
> Narendra K
