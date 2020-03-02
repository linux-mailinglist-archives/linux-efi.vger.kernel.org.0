Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2522B1754E1
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 08:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgCBHub (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 02:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgCBHua (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Mar 2020 02:50:30 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 348BF246B6
        for <linux-efi@vger.kernel.org>; Mon,  2 Mar 2020 07:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135429;
        bh=O5/tiRCv2lf9UHdd/8DRCYM/sJBi0xsnMZYl0LPjZxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JOGApCtYJxE4Bp7Tx9mQhzkU0NSJCYIk/smGF0puvITGXyxkA1qegfgg1eVwL/WOn
         uCgyeIa4xlMnmDD5AzBYvU3I7rNDe7o6NdJ74tEahB9g0jYTqQp0DHmx4CD9LblZQG
         TvfxXQK3DyIGsrzdAGVNdV4uqus1vxVMbsb5MNtA=
Received: by mail-wr1-f53.google.com with SMTP id j7so11120882wrp.13
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 23:50:29 -0800 (PST)
X-Gm-Message-State: APjAAAXw30cX4Utw6VeGGlkCI/02PtiTEC9LTyQ6/4SX8Ej2xm5bJZ6p
        gADHpbQ4Wrw64ChwVfwo4WNnUjNRxy2f4tA4gWGy4Q==
X-Google-Smtp-Source: APXvYqy8mIonbGGBiIESjdyLQUcHAeyZfK5neJ4zgPtMWWhUKLOq/2BTrVQxQFpIPPy3Us8MOlJj8NvfptmH0iuxtMw=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr21307603wrw.252.1583135427687;
 Sun, 01 Mar 2020 23:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
In-Reply-To: <20200301230436.2246909-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Mar 2020 08:50:16 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_USvAxcT7qFUvMoM_5Q=rHad4WJw5uqX1shk3vdau0Gg@mail.gmail.com>
Message-ID: <CAKv+Gu_USvAxcT7qFUvMoM_5Q=rHad4WJw5uqX1shk3vdau0Gg@mail.gmail.com>
Subject: Re: [PATCH 0/5] efi/x86 cleanups and one bugfix
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2 Mar 2020 at 00:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> First 3 patches are misc. beautifications to the new compat PE entry
> code.
>
> Next patch stops EFI stub using code32_start field to communicate the
> address of startup_32, instead returning it directly to efi_stub_entry.
>
> Last patch is a bugfix for x86/boot/head code to use unsigned
> comparisons on addresses rather than signed.
>
> Based on tip:efi/core
>
> Arvind Sankar (5):
>   efi/x86: Annotate the LOADED_IMAGE_PROTOCOL_GUID with SYM_DATA
>   efi/x86: Respect 32-bit ABI in efi32_pe_entry
>   efi/x86: Make efi32_pe_entry more readable
>   efi/x86: Avoid using code32_start
>   x86/boot: Use unsigned comparison for addresses
>

Thanks Arvind. This looks really good, as usual. I had one question,
the rest looks good to go.
