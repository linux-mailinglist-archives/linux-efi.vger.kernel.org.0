Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB13158B
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2019 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEaTo3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 May 2019 15:44:29 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:46711 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfEaTo3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 May 2019 15:44:29 -0400
Received: by mail-io1-f46.google.com with SMTP id u25so9167583iot.13
        for <linux-efi@vger.kernel.org>; Fri, 31 May 2019 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXkszx+Yp/B+HVHgnIVXnLzxSKipwLnqNB7XThCSZWQ=;
        b=Im2SKs30IcunA1f6vSy2WI/cRsPpJ46xgGulYPcaBMMKeLmv3iSiWWVaJ08x8KMd3a
         DlATaDILiWnukZkshgIOxrpnLJwYAPrdgbGIkjvyB6ghJF7dqxr5d7pCTDkhdlVAlzV1
         +IEiuAr+6E660Tgezyn0KZJSM1JlCKRHYA1BOHmbVP3kaAB/NeanxhSW7KT61qZAnYye
         7oQYOTGgLBy2hZn8IYe3WDLS4K7BcE5PNZE4bT910+lo7RbFgYpMskdYbovQz0r7CW/9
         Ezr2nmJ49zJtBC75tdx0wQ99KohrK7V/7WydE2k6E6Xdj+ybLBhjc+n9wZuIe7ZdC7km
         b1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXkszx+Yp/B+HVHgnIVXnLzxSKipwLnqNB7XThCSZWQ=;
        b=MFyQS/EitfrzPvpPQsx/G5/pnpB8iEzezYrkcn9KXHgjUJnPvCb7mJHHXMBnAf2Fe3
         t7bA7/SxFvygRtrr8FSg5a596CjqR5PqpUwFxavKRVAyyph9FOkfOY6sg6e0jbrLL/Uf
         TbT5sB4IUAIZ9Bn05t91o4KYK2NXj+6TFIMXjtjXnD4TZ0j1WDFQsF67hS7ogBhK2cBk
         /evasYwH54nOzyEnxM+bj2+mJftnhDl4Hay4YJbk8SM5CdS7LvgIVrw+6kaBc30H/dWI
         0scLqAmYh1DaXZfLxixhrXfSfY94mFR+iWYSMXvanpcqtHqRuzzDVLhy/X4T68DyhIht
         G/sw==
X-Gm-Message-State: APjAAAUyfPVK6pWyW1cxmpAIYwCTh0WAFTEKr3M5rje28dWFHiYrGbey
        mzmmw/Kr33xoOCan9MEPY72rti5LP9I5UpapSOEz5LJ81QI=
X-Google-Smtp-Source: APXvYqz6yjbHJbzGyXR0zZHhTFQIu+bwCxC9ZhkVhuGcgb8roqHXJ70pQFD54+PEiJOHXD4lR/J0fmtVyv9yNrFWmVI=
X-Received: by 2002:a5e:8217:: with SMTP id l23mr8504157iom.84.1559331868349;
 Fri, 31 May 2019 12:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <bug-203761-199677@https.bugzilla.kernel.org/> <CAKv+Gu8vuTLGX6h2T=d_EnzQx-XirD+yTV5AX_zA9vdtP1qU7A@mail.gmail.com>
In-Reply-To: <CAKv+Gu8vuTLGX6h2T=d_EnzQx-XirD+yTV5AX_zA9vdtP1qU7A@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 31 May 2019 12:44:17 -0700
Message-ID: <CACdnJuvJoyV-OnDuUPb1PNt4RUw2PzyA41P9DFhaYnD0ArCeGw@mail.gmail.com>
Subject: Re: [Bug 203761] New: efivar_ssdt_iter is subject to stack corruption
 when the input name_size is 0
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     bugzilla-daemon@bugzilla.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 31, 2019 at 2:03 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

> > The input of name_size is signed long, gets compared against an unsigned long
> > of a fixed size, then stored as a signed int (this is mostly okay because of
> > the known max size), but it then gets passed to a function takes unsigned long
> > without checking the range.
> >
> > Here, the input name_size is 0, limit also is 0, but limit - 1 = -1, and then
> > casts to ULONGMAX to ucs2_as_utf8 and corrupts the stack storage with a size of
> > only EFIVAR_SSDT_NAME_MAX.

This is a legitimate bug, but anyone in a position to trigger this is
also in a position to inject an arbitrary SSDT which then means
arbitrary code execution in the kernel, so I don't think there's any
security-relevant impact.
