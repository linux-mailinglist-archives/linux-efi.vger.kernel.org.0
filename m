Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F1EB2640
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2019 21:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfIMTtF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Sep 2019 15:49:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33661 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfIMTtF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Sep 2019 15:49:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so33232748wrr.0
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2019 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3F1+Vd20qQHEAMcsaqDBeShk2k2fZrIc64DNNthuGjM=;
        b=szixyBRl+Ziz3JuFg1c7zut06tg+5tBym303ch5PIVdtP3ToNDCecxq9r+lT6LRLKY
         JNxu3pMX9VLQAhngWbDKzdMVqMdiIuZgRR7c4YyyK18s/Y0OJXdY5tB9LmCry5iHR24Q
         d6KtnwaMQmk/Cs/PQVIU4WDlVduyqczq/vHFSSXiaJ0stkTD5ctl1dFQWqCeaZsm2HSb
         mm89C2XzWCvmpFyEtpc8/uDhE1gnzisBmxhOMNmZ/9LCO0DdZBCSIiD2KYcXRz+9UH+N
         lTeWQqUo1Ht/QGKF2EdfNtiolCMxdFXinquCv90bMrYrm50C4h+DIW/GxD169vdyE9RA
         l40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3F1+Vd20qQHEAMcsaqDBeShk2k2fZrIc64DNNthuGjM=;
        b=lXtUq8KPwoNMhH5+EYQWwi6rFpG+okwv4ZrN4lzKVOHf8ARBL+0g8OPY4fhvIwASQA
         zOUjWgjvmJBcbdkXsW+uSrs/YUw4DpCNffvZxPPmvP2PkJtCBiNiDeUslHNYOMluczuF
         owS7I1omEbsxZHCVI5/Fz9ylp2ZamCDOs5LAA8I8mhbWfQnWCTgvP3YYqB+5Up2Dqww6
         L8QRBXN201IBlQCEv5jr+lSECnZPTw3nsltX8epnoEiZs+3PDodRXoVzYQ86MqhUXnRp
         nIwRucV+hI7aFXep4bkdpCAk7wbE6AkAN0lXLPQ7xsgMjrI68BRfeiJ6EIE3WZsJiEEb
         u7nw==
X-Gm-Message-State: APjAAAV+0StoP+JykyuQNOVDW/czH4PBC+6UX+S5Yj5eJg54+WJcL+il
        LnXyr9sepg6h6aMX8lohcDcapzSMd9wypM+8M1cFPw==
X-Google-Smtp-Source: APXvYqx8w1+GO1+fmabltVM+trq9DqeCKeWrLUAxVIW//lvPpzUqvWWtltEQb9WQQDrAT6HuUAOAOjUxrpjD0cbuyLs=
X-Received: by 2002:a5d:638f:: with SMTP id p15mr4492201wru.169.1568404143136;
 Fri, 13 Sep 2019 12:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712996407.1616117.11409311856083390862.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156712996407.1616117.11409311856083390862.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Sep 2019 20:48:39 +0100
Message-ID: <CAKv+Gu_Bg-siUDodOu26GQO2L0xEJXxPZehPJtd0FRhD=-ubJw@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] x86, efi: Add efi_fake_mem support for EFI_MEMORY_SP
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 30 Aug 2019 at 03:07, Dan Williams <dan.j.williams@intel.com> wrote:
>
...
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index 4ac2de4dfa72..d7a6db03ea79 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -20,13 +20,16 @@ obj-$(CONFIG_UEFI_CPER)                     += cper.o
>  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
>  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
>  obj-$(CONFIG_EFI_STUB)                 += libstub/
> -obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_mem.o
> +obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_map.o
>  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)   += efibc.o
>  obj-$(CONFIG_EFI_TEST)                 += test/
>  obj-$(CONFIG_EFI_DEV_PATH_PARSER)      += dev-path-parser.o
>  obj-$(CONFIG_APPLE_PROPERTIES)         += apple-properties.o
>  obj-$(CONFIG_EFI_RCI2_TABLE)           += rci2-table.o
>
> +fake_map-y                             += fake_mem.o
> +fake_map-$(CONFIG_X86)                 += x86-fake_mem.o
> +

Please use

fake-mem-$(CONFIG_X86) := x86-fake_mem.o
obj-$(CONFIG_EFI_FAKE_MEMMAP) += fake_mem.o $(fake-mem-y)

instead, and please use either - or _ in filenames, not both.
