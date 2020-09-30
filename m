Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD90227E29E
	for <lists+linux-efi@lfdr.de>; Wed, 30 Sep 2020 09:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgI3Has (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Sep 2020 03:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3Has (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 30 Sep 2020 03:30:48 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7E420789
        for <linux-efi@vger.kernel.org>; Wed, 30 Sep 2020 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601451047;
        bh=ywqObVwY5f4EDlcjRlrg8MFEga13+01/XhWfl9gYH0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EdLZlzLLFJgHI3Nns4C9Oo7bVhRin4sCalaL6BviqQLtRVSBRjucA9XUFrVKNQC70
         TTLYTt0igI3lAVnEBJ7FHVvryk2jwIV8DMYBchoaYEimZMcitXmj9fcW2JmmNO/+24
         N0VZ25jKTnj791XQK4NntNDISdhhTcXAg29uNwcA=
Received: by mail-oi1-f170.google.com with SMTP id a3so698000oib.4
        for <linux-efi@vger.kernel.org>; Wed, 30 Sep 2020 00:30:47 -0700 (PDT)
X-Gm-Message-State: AOAM5315k4P/5Aq7msciJ3HIDj0ostUCmiFPppAIGN+Fc93N6joWnBIV
        FQDf/ia3Osx5Vmc330EpfDcoRXRo3s6YAG90Vx8=
X-Google-Smtp-Source: ABdhPJxUUEB9B+22JvZIhYM+H47MeL4Cz1sg424KoeiGuB2FVxcBkars5LKQavAHtBjXgvkW7evIgvT7CmyeciWHnQA=
X-Received: by 2002:aca:d845:: with SMTP id p66mr667995oig.47.1601451046915;
 Wed, 30 Sep 2020 00:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200929182405.31809-1-ardb@kernel.org> <CAMj1kXG8=tO+nSE_m5N=7tz6VOgMwuBj7dPis4jYhA1jw1q-Bw@mail.gmail.com>
 <20200930072817.GC6810@zn.tnic>
In-Reply-To: <20200930072817.GC6810@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Sep 2020 09:30:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG79h2Hghyy6rqyWJ-t1=E=cPLO0P82ay7k6YB3mcPW1g@mail.gmail.com>
Message-ID: <CAMj1kXG79h2Hghyy6rqyWJ-t1=E=cPLO0P82ay7k6YB3mcPW1g@mail.gmail.com>
Subject: Re: [GIT PULL] More EFI changes for v5.10
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 30 Sep 2020 at 09:28, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 30, 2020 at 08:37:55AM +0200, Ard Biesheuvel wrote:
> > The only difference between d2778b4891fb and 4a568ce29d3f is that I
> > fixed up a typo in a person's name in the commit log, the patches are
> > otherwise identical. I recreated the tag right after, and the correct
> > commit ID is referenced in the PR I sent originally. However, I don't
> > remember if I failed to push the changes to kernel.org right away, or
> > whether this is a kernel.org mirroring issue, but the end result is
> > that that the wrong version of the tag got merged into efi/core
>
> Right.
>
> > This is not the end of the world, as the patches are identical.
> > However, if you prefer to fix it, please reset efi/core to
> > tags/efi-next-for-v5.10-2 - it covers the whole batch of EFI changes
> > for v5.10.
>
> Pushed now.
>

Thanks Boris.
