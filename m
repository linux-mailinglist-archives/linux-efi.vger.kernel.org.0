Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0192230AFE
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2019 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfEaJDL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 May 2019 05:03:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35559 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaJDL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 May 2019 05:03:11 -0400
Received: by mail-io1-f67.google.com with SMTP id p2so7565127iol.2
        for <linux-efi@vger.kernel.org>; Fri, 31 May 2019 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fMTGL8wPS9uvXito7LEBE76m2vLpWlvbqw1ZDt1wb4Q=;
        b=aUQfiLpyRk9IP+8t0Yy9mKYMS58Q6DUjBule65TD0UMa9JJezYGbvcvGiyxPwcKXpd
         6sL9XJpTGJzu7gpPDX9U/9oPHibWcC08Hbp4GRkhD/4me5fadOjBSscIIOlLN0DygyLv
         cXQFD33KK8Py38tyc0El2nZaZ6q2UnewQx82DkkGLLovPURGdwRLBe+wdKvybefN1aYZ
         gSp1Gs47U5hRfMYCZZnjO6WrMII0EFxeYCPU3V4Eb4s3sqkX1O3ysWYRWpAvY+bAAHcx
         3mYc7VO8vSrCNp8SeYD3ui+yvElGuxvyDknUmcAE7uIS565ArO0TuYMpw037oDpByKQr
         SwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fMTGL8wPS9uvXito7LEBE76m2vLpWlvbqw1ZDt1wb4Q=;
        b=Ms3Sgt0V7275Ezr7hk8vYd+f5tjPS109FjBygYOnJxor4fCGnh7zAnnuhs1ltAuirw
         8R+W5BZfWtDEd6fUnC+7rp4C1BNezvfcXRcj2Jv72rDF1yWakZCj32KSubzAo2gcUf6l
         o4XyORphUetjC0DJRX+3SJErEiqwwYb5Um8c5pT5aUDN/pwj60c7b35Doa8q9P8Sum6m
         4G4my+rlQLatRSwdcrfJe7QrL4FHF6/D6dbYJCpjeogdXY4J9yTa0jBe+eed9am1/Ux3
         IDDLpiuI9OX2zH+Z5w1QYhLhm7eykQh5iF9nnuO6t05COPJVmXJutoXk2D0cyn5srcbs
         swiQ==
X-Gm-Message-State: APjAAAVpA/g4mrUFGbUdlSh6U04a55yJSSD9kaDyy/NgXK6cLwo++I2h
        TQZTwo+3whYF5opvZsBDcKyIuCgZRR4LqNME9FdEkA==
X-Google-Smtp-Source: APXvYqyh9QNyVKDHvLYxsht24OxqIOoisOlKPqv4BvUZYUuRazWXzv5KTY6jNzAf+7BVrxuloUUW8FbfVgxomsUWL5w=
X-Received: by 2002:a5d:968e:: with SMTP id m14mr5858513ion.49.1559293390337;
 Fri, 31 May 2019 02:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <bug-203761-199677@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203761-199677@https.bugzilla.kernel.org/>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 31 May 2019 11:02:57 +0200
Message-ID: <CAKv+Gu8vuTLGX6h2T=d_EnzQx-XirD+yTV5AX_zA9vdtP1qU7A@mail.gmail.com>
Subject: Re: [Bug 203761] New: efivar_ssdt_iter is subject to stack corruption
 when the input name_size is 0
To:     bugzilla-daemon@bugzilla.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 30 May 2019 at 18:04, <bugzilla-daemon@bugzilla.kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=203761
>
>             Bug ID: 203761
>            Summary: efivar_ssdt_iter is subject to stack corruption when
>                     the input name_size is 0
>            Product: EFI
>            Version: unspecified
>     Kernel Version: 4.18.0-20-generic
>           Hardware: Intel
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Boot
>           Assignee: efi@kernel-bugs.osdl.org
>           Reporter: steven.yutang@gmail.com
>         Regression: No
>
> Reported also at https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1830951
>
> function efivar_ssdt_iter in efi.c has the following code:
>
>         char utf8_name[EFIVAR_SSDT_NAME_MAX];
>         int limit = min_t(unsigned long, EFIVAR_SSDT_NAME_MAX, name_size);
>         ucs2_as_utf8(utf8_name, name, limit - 1);
>
> In this short snippet of code, we can see typical issues due to unsigned long
> <-> int casting.
>
> 1. mismatch of signedness.
> 2. loss of precision.
>
> The input of name_size is signed long, gets compared against an unsigned long
> of a fixed size, then stored as a signed int (this is mostly okay because of
> the known max size), but it then gets passed to a function takes unsigned long
> without checking the range.
>
> Here, the input name_size is 0, limit also is 0, but limit - 1 = -1, and then
> casts to ULONGMAX to ucs2_as_utf8 and corrupts the stack storage with a size of
> only EFIVAR_SSDT_NAME_MAX.
>
