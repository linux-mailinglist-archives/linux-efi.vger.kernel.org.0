Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC9143FD3C
	for <lists+linux-efi@lfdr.de>; Fri, 29 Oct 2021 15:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhJ2NRM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Oct 2021 09:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJ2NRL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Oct 2021 09:17:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA8EC061570;
        Fri, 29 Oct 2021 06:14:42 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l2so16844098lji.6;
        Fri, 29 Oct 2021 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osDamQOuONsYrpKcvETFaiMS87IGXmH0jox9ViqQ238=;
        b=hRxPn9kf5utbmv79GgZM21YGEg+2weS4UCfoFwFvDJ4HvUnJjrdLlBT7rLK+BVB9iX
         D6lI/76Z2dmHfsJboeTibySTEC3rxrgxwUDCQeydihBDtbQXj1vR5mT2aslyM34lZQw4
         6Dtivo6dQtpZXcMfESU7f/+nWoLsBCIObAi410ITGxuCGowr0JFCpgMn3ypRfGZyfADt
         aNbsOTw8znTeUSnfDRwYiOZNTYNp042xfcF/9yvQblKxMZJw4T7WOopI8W2nEXDTkbRf
         h6etLt771nqgrhb1WKVnZM/aX0wTPZXQoGNTYvIqAFsWNOeCVzITJYQIbl7m8gfv54mY
         /XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osDamQOuONsYrpKcvETFaiMS87IGXmH0jox9ViqQ238=;
        b=pq1JkEEEuNlkKRY8xAu58fJOmdLb49O0imESOU6SppeByxIz/gXHnEKYiB1NaCoTij
         n5e1TtHqFdvvfqw2yf0vGWydt6nkvrYSPO7kutiFoI1RwaS3Fg8aXmqX4/Ngt6SJgplf
         jYgKePNrU7mt69ob4W6EaPDfiNF8uiZW7UtvChhwhDNVAR6V6P3F8NYdhLwQ21KVwKbs
         5Yutdc7QWpEeYWOUdH3xy6uqwm88q/lB4C5mMyh6lVeB6DoAS48ilmBICCR4OwMnFJGR
         qIJngalGQ//6IqK2JC6l6ocrjwtm9euVPSKK7CItbQlIY2LT3K46jJ++jqnUbL/cR9NH
         TJ1A==
X-Gm-Message-State: AOAM533LybN3wypnUwaC2e4TNZ8hQXNGzp8PUvLxYef2PRR8/MzSZV/I
        ZHi2brsd+Fbu+GJsFMJeQFysErmB04v2dkeIV8Su1WB8AkA=
X-Google-Smtp-Source: ABdhPJyFnCZne9XeVCKdL8ft8JTJVYclV9S/a3sZtLvY3wZiLOU7vpAe9KMcmjVFsT0nFq6qx3RGBvI2LrBMnPlMSQs=
X-Received: by 2002:a2e:901:: with SMTP id 1mr11738396ljj.333.1635513281231;
 Fri, 29 Oct 2021 06:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
 <8a8e0743-e54d-ec96-da4e-1d101b550274@intel.com> <CAKgze5Z3fT9F0S-mogfP6is9sL3=0imtCbfy6ZYrd3zgaBUqRg@mail.gmail.com>
 <YXq50yzJQqrJk13v@zn.tnic> <CAD2FfiFS++2-Sn5nCft8Eb-R41MM6abCjXyDn8bOVY-_miCpRA@mail.gmail.com>
 <YXrRN+pDr4Uv5p0t@zn.tnic>
In-Reply-To: <YXrRN+pDr4Uv5p0t@zn.tnic>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 29 Oct 2021 14:14:29 +0100
Message-ID: <CAD2FfiEurBe34_dx-ChY7BPtaiZpFW7SFBBa4hKU2w-3QLr+DQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] [RFC] x86: Export information about hardware
 memory encryption to sysfs
To:     Borislav Petkov <bp@alien8.de>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-efi@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Daniel Gutson <daniel.gutson@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 28 Oct 2021 at 17:35, Borislav Petkov <bp@alien8.de> wrote:
> Sorry, you need to expand on that: part of what specification?

My apologies, I should have linked to the specification. It's called
Host Security ID: https://fwupd.github.io/libfwupdplugin/hsi.html

> How is this going to be run?

HSI tests are run at every boot and logged. HSI is part of Insights
(for servers) and is even now part of several large companies'
purchasing policies.

> Why cannot this be a userspace program, script, tool, whatever?

We actually tried this, using the journal API:
https://github.com/fwupd/fwupd/pull/2129

It was a hack, and took a really long time to complete on slow
embedded hardware.

Richard
