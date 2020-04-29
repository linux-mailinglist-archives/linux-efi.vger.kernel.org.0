Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02181BE6C8
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 20:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgD2S7n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 14:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgD2S7m (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 Apr 2020 14:59:42 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4678020B80;
        Wed, 29 Apr 2020 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588186782;
        bh=mCzgndZV9oSgYH3A5npWh8MPllIC/3Qa3Gd80PeFISk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CqWc7zHruZXF9PobL6vlCmR2JVxmu1hSKnbyUeP/6FvwejRNOemqRKiWdGBjaCK1Y
         QLTjFAP9qDi3xbg6Dl4RFp2LVqEcN+w+oTHDzhY+niYQnunw9/5w0hXg6YBgLMth7S
         ic2HSGgf4n+gR6SfcGhfCu0imLrIlRNILWD2R9xY=
Received: by mail-il1-f174.google.com with SMTP id w6so3544692ilg.1;
        Wed, 29 Apr 2020 11:59:42 -0700 (PDT)
X-Gm-Message-State: AGi0Puba9cv/wpA1RGEcmQeAbJRBvnMeXyTVWFVWWFcHqwotOuXAnaBq
        3xNWpWp59vKc0SabAq5yZS5vVdhdEVXs9x1MEZ4=
X-Google-Smtp-Source: APiQypIMmAxIAz8HiXRShXUeJVDGv62oB+5s7tuAIyLsW6eHj+7cNblrdjh9dWJqmS+bsEUB2xAQPg6nP5AIHxGdDmE=
X-Received: by 2002:a92:405:: with SMTP id 5mr31534493ile.279.1588186780730;
 Wed, 29 Apr 2020 11:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-5-nivedita@alum.mit.edu> <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
 <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com> <3fa8fba37f9339adc993cdb7afc77ed0e063967d.camel@perches.com>
In-Reply-To: <3fa8fba37f9339adc993cdb7afc77ed0e063967d.camel@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Apr 2020 20:59:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHN1j4+h-mTf_EpsaX3-ifAtKJOPmSSq9LvHoFUUg+0bw@mail.gmail.com>
Message-ID: <CAMj1kXHN1j4+h-mTf_EpsaX3-ifAtKJOPmSSq9LvHoFUUg+0bw@mail.gmail.com>
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

On Wed, 29 Apr 2020 at 20:57, Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-04-29 at 20:49 +0200, Ard Biesheuvel wrote:
> > On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
> > > Looking at code for efi_printk -> efi_char16_printk,
> > > it's somewhat difficult to see where the "output_string"
> > > function pointer is set.  Any clue?
> > It is set by the firmware.
>
> Sure, where in the code though?
>

In which code? The firmware code?
