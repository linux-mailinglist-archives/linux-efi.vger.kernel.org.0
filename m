Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0314515A851
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2020 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgBLLxU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Feb 2020 06:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgBLLxU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Feb 2020 06:53:20 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 611F92082F
        for <linux-efi@vger.kernel.org>; Wed, 12 Feb 2020 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581508399;
        bh=B9hhoHU4d7e27Fk7vhI6em5grqyGpRsXt4c7RpLCCbs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x0h7tzdMHgS0U7KPw7/iskJ7vRuLzRtFpNv9vJdjH9BPxaos+GeTwVoGnLaOZ8CvD
         jUprSlquHzGTrOT8cPA6r30A0ipDoSuSw/V3ffk/uJuaCDmmRDHlafIWubhhBVjvzX
         dHYRMYZz2yMVggLyjQ4cCett5ZoAXyH5SG5Tgwdk=
Received: by mail-wm1-f49.google.com with SMTP id b17so2020822wmb.0
        for <linux-efi@vger.kernel.org>; Wed, 12 Feb 2020 03:53:19 -0800 (PST)
X-Gm-Message-State: APjAAAVSel+6umbc9xM3F1k46b0zTMODIjmDBD5zNivMSJ60oQiRSm4e
        6+hsJ1UpLhDv392haVtBSBL7Sfevm72jiYa5CE+8+A==
X-Google-Smtp-Source: APXvYqzyJ32tLjSgGvwjz8DmOxVlgEb8BIcWuheEnH+vWM9B27ckLGiPHjadXpkiwsSeO6Di6H6ar5xaOEDuj0VD3S4=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr12333925wmj.1.1581508397795;
 Wed, 12 Feb 2020 03:53:17 -0800 (PST)
MIME-Version: 1.0
References: <aaf658ab-82ff-4a35-2984-77150924d3a7@redhat.com>
In-Reply-To: <aaf658ab-82ff-4a35-2984-77150924d3a7@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Feb 2020 11:53:06 +0000
X-Gmail-Original-Message-ID: <CAKv+Gu9fh_reYp65QXCeL4X3iovrCQFGNZWS3jMkpveZLgre-A@mail.gmail.com>
Message-ID: <CAKv+Gu9fh_reYp65QXCeL4X3iovrCQFGNZWS3jMkpveZLgre-A@mail.gmail.com>
Subject: Re: New EFI thunk alignment WARN_ON in 5.6 triggers multiple times
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 12 Feb 2020 at 12:44, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ard,
>
> While booting 5.6-rc1 on one of my test machines I noticed the WARN_ON
> on line 198 of arch/x86/platform/efi/efi_64.c trigger many times.
>
> I've done some debugging on this an this is caused by the following
> call path:
>
> drivers/firmware/efi/vars.c: efivar_init():
>
>          unsigned long variable_name_size = 1024;
>          efi_char16_t *variable_name;
>          efi_guid_t vendor_guid;
>
>          variable_name = kzalloc(variable_name_size, GFP_KERNEL);
>          if (!variable_name) {
>                  printk(KERN_ERR "efivars: Memory allocation failed.\n");
>                  return -ENOMEM;
>          }
>
>         ...
>
>
>          do {
>                  variable_name_size = 1024;
>
>                  status = ops->get_next_variable(&variable_name_size,
>                                                  variable_name,
>                                                  &vendor_guid);
>         ...
>
> arch/x86/platform/efi/efi_64.c: efi_thunk_get_next_variable()
>
>         ...
>          phys_vendor = virt_to_phys_or_null(vendor);
>         ...
>
> arch/x86/platform/efi/efi_64.c: virt_to_phys_or_null_size()
>
>         ...
>         WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
>         ...
>
> Specifically the problem is that the efi_guid_t vendor_guid has an 8 bytes
> aligned address and the WARN_ON checks for it being aligned to\
> sizeof(efi_guid_t) which is 16 bytes.
>
> I've fixed this for now with the following local fix, but I'm not sure
> what the alignment rules actually are so I'm not sure this is correct:
>
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -181,6 +181,7 @@ static inline phys_addr_t
>   virt_to_phys_or_null_size(void *va, unsigned long size)
>   {
>         bool bad_size;
> +       int alignment;
>
>         if (!va)
>                 return 0;
> @@ -195,7 +196,8 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
>          */
>         bad_size = size > PAGE_SIZE || !is_power_of_2(size);
>
> -       WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
> +       alignment = size > 8 ? 8 : size;
> +       WARN_ON(!IS_ALIGNED((unsigned long)va, alignment) || bad_size);
>
>         return slow_virt_to_phys(va);
>   }
>
>
> I have a feeling that this is the right thing to do, but as said I'm not 100%
> sure. If you can confirm that this is the right fix, then I can submit this
> upstream.
>


It seems that the purpose of the alignment check is to ensure that the
data does not cross a page boundary, so that the data is guaranteed to
be contiguous in the physical address space as well.

So in that light, the fix is most definitely wrong, although I am not
sure how this is supposed to work generally.
