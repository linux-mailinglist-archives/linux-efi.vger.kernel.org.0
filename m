Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB43879D
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfFGKDi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 06:03:38 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50401 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfFGKDh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 06:03:37 -0400
Received: by mail-it1-f196.google.com with SMTP id a186so1853734itg.0
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXkL1vVxNkQCEf8uIM1j/K14yJ9boqMG1SgO7jduIvc=;
        b=YYxEGmddlTZo7bYwJ78QEjiVFt60Vd1vKrd7FfgLha73Bfp5xhojPc11T2qge0Ee9U
         iEqXavk/gZtf5msWQQkYvZ1FzL7dWqtbtuoUThGhH857ANjy9kFBzvrXgfqZfV/ZT3cC
         kVpAjDoZ9MZX4pFbBjFZoTTZeA9lLePg/eIHn088JZOyRjycYI9mfwz/Vb9bd/ma1wIO
         G95UnNdBWaTK+dtIs8xMKXGvMdyYZoX8UiJcndYL5Rl9Jt1jBBP+Q2my6vMGB1gSgAoV
         abk/Dr7gHvMTE+6TxfkThW8/Jdj/PtnPfHBO7GUcd+pe0z7IWh9xEwhLM+cdB0H4qBbF
         ZCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXkL1vVxNkQCEf8uIM1j/K14yJ9boqMG1SgO7jduIvc=;
        b=d/CmlXmuCJ95avMlL+iLJUVbT/Otx9Hr6vHaQiK640ct4sYvSyCDyK4zhfVxS4K5tZ
         F+xxK/1LmPhEgHQHygEnO1gYxQzdD8SWJIj0NPYlSe8Qbm1nfAHB89CyYMCTvIT6GX3h
         Nc5y68ptmasvnXHpJCdSOlqPXr3vc/V73KVSFIwRxixRLrxyt3r7J25RhcOKPH6W++VX
         iPHLvtrAZxQ9Wlp4ZTCUMzgomPNZkkkPuM73SyzukBXMy+mS33imsxx5B1mFBftGW9bJ
         VpfPyT8eGJh23MB6QHtxkl/XL1FRDPeZc5f5yv4Mukrk36X4t1XdtsOD7Li81BZGArhZ
         UdOg==
X-Gm-Message-State: APjAAAXAc/PN4scT6+DskuM9ve7OkvvtIetm12+6VSwUQiuCBpMjzxy5
        tHPR/22n/4v3JFNHwFXiKfm4GGB1yTYrhQiGW+ILaw==
X-Google-Smtp-Source: APXvYqx5BvzpPElJuxssZGqIo/LIQYox9lJ48Af/yrJsR3eUMkJQWs/vjbsQgg7qQmQ96IMfzCBOykjsxchEhdgwN+E=
X-Received: by 2002:a02:ce37:: with SMTP id v23mr34148542jar.2.1559901817170;
 Fri, 07 Jun 2019 03:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190605181140.35559-1-matthewgarrett@google.com>
 <CAKv+Gu_GxV1GySRz-xju6RsB0Qdra=nN=CL+M=jvQ1e2V6p_ig@mail.gmail.com> <CACdnJusonjd_2eciwA8MgJNS7GntGGBqoAMHuJBRHsuqrn4aGQ@mail.gmail.com>
In-Reply-To: <CACdnJusonjd_2eciwA8MgJNS7GntGGBqoAMHuJBRHsuqrn4aGQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Jun 2019 12:03:26 +0200
Message-ID: <CAKv+Gu-rqW7VrQ_jiGQLcx2xTc-khOoV7_FOQ0N7tbU932QhFQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix TPM code build failure on ARM
To:     Matthew Garrett <mjg59@google.com>
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

On Thu, 6 Jun 2019 at 18:04, Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, Jun 6, 2019 at 4:39 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Wed, 5 Jun 2019 at 20:11, Matthew Garrett <matthewgarrett@google.com> wrote:
> > >
> > > asm/early_ioremap.h needs to be #included before tpm_eventlog.h in order
> > > to ensure that early_memremap is available.
> > >
> >
> > Doesn't that make it tpm_eventlog.h's job to #include it?
>
> tpm_eventlog.h doesn't use early_memremap directly, it's expanded from
> the macros declared in tpm.c .

Fair enough

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
