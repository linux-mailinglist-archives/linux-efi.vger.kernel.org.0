Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7006D134867
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 17:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAHQsK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 11:48:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33900 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgAHQsK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 11:48:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so4173035wrr.1
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2020 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oThwVOSRghlMQrtGPJX+ACmEzpakZ7+aStYbwUOl/sQ=;
        b=KJ8VyuDbKf/CPrDOdmCtRVxpPCX/7Bw2aLcUSgFdoCjxTyv2qSBWu4ufbzJFir/k3d
         y3fNIDlz6I1cgxg6GcWbamUyAFo5XarJYOMqCqgWxWGFC8/ozip7Kdd2Dz2GBbR1y7Gd
         w6IGiT/m172BO9/zrnfDaW2THDf8WhTBmx0Vh4F3WFBce1UUSebyzVN38MIhOG6d3O6M
         dUrrq7OlsDBXdhZ5DQWdUdQ6rpHgvpWe6kvJM+kKRK6oA5Hlxb0SUULePRnvyIflSrAY
         YacENCL515yBuZFJKvrQ8jMHHERmGLu5nuWHeBhd4w70PcOJ3grnKyX8gfc9V4a7/ZLk
         DLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oThwVOSRghlMQrtGPJX+ACmEzpakZ7+aStYbwUOl/sQ=;
        b=I3tcAkBbPlAvR1A3zIZcc8WXpdR+bGCGROh7DxGD9I0GHn4LLcJCmTOHKgSSFMErMQ
         /odGFiyFlGHcm0QFsDZuq0FdAkxcNBoa/4Rq2BKn0RF7qeRPUxDVXWvpP3l5/WZu+LYI
         1148dSv/2G4sr1kHpfpR4XbEQThOc+6El7CNB6qGLNVCd0QJogI/bc4Ooa51mdYjgxTG
         1mJ5Bs4Y1873eZVqGHjmwiag48abJr/iAj7Zhz9qgLW4hJEed8upIvtWIlXq9P7a0cmz
         E6vIMD8eIYRFAmiDPtE2bjcuLEind7+D8Xg8no6PCcIOEDDWuJ8xsXrZ0iMOOVre4pZz
         u84w==
X-Gm-Message-State: APjAAAWCcL6/o6yU8hy2qWCa0WH964G53S7gHRoLbd0bh95vS6CxuqtX
        lR5UZrQ+uD01jZMXPvrxPdrfZRE9eCAXqNGatkAd8w==
X-Google-Smtp-Source: APXvYqxld4/J+48jZWMZsKYas2V8hJ6QfYzgpwPJfWXcagD63FIKHzy4jZc/YPSKMusV0C4z/jLQo+8YZf5zhAIJeoE=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr5359077wrr.32.1578502088604;
 Wed, 08 Jan 2020 08:48:08 -0800 (PST)
MIME-Version: 1.0
References: <20200108102304.25800-1-ardb@kernel.org> <20200108102304.25800-3-ardb@kernel.org>
 <20200108154031.GA2512498@rani.riverdale.lan> <CAKv+Gu8AOukQL3qokt+Rz3PKBRWWnSULGUr=+yxg_HPM8-uodw@mail.gmail.com>
 <20200108155700.GA2602122@rani.riverdale.lan>
In-Reply-To: <20200108155700.GA2602122@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 8 Jan 2020 17:47:57 +0100
Message-ID: <CAKv+Gu_EVuX1nktX6Ueyot7XFgtq+AG9SqRHvN91r9oG5GL_wQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 8 Jan 2020 at 16:57, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Jan 08, 2020 at 04:47:51PM +0100, Ard Biesheuvel wrote:
> > The EFI stub already sets the hidden visibility attribute for the few
> > external symbol references that it contains, so it is not needed in
> > the context of this series.
> >
> > In the future, we can revisit this if we want to get rid of the
> > various __pure getter functions, but that requires thorough testing on
> > other architectures and toolchains, so I'd prefer to leave that for
> > later.
>
> We don't need it for the stub right now, but then this bit in the cover
> letter is not yet true, we still need to be careful about libstub code.
>
> > ...we can start using ordinary external symbol references in the EFI
> > stub without running the risk of boot regressions.

Spurious GOT entries will now be caught by the ASSERT() in the linker
script and fail the build instead of causing hard to debug boot
regressions, so it is not entirely untrue either. But I take your
point.
