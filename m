Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C81B83FA
	for <lists+linux-efi@lfdr.de>; Sat, 25 Apr 2020 08:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDYG7t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Apr 2020 02:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYG7t (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 25 Apr 2020 02:59:49 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA1C20857
        for <linux-efi@vger.kernel.org>; Sat, 25 Apr 2020 06:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587797988;
        bh=xP+Doeb7Nm04wbQgrPY5GdoUqTHUi3Y0noFsVbvxk+M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SbyIbHIIYauYY+YfGG7K/OyJpy4exua9XEid0ws5MYUaUi1e5vMozGZRdVy0/AcJD
         +CBVC4gmyBZUkegG2Imoz2LrlaXg2UkMT/cCWGcZmNzxNFPEs1m/omdK6mj3KEiuse
         clCnew5e5RdNCeAQgQfKC7Jh3BuulKAxkmOO3kiU=
Received: by mail-io1-f44.google.com with SMTP id y26so3017625ioj.2
        for <linux-efi@vger.kernel.org>; Fri, 24 Apr 2020 23:59:48 -0700 (PDT)
X-Gm-Message-State: AGi0PubXzDgVQkasazrYZF8v7fC4Y76Hc9y6ZcF/9DE4CRIBkMzSro78
        jZv4L7L06nT+pK775hKoJgsRBZNSV7hgAVVckRk=
X-Google-Smtp-Source: APiQypJxGA31QH+VMOUnWKqs0JxIMjjkZ0t3Kh9L05SQbSbT5N6GqqQSBiWl70Ujw1AW8RFSFedbXY7g9Nyl7ytmsW4=
X-Received: by 2002:a02:8247:: with SMTP id q7mr10993198jag.68.1587797988078;
 Fri, 24 Apr 2020 23:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <202004250859.zJ89lvJs%lkp@intel.com>
In-Reply-To: <202004250859.zJ89lvJs%lkp@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 25 Apr 2020 08:59:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHXKxddNByRME9GAHrK69vbyYZ+Zj1PDFXc85x6UHzeZQ@mail.gmail.com>
Message-ID: <CAMj1kXHXKxddNByRME9GAHrK69vbyYZ+Zj1PDFXc85x6UHzeZQ@mail.gmail.com>
Subject: Re: [efi:next 2/33] drivers/firmware/efi/libstub/efistub.h:680:44:
 sparse: sparse: incorrect type in argument 2 (different type sizes)
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 25 Apr 2020 at 02:02, kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> head:   4eb8320bd1aaa7e69d039f2c251735e3ef0b9a38
> commit: cf6b83664895a5c7e97710df282e220bd047f0f5 [2/33] efi/libstub: Make initrd file loader configurable
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-191-gc51a0382-dirty
>         git checkout cf6b83664895a5c7e97710df282e220bd047f0f5
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
>    drivers/firmware/efi/libstub/x86-stub.c:225:37: sparse: sparse: invalid initializer
> >> drivers/firmware/efi/libstub/efistub.h:680:44: sparse: sparse: incorrect type in argument 2 (different type sizes) @@    expected unsigned short const [usertype] *optstr @@    got ype] *optstr @@
> >> drivers/firmware/efi/libstub/efistub.h:680:44: sparse:    expected unsigned short const [usertype] *optstr
> >> drivers/firmware/efi/libstub/efistub.h:680:44: sparse:    got char *
>

This is a bug in Sparse. The L"..." literals have type wchar_t * not char *

> vim +680 drivers/firmware/efi/libstub/efistub.h
>
>    670
>    671  static inline efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>    672                                             unsigned long *load_addr,
>    673                                             unsigned long *load_size,
>    674                                             unsigned long soft_limit,
>    675                                             unsigned long hard_limit)
>    676  {
>    677          if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER))
>    678                  return EFI_SUCCESS;
>    679
>  > 680          return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
>    681                                      soft_limit, hard_limit, load_addr, load_size);
>    682  }
>    683
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
