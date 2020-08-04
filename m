Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8C23BAA4
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgHDMpz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 08:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgHDMpj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 4 Aug 2020 08:45:39 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C57208C7;
        Tue,  4 Aug 2020 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596545139;
        bh=uOzlt5bua2472/dKyBwUpGHM2fobEm8gRY1VfCC7ZhU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kyt2DYaBLfqTCaZlJgJ8Vbx122bqzT/j51oqmKziP6RX5mpCy0YMKPU/QvoKb3Vtz
         Gt4XiWphb6qvRzhdGGS+lXl/JDosXUMyTIsUlx3LlieMoIKc4xX6QCia7VjiXj0V4o
         xzHb/RVyFUWXmWcA3QJSQVH8s8QGutfKk/yHfplY=
Received: by mail-oi1-f181.google.com with SMTP id e6so15981322oii.4;
        Tue, 04 Aug 2020 05:45:38 -0700 (PDT)
X-Gm-Message-State: AOAM530RQW+Xei2SgoZC6ywX2QN56aE3GL7RQBDVOBXefm96MIvMi5Al
        HIi/1phKUwkr3+iXl1LU9UsDAUFL+Xks4MQkLD8=
X-Google-Smtp-Source: ABdhPJxb8MesMRb416e8kTI8ZauUqLqB/eVjRnHNd8WuqjCzShGF5XRXreP3TOHqe4CfYkGp36dN9g+66PkSaUVXJjU=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr3331033oij.174.1596545138345;
 Tue, 04 Aug 2020 05:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com> <6514652d3a32d3ed33d6eb5c91d0af63bf0d1a0c.1596544734.git.andreyknvl@google.com>
In-Reply-To: <6514652d3a32d3ed33d6eb5c91d0af63bf0d1a0c.1596544734.git.andreyknvl@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 4 Aug 2020 14:45:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFua3LuoD=-7rkS1UuBXXCppsc32tZryyu2GoS4mpwzVQ@mail.gmail.com>
Message-ID: <CAMj1kXFua3LuoD=-7rkS1UuBXXCppsc32tZryyu2GoS4mpwzVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] efi: provide empty efi_enter_virtual_mode implementation
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        kasan-dev <kasan-dev@googlegroups.com>, linux-mm@kvack.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 4 Aug 2020 at 14:41, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> When CONFIG_EFI is not enabled, we might get an undefined reference
> to efi_enter_virtual_mode() error, if this efi_enabled() call isn't
> inlined into start_kernel(). This happens in particular, if start_kernel()
> is annodated with __no_sanitize_address.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  include/linux/efi.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 05c47f857383..73db1ae04cef 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -606,7 +606,11 @@ extern void *efi_get_pal_addr (void);
>  extern void efi_map_pal_code (void);
>  extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
>  extern void efi_gettimeofday (struct timespec64 *ts);
> +#ifdef CONFIG_EFI
>  extern void efi_enter_virtual_mode (void);     /* switch EFI to virtual mode, if possible */
> +#else
> +static inline void efi_enter_virtual_mode (void) {}
> +#endif
>  #ifdef CONFIG_X86
>  extern efi_status_t efi_query_variable_store(u32 attributes,
>                                              unsigned long size,
> --
> 2.28.0.163.g6104cc2f0b6-goog
>
