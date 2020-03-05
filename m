Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C800917A10B
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 09:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCEIQd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 03:16:33 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:39593 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCEIQc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Mar 2020 03:16:32 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 0258GLN6012313;
        Thu, 5 Mar 2020 17:16:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 0258GLN6012313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583396182;
        bh=nhkaOm7d8PtRUHOn9qwBHZvSSFuzC0pWUZP2QZo5Id0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2H6yGxxWQVhOGrbh3sL7pWcYt0eyo5MCTlIey4kOClBCanuCm/8H2aApT9ROkmFpO
         +UgKlVEJlAZ8p/d+pZmQ/RW4iQkZOw3JSnzptRnE0ihHU1lUTJYZF6W7CyuDwToWMr
         +HzwIJUMOImaEcDRO+y/mRRQ/Wso8l0QH1oAo8YRtpcUyUfb4dxkvrkKsqQUHmL5XW
         Dhv22CBZ+gWHAoPecXxWrr4u9dc2yR7SHRtrTyl3YjK9RBJLWDpbrniKYNhz/oUI9s
         K4kUASFz2+fsx/9XW16CAlFftSz8BN9BBcOHVPUGzEfqu8+jSqJu+gQaS4oH+UM9AF
         DvnFAMkbnZsIg==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id 8so904310uar.3;
        Thu, 05 Mar 2020 00:16:21 -0800 (PST)
X-Gm-Message-State: ANhLgQ2jSQNqO45V+WB4p6ZaVV1taXsVVjfzlfZkwiP4LY71oMrhNWW6
        Wptv9DMDF/eFBiGOjG3n+ngOSdFYgq/morPeD5c=
X-Google-Smtp-Source: ADFU+vt7c2j4DWNsnnWYd+6NhbZYkJnGCbhuMI8wsKZIm2g70mMKlexStnM3ny8FX18fCJhGkZ/m6z2JogCB2xrbGbY=
X-Received: by 2002:ab0:3485:: with SMTP id c5mr3724348uar.109.1583396180792;
 Thu, 05 Mar 2020 00:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20200305055047.6097-1-masahiroy@kernel.org> <CAKv+Gu8KfZZ_v-kUq=vwd+8MfhiOCpTG_AYA06bAuq7G-=c+WQ@mail.gmail.com>
 <CAK7LNATwBALmPjZiY6teac3FcA_BFsBVzwf5cqbVNCZSqGrHJg@mail.gmail.com> <CAKv+Gu-7GYj5fJjOMRQQiKhA+PYeHYcwcG6sVx5O0Pj2Ufd2rg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-7GYj5fJjOMRQQiKhA+PYeHYcwcG6sVx5O0Pj2Ufd2rg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 5 Mar 2020 17:15:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARL=mj3HuhjuRhZyNvcqVPYaQYN_x+71khX=6YJE-Bsng@mail.gmail.com>
Message-ID: <CAK7LNARL=mj3HuhjuRhZyNvcqVPYaQYN_x+71khX=6YJE-Bsng@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: avoid linking libstub/lib-ksyms.o into vmlinux
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,


On Thu, Mar 5, 2020 at 4:47 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> If you agree, no need to resend, I'll fix it up when applying
>


I agree.
Please fix it up.

Thanks.

-- 
Best Regards
Masahiro Yamada
