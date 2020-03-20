Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF318CDF5
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 13:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCTMiI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Mar 2020 08:38:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40650 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTMiH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Mar 2020 08:38:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id l25so1688794qki.7
        for <linux-efi@vger.kernel.org>; Fri, 20 Mar 2020 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUsFDDLc+OT1mxat4BydgprIPibf9UQTcm/vZqGE7Pg=;
        b=tZugQz/AH0shvqjYWaF1gAAwX+4ovdwCpMJMoGaKc3JPHNP4DA0wP2zsgC6Wc7fcg7
         6b/lkws0cqY8gp36RTo5o0CfaGP2IIcQy+DYVsoxd+wux++dbBa5aLZaeLXCvn6pqDX4
         FgHC2C8kyi7zTi7bMu5dulWZ6wSXCXhxLDDUK533HO0MZDS+kbxeuPXjJpp/F7DX93JL
         g3wBrf1xCYeBbUCQSoEUYQIrA0EszHphDJCTYduJhXi36Hynt6Az3btqPZrUFmEz7+Fx
         GOMEQYUDg01KIVTjvzayfXnA7mXXR76J+LjqCgO0nZg6b4+WcdsuuGzGFuz6G99yEIgf
         3nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUsFDDLc+OT1mxat4BydgprIPibf9UQTcm/vZqGE7Pg=;
        b=Q5jsTjZfBJIl/VkiruQLXZkngx3SHIchhaWK8yUloHGRfFqsaj8wPbcz9afwc2WDQJ
         YX698dT0RSg8Useaok6x1aG/Ze5EOonYxNKxQgkMM3ybdJM+T4l/S8GyfKFrkkE3baJP
         beSjiLdD8ti+fkK6J8qW130qoSqiOMxauyNyvCZATx6HOvU17ZPKHuYzoAOZHl0k+5SE
         oSfTgh2E/WUtKsf+kih48bl2nWG+rq090o0U4O4i6IuU+BOZ12DnSOmROZzBKBjPB0lF
         DkoBvz9IbR23UVRDJO9W+9/cPSPdAwl1xklqkRLpHkio/4ZkRS+Pdr+EsXBLlPhWUgt5
         x8Cg==
X-Gm-Message-State: ANhLgQ1qSyLBdFaMWQFAvKwpGAxMPHF4XBKpYEVUR9YL7+TiHxhCIhQz
        +10YJf754X9DbdOQgbxaXmKPiRpS26a6wkr98/XPGQ==
X-Google-Smtp-Source: ADFU+vvDBQQsdYulrWhgu3FelWi5P2Ua5BYNVN5DgtEqXHnJH+UBtT1nfmzl6r7OJ12TSJdnY5SvrhtF8srk+gySCGk=
X-Received: by 2002:a37:51d5:: with SMTP id f204mr7674280qkb.14.1584707886141;
 Fri, 20 Mar 2020 05:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200312083341.9365-1-jian-hong@endlessm.com> <20200312104643.GA15619@zn.tnic>
In-Reply-To: <20200312104643.GA15619@zn.tnic>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 20 Mar 2020 20:37:54 +0800
Message-ID: <CAD8Lp47ndRqeS5VbkCMR_Faq-du9eDW28rHOG4Owxq862t-kGQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/reboot, efi: Use EFI reboot for Acer
 TravelMate X514-51T"
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 12, 2020 at 6:46 PM Borislav Petkov <bp@alien8.de> wrote:
> How do you know *everyone* affected will update their BIOS?
>
> And what's the downside of keeping it?

It could indeed be kept without user-visible downside, and that would
be the normal case for quirks that work around BIOS bugs.

But I had two reasons for suggesting that Jian-Hong should send this
revert patch, which may be worth some consideration:

 1. This was working around a BIOS bug truly separate from Linux to
the point where it was a little questionable for Linux to put a quirk
in place. The original bug was that after Linux completed executing
the reboot code, the machine would reboot, the BIOS would start
loading, and then crash well before loading the OS. Presumably
crashing on some state that Linux left that was not reset in the
machine's reboot stage. The vendor later found the issue (something
TPM-related) and fixed the BIOS to avoid the crash.
 2. We normally receive these units before they go into mass
production, so there's a decent chance that production versions
already include this BIOS fix.

Based on that I was considering that the patch could be reverted for
cleanliness/ At the same time, I do not have strong feelings on this,
no issues if the quirk is left in place.

Daniel
