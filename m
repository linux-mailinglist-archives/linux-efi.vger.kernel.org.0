Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3902805B8
	for <lists+linux-efi@lfdr.de>; Thu,  1 Oct 2020 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbgJARoj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Oct 2020 13:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARoj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Oct 2020 13:44:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DC5C0613D0;
        Thu,  1 Oct 2020 10:44:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 144so382443pfb.4;
        Thu, 01 Oct 2020 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xwkaw38cgwHkNtoVtJK2JhdTeVpjV+AYAxG0kMKtMnI=;
        b=BV7v1qkfQ2xRfiu8NpANEPoUbG97BoDOHD2KhaTguGsC2qxZ7V+Gg+u52jc8XTx5dH
         NgRPDWBJbjMK+uxRg9Weux7CPLdIo8EZZRkmpvDHsPB9D8gtkAHWDUoV7Z7CawXtGkBg
         ct35he9NGxcYsaI6NuvvwSSrQQYDbawVCsItv/2uEsLuMRLZnugHUfB9LnbO0PD3LuFG
         nPm7QTqrJ9LG6ADc81EHDwn/y8cglED7qHsr0wMcmOkbnL+Z7IK5kg51hb6AR96Jt1Xa
         AxUXwqanWOKoNIwMDUZO8JVjmPaMRsGk4K8CeXAdq+Bj6JukVzAbDLYwO2n3Y60mCAp0
         2oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xwkaw38cgwHkNtoVtJK2JhdTeVpjV+AYAxG0kMKtMnI=;
        b=L+qJb+l5pHFVLHkp8QFB/uwCtO6n/TZ0PrPdkaeEOfvnKn77l1adqtf0FXUPIzR0+4
         mqjd+D7keAoZVSrBf5L1UgL7wOkhF4VvW6FBvuXKaAziGz0/CCd19oP2HJTma2dhx3jh
         Jb1Il517X4BE03jWtEYbr84soOatWmTF2YPI8Z3bxS7GF5xFznUW4BDyVLvJHdx+7V3q
         2iUVjYe3k6mJSmxsxMFzTwZVsAEqVS6sJZ3rTtGc9WXtP5v0FqJ4czGYo4CKk4OQm5E2
         LnGuPcciS3GsBbyZEJ9Rp2FyEsCWRFwgx3mZun368cDm3HbHlI+nmrVNc68p5SrPo2zh
         UiUg==
X-Gm-Message-State: AOAM531NKRbaqeDysFzRuQwmTVKB+VZ2pIdGulbNwaCUpa7u2zLACn9h
        a+96OtHTWVDQHHJqNIzHY6w=
X-Google-Smtp-Source: ABdhPJzlg9wioDaDQeFELxBiW6SWSo+AK0dG8aWp4yY632RVWNfS7tpzlqLDRpZ9Vd9fusarLXSf5Q==
X-Received: by 2002:a62:19c4:0:b029:13e:d13d:a081 with SMTP id 187-20020a6219c40000b029013ed13da081mr3804867pfz.24.1601574278745;
        Thu, 01 Oct 2020 10:44:38 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id o4sm7001277pfh.39.2020.10.01.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:44:38 -0700 (PDT)
Date:   Thu, 1 Oct 2020 10:44:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        ardb@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, zohar@linux.ibm.com, bp@alien8.de,
        pjones@redhat.com, dhowells@redhat.com, prarit@redhat.com
Subject: Re: [PATCH V2 1/3] efi: Support for MOK variable config table
Message-ID: <20201001174436.GA2622286@ubuntu-m3-large-x86>
References: <20200905013107.10457-1-lszubowi@redhat.com>
 <20200905013107.10457-2-lszubowi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905013107.10457-2-lszubowi@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 04, 2020 at 09:31:05PM -0400, Lenny Szubowicz wrote:
> Because of system-specific EFI firmware limitations, EFI volatile
> variables may not be capable of holding the required contents of
> the Machine Owner Key (MOK) certificate store when the certificate
> list grows above some size. Therefore, an EFI boot loader may pass
> the MOK certs via a EFI configuration table created specifically for
> this purpose to avoid this firmware limitation.
> 
> An EFI configuration table is a much more primitive mechanism
> compared to EFI variables and is well suited for one-way passage
> of static information from a pre-OS environment to the kernel.
> 
> This patch adds initial kernel support to recognize, parse,
> and validate the EFI MOK configuration table, where named
> entries contain the same data that would otherwise be provided
> in similarly named EFI variables.
> 
> Additionally, this patch creates a sysfs binary file for each
> EFI MOK configuration table entry found. These files are read-only
> to root and are provided for use by user space utilities such as
> mokutil.
> 
> A subsequent patch will load MOK certs into the trusted platform
> key ring using this infrastructure.
> 
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>

I have not seen this reported yet but this breaks arm allyesconfig and
allmodconfig when CPU_LITTLE_ENDIAN is force selected (because CONFIG_EFI
will actually be enabled):

$ cat le.config
CONFIG_CPU_BIG_ENDIAN=n

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- KCONFIG_ALLCONFIG=le.config allyesconfig drivers/firmware/efi/mokvar-table.o
drivers/firmware/efi/mokvar-table.c: In function 'efi_mokvar_table_init':
drivers/firmware/efi/mokvar-table.c:139:5: error: implicit declaration of function 'early_memunmap' [-Werror=implicit-function-declaration]
  139 |     early_memunmap(va, map_size);
      |     ^~~~~~~~~~~~~~
drivers/firmware/efi/mokvar-table.c:148:9: error: implicit declaration of function 'early_memremap' [-Werror=implicit-function-declaration]
  148 |    va = early_memremap(efi.mokvar_table, map_size);
      |         ^~~~~~~~~~~~~~
drivers/firmware/efi/mokvar-table.c:148:7: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  148 |    va = early_memremap(efi.mokvar_table, map_size);
      |       ^
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:283: drivers/firmware/efi/mokvar-table.o] Error 1

Cheers,
Nathan
