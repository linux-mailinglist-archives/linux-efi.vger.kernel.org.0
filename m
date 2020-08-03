Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD6523AC18
	for <lists+linux-efi@lfdr.de>; Mon,  3 Aug 2020 20:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHCSEF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Aug 2020 14:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCSEE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Aug 2020 14:04:04 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCB4C06174A
        for <linux-efi@vger.kernel.org>; Mon,  3 Aug 2020 11:04:04 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o22so28661447qtt.13
        for <linux-efi@vger.kernel.org>; Mon, 03 Aug 2020 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rQffdkDpJsvCogJyVsUeEYROYwZ62G9925/dWTW2BzU=;
        b=mQ/M8FnGQ+MvFZsxI5wDFtmrrN3hVpHunSd8TNxEjUD7SZ/poA1F2pMYagFR2h5uSG
         gKg7Di7AMOBSup6o0iSpW4Qx7anJINjwjofg8161nNSbwrkgExvz3Yo37dHOpB3MijN2
         aHiWqNXEa0qSiKBWST+4iY3mVmq/fa3aNT8lpbJwYfKva1BYngkx5PQtnlTjWRrOOkYX
         PNG6k+MTkfHO7IVWfUf3Uzye9Ou4zj3abFdtTZYvFFmbKZhno2gIFoNrfEAVbWUu13P4
         SWzq3qj+Fq2YSohPQcUdeSImGjbvViT3VcYwQMsvzP4m7nElya22yV5syHrQPINaNvKV
         TLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rQffdkDpJsvCogJyVsUeEYROYwZ62G9925/dWTW2BzU=;
        b=tYGslSwVOAWpqIc4YVHc7fuKjwuRSL2Q/+1baECAGNacmacHSTf+K2q3S37GMQ7Zt8
         iQaFxCgUYUxr/vDpZAJcMa70/+27dhFnMthidz6ELU3xuCzzDfVB4JD5LUOXnEiiu/UM
         FZ4DDpUCFYN+c+0Ir3WfwVW/2UwD+iN5NdaWtuLMlwADmfYvg8ky29FlT9PgxJZxIe/d
         HKoGtr75qdT0BFhrnFatgCYqxmo5/Np2pUQOVyyC27CBrQ5wh8bqAhKp45oM+9GVQgeR
         Fqus2El0CffnCHoPMVWkmGd7ZmuXO/wXXQPHxwhQyvAADYTZy85Smv5NjHbkmb3wSftR
         wUjw==
X-Gm-Message-State: AOAM53107/hVDCVQugJ6i59sqjyVJ0+ZYwdegv0vJV1IivCBlDAT4yaU
        JGjvkjUi+GpRNrpWHbxBWT4=
X-Google-Smtp-Source: ABdhPJyZKnwtE21BcNyw6qANenzDCUzeQrxt6AYlqaPG4DYmmkJwUSTqVdLMm+vxrDRw28WASv4SDw==
X-Received: by 2002:ac8:777a:: with SMTP id h26mr17410449qtu.141.1596477843719;
        Mon, 03 Aug 2020 11:04:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h13sm21625090qtu.7.2020.08.03.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:04:02 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 3 Aug 2020 14:03:58 -0400
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kbuild-all@lists.01.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [hnaz-linux-mm:master 168/421] init/main.c:1012: undefined
 reference to `efi_enter_virtual_mode'
Message-ID: <20200803180358.GA1299225@rani.riverdale.lan>
References: <202008020649.TJ8Zu7ei%lkp@intel.com>
 <CAAeHK+zbBF0YVveGNZo0bJ8fWHVZRcrr6n90eYLDCov2vcfZyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAeHK+zbBF0YVveGNZo0bJ8fWHVZRcrr6n90eYLDCov2vcfZyg@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 03, 2020 at 05:37:32PM +0200, Andrey Konovalov wrote:
> On Sun, Aug 2, 2020 at 12:25 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://github.com/hnaz/linux-mm master
> > head:   2932a9e66c580f3c8d95ec27716d437198fb4c94
> > commit: 7c0265f304de3c3acd02d0015b56a076357bcce3 [168/421] kasan, arm64: don't instrument functions that enable kasan
> > config: x86_64-randconfig-r036-20200802 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
> > reproduce (this is a W=1 build):
> >         git checkout 7c0265f304de3c3acd02d0015b56a076357bcce3
> >         # save the attached .config to linux build tree
> >         make W=1 ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    ld: init/main.o: in function `start_kernel':
> > >> init/main.c:1012: undefined reference to `efi_enter_virtual_mode'
> 
> Hm, I can reproduce the issue, but I don't understand why it happens.
> 
> +EFI and KASAN people, maybe someone has an idea.
> 
> This is the guilty patch:
> 
> https://github.com/hnaz/linux-mm/commit/7c0265f304de3c3acd02d0015b56a076357bcce3
> 
> The issue is only with efi_enter_virtual_mode() AFAIU, not with any of
> the other functions.
> 
> Thanks!
> 

After adding __no_sanitize_address, gcc doesn't inline efi_enabled() on
a KASAN build, even when CONFIG_EFI is disabled, and the function is
just
	return false;
and so it isn't optimizing out the call to efi_enter_virtual_mode().

Making efi_enabled() __always_inline fixes this, but not sure if that is
the correct fix?
