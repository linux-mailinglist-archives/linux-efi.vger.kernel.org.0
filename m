Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0083137910
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2019 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfFFQEI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jun 2019 12:04:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54121 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfFFQEI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jun 2019 12:04:08 -0400
Received: by mail-it1-f193.google.com with SMTP id m187so789613ite.3
        for <linux-efi@vger.kernel.org>; Thu, 06 Jun 2019 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79YHY2kuyJAoI71w0CE6gdEXA7Who0bex5ytS37xcQo=;
        b=r2dMeI6ND0eztLJwJoVoBTBWBAMl3EhOp8askMUviuV445+/CxjMPjNfOPwgLQ76oZ
         GcnNsWYf/Eo1TXeabXwKNAi0A5HeIjfgxJzK88xwyl0MNqcC3xAlEtJGNPdNWca1QClF
         aZ82WuTUdkkcbzaAGmM46YUNFIERYucuaZSO9dpNQHcmT0+9RO6hrhSp1rEvlBU4YlrV
         HEakmFS2E+02jGvFO45pZGdE7Fzc1bARkIuW36BSTEV3B4aFmaDbKgEkH12wCdBLx8dt
         PV9QEAqfN9JWWNsdw6sRYYVuohOTS2giCHUUyi091dQ4tXr9cNBiE31AtWIB/RYu1wzo
         k/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79YHY2kuyJAoI71w0CE6gdEXA7Who0bex5ytS37xcQo=;
        b=i2jGTdpq0HHYa8G8zwqy6WXExiLrJyjfbXNGzr17DLdHsa926YRN1DzYAq8IuReo/4
         e109An0QreO1P+fNs3yF6QlDFrsTIKl1hvVhaeskb/6TeaL9mxM8eCyW59nj6B+Lpep5
         040au5pNlotNSnY13K4MyREX9ZGpZ7BE73Rajsn/4a2veyAbXnBQFX8OsnxxE2QUSK1T
         JIKOR6QpXNDFkdVeboFSq4fOChW9vG/VljYInsb32cWFT04mFMShLhYdGiMie8FDL4c7
         sBhIvcYS4m/3M0vHWhzW4/N1mlLB9Mx7Z+iRaCtsVvnbDwkdEiaQX2QvWDGy7sjrdpqO
         RUug==
X-Gm-Message-State: APjAAAUU2vfCn3e6J0b4TrHA9yhYJNfUPjfHQWVYr8bsuRhauxWZByk1
        jhJHOKGU7UseDG0Gos1LW2qXpcfwFYHI1ZINbDAidA==
X-Google-Smtp-Source: APXvYqyH4t7gJ6U8Sk3x8cMUs8aTFLnfuX8s36qZLzqQnFNLxQjPBcke7SPHzWlAeciqXBJvheaYkYYrVyTizDUPVz0=
X-Received: by 2002:a24:6887:: with SMTP id v129mr658523itb.150.1559837046601;
 Thu, 06 Jun 2019 09:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190605181140.35559-1-matthewgarrett@google.com> <CAKv+Gu_GxV1GySRz-xju6RsB0Qdra=nN=CL+M=jvQ1e2V6p_ig@mail.gmail.com>
In-Reply-To: <CAKv+Gu_GxV1GySRz-xju6RsB0Qdra=nN=CL+M=jvQ1e2V6p_ig@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 6 Jun 2019 09:03:53 -0700
Message-ID: <CACdnJusonjd_2eciwA8MgJNS7GntGGBqoAMHuJBRHsuqrn4aGQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix TPM code build failure on ARM
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 6, 2019 at 4:39 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 5 Jun 2019 at 20:11, Matthew Garrett <matthewgarrett@google.com> wrote:
> >
> > asm/early_ioremap.h needs to be #included before tpm_eventlog.h in order
> > to ensure that early_memremap is available.
> >
>
> Doesn't that make it tpm_eventlog.h's job to #include it?

tpm_eventlog.h doesn't use early_memremap directly, it's expanded from
the macros declared in tpm.c .
