Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5EF6155EC0
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 20:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGTr7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 14:47:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40608 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgBGTr7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 14:47:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so299296wru.7
        for <linux-efi@vger.kernel.org>; Fri, 07 Feb 2020 11:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADmEob5aCHIMZYdk17bc2JtUL+648UgN60jHGzFUmnQ=;
        b=ZtenNvpggSNUBFW84py2rlNqNs1p27CT9g4Y0dQKsE0VKS/mqmxCYdKR44F4KrFJmH
         ccgRRcEazb4hunqtwY7yIYDj1VI46LGOzVIA1W3gOalQEHUL4XoeKvTAwL4LuWC7wEfW
         ku9j4hCIBFMt2Y6ZbkfWtXyv887LDZ2Ka8QncGwcHx4pHRG7UqtVJrnYarZuytQouWff
         1IqZL2Qa70K/tU+n6B2Df3bQS2a2DKxwqYeKbg3UmzWAjmj1ybwWKOvJzy1IArws51Q6
         VR7tmPpl6QbokDZMdKvp8ApdMtLCzEn/oW7hOcCEXhWH1uHKy5lV+e4K7EWISk+C3Igu
         axRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADmEob5aCHIMZYdk17bc2JtUL+648UgN60jHGzFUmnQ=;
        b=ifZvKw6S7Kb2ZHfmnV3dbFIe1Z74IIuXk/7359juWsQcQt2cmS12rv6Bo2wQAJyIS7
         3glJhgmnvf1cJtg4rs2aY5n3FUjI5/N0uKRn7v/ttPfWh+/jgi2YDy1SwbhI0MVOImRN
         EaRr35VzXYL9kgB5MD1nMbeBraoskCs+GwnXvPFrhtwXiEpFohq+pIqHmCyFN8+3yzQ0
         Mp0FbzrMz6YTxvCwg4G8BOInITWpj2yjDN3eN/7eyRnHqkItWRbanaPGAvl90qKewflm
         zZWEvufNHnhNrfEYhc5sDWaNT8a3rIHH02Nyt5tAQsCbAtzqVHYGUyMXtWqo/7tvcH0x
         6PbQ==
X-Gm-Message-State: APjAAAU8F5+ErVeeDVn3Rms8zXW3Ofob3ER3tGH/qVPJcSEvqJqA/GLr
        hFVLvjhMyLneCOHjv4tT3E2CTapaaup8ty2BmMOwOfnR2AIZgA==
X-Google-Smtp-Source: APXvYqy8ulALAFMRrpiERJSH7DxxaKYXZW/FVT6fUplf6OymnaPN0l0tMb7TfG90cZJkFEOJdBoIgpGS95aYvd5xNtc=
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr643736wrr.208.1581104877140;
 Fri, 07 Feb 2020 11:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20200206140352.6300-1-ardb@kernel.org> <20200207184532.GA3276112@rani.riverdale.lan>
In-Reply-To: <20200207184532.GA3276112@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Feb 2020 19:47:46 +0000
Message-ID: <CAKv+Gu8Z3=cqbNxspLXAgM_8wEm+to2TWRjpaaC231MbwL2Ycw@mail.gmail.com>
Subject: Re: [PATCH 0/2] arch-agnostic initrd loading method for EFI systems
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 7 Feb 2020 at 18:45, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Feb 06, 2020 at 02:03:50PM +0000, Ard Biesheuvel wrote:
> >   data structure. It also creates a time window where the initrd data sits
> >   in memory, and can potentially be corrupted before the kernel is booted.
> >
>
> I don't quite understand the time window aspect -- can you expand on
> that? It seems like the same time window exists between when the kernel
> is loaded and when it actually runs, no? Why is this more important for
> initrd?

When using loadimage+startimage, the authentication and measurement of
the kernel image occur during the call to loadimage(), even if the
source of the load is memory itself, and startimage() is typically
called right after.

The assumption is that it may help to make this time as short as
possible for the initrd as well.
