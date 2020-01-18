Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE161417BF
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 14:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgARNlX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 08:41:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34029 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgARNlW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Jan 2020 08:41:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so25248380wrr.1
        for <linux-efi@vger.kernel.org>; Sat, 18 Jan 2020 05:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFe6n4FQHA1VOWCd6CGPk+kxacT5cKq8IuN+p1i7TQU=;
        b=nFG8dNHBdZVhq3lvwz+Ep/QRxaLzhWkpPsocSLSZtiWyPnHgy4DxZAO/r0wabt48hY
         m+c0Pk3kfEXm2iSHTYvTojcKPmm4P37by8jfTxv3lNUZWF8NnX+67zdHqd4YflzbSdoW
         n8Af3utWqYpeR/zY9UIDnxiQfKZffkduDaswsivVMbqUiwMcAdwo1qGaLeoA/tGLbhcQ
         WpR04wcFwqexpVNpBcaVmmd7agjQ1ldiELpyoFazZIm2KVzyOjXyHDvLg5ARcwweBo9t
         ed8v6jByNQhZWYR9xaof4u4stupgr1Uj0ySvV9MsNp5ukKo1dra3itOyaqMtH4hBFked
         uL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFe6n4FQHA1VOWCd6CGPk+kxacT5cKq8IuN+p1i7TQU=;
        b=fH8DAUSpjhZP4lYXbfO/yUFWFC2LWIqao9VVPlXoTB3U6IfwYcQ2DAbasel84oCGy9
         5lDsbw3a5xXCfp9Kle9SNMqEiROq3znbbCzjN5TNiGrn4jL7sHJGxnM27jbdsSNhmtJH
         +tcSwXR0Jnf5Pz+RyT+qtq9/DPwH7qJkIaQTVjPoT8P6a7321ukXO7Dfrhm354bcAQjw
         Es6VBKEzAecyK3YUGiMIxi8K1NyWyqutZsH29fY2k31oJuOe6i8jplMjVnBcv29oB7Ho
         TVYQnl4kCN0Nt7ipxUW/qaeP+IF8HhmhM6OWctO5ucxb/3Tzm14OfnVHW5OKMRYnPhBK
         xvNQ==
X-Gm-Message-State: APjAAAX0iMA6gTxaaXhAjLbM+ekmixgeHdbD93syCxvN2/OHlGTC+VrI
        Kev8kgOVp3WkqkZfoCK6HiPMPKuUrjwGpwC0nrslGA==
X-Google-Smtp-Source: APXvYqxh1828BCmBT0NKPlZZ7fa0OWfuI0uRzSzAhQFvZ9LtyMpJok6v1/E18UYrR8Ik4eSL1Q8JSwyC6XAMbbsKA08=
X-Received: by 2002:adf:fe86:: with SMTP id l6mr8723881wrr.252.1579354880364;
 Sat, 18 Jan 2020 05:41:20 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
 <934E6F23-96FE-4C59-9387-9ABA2959DBBB@lca.pw> <CAKv+Gu9PfAHP4_Xaj3_PHFGQCsZRk2oXGbh8oTt22y3aCJBFTg@mail.gmail.com>
 <CACT4Y+bKhgRdCM1v8wTht=pEcX6u-J_Rq6=zA5yfMuBUcj169w@mail.gmail.com>
In-Reply-To: <CACT4Y+bKhgRdCM1v8wTht=pEcX6u-J_Rq6=zA5yfMuBUcj169w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 18 Jan 2020 14:41:09 +0100
Message-ID: <CAKv+Gu8X1dPBk-_o66V81o_uXLReFYZhHgt7CfBGN_MhXXFTmg@mail.gmail.com>
Subject: Re: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Sat, 18 Jan 2020 at 14:37, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Jan 18, 2020 at 2:35 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > > > On Jan 18, 2020, at 3:00 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > Can't we just use READ_ONCE_NOCHECK() instead?
> > >
> > > My understanding is that KASAN actually want to make sure there is a no dereference of user memory because it has security implications. Does that make no sense here?
> >
> > Not really. This code runs extremely early in the boot, with a
> > temporary 1:1 memory mapping installed so that the EFI firmware can
> > transition into virtually remapped mode.
> >
> > Furthermore, the same issue exists for mixed mode, so we'll need to
> > fix that as well. I'll spin a patch and credit you as the reporter.
>
> If this code runs extremely early and uses even completely different
> mapping, it may make sense to disable KASAN instrumentation of this
> file in Makefile.

The routine in question runs extremely early, but the other code in
the file may be called at any time, so this is probably not the right
choice in this case.
