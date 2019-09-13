Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40ADAB26C9
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2019 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbfIMUnz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Sep 2019 16:43:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41822 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388262AbfIMUnz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Sep 2019 16:43:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id w17so3757925oiw.8
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2019 13:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOAUX4OdLpvo9WBZDLLsREmtWOFwmYmLGnIHP0wTxJg=;
        b=FNPVEbbUgChfq2Et92FLukPrI0Ko5FIwjYGbGaIthuaUp6cj/KZh1K5INM6fmarDAF
         2j81KsIy5HT6vJ8wcaMBkthk28s4y3RUf8LNFioYxMSqVUYSQIySzLUJwTi7davloXPF
         ieSg5/GlYQMurJUp//hCHmVB7pAs6oYAHSMn2vEQ7NPw4oyZXnScEe+36+k3T6TtXUh/
         KzArSqNeHx+ZfkPWBtW8NBcBkyRAH2ZlsXIQbZJaH2ZoUK+rFJ2pnQY9eTEZRBtzv3wW
         VHA5CdViLIHcDBhXGmPpwVXv90woHPdEdahns75QbRuWc8eB79aIjaYXOVKjytYqcbhZ
         mJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOAUX4OdLpvo9WBZDLLsREmtWOFwmYmLGnIHP0wTxJg=;
        b=Hl01gkS3h1L+QImjQdn8vOHd/DGL2K8KVRDUiCyNLK7ETDdk0Uzk4Vwfr+BUB4IQlp
         dvfyDrigx79a6Qiml/MU91djieqx9BeglfL+WbAlzIkzLfJWrteQEnJGkpUJzrEC1Cls
         bH/ETkVLJdeFV/Q6smXzYxo73KKgUPISPWcto/1dr8ZsYdKEEpJt4tifwAplMS4HLUMI
         kd9JMBNLzYlbyctS5EGBuNDljvOFPEavXgiBy/PYjq+k0d0ityOEECxtLMjJkDv2a3S6
         9PTVSPHG7mjuj+vvy0Gus625eC+OVrZpl82onbFmHebB+Sl1gTh7DBbPvuvc6saC2iMR
         I/4Q==
X-Gm-Message-State: APjAAAXZLZsn02x1X4fcih6hN00T58vhVquMCWN6IEVTQpHUhb1lCWwS
        1r/ZT/SmsHciaNlqGNfSLF4cIcrhYJiDn1UiJL13nQ==
X-Google-Smtp-Source: APXvYqxUiyLctoyFRhF21T9ndQ4dGulfc4iDnHPJOrxuNoKnHrPQPdxE8GNpAd5B0JU02LHWbT6/iFfR6ZReTjR9HcI=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr4055623oia.70.1568407434384;
 Fri, 13 Sep 2019 13:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712996407.1616117.11409311856083390862.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu_Bg-siUDodOu26GQO2L0xEJXxPZehPJtd0FRhD=-ubJw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_Bg-siUDodOu26GQO2L0xEJXxPZehPJtd0FRhD=-ubJw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 Sep 2019 13:43:42 -0700
Message-ID: <CAPcyv4jPsLNVNm4mAbhZe07eWX+ztrovHEmT=Wt2pBxOCe14aQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] x86, efi: Add efi_fake_mem support for EFI_MEMORY_SP
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

On Fri, Sep 13, 2019 at 12:49 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 30 Aug 2019 at 03:07, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> ...
> > diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> > index 4ac2de4dfa72..d7a6db03ea79 100644
> > --- a/drivers/firmware/efi/Makefile
> > +++ b/drivers/firmware/efi/Makefile
> > @@ -20,13 +20,16 @@ obj-$(CONFIG_UEFI_CPER)                     += cper.o
> >  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
> >  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
> >  obj-$(CONFIG_EFI_STUB)                 += libstub/
> > -obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_mem.o
> > +obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_map.o
> >  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)   += efibc.o
> >  obj-$(CONFIG_EFI_TEST)                 += test/
> >  obj-$(CONFIG_EFI_DEV_PATH_PARSER)      += dev-path-parser.o
> >  obj-$(CONFIG_APPLE_PROPERTIES)         += apple-properties.o
> >  obj-$(CONFIG_EFI_RCI2_TABLE)           += rci2-table.o
> >
> > +fake_map-y                             += fake_mem.o
> > +fake_map-$(CONFIG_X86)                 += x86-fake_mem.o
> > +
>
> Please use
>
> fake-mem-$(CONFIG_X86) := x86-fake_mem.o
> obj-$(CONFIG_EFI_FAKE_MEMMAP) += fake_mem.o $(fake-mem-y)

Ok, looks good.

>
> instead, and please use either - or _ in filenames, not both.

Fair enough.
