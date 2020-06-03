Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7001ECD7F
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jun 2020 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgFCK0a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 06:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCK03 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Jun 2020 06:26:29 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E059220679
        for <linux-efi@vger.kernel.org>; Wed,  3 Jun 2020 10:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591179989;
        bh=AcvxDC7DtZQEzsen1S2AUaqnZdtvveNUigh+1RKfQxI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c4l+pn4CNdnNN7SoxFxwBJxMaKbWRL++VoytNMG1L0kVtU17tD9X0+X8yO4aS+mqz
         6kgpyEeRumd/k+TSoY1lH+AoDsEddELdUnvOLRr33f2nfgQC2PFRYuWObImTMsJvlk
         wbPFJsRqZkNJqn6AL4+RX83DWb8Kgi3hjbDUKZP0=
Received: by mail-oi1-f175.google.com with SMTP id x202so1318124oix.11
        for <linux-efi@vger.kernel.org>; Wed, 03 Jun 2020 03:26:28 -0700 (PDT)
X-Gm-Message-State: AOAM530vEHNstKxsPEFor24wZxYjEwAxE230NFZFYDAS6iMOG2ltu9d+
        diSpyaY94txmce9EpgO/vKEpwf+h4br96Na6MMY=
X-Google-Smtp-Source: ABdhPJwQcGu3Jo3TaykGClJHsO0yyK8Qs277UBk07JmBYD0YGxes5Paxk/9Fre/id/efztRxuMO81voSLmYtOYnn5u8=
X-Received: by 2002:aca:b887:: with SMTP id i129mr5479680oif.47.1591179988311;
 Wed, 03 Jun 2020 03:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200603100501.GA1843390@mwanda>
In-Reply-To: <20200603100501.GA1843390@mwanda>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 Jun 2020 12:26:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE7KgXBviF5epda7k4zani-rZo3tOD-a9k8hrFOLOL+mg@mail.gmail.com>
Message-ID: <CAMj1kXE7KgXBviF5epda7k4zani-rZo3tOD-a9k8hrFOLOL+mg@mail.gmail.com>
Subject: Re: [bug report] efi/libstub: Unify initrd loading across architectures
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 3 Jun 2020 at 12:05, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Arvind Sankar,
>
> The patch f61900fd0ebf: "efi/libstub: Unify initrd loading across
> architectures" from Apr 30, 2020, leads to the following static
> checker warning:
>
>         drivers/firmware/efi/libstub/efi-stub-helper.c:481 efi_load_initrd_cmdline()
>         error: we previously assumed 'image' could be null (see line 474)
>
> drivers/firmware/efi/libstub/efi-stub-helper.c
>    466  static
>    467  efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
>    468                                       unsigned long *load_addr,
>    469                                       unsigned long *load_size,
>    470                                       unsigned long soft_limit,
>    471                                       unsigned long hard_limit)
>    472  {
>    473          if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER) ||
>    474              (IS_ENABLED(CONFIG_X86) && (!efi_is_native() || image == NULL))) {
>                      ^^^^^^^^^^^^^^^^^^^^^^                         ^^^^^^^^^^^^^
> Assume X86 is not configured but "image" is NULL.
>
>    475                  *load_addr = *load_size = 0;
>    476                  return EFI_SUCCESS;
>    477          }
>    478
>    479          return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
>                                             ^^^^^
> Dereferenced inside the function.

image is guaranteed to be non-null on !x86 architectures.

>
>    480                                      soft_limit, hard_limit,
>    481                                      load_addr, load_size);
>    482  }
>
> regards,
> dan carpenter
