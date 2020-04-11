Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A580E1A4E5C
	for <lists+linux-efi@lfdr.de>; Sat, 11 Apr 2020 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgDKGjM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Apr 2020 02:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgDKGjM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 11 Apr 2020 02:39:12 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E308220B1F;
        Sat, 11 Apr 2020 06:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586587152;
        bh=HWHJPILduYQ1xyphNec7DOITk86Vn5G/w09Haiir/sA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2bxSJTfwvDlWdTGtWjUGaQVjdIAW3wlH2dnhCg+UsVP+/XJVPW+UQSV2VyMX7vDB5
         U5cSy1RBE+wsMLEQlxLCJ8QVLSPWC0KMZC5pEVGpJnkggl2weuJFfnDVNvsFouSrTj
         EdTCPYGwoEujo/7RJXpC8G/wsKU6a/EB3niZFn+E=
Received: by mail-io1-f53.google.com with SMTP id f19so3860394iog.5;
        Fri, 10 Apr 2020 23:39:11 -0700 (PDT)
X-Gm-Message-State: AGi0PuZd4R8iQjmVAsnO9idJeGqqbHwulcmwPiRbeHL7pbrDzXtCRxNA
        ebmGyPPJe4p9VWb3UvMhyc8ftDjY0rZRjh5vvZU=
X-Google-Smtp-Source: APiQypIMmf7iuMrn+v96ksMmp4R4knwgBE9EtdO4mm3/ygCFmgX4pZmQEx0xIgsOg3CvkN2fbHC6a6RymqdyTVY+flk=
X-Received: by 2002:a02:7785:: with SMTP id g127mr7528307jac.134.1586587151371;
 Fri, 10 Apr 2020 23:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <1586468669-21456-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXGgYYx=9rq-Ficw3vS6FX_0nb-hRStXijh7H4zdD=+Gaw@mail.gmail.com> <aee6c7cc-24c7-2822-47d5-1e05413a8024@oracle.com>
In-Reply-To: <aee6c7cc-24c7-2822-47d5-1e05413a8024@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 11 Apr 2020 08:39:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFF3gR+LyE1VbLuwnRA3CzQtF90mv7rpw9x2RcyugO1JA@mail.gmail.com>
Message-ID: <CAMj1kXFF3gR+LyE1VbLuwnRA3CzQtF90mv7rpw9x2RcyugO1JA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/arm64: Enable __efistub_global define in
 .data section
To:     Victor Erminpour <victor.erminpour@oracle.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 11 Apr 2020 at 00:12, Victor Erminpour
<victor.erminpour@oracle.com> wrote:
>
>
>
> On 4/10/20 1:09 AM, Ard Biesheuvel wrote:
> > On Thu, 9 Apr 2020 at 23:44, Victor Erminpour
> > <victor.erminpour@oracle.com> wrote:
> >>
> >> Enable the __efistub_global define to place variables in the
> >> .data section for both CONFIG_ARM and CONFIG_ARM64.
> >>
> >> This places the EFIstub sys_table variable and other EFIstub
> >> static variables in the .data section for both CONFIG_ARM and
> >> CONFIG_ARM64.
> >>
> >
> > What does that achieve?
>
> Hi Ard,
>
> Without placing these global variables in .data, I get the
> following errors when booting an ARM64 EFI system:
>
> EFI stub: ERROR: Exit boot services failed.
> EFI stub: ERROR: Failed to update FDT and exit boot services
>

Which boot loader are you using? Does this involve shim?

Also, does it help if you add 'efi=no_disable_early_pci_dma'?


>
> I know that the ARM64 linker script is supposed to put the
> .init.bss into the .init.data section, but I don't think this
> is happening for all systems.
>
> Having it explicitly enabled for CONFIG_ARM64 worked for me.
>

OK, thanks for the report. However, we will be removing
__efistub_global entirely during the next cycle, so this is not the
right fix.
