Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2FF12D6F9
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 09:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfLaIMi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 03:12:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35052 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfLaIMi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 03:12:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so34570854wro.2
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2019 00:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Niqmi8WrM7wY15dc/ApnUBfIIdXstHYsMpu4RQbB2FY=;
        b=myX17uJXoRkKYQAVv+EEzRxYNiHWRx6NqZntasQv1FJe6Q0VryH/Ghb4Q0cCI5Trhz
         3UrU2BYg7vfftqaWihcssCem3bAtwLw93V/oY9PP4N3pAeQJ9OiTP0IwiAcv25S1A9j1
         JS0rqlflypI81TNw2QUuiyHlOMf8/H33jVrAoG7km8RiajoGM20RTDQfAhKv5IKeuNEC
         ZAULXKreBskGgB7CbWzp+IxQkY7YsAAg0JOlz1ANIGDIqSQDcWR/aFmDBJ4wSm8B/RxY
         Wr0DunKJI6nJ5JDhz9+ucHDAf2ByA615HdlVEaKBT5d8Bktw+peq6oTgoK2094hhhwxc
         c0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Niqmi8WrM7wY15dc/ApnUBfIIdXstHYsMpu4RQbB2FY=;
        b=PfFu3exqvCEt2ZajEBPYdyNhbSqzWD0smfLGxtYvcbHy4Cu//3SRXrHTBmipi3UWH5
         n9AZ1X6tMrG6xeo+5vyBmw5Fu7UGYSLpuldW9xsRsUeoMjSEtws/miIyy8JycLW5kEPm
         Jg2mgZTk3oVwsTvFXGEEDwqfc//x1YIq2e4yrvJqlpr6KULf+tqqiSaRPnqw/nFLHSc5
         9A6wsgG/QlenwRPac+IgvnTNVi1mrlavlJUw5aKkjO0M79fKA2fOJQ8s0e8+Qtev0AfS
         jSZsRNpykd+n5VUGZCB0H8UZ3peDrC9enXM8Rq0cCgr3gDJVlHYiMgnAnUgu2H9RHWgJ
         iDHA==
X-Gm-Message-State: APjAAAW6bR7IG0ZtQL8Y5ADPrhGJx+CXDnAw3wWW5GWJ3aDmXV0HJ09w
        3wLhfi0uoqQ32YRxAlfN3OucmO+LahrnUndWruBDkmOQWfYBYDks
X-Google-Smtp-Source: APXvYqydldUw1aoAyda1JIpr26p9X2wWGXQSr7h/vC63byJ4Ilsjuy703FsRVXK9hSvlTZUspsBMSMHZVGiuq5S4kRE=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr66667335wrr.32.1577779956776;
 Tue, 31 Dec 2019 00:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20191230200011.2589934-1-nivedita@alum.mit.edu>
 <20191230201038.GA2593547@rani.riverdale.lan> <CAKv+Gu89oeKzccbPsmPye3V_=yYD_HCErYtJHqbpHFxv3QGRUw@mail.gmail.com>
 <DM6PR04MB5116612398311EFAB71BCFE9AA260@DM6PR04MB5116.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB5116612398311EFAB71BCFE9AA260@DM6PR04MB5116.namprd04.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 31 Dec 2019 09:12:25 +0100
Message-ID: <CAKv+Gu_7KxS2--Zy7vky7zZ4bQchLJ6Vv+kceKDwjAvYVeXL9A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] efi/x86: Check number of arguments to variadic functions
To:     "niveditas98 ." <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 31 Dec 2019 at 01:26, niveditas98 . <nivedita@alum.mit.edu> wrote:
>
> Yeah I forgot to add comments for the second one before sending.
>
> For the first one I agree on the naming. If it looks sensible otherwise I can revise that.
>

Yes please

Also, could we use the argmaps to zero init the top half of OUT pointers? E.g.,

#define __efi64_argmap_allocate_pool(type, size, buffer)  (type),
(size), efi_zi(buffer)

static inline void *efi_zi(void *p)
{
    ((u32 *)p)[1] = 0;
    return p;
}

That would make the mixed mode support in the stub much more robust.


>
> ________________________________
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Sent: Monday, December 30, 2019 7:21 PM
> To: Arvind Sankar
> Cc: Ard Biesheuvel; linux-efi
> Subject: Re: [RFC PATCH 1/2] efi/x86: Check number of arguments to variadic functions
>
> On Mon, 30 Dec 2019 at 21:10, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > This is on top of https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
>
> Good stuff!
>
> I'd like to make a few tweaks, but this is definitely something I'd
> like to incorporate for v5.6
>
> The macros are a bit light on documentation, and I'd prefer to avoid
> macros recursively invoking C functions with the same name if we can.
