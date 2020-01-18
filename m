Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229B61417BA
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 14:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgARNhc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 08:37:32 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43956 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgARNh3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Jan 2020 08:37:29 -0500
Received: by mail-qv1-f66.google.com with SMTP id p2so11987062qvo.10
        for <linux-efi@vger.kernel.org>; Sat, 18 Jan 2020 05:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VF7Ybre9nicDdkbJ8YLCx9ZGXACXxQfpsesRhP5xc4k=;
        b=EY3A6DSLTKp1/kz1PrlGIeXEHIfZ+oH6MwVnlkr7xQTR3QolUfLzcrf937teMuKRrb
         zujAJVMsdgkbQFnO7cdoFfEDSmlT6jfMb9+hqE49E2xj6fg4AzURPCHdn/fCXSbXhwEJ
         yTxjNPWuM83IaBXYefWXukRwVW8We1HyswaRf+1gQ6WUlu+ntdM8jfDaSvHUA5QTaXe9
         ZSbr9yOKCstPniXl7afwYigPQOdWs3y8vaqUVQeu7emu2B+C/jljkfi9d2e9Bv/JVoBz
         s7xJnj4qdvZpwBrajm/Kd4AIsI8+9J48hr/ks/cqpU7LVTZ9YjpJ/sv0HCRQpfN3OnmO
         o3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VF7Ybre9nicDdkbJ8YLCx9ZGXACXxQfpsesRhP5xc4k=;
        b=Gg74q1y8uUCH1Wv+bteGiLhZF7EiUc4IsLHFRYiUPTjz8wueYiZopia2+EZ7rjFrj/
         x/Hm6CjFEZ3B2Ea7yXD925hpbnN1llNZEMH/zfMvbNL4qsEEyW4NuXw7vWIiVMAv8YPu
         QjcveZs53JnIkQ7OxJa0pymRPXPEIRfFkqVv89tuAoWlFLNCI96P8bcUAzeWzNKXGZGQ
         fpdg6CnkA7y8FMTNWpXqjAY5X5D4/F6SB9VC5o4SUDSmsyxAce4ghdMnd8OgWZnnIqUV
         fvfKpUR8NXyf6fBL+IiLchrZMkMv3T9/DGWas+Pptb5GemSVdCNsTFdu6ZRt4oNV0LXR
         1iBA==
X-Gm-Message-State: APjAAAWFJyoHy6W3WfKVdRRV6hj4k4U6l1wnfv1eRwsu10v135HzXX8R
        gU/sFcghTKdIe0TJNFWl6BQRKGVtNQEbDpKisQtF6Q==
X-Google-Smtp-Source: APXvYqwYblXYgB6+GHPK1LDSZMKjsXLHY5pS/MY8CjPumGXuzkIwxuXY7SK9oa8eOhjw5iioY3V40KhDw4njeWh5CLo=
X-Received: by 2002:a05:6214:1103:: with SMTP id e3mr12426686qvs.159.1579354648459;
 Sat, 18 Jan 2020 05:37:28 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
 <934E6F23-96FE-4C59-9387-9ABA2959DBBB@lca.pw> <CAKv+Gu9PfAHP4_Xaj3_PHFGQCsZRk2oXGbh8oTt22y3aCJBFTg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9PfAHP4_Xaj3_PHFGQCsZRk2oXGbh8oTt22y3aCJBFTg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 18 Jan 2020 14:37:17 +0100
Message-ID: <CACT4Y+bKhgRdCM1v8wTht=pEcX6u-J_Rq6=zA5yfMuBUcj169w@mail.gmail.com>
Subject: Re: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Qian Cai <cai@lca.pw>, Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jan 18, 2020 at 2:35 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> > > On Jan 18, 2020, at 3:00 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > Can't we just use READ_ONCE_NOCHECK() instead?
> >
> > My understanding is that KASAN actually want to make sure there is a no dereference of user memory because it has security implications. Does that make no sense here?
>
> Not really. This code runs extremely early in the boot, with a
> temporary 1:1 memory mapping installed so that the EFI firmware can
> transition into virtually remapped mode.
>
> Furthermore, the same issue exists for mixed mode, so we'll need to
> fix that as well. I'll spin a patch and credit you as the reporter.

If this code runs extremely early and uses even completely different
mapping, it may make sense to disable KASAN instrumentation of this
file in Makefile.
