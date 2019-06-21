Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780184EC9F
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2019 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfFUPyj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jun 2019 11:54:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44508 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfFUPyj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jun 2019 11:54:39 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so3981586iob.11
        for <linux-efi@vger.kernel.org>; Fri, 21 Jun 2019 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67Zwr0+JR5ftAH9XUiVHCrJ8ZWllxG5OsGyxy9ZC38U=;
        b=PHUKIT0ZA3D4YNl0n8jtu3bk/mrY4ytlRjGB3rTDb7+ENS6p5Mu5RTIT8BarLvMCTH
         gUUt+fPaymQJQez1UZ6QAZesqWJrySt+p1i0cDLoupf8DZ9WMJDGtaYPk7IxlBWw7Z1Y
         H7yJVROh7kaYVz1Ck9fATi7Avsz9ofKCoHfMDIBia5wwCTpMdxyk/N3SntRzXKNYQtfu
         I5kn+SsO+J0fWxgqcmq78xHSJdtdY5WuvM2c81CqjGs3krBniLMpYVXI1EzD+qvFHUh6
         PX2RqoVKiWVfbcoTmU5ZeGBFmhc9bJf7ehLbfEvtq5Lp1VuBJi7+ylPD2Tgle8PrztfY
         U3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67Zwr0+JR5ftAH9XUiVHCrJ8ZWllxG5OsGyxy9ZC38U=;
        b=hQNkET8TA3fhvqcAYUSooGL5YBtCO6JzHgZ6qDgwXqo39iCT8uqjMhKG66iZPKFYTb
         MjqFTF4wEXbEGOPIPF7/4FkLoNhisTx4+/+n3f8a4PZ0Y38C9iT7IoSVGlp87KCA9yDg
         BJJy98ETakxw9fBQZpSVmdScZ6luD260G/wlZ1a9DZBaciqiCOiC6ypsJrbhyWRBDQ6H
         6DThdgiUQVB44TkwuDUs/GHaS1gryRye1EjU7UhKtAQwQgNjeOPDHhzzrp5DmnYvGaob
         Vxoa6di1TUT1kPiqVohoilAJvSF/eJ/N8k8DMnyI8dY/rSadNOP68sdAFWe6qeIM+FhV
         Bc2w==
X-Gm-Message-State: APjAAAXsHANPObsXJqtMBCa+5hcZiMrPdfaXk/DOkhCesdT7g43M1b+H
        IV0t79HRfq2DU8lWYZ7YKwnYG8dbQrPOPDHCYmnqyw==
X-Google-Smtp-Source: APXvYqyi87dZ/gi5usy6mMIGsqoAR7PMShcYzW72U858qc3P99BF2m9iqkby4DNpe/dyc1JPF0bLnWX/rYQGsvwmFAE=
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr7359926iob.49.1561132478625;
 Fri, 21 Jun 2019 08:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <1560966464-27644-1-git-send-email-cai@lca.pw> <FFF73D592F13FD46B8700F0A279B802F4F787D4B@ORSMSX114.amr.corp.intel.com>
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F4F787D4B@ORSMSX114.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Jun 2019 17:54:27 +0200
Message-ID: <CAKv+Gu8ynfn04eSNqJR__yFJMrp6=FptxTcN40YwomV4O5u=OA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: fix a -Wtype-limits compilation warning
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     Qian Cai <cai@lca.pw>, "bp@alien8.de" <bp@alien8.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 19 Jun 2019 at 19:53, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>
> > Compiling a kernel with W=1 generates this warning,
> >
> > arch/x86/platform/efi/quirks.c:731:16: warning: comparison of unsigned
> > expression >= 0 is always true [-Wtype-limits]
> >
> > Fixes: 3425d934fc03 ("efi/x86: Handle page faults occurring while running EFI
> > runtime services")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >
> > v2: Add a "Fixes" tag.
>
> Makes sense.
> Thanks for the fix Qian Cai.
>

Queued as a fix with Sai's ack

Thanks,
