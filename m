Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE8E28C8DC
	for <lists+linux-efi@lfdr.de>; Tue, 13 Oct 2020 08:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgJMG7U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Oct 2020 02:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbgJMG7U (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 13 Oct 2020 02:59:20 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547E720797;
        Tue, 13 Oct 2020 06:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602572359;
        bh=MsewuQOJT/wXiW46OehDHWV7hm6+8FWK9p28D9EVkwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EgcDUHEHrfPVidj5EugL6yu2g2ITDLQTfHjUbdogcWroG1ciS41T+BbFnuD3szL4M
         v2ve0+qKH/CM/wm3O2Dxd9cXze0xlK9lsJsm70RZ86456oiRT4ad1XGl0VSI42bfin
         aPN3PdfTVeyZJOYMNvvYW2tGUT+aXPGTDkrC4U+I=
Received: by mail-oi1-f174.google.com with SMTP id t77so21447636oie.4;
        Mon, 12 Oct 2020 23:59:19 -0700 (PDT)
X-Gm-Message-State: AOAM530V+wfFtjAJzlbbZwpOLW9pdRIZ+/fkpf7DItRoLqQhI4FCGcdi
        C7D/rnOA1oegnnY6+B3lPZeONhgp3NafbjJvovc=
X-Google-Smtp-Source: ABdhPJyN/h+J29thUNFJa4d27RQWpUv7YcAxi8l5038ROzT3Mq+4mXzc3tQ9EWfXOH5/8xKQIm6xa1A6Gs5j70rnZ8c=
X-Received: by 2002:aca:d64f:: with SMTP id n76mr13668902oig.174.1602572358590;
 Mon, 12 Oct 2020 23:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201012083631.12724-1-ardb@kernel.org> <bafaaab0a1798b1be3f3e52f3340937edb3d84e6.camel@linux.ibm.com>
In-Reply-To: <bafaaab0a1798b1be3f3e52f3340937edb3d84e6.camel@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 13 Oct 2020 08:59:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHT-6OTLf-PN1LxptDMHvvEAfoi8ZAVcyqL55QCzJRoUw@mail.gmail.com>
Message-ID: <CAMj1kXHT-6OTLf-PN1LxptDMHvvEAfoi8ZAVcyqL55QCzJRoUw@mail.gmail.com>
Subject: Re: [PATCH] ima: defer arch_ima_get_secureboot() call to IMA init time
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org, Chester Lin <clin@suse.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 12 Oct 2020 at 23:29, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Ard,
>
> On Mon, 2020-10-12 at 10:36 +0200, Ard Biesheuvel wrote:
> > Chester reports that it is necessary to introduce a new way to pass
> > the EFI secure boot status between the EFI stub and the core kernel
> > on ARM systems. The usual way of obtaining this information is by
> > checking the SecureBoot and SetupMode EFI variables, but this can
> > only be done after the EFI variable workqueue is created, which
> > occurs in a subsys_initcall(), whereas arch_ima_get_secureboot()
> > is called much earlier by the IMA framework.
> >
> > However, the IMA framework itself is started as a late_initcall,
> > and the only reason the call to arch_ima_get_secureboot() occurs
> > so early is because it happens in the context of a __setup()
> > callback that parses the ima_appraise= command line parameter.
> >
> > So let's refactor this code a little bit, by using a core_param()
> > callback to capture the command line argument, and deferring any
> > reasoning based on its contents to the IMA init routine.
>
> Other than this patch needing to be on top of commit e4d7e2df3a09
> ("ima: limit secure boot feedback scope for appraise"), it looks good.
>

Thanks Mimi, I will rebase and resend.
