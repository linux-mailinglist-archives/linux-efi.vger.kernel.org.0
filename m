Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AE01AD027
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 21:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgDPTJW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 15:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgDPTJU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 15:09:20 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0777920786
        for <linux-efi@vger.kernel.org>; Thu, 16 Apr 2020 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587064160;
        bh=RZtjSfTbPfzyJi43Z0Lu5mevw91QOspjBkWxSA5wi/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bLXCSh6AwDljpRSesZWLGbShtBGIU/NLk/rF04WirfmT/GOtEOcTU/Fzr0eZ5XwAR
         RwgT6ulpp+Y3YNQ+Vu4IH0XUZHXkhyaiYPNg9Xbaz6h44tymrm2IHv86nDj94+xVHV
         fpunL/nj3hc74D6TE8dXKt0RFJiJZ5uaIMMZsGqk=
Received: by mail-il1-f180.google.com with SMTP id f2so8012100ilq.7
        for <linux-efi@vger.kernel.org>; Thu, 16 Apr 2020 12:09:20 -0700 (PDT)
X-Gm-Message-State: AGi0PuY3vPTayyi1/8wVHcLfGdIffDlZ2UGaqkTG7TYWMH3L2SsLfhvj
        smn6jlEzUjlcgqAvVas5aVJS/1kYH+NRHTpZzpU=
X-Google-Smtp-Source: APiQypIZigPyj5GZVEJoSOG633f6XnqmO35sFRg3PKVO3VZqvJpEd7VrBFd6Pc7Thz7JmX8VUGKgfWYoeFCU8wAZ0QE=
X-Received: by 2002:a92:39dd:: with SMTP id h90mr12338894ilf.80.1587064159408;
 Thu, 16 Apr 2020 12:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200416164831.11724-1-ardb@kernel.org> <20200416190734.GA3540850@rani.riverdale.lan>
In-Reply-To: <20200416190734.GA3540850@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Apr 2020 21:09:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEavm=dn3p2mo8Dcv=dfcp8NoFD5o+OnO3_J16fke+=sg@mail.gmail.com>
Message-ID: <CAMj1kXEavm=dn3p2mo8Dcv=dfcp8NoFD5o+OnO3_J16fke+=sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/libstub: drop __pure getter for efi_system_table
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 16 Apr 2020 at 21:07, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Apr 16, 2020 at 06:48:30PM +0200, Ard Biesheuvel wrote:
> > The practice of using __pure getter functions to access global
> > variables in the EFI stub dates back to the time when we had to
> > carefully prevent GOT entries from being emitted, because we
> > could not rely on the toolchain to do this for us.
> >
> > Today, we use the hidden visibility pragma for all EFI stub source
> > files, which now all live in the same subdirectory, and we apply a
> > sanity check on the objects, so we can get rid of these getter
> > functions and simply refer to global data objects directly.
> >
> > Start with efi_system_table(), and convert it into a global variable.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Could turn efi_is_64bit() into an inline function as well?

Yep
