Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D826912D538
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 01:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfLaAVb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 19:21:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52338 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfLaAVa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Dec 2019 19:21:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so812927wmc.2
        for <linux-efi@vger.kernel.org>; Mon, 30 Dec 2019 16:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/zlTiQ9Q2nwnXoLXheMoJ6BBnsWSypCemaXiLIW2Gc=;
        b=LNZaLKnhFyBN8NHcxcF19yp5rrwWyIBVVQGzUFK4oweTyuxh0tjFD6W2qQbz7qWKR7
         Y3mtxf98Gf/TP/CAzoKEEHdYbOn678A0BSWIXz0c1Nh3VGX6uMKQRx4Zdw9csoRAV2pG
         fgsGkF6Vk34pUbnB5NGaIo+j8kFLuwjjiNyD3oWxDq9HyKrzwUTvL3W0Ztlbktl4XL0P
         sV/v5W+mnYYy4w+4rZrvCnzRakUkUxDRdtH+0SMzsOaLA/CEqnMLnLcuppKeTEkhNR53
         6pXW+nwe0Dcjy8VDWc8BFzuTJtlZTlUrN1le24yxfa4+jq4lt9tWJdjYZQ/gxLsTWeCh
         KSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/zlTiQ9Q2nwnXoLXheMoJ6BBnsWSypCemaXiLIW2Gc=;
        b=YFCBhyXkhupoh7UydA+FT7MbZWBsldQkCoojz1NHmffs/dvknSsctNrE1v+zt4h2xc
         Bt1h78omWqDa4lwFOuGQpwLr8lbs5qXNuE90oyRU7/3VaW5ZqpyIpfuA3P9PwyhPXF4T
         3U/zTs2GqI8pC8caKkVt32AdVmp0UScSJB6DiRfEIWBOTzOlj7obMgVlaAarf8YGa8LM
         Jx1r24026SYl61lEvDEt+85urrnxANc7hpYWMx/MWg2SWRdBk8dBc1NX/qXopfbDMHGH
         jpqOAudfePqd7JKiqbwUTkJa7WSMl0A0pjIj3gHrVj8dWQ+TUbhLJXgM8Lsj2RZORM6u
         25Ag==
X-Gm-Message-State: APjAAAVUiWRp8yKPQngau05K6vNjmQvhWlMq8qi5nO/NP9Qhc9FfCyST
        f/XgmEPLSSuF1BbQg9jP9tdX5FQw0V+rMrJLVULX/A==
X-Google-Smtp-Source: APXvYqwtNEsVYF/7HEKWl4GySB35uI2Y2NklVm6bbtiwSefn8r5O1W067cfhLuXx6de8Dk3NEGdUkHM+PGjNlUI1D9k=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr1315871wme.148.1577751688806;
 Mon, 30 Dec 2019 16:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20191230200011.2589934-1-nivedita@alum.mit.edu> <20191230201038.GA2593547@rani.riverdale.lan>
In-Reply-To: <20191230201038.GA2593547@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 31 Dec 2019 01:21:30 +0100
Message-ID: <CAKv+Gu89oeKzccbPsmPye3V_=yYD_HCErYtJHqbpHFxv3QGRUw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] efi/x86: Check number of arguments to variadic functions
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 30 Dec 2019 at 21:10, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This is on top of https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next

Good stuff!

I'd like to make a few tweaks, but this is definitely something I'd
like to incorporate for v5.6

The macros are a bit light on documentation, and I'd prefer to avoid
macros recursively invoking C functions with the same name if we can.
