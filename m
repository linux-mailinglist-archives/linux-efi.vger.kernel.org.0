Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619091BE69B
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 20:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgD2Ste (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 14:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Ste (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 Apr 2020 14:49:34 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DB82072A;
        Wed, 29 Apr 2020 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588186174;
        bh=D8dZyCwxk+OumIfZBSmX8/xPo4zJ9/S7K3N6q7Bc/iE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H41zh0sYOVQLUebqwgURIfTDNeLxaYovhxFSQn4nd0V0ZULMj8nIBWllwnsxhYcah
         Cg1u11QbtiMGGDDolxSS1d+FbsJMtM5+dp7UvUCHxl7q/PiChJTgXvpcNLP/2MU9A9
         0rtlLU3uJu48tbPvI47Z8dkqFkz1qMluywz1q0Ks=
Received: by mail-il1-f176.google.com with SMTP id w6so3511532ilg.1;
        Wed, 29 Apr 2020 11:49:34 -0700 (PDT)
X-Gm-Message-State: AGi0PubOUMLSxlXpfQyQf5s8Lc+WkNo6xMsQ8lE/s82BEDEzScbxPfEB
        LSoLtnf3Jz/uDwE/FvdYEJqNVXjsrofP/XV71hA=
X-Google-Smtp-Source: APiQypKGEHfKz4Lr3zApMTsqN7GnORbAp3JEtx6/QWAhNKlP0cLiHFvxusfjC/tFs1UDUFHwiTrU11jj3FueBln5jMY=
X-Received: by 2002:a92:3c55:: with SMTP id j82mr33814677ila.258.1588186171917;
 Wed, 29 Apr 2020 11:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-5-nivedita@alum.mit.edu> <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
In-Reply-To: <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Apr 2020 20:49:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
Message-ID: <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
Subject: Re: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
To:     Joe Perches <joe@perches.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-04-29 at 13:41 -0400, Arvind Sankar wrote:
> > Use pr_efi_err instead of bare efi_printk for error messages.
>
> Perhaps it'd be better to rename pr_efi_err to eri_err
> to it's clearer it's a typical efi_ logging function.
>
> $ git grep -w --name-only pr_efi_err | \
>   xargs sed -i 's/\bpr_efi_err\b/efi_err/g'
>

Yeah, pr_efi_err() is probably not the best name

> Looking at code for efi_printk -> efi_char16_printk,
> it's somewhat difficult to see where the "output_string"
> function pointer is set.  Any clue?
>

It is set by the firmware.
